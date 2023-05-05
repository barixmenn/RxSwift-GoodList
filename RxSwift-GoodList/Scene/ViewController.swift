//
//  ViewController.swift
//  RxSwift-GoodList
//
//  Created by Baris on 5.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var choiceSegmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
    }


}

//MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }
}

