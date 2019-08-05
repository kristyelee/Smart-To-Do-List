//
//  ToDoDocumentsTableViewController.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/24/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//

import UIKit
import os.log

class ToDoDocumentsTableViewController: UITableViewController, UISplitViewControllerDelegate {

    var listTextField: UITextField?
    static var toDoDocuments = [TaskList(name: "To-Do List", taskList: StringArrayList(array: [String]()), timeList: StringArrayList(array: [String]()))]
    lazy var toDoNames = ToDoDocumentsTableViewController.toDoDocuments.map { $0.name }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
//        if let savedLists = loadToDoLists() {
//            ToDoDocumentsTableViewController.toDoDocuments += savedLists
//        }
    }
    
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoDocumentsTableViewController.toDoDocuments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = ToDoDocumentsTableViewController.toDoDocuments[indexPath.row].name
        
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
        ToDoDocumentsTableViewController.toDoDocuments.append(TaskList(name: listTextField?.text?.madeUnique(withRespectTo: toDoNames) ?? "n/a", taskList: StringArrayList(array: [String]()), timeList: StringArrayList(array: [String]())))
        //saveToDoLists()
        tableView.reloadData()
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ToDoDocumentsTableViewController.toDoDocuments.remove(at: indexPath.row)
            //saveToDoLists()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let toDoList = ToDoDocumentsTableViewController.toDoDocuments[fromIndexPath.row]
        ToDoDocumentsTableViewController.toDoDocuments.remove(at: fromIndexPath.row)
        ToDoDocumentsTableViewController.toDoDocuments.insert(toDoList, at: to.row)
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
            destination.tableData = ToDoDocumentsTableViewController.toDoDocuments[index].taskList
            destination.timeData = ToDoDocumentsTableViewController.toDoDocuments[index].timeList
            destination.taskList = ToDoDocumentsTableViewController.toDoDocuments[index]
        }
     }
  
    //MARK: Split View Controller
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if secondaryViewController is ViewController {
            return true //The iPhone will show this TableView in main menu
        }
        return false
    }
//    private func saveToDoLists() {
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: ToDoDocumentsTableViewController.toDoDocuments, requiringSecureCoding: false)
//            print("Saved files")
//            try data.write(to: TaskList.ArchiveURL)
//        } catch {
//            print("Couldn't write file")
//        }
//////        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(ToDoDocumentsTableViewController.toDoDocuments, toFile: TaskList.ArchiveURL.path)
//////        if isSuccessfulSave {
//////            os_log("To-do lists successfully saved.", log: OSLog.default, type: .debug)
//////        } else {
//////            os_log("Failed to save to-do lists...", log: OSLog.default, type: .error)
//////        }
//    }
//
//    private func loadToDoLists() -> [TaskList]?  {
////        //return NSKeyedUnarchiver.unarchiveObject(withFile: TaskList.ArchiveURL.path) as? [TaskList]
//        do {
//           let data = try NSKeyedArchiver.archivedData(withRootObject: ToDoDocumentsTableViewController.toDoDocuments, requiringSecureCoding: false)
//            if let loadedTaskLists = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [TaskList] {
//                return loadedTaskLists
//            }
//        } catch {
//           print("Couldn't read file.")
//        }
//        return [TaskList]()
//    }
//
//
}

