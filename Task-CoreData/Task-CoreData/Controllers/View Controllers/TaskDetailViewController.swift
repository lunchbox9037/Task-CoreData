//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/19/21.
//

import UIKit

class TaskDetailViewController: UIViewController, UNUserNotificationCenterDelegate {
    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Properties
    var task: Task?
    var date: Date?
    var project: Project?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //give the textview a border
        taskNotesTextView.layer.borderWidth = 0.5
        taskNotesTextView.layer.borderColor = UIColor.systemFill.cgColor
        taskNotesTextView.layer.cornerRadius = 8
        //allows the keyboard to be hidden when the user taps anywhere outside the text fields
        hideKeyboardWhenTappedAround()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskName = taskNameTextField.text, !taskName.isEmpty,
              let taskNotes = taskNotesTextView.text else {return}
        
        if let task = task {
            TaskController.shared.update(task: task, with: taskName, notes: taskNotes, dueDate: date)
        } else {
            guard let project = project else {return}
            TaskController.shared.createTaskFor(project: project, name: taskName, notes: taskNotes, dueDate: date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let taskDetails = task else {return}
        taskNameTextField.text = taskDetails.name
        taskNotesTextView.text = taskDetails.notes
        taskDueDatePicker.date = taskDetails.dueDate ?? Date()
    }
}
