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
        taskNameLabel.text = taskDetails.name
        taskDetails.isComplete ? completionButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal) : completionButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
    }
}
