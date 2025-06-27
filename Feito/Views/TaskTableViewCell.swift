//
//  TaskTableViewCell.swift
//  Feito
//
//  Created by Ana Julia Brito de Souza on 23/06/25.
//

import UIKit

class TaskTableViewCell: UITableViewCell, ViewProtocol {

    static let identifier = "TaskTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        contentView.backgroundColor = .systemGray6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentViewCell: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.layer.cornerRadius = 15
        content.layer.masksToBounds = true
        content.backgroundColor = .white
        return content
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Finalizar relatório"
        return label
    }()
    
    lazy var datesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = Date.distantFuture.formatted()
        return label
    }()
    
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "checkmark.circle.fill")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    func setupSubView() {
        contentView.addSubview(contentViewCell)
        contentViewCell.addSubview(titleLabel)
        contentViewCell.addSubview(datesLabel)
        contentViewCell.addSubview(iconImage)
    }
    
    func taskCell(title: String, date: String) {
        self.titleLabel.text = title
        self.datesLabel.text = date
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            contentViewCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            contentViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            contentViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentViewCell.heightAnchor.constraint(equalToConstant: 90),

            titleLabel.topAnchor.constraint(equalTo: contentViewCell.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentViewCell.leadingAnchor,constant: 20),
            
            datesLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            datesLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            datesLabel.bottomAnchor.constraint(equalTo: contentViewCell.bottomAnchor,constant: -10),
            
            iconImage.centerYAnchor.constraint(equalTo: contentViewCell.centerYAnchor),
            iconImage.trailingAnchor.constraint(equalTo: contentViewCell.trailingAnchor,constant: -20),
        ])
    }
    
    func configureDelegate() {
        //Intentionally not implmentation
    }
    
    
}
