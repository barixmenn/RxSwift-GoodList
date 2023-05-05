//
//  AddTaskController.swift
//  RxSwift-GoodList
//
//  Created by Baris on 5.05.2023.
//

import UIKit
import RxSwift

class AddTaskController: UIViewController {
    //MARK: - UI Elements
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var choiceSegmentController: UISegmentedControl!
    //MARK: - Properties
    private let taskObject = PublishSubject<Task>()
    var taskSubjectObservable : Observable<Task> {
        return taskObject.asObservable()
    }
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: - Functions

    
    //MARK: - Actions
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        guard let priority = Priority(rawValue: choiceSegmentController.selectedSegmentIndex),
              let title = taskTextField.text else {
            return
        }
        let task = Task(title: title, priority: priority)
        taskObject.onNext(task)
        self.dismiss(animated: true)
    }
}


