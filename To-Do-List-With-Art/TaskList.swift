//
//  TaskList.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/29/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//

import Foundation
import UIKit
import os.log

class TaskList: NSObject, NSCoding/*, Codable*/ {
    
    //MARK: Properties
    var name: String
    var taskList = StringArrayList(array: [String]())
    var timeList = StringArrayList(array: [String]())
    var step: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    //static let ArchiveURL = DocumentsDirectory.appendingPathComponent("taskLists")
    static let randomFilename = UUID().uuidString
    static let ArchiveURL = getDocumentsDirectory().appendingPathComponent(randomFilename)
    
    
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    //MARK: Types
    
    enum PropertyKeys: String {
        case name = "name"
        case taskList = "taskList"
        case timeList = "timeList"
    }
    
    
    
    //MARK: Initialization
    init(name: String, taskList: StringArrayList, timeList: StringArrayList) {
        self.name = name
        self.taskList = taskList
        self.timeList = timeList
        self.step = 0
        
        
    }
    
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKeys.name.rawValue)
        aCoder.encode(taskList, forKey: PropertyKeys.taskList.rawValue)
        aCoder.encode(timeList, forKey: PropertyKeys.timeList.rawValue)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKeys.name.rawValue) as? String else {
            os_log("Unable to decode the name for this TaskList object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The taskList is required.
        guard let taskList = aDecoder.decodeObject(forKey: PropertyKeys.taskList.rawValue) as? StringArrayList else {
            os_log("Unable to decode the taskList for this TaskList object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // The timeList is required.
        guard let timeList = aDecoder.decodeObject(forKey: PropertyKeys.timeList.rawValue) as? StringArrayList else {
            os_log("Unable to decode the timeList for this TaskList object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Must call designated initializer.
        self.init(name: name, taskList: taskList, timeList: timeList)
        
    }
    
    
}
