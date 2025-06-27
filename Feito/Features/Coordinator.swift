//
//  Coordinator.swift
//  Feito
//
//  Created by Ana Julia Brito de Souza on 27/06/25.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
