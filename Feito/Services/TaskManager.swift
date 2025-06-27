//
//  TaskManager.swift
//  Feito
//
//  Created by Ana Julia Brito de Souza on 23/06/25.
//

import Foundation
import UIKit

class TaskManager {
    
    static var userDefaults: UserDefaults = .standard
    private static let taskIDsKey = "task_ids"

    private(set) var arrayTasks: [Task] = []
    
    
    public func persistTask(_ task: Task) {
        guard let data = try? JSONEncoder().encode(task) else { return }
        TaskManager.userDefaults.set(data, forKey: task.id.uuidString)

        var ids = TaskManager.userDefaults.stringArray(forKey: Self.taskIDsKey) ?? []
        if !ids.contains(task.id.uuidString) {
            ids.append(task.id.uuidString)
            TaskManager.userDefaults.set(ids, forKey: Self.taskIDsKey)
        }
    }
    
    public func loadAllTasks() -> [Task] {
        let ids = TaskManager.userDefaults.stringArray(forKey: TaskManager.taskIDsKey) ?? []
        var tasks: [Task] = []

        for id in ids {
            if let data = TaskManager.userDefaults.data(forKey: id),
               let task = try? JSONDecoder().decode(Task.self, from: data) {
                tasks.append(task)
            }
        }
        self.arrayTasks = tasks
        return tasks
    }

    public func taskCount() -> Int {
        return self.arrayTasks.count
    }
    
    public func getCompletedTasks() -> [Task] {
        return self.arrayTasks.filter({ $0.isCompleted})
    }
    
    public func getImportantTasks() -> [Task] {
        return self.arrayTasks.filter({ $0.isImportant})
    }
}
