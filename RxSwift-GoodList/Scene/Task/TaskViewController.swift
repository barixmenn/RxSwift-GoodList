//
//  ViewController.swift
//  RxSwift-GoodList
//
//  Created by Baris on 5.05.2023.
//

import UIKit
import RxSwift
import RxRelay

private let disposeBag = DisposeBag()

class TaskViewController: UIViewController {

    //MARK: - UI Element
    @IBOutlet weak var choiceSegmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private var tasks = BehaviorRelay(value: [Task]())
    private var filteredTasks = [Task]()

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
    }
    
    
    //MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
            let addTVC = navC.viewControllers.first as? AddTaskController else {
                fatalError("Controller not found...")
        }
        
        addTVC.taskSubjectObservable
            .subscribe { [unowned self] task in
                print(task)
                let priority = Priority(rawValue: self.choiceSegmentController.selectedSegmentIndex - 1)
                var existingTask = self.tasks.value
                existingTask.append(task)
                self.tasks.accept(existingTask)
                self.filterTasks(by: priority)
            }.disposed(by: disposeBag)
    }

    //MARK: - Actions
    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl) {
        
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
        
    }
}

//MARK: - Helper
extension TaskViewController {
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            self.filteredTasks = self.tasks.value
            self.updateTableView()
        } else {
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority!}
            }.subscribe(onNext: { [weak self] tasks in
                self?.filteredTasks = tasks
                print(tasks)
                self?.updateTableView()
            }).disposed(by: disposeBag)
        }
    }
    
    private func updateTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: - TableViewDataSource
extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.filteredTasks[indexPath.row].title
        return cell
    }
}

