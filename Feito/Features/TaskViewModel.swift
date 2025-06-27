//
//  TaskViewModel.swift
//  Feito
//
//  Created by Ana Julia Brito de Souza on 23/06/25.
//

import Foundation

protocol TaskNavigationProtocol: AnyObject {
    func goToTaskDetails()
    func popToTask()
}

protocol TaskViewModelDelegate: AnyObject {
    func didUpdateTasks()
}

class TaskViewModel: TaskNavigationProtocol {
    
    var manager: TaskManager = TaskManager()
    weak var coordinator: TaskNavigationProtocol?
    weak var delegate: TaskViewModelDelegate?
    
    private(set) var arrayTasks: [Task] = []
    
    init(coordinator: TaskNavigationProtocol? = nil) {
        self.coordinator = coordinator
    }
    
    public func numberOfTasks() -> Int {
        return manager.taskCount()
    }
    
    func task(at index: Int) -> Task {
        return arrayTasks[index]
    }
    
    public func createTask(_ task: Task) {
        manager.persistTask(task)
        arrayTasks.append(task)
        delegate?.didUpdateTasks()
    }
    
    public func loadPersistedTasks() {
        self.arrayTasks = manager.loadAllTasks()
        delegate?.didUpdateTasks()
    }
}

extension TaskViewModel {
    
    func goToTaskDetails() {
        coordinator?.goToTaskDetails()
    }
    
    func popToTask() {
        coordinator?.popToTask()
    }
}
