//
//  ViewProtocol.swift
//  Feito
//
//  Created by Ana Julia Brito de Souza on 23/06/25.
//

import Foundation

protocol ViewProtocol {

    func setupSubView()
    func setupConstraints()
    func configureView()
    func configureDelegate()
}

extension ViewProtocol{
    
    func configureView() {
        setupSubView()
        setupConstraints()
        configureDelegate()
    }
}

