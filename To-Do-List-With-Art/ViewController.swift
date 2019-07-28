//
//  ViewController.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/15/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var taskTextField: UITextField?
    var timeTextField: UITextField?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: Properties
    @IBOutlet weak var drawingCanvas: UIView!
    @IBOutlet weak var tableView: UITableView!
    var tableData = [String]()
    var timeData = [String]()
    
    //MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
            // Configure the cell...
            if let taskCell = cell as? TaskTableViewCell {
                taskCell.taskName.text = tableData[indexPath.row]
                taskCell.timeName.text = timeData[indexPath.row]
                return taskCell
            }
            //cell.textLabel?.text = tableData[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    //MARK: Action
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Add Task",
                                      message: "Please enter task and time (date, hours, etc. formatted however you like) to get task done by.",
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: taskTextField)
        alert.addTextField(configurationHandler: timeTextField)
        
        let saveAction = UIAlertAction(title: "Add",
                                       style: .default, handler: self.addHandler)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    func taskTextField(_ textField: UITextField) {
        taskTextField = textField
        taskTextField?.placeholder = "Task name"
    }
    
    func timeTextField(_ textField: UITextField) {
        timeTextField = textField
        timeTextField?.placeholder = "Date(#/#/#), hours, etc"
    }
    
    func addHandler(_ alert: UIAlertAction!) {
        tableData.append(taskTextField?.text ?? "n/a")
        timeData.append(timeTextField?.text ?? "n/a")
        self.tableView.reloadData()
    }
    
    
    
}

