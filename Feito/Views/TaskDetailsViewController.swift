//
//  TaskDetailsViewController.swift
//  Feito
//
//  Created by Ana Julia Brito de Souza on 26/06/25.
//

import UIKit

class TaskDetailsViewController: UIViewController, ViewProtocol {
    
    private let viewModel: TaskViewModel
    private let maxWords = 30
    
    init(viewModel: TaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        view.backgroundColor = .systemGray6
    }
    
    private let taskTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.text = "Nova Tarefa"
        return label
    }()
    
    private let taskContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let titleTaskTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Título"
        textField.attributedPlaceholder = NSAttributedString(
            string: "Digite o título",
            attributes: [
                .foregroundColor: UIColor.systemGray,
                .font: UIFont.systemFont(ofSize: 17)
            ]
        )
        textField.autocapitalizationType = .sentences
        textField.textColor = UIColor.black
        return textField
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTaskLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 17)
        text.textColor = UIColor.systemGray
        text.text = "Descrição da Tarefa"
        return text
    }()
    
    private let descriptionTaskTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.returnKeyType = .done
        return textView
    }()
    
    private let importanceContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let importanceTaskLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "Importante"
        return text
    }()
    
    private let importanceTaskSwitch: UISwitch = {
        let switchTask = UISwitch()
        switchTask.translatesAutoresizingMaskIntoConstraints = false
        switchTask.isOn = true
        return switchTask
    }()
    
    private let dateContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let maturityTaskLabel: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        text.text = "Data de Vencimento"
        return text
    }()
    
    
    private let taskDatePicker: UIDatePicker = {
        let calendar = UIDatePicker()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.preferredDatePickerStyle = .automatic
        return calendar
    }()
    
    private let saveTaskButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("Salvar", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(createTask), for: .touchUpInside)
        return button
    }()
    
    @objc private func createTask(){
        print("Botão createTask foi tocado!")
        viewModel.createTask(addTask())
        viewModel.popToTask()
    }
    
    private func addTask() -> Task{
        guard let textTitle = titleTaskTextField.text,
              let textDescription = descriptionTaskTextView.text else { return Task() }
        return Task(title: textTitle,
                    description: textDescription,
                    isImportant: importanceTaskSwitch.isOn,
                    isCompleted: false,
                    dueDate: taskDatePicker.date)
    }

    func setupSubView() {
        view.addSubview(taskTitleLabel)
        view.addSubview(taskContentView)
        taskContentView.addSubview(titleTaskTextField)
        taskContentView.addSubview(separatorView)
        taskContentView.addSubview(descriptionTaskLabel)
        taskContentView.addSubview(descriptionTaskTextView)
        view.addSubview(importanceContentView)
        importanceContentView.addSubview(importanceTaskLabel)
        importanceContentView.addSubview(importanceTaskSwitch)
        
        view.addSubview(dateContentView)
        dateContentView.addSubview(maturityTaskLabel)
        dateContentView.addSubview(taskDatePicker)
        
        view.addSubview(saveTaskButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
        
            taskTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            taskTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            
            taskContentView.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor,constant: 20),
            taskContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            taskContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            taskContentView.heightAnchor.constraint(equalToConstant: 200),
            
            titleTaskTextField.topAnchor.constraint(equalTo: taskContentView.topAnchor,constant: 20),
            titleTaskTextField.leadingAnchor.constraint(equalTo: taskContentView.leadingAnchor,constant: 20),
            titleTaskTextField.trailingAnchor.constraint(equalTo: taskContentView.trailingAnchor),
            
            separatorView.topAnchor.constraint(equalTo: titleTaskTextField.bottomAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: taskContentView.leadingAnchor, constant: 20),
            separatorView.trailingAnchor.constraint(equalTo: taskContentView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale),
            
            descriptionTaskLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor,constant: 10),
            descriptionTaskLabel.leadingAnchor.constraint(equalTo: titleTaskTextField.leadingAnchor),
            descriptionTaskLabel.trailingAnchor.constraint(equalTo: titleTaskTextField.trailingAnchor),
            
            descriptionTaskTextView.topAnchor.constraint(equalTo: descriptionTaskLabel.bottomAnchor,constant: 10),
            descriptionTaskTextView.leadingAnchor.constraint(equalTo: titleTaskTextField.leadingAnchor),
            descriptionTaskTextView.trailingAnchor.constraint(equalTo: titleTaskTextField.trailingAnchor),
            descriptionTaskTextView.bottomAnchor.constraint(equalTo: taskContentView.bottomAnchor),
            
            importanceContentView.topAnchor.constraint(equalTo: taskContentView.bottomAnchor,constant: 20),
            importanceContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            importanceContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            importanceContentView.heightAnchor.constraint(equalToConstant: 40),
                        
            importanceTaskLabel.topAnchor.constraint(equalTo: importanceContentView.topAnchor,constant: 10),
            importanceTaskLabel.leadingAnchor.constraint(equalTo: importanceContentView.leadingAnchor,constant: 20),
            importanceTaskLabel.trailingAnchor.constraint(equalTo: importanceContentView.trailingAnchor),
            
            importanceTaskSwitch.centerYAnchor.constraint(equalTo: importanceContentView.centerYAnchor),
            importanceTaskSwitch.trailingAnchor.constraint(equalTo: importanceContentView.trailingAnchor,constant: -20),
            
            dateContentView.topAnchor.constraint(equalTo: importanceContentView.bottomAnchor,constant: 20),
            dateContentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            dateContentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            dateContentView.heightAnchor.constraint(equalToConstant: 90),
            
            maturityTaskLabel.topAnchor.constraint(equalTo: dateContentView.topAnchor,constant: 10),
            maturityTaskLabel.centerXAnchor.constraint(equalTo: dateContentView.centerXAnchor),
            
            taskDatePicker.topAnchor.constraint(equalTo: maturityTaskLabel.bottomAnchor,constant: 10),
            taskDatePicker.centerXAnchor.constraint(equalTo: dateContentView.centerXAnchor),
            
            saveTaskButton.topAnchor.constraint(equalTo: dateContentView.bottomAnchor,constant: 20),
            saveTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            saveTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            saveTaskButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureDelegate() {
        descriptionTaskTextView.delegate = self
    }
}

extension TaskDetailsViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           // Fecha o teclado ao pressionar "Done"
           if text == "\n" {
               textView.resignFirstResponder()
               return false
           }
        return true
       }
}
