//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/19/21.
//

import UIKit

class TaskListTableViewController: UITableViewController {
    // MARK: - Properties
    var project: Project?
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let selectedProject = project else {return}
        TaskController.shared.fetchTasks(project: selectedProject)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.shared.sectionedTasks.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.sectionedTasks[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header = ""
        if section == 0 {
            if TaskController.shared.incompleteTasks.count > 0 {
                header = "To Do"
            }
        } else if section == 1 {
            if TaskController.shared.completeTasks.count > 0 {
                header = "Completed"
            }
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else {return UITableViewCell()}
        let task = TaskController.shared.sectionedTasks[indexPath.section][indexPath.row]
        
        cell.delegate = self
        cell.task = task
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.shared.sectionedTasks[indexPath.section][indexPath.row]
            TaskController.shared.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetails" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else {return}
            let taskToSend = TaskController.shared.sectionedTasks[indexPath.section][indexPath.row]
            destination.task = taskToSend
        } else if segue.identifier == "createNewTask" {
            guard let projectToSend = project,
                  let destination = segue.destination as? TaskDetailViewController else {return}
            destination.project = projectToSend
        }
    }
}

// MARK: - Custom Cell Delegate functions
extension TaskListTableViewController: TaskCompletionDelegate {
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let task = sender.task else {return}
        TaskController.shared.toggleIsComplete(task: task)
        sender.updateCells()
        tableView.reloadData()
    }
}
