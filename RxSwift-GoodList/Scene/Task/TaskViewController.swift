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
    

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
            let addTVC = navC.viewControllers.first as? AddTaskController else {
                fatalError("Controller not found...")
        }
        
        addTVC.taskSubjectObservable
            .subscribe { task in
                print(task)
                let priority = Priority(rawValue: self.choiceSegmentController.selectedSegmentIndex - 1)
                var existingTask = self.tasks.value
                existingTask.append(task)
                self.tasks.accept(existingTask)
            }.disposed(by: disposeBag)
    }

}

//MARK: - TableViewDataSource
extension TaskViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }
}

