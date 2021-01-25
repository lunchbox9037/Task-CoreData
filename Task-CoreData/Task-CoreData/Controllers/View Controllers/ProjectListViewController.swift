//
//  ProjectListViewController.swift
//  Task-CoreData
//
//  Created by stanley phillips on 1/20/21.
//

import UIKit
import CoreData

class ProjectListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Outlets
    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectListTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        projectListTableView.delegate = self
        projectListTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        projectListTableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func createProjectButtonTapped(_ sender: Any) {
        guard let projectName = projectNameTextField.text, !projectName.isEmpty else {return}
        ProjectController.shared.createProjectWith(name: projectName)
        projectNameTextField.text = ""
        projectListTableView.reloadData()
    }
    
    // MARK: - Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectController.shared.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        
        let project = ProjectController.shared.projects[indexPath.row]
        //use this if i want to add detail text to show the number of tasks in a project
//        guard let tasks = project.tasks else {return UITableViewCell()}
        
        cell.textLabel?.text = project.name
        
//        if tasks.count == 1 {
//            cell.detailTextLabel?.text = "1 task"
//        } else {
//            cell.detailTextLabel?.text = "\(tasks.count) tasks"
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let projectToDelete = ProjectController.shared.projects[indexPath.row]
            ProjectController.shared.delete(project: projectToDelete)
            projectListTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProjectTasksVC" {
            guard let indexPath = projectListTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskListTableViewController else {return}
            let projectToSend = ProjectController.shared.projects[indexPath.row]
            destination.project = projectToSend
        }
    }
}//end of class

