//
//  ToDoDocumentsTableViewController.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/24/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//

import UIKit

class ToDoDocumentsTableViewController: UITableViewController {

    var taskTextField: UITextField?
    var toDoDocuments = [TaskList(name: "To-Do List", taskList: [String](), timeList: [String]())]
    lazy var toDoNames = toDoDocuments.map { $0.name }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    
//    override func awakeFromNib() {
//        splitViewController?.delegate = self
//    }
    
    
    // MARK: - Table view data source UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoDocuments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = toDoDocuments[indexPath.row].name
        
        return cell
    }

    @IBAction func newToDo(_ sender: Any) {
        let alert = UIAlertController(title: "Add To-Do List",
                                      message: "Enter name of list:",
                                      preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: taskTextField)
        
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
        taskTextField?.placeholder = "List"
        taskTextField?.enablesReturnKeyAutomatically = true
    }

    func addHandler(_ alert: UIAlertAction!) {
        toDoDocuments.append(TaskList(name: taskTextField?.text?.madeUnique(withRespectTo: toDoNames) ?? "n/a", taskList: [String](), timeList: [String]()))
        tableView.reloadData()
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
  
    /*
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if splitViewController?.preferredDisplayMode != .primaryOverlay {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            toDoDocuments.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
 
    
    
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
        return true
     }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //ViewController.tableData = toDoDocuments[indexPath.row].taskList
        //ViewController.timeData = toDoDocuments[indexPath.row].timeList
        //performSegue(withIdentifier: toDoDocuments[indexPath.row], sender: self)
//        if let cvc = splitViewDetailViewController {
//            let toDoList = toDoDocuments[indexPath.row]
//            cvc.tableData = toDoList.taskList
//            cvc.timeData = toDoList.timeList
//            cvc.tableView.reloadData()
//        } else if let cvc = lastSeguedToViewController {
//            navigationController?.pushViewController(cvc, animated: true)
//        }
    }
    
    
     // MARK: - Navigation
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "Choose To-Do List", let destination = segue.destination as? ViewController, let index = tableView.indexPathForSelectedRow?.row {
            print(index)
            destination.tableData = toDoDocuments[index].taskList
            destination.timeData = toDoDocuments[index].timeList
            print(toDoDocuments[index].taskList.count)
            print(toDoDocuments[index].timeList.count)
            
        }
     }
    
//    //MARK: Split View Controller
//    func splitViewController(_ splitViewController: UISplitViewController,
//                             collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
//        if let cvc = secondaryViewController as? ViewController {
//
//        }
//        return false
//    }
//
//
//    private var splitViewDetailViewController: ViewController? { //last is the detail
//        return splitViewController?.viewControllers.last as? ViewController
//    }
//
//    private var lastSeguedToViewController: ViewController?
//
    

}
