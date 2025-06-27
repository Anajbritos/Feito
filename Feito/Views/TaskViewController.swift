//
//  ViewController.swift
//  Feito
//
//  Created by Ana Julia Brito de Souza on 23/06/25.
//

import UIKit

class TaskViewController: UIViewController, ViewProtocol{
    
    private let viewModel: TaskViewModel
    
    init(viewModel: TaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        configureView()
        viewModel.loadPersistedTasks()
    }
    
    private let taskTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.text = "Minhas Tarefas"
        return label
    }()
    
    private let taskSegmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["Todas", "Importante", "Concluidas"])
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.layer.cornerRadius = 15
        segment.selectedSegmentTintColor = .systemBlue
        segment.layer.masksToBounds = true
        return segment
    }()
    
    private let taskTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    @objc private let addNewTaskButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .light)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = true
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(createTaskTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func createTaskTapped(){
        print("Botão createTaskTapped foi tocado!")
        viewModel.goToTaskDetails()
    }
    
    func setupSubView() {
        view.addSubview(taskTitleLabel)
        view.addSubview(taskSegmentControl)
        view.addSubview(taskTableView)
        view.addSubview(addNewTaskButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            taskTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            taskTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            
            taskSegmentControl.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor,constant: 20),
            taskSegmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            taskSegmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            taskSegmentControl.heightAnchor.constraint(equalToConstant: 40),
            
            taskTableView.topAnchor.constraint(equalTo: taskSegmentControl.bottomAnchor,constant: 10),
            taskTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            taskTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            taskTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addNewTaskButton.topAnchor.constraint(equalTo: view.bottomAnchor,constant: -100),
            addNewTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addNewTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }
    
    func configureDelegate() {
        self.taskTableView.delegate = self
        self.taskTableView.dataSource = self
        self.viewModel.delegate = self
    }
}

extension TaskViewController: TaskViewModelDelegate {
    func didUpdateTasks() {
        print("📢 Reload solicitado pela ViewModel")
        DispatchQueue.main.async {
            self.taskTableView.reloadData()
        }
    }
}

extension TaskViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTasks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as? TaskTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let task = viewModel.task(at: indexPath.row)
        cell.taskCell(title: task.title, date: (task.dueDate?.formatted())!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

