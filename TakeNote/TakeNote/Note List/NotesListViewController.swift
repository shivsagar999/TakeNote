//
//  ViewController.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 23/06/22.
//

import UIKit

class NotesListViewController: UIViewController {

    @IBOutlet weak var notesTable: UITableView!
    @IBOutlet weak var numberOfNotes: UIBarButtonItem!
    let notesListVM = NotesListViewModel()
    var notes: [Note] = [Note]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notes = notesListVM.getNotes()
        // Space is given to place title in the middle of the screen
        self.numberOfNotes.title = "\t    \(self.notes.count) Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
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
        performSegue(withIdentifier: "NewNote", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NoteViewController
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
        
        cell.noteTitle.text = notes[indexPath.row].noteTitle
        cell.noteDescription.text = notes[indexPath.row].noteDescription
        cell.lastEditDate.text = self.notesListVM.convertDateToString(date: notes[indexPath.row].date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }

}
