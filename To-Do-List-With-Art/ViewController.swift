//
//  ViewController.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/15/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    
    }
        
    override func viewWillAppear(_ animated: Bool) {
        if ToDoDocumentsTableViewController.toDoDocuments.count == 1 {
            tableData = ToDoDocumentsTableViewController.toDoDocuments[0].taskList
            timeData = ToDoDocumentsTableViewController.toDoDocuments[0].timeList
            taskList = ToDoDocumentsTableViewController.toDoDocuments[0]
        }
        self.tableView.isOpaque = false
        self.tableView.backgroundColor = UIColor(white: CGFloat(1), alpha: CGFloat(0.65))
        self.tableView.separatorColor = #colorLiteral(red: 0.04789453745, green: 0.1055381522, blue: 0.2773030698, alpha: 1)
        self.tableView.reloadData()
        self.step = taskList.step
        self.drawingCanvas.step = self.step
        self.drawingCanvas.setNeedsDisplay()
        self.drawingCanvas.setNeedsLayout()
        if (self.taskList.wordCount >= 30) {
            var count = 0
            var maxWord = ""
            var lst = [String]()
            for word in self.taskList.wordList.keys {
                if self.taskList.wordList[word]! > count {
                    count = self.taskList.wordList[word]!
                    maxWord = word
                    lst = [word]
                } else if self.taskList.wordList[word]! == count {
                    lst.append(word)
                }
            }
            if lst.count > 1 {
                maxWord = lst[Int((CGFloat(lst.count)).arc4random)]
            } 
            
            if (count / self.taskList.wordCount) * 100 >= 175  {
                suggestionLabel.textColor = UIColor.black
                switch (maxWord) {
                case "buy": suggestionLabel.text = "Did you forget to add a task involving  buying something?"
                case "homework": suggestionLabel.text = "Did you forget to add a task involving finishing homework?"
                case "research": suggestionLabel.text = "Did you forget to add a task involving finishing a research assignment?"
                case "friend": suggestionLabel.text = "Did you want to add a reminder for meeting up with a friend?"
                default: suggestionLabel.text = "Did you forget to add a task involving \"\(maxWord)\"?"
                }
            }
            
            
        } else {
            suggestionLabel.textColor = UIColor.clear
        }
    }
    
    //MARK: Properties
    @IBOutlet weak var drawingCanvas: DrawingCanvasView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var suggestionLabel: UILabel!
    var tableData = StringArrayList(array: [String]())
    var timeData = StringArrayList(array: [String]())
    var taskList = TaskList(name: "name", taskList: StringArrayList(array: [String]()), timeList: StringArrayList(array: [String]()))
    var taskTextField: UITextField?
    var timeTextField: UITextField?
    var step: Int = 0
    
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
            
            if let taskCell = cell as? TaskTableViewCell {
                taskCell.taskName.text = tableData.get(at: indexPath.row)
                taskCell.timeName.text = timeData.get(at: indexPath.row)
                cell.contentView.backgroundColor = UIColor(white: CGFloat(1), alpha: CGFloat(0.20))
                cell.backgroundColor = UIColor(white: CGFloat(1), alpha: CGFloat(0.20))
                self.step = taskList.step
                return taskCell
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath)
        if let taskCell = cell as? TaskTableViewCell {
            if taskCell.checkButton.currentTitle == "✔" {
                taskCell.checkButton.backgroundColor = #colorLiteral(red: 0.3932797313, green: 0.6405071616, blue: 0.8404534459, alpha: 1)
            }
        }
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
        taskList.lemmatization(for: taskTextField?.text ?? "n/a")
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
    
    @IBAction func checkTask(_ sender: UIButton) {
        if (sender.currentTitle == " ") {
            self.step += 1
            taskList.step += 1
            self.drawingCanvas.step = self.step
            sender.setTitle("✔", for: UIControl.State.normal)
            sender.backgroundColor = #colorLiteral(red: 0.3932797313, green: 0.6405071616, blue: 0.8404534459, alpha: 1)
            print(taskList.step)
        } else {
            sender.setTitle(" ", for: UIControl.State.normal)
            sender.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        }
        
    }
    
}

