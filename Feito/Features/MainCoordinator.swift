//
//  MainCoordinator.swift
//  Feito
//
//  Created by Ana Julia Brito de Souza on 27/06/25.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator, TaskNavigationProtocol {
    
    var navigationController: UINavigationController
    private let viewModel: TaskViewModel
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewModel = TaskViewModel(coordinator: nil)
        self.viewModel.coordinator = self
    }
    
    func start() {
        let taskVC = TaskViewController(viewModel: viewModel)
        navigationController.pushViewController(taskVC, animated: false)
    }
    
    func goToTaskDetails() {
        let taskDetailVC = TaskDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(taskDetailVC, animated: false)
    }
    
    func popToTask() {
        navigationController.popViewController(animated: false)
    }
}
