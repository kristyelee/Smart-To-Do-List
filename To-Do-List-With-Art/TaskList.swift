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

class TaskList: NSObject, NSCoding {
    
    //MARK: Properties
    var name: String
    var taskList = StringArrayList(array: [String]())
    var timeList = StringArrayList(array: [String]())
    var step: Int
    var wordList =  [String: Int]()
    var wordCount: Int = 0 //When this number reaches > 30 and when wordList has a number that is greater than 8, then write a suggestion. For continuous
    let tagger = NSLinguisticTagger(tagSchemes: [.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]
    
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
    
    //MARK: NLP
    /* Lemmatization
    Lemmatization breaks down the word into it's most basic form.
    */
    func lemmatization(for text: String) {
        let words = text.components(separatedBy: " ")
        let input = words.filter( { !StopWords.stopwords.contains($0) } ).joined(separator: " ")
        tagger.string = input
        print(input)
        if (input.isEmpty) {
            return
        }
        let range = NSRange(location:0, length: input.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { (tag, tokenRange, stop) in
            do {
                let word = (input as NSString).substring(with: tokenRange)
                if let lemma = tag?.rawValue {
                    print("\(word) -> \(lemma)")
                    if let _ = self.wordList[word] {
                        self.wordList[word] = self.wordList[word]! + 1
                    } else {
                        self.wordList[word] = 1
                    }
                    self.wordCount += 1
                    
                } else {
                    print("\(word) -> ???")
                    if let _ = self.wordList[word] {
                        self.wordList[word] = self.wordList[word]! + 1
                    } else {
                        self.wordList[word] = 1
                    }
                    self.wordCount += 1
                }
            } catch {
            
            }
        }
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
