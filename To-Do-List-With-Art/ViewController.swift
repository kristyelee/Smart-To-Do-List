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
    static var counter = 0 {
        didSet {
            //tableView.draw()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if tableData.count() > 0 {
            print(tableData.get(at: 0))
        }
        self.tableView.reloadData()
    }
    
    //MARK: Properties
    @IBOutlet weak var drawingCanvas: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    var tableData = StringArrayList(array: [String]())
    var timeData = StringArrayList(array: [String]())
    
    //MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
            // Configure the cell...
            //cell.textLabel?.text = tableData[indexPath.row]
            //cell.detailTextLabel?.text = tableData[indexPath.row]
            
            if let taskCell = cell as? TaskTableViewCell {
                taskCell.taskName.text = tableData.get(at: indexPath.row)
                taskCell.timeName.text = timeData.get(at: indexPath.row)
                return taskCell
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableData.remove(at: indexPath.row)
            timeData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let task = tableData.get(at: fromIndexPath.row)
        let time = timeData.get(at: fromIndexPath.row)
        tableData.remove(at: fromIndexPath.row)
        timeData.remove(at: fromIndexPath.row)
        tableData.insert(task, at: to.row)
        timeData.insert(time, at: to.row)
        
    }
    
    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    //MARK: Action
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Add Task",
                                      message: "Please enter task and time (date or hours) to get task done by.",
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
        taskTextField?.enablesReturnKeyAutomatically = true
    }
    
    func timeTextField(_ textField: UITextField) {
        timeTextField = textField
        timeTextField?.placeholder = "Date(Wed 3/14), hours (5 hours)"
        timeTextField?.enablesReturnKeyAutomatically = true
    }
    
    func addHandler(_ alert: UIAlertAction!) {
        tableData.append(taskTextField?.text ?? "n/a")
        timeData.append(timeTextField?.text ?? "n/a")
        self.tableView.reloadData()
    }
    
    
    @IBAction func edit(_ sender: UIButton) {
        if self.tableView.isEditing {
            self.tableView.isEditing = false
            editButton.setTitle("Edit", for: UIControl.State.normal)
            
        } else {
            self.tableView.isEditing = true
            editButton.setTitle("Done", for: UIControl.State.normal)
        }
    }
    
}

