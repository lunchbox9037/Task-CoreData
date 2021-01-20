//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/19/21.
//

import UIKit

protocol TaskCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var taskCellView: UIView!
    
    // MARK: - Properties
    var task: Task? {
        didSet{
            updateCells()
        }
    }
    weak var delegate: TaskCompletionDelegate?
    
    // MARK: - Actions
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
    }
    
    func updateCells() {
        guard let taskDetails = task else {return}
        let dueDateFormatted = DateFormatter.dueDate.string(from: taskDetails.dueDate ?? Date())
        let currentDateFormatted = DateFormatter.dueDate.string(from: Date())
        taskNameLabel.text = taskDetails.name
        if taskDetails.isComplete {
            dueDateLabel.text = "Completed on \(currentDateFormatted)"
            completionButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
            taskCellView.backgroundColor = UIColor.systemFill
            taskNameLabel.textColor = UIColor.systemFill
            dueDateLabel.textColor = UIColor.systemFill
        } else {
            dueDateLabel.text = "Complete by \(dueDateFormatted)"
            completionButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            taskCellView.backgroundColor = UIColor.systemGroupedBackground
            taskNameLabel.textColor = UIColor.label
            dueDateLabel.textColor = UIColor.systemBlue
        }
    }
}
