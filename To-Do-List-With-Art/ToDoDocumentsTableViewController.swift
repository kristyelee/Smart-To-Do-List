//
//  ToDoDocumentsTableViewController.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/24/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//

import UIKit

class ToDoDocumentsTableViewController: UITableViewController {

    var listTextField: UITextField?
    var toDoDocuments = [TaskList(name: "To-Do List", taskList: StringArrayList(array: [String]()), timeList: StringArrayList(array: [String]()))]
    lazy var toDoNames = toDoDocuments.map { $0.name }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return UIInterfaceOrientationMask.portrait
            } else {
                return UIInterfaceOrientationMask.allButUpsideDown //return the value as per the required orientation
            }
        }
        
    }
    
    func supportedInterfaceOrientations(for window: UIWindow?) -> UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return UIInterfaceOrientationMask.portrait
        } else {
            return UIInterfaceOrientationMask.allButUpsideDown //return the value as per the required orientation
        }
    }
    
    var shouldAutorotateToInterfaceOrientation: Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return false
        } else {
            return true
        }
    }
    
    override var shouldAutorotate: Bool {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return false
        } else {
            return true
        }
    }

    
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
        
        alert.addTextField(configurationHandler: listTextField)
        
        let saveAction = UIAlertAction(title: "Add",
                                       style: .default, handler: self.addHandler)
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
        
    }
    
    func listTextField(_ textField: UITextField) {
        listTextField = textField
        listTextField?.placeholder = "List"
        listTextField?.enablesReturnKeyAutomatically = true
    }

    func addHandler(_ alert: UIAlertAction!) {
        toDoDocuments.append(TaskList(name: listTextField?.text?.madeUnique(withRespectTo: toDoNames) ?? "n/a", taskList: StringArrayList(array: [String]()), timeList: StringArrayList(array: [String]())))
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
        let toDoList = toDoDocuments[fromIndexPath.row]
        toDoDocuments.remove(at: fromIndexPath.row)
        toDoDocuments.insert(toDoList, at: to.row)
     }
 
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
        return true
     }
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
     */
    
    
     // MARK: - Navigation
    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if segue.identifier == "Choose To-Do List", let destination = segue.destination as? ViewController, let index = tableView.indexPathForSelectedRow?.row {
            destination.tableData = toDoDocuments[index].taskList
            destination.timeData = toDoDocuments[index].timeList
            
        }
     }
    
}
