//
//  TaskListDatabase.swift
//  To-Do-List-With-Art
//
//  Created by Kristy Lee on 7/30/19.
//  Copyright © 2019 Kristy Lee. All rights reserved.
//
//
//import Foundation
//
//class TaskListDatabase: NSObject {
//    static let privateDocsDir: URL = {
//        // 1
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//
//        // 2
//        let documentsDirectoryURL = paths.first!.appendingPathComponent("PrivateDocuments")
//
//        // 3
//        do {
//            try FileManager.default.createDirectory(at: documentsDirectoryURL,
//                                                    withIntermediateDirectories: true,
//                                                    attributes: nil)
//        } catch {
//            print("Couldn't create directory")
//        }
//        return documentsDirectoryURL
//    }()
//
//    class func nextTaskDocPath() -> URL? {
//        // 1) Get all the files and folders within the database folder
//        guard let files = try? FileManager.default.contentsOfDirectory(at: privateDocsDir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else { return nil }
//        var maxNumber = 0
//
//        // 2) Get the highest numbered item saved within the database
//        files.forEach {
//            if $0.pathExtension == "tasklist" {
//                let fileName = $0.deletingPathExtension().lastPathComponent
//                maxNumber = max(maxNumber, Int(fileName) ?? 0)
//            }
//        }
//
//        // 3) Return a path with the consecutive number
//        return privateDocsDir.appendingPathComponent("\(maxNumber + 1).tasklist", isDirectory: true)
//    }
//
//    class func loadScaryCreatureDocs() -> [TaskList] {
//        guard let files = try? FileManager.default.contentsOfDirectory(at: privateDocsDir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else { return [] }
//
//        return files
//            .filter { $0.pathExtension == "taskist" }
//            .map { TaskList(coder: $0) }
//    }
//}
//

