//
//  ViewController.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 23/06/22.
//

import UIKit

class NotesListViewController: UIViewController {

    @IBOutlet weak var notesTable: UITableView!
    var notes: [String] = ["Albemarle", "Brandywine", "Chesapeake", "Ben", "Ivy", "Jordell", "Liam"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Select" {
            sender.title = "Delete"
            notesTable.allowsMultipleSelection = true
        } else if sender.title == "Delete" {
            sender.title = "Select"
            notesTable.allowsMultipleSelection = false
        }
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
    }
    
}


// MARK: - TableView

extension NotesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesListCell") as! NotesListCell
        
        cell.noteTitle.text = notes[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}
