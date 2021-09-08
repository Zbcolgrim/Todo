//
//  ToDoTableViewController.swift
//  ToDo
//
//  Created by Zachary Buffington on 9/8/21.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    let manager = ToDoNoteManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.todoNotes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        let note = manager.todoNotes[indexPath.row]
        
        cell.textLabel?.text = note.subtitle
        cell.detailTextLabel?.text = note.subtitle
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = manager.todoNotes[indexPath.row]
            
            manager.deleteTodo(note: note)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        // create an alert controller
        let alert = UIAlertController(title: "New TodoNote", message: "Write a title." , preferredStyle: .alert)
        
        // add text fields to the alrt
        alert.addTextField()
        alert.addTextField()
        
        // add buttons to the alert
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelButton)
        
        let saveButton = UIAlertAction(title: "Save", style: .default) { _ in
            // get the text fields
            guard let titleField = alert.textFields?.first,
                  let subtitleField = alert.textFields?.last else { return }
            
            // get title and subtitle  ?? -> if it is nil use this other string istead
            let title = titleField.text ?? "No title"
            let subtilte = subtitleField.text ?? ""
            
            //create new note
            self.manager.createTodo(title: title, subtitle: subtilte)
            
            
            // reload the tableview
            self.tableView.reloadData()
        }
        alert.addAction(saveButton)
        
        // present the alert
        present(alert, animated: true)
        
    }
    
}
