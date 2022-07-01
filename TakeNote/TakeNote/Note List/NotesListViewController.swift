//
//  ViewController.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 23/06/22.
//

import UIKit

class NotesListViewController: UIViewController {

    var category: Category! = nil
    @IBOutlet weak var notesTable: UITableView!
    @IBOutlet weak var selectButton: UIBarButtonItem!
    @IBOutlet weak var numberOfNotes: UIBarButtonItem!
    var notesListVM: NotesListViewModel! = nil
    var notes: [Note] = [Note]()
    var selectedNotes: [Note] = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesListVM = NotesListViewModel(category: self.category)
        notes = notesListVM.getNotes()
        // Space is given to place title in the middle of the screen
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.sizeToFit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.reloadTableView()
    }
    
    func reloadTableView() {
        self.notes = notesListVM.getNotes()
        self.notesTable.reloadData()
        self.numberOfNotes.title = "\t    \(self.notes.count) Notes"
    }
    
    
    @IBAction func selectPressed(_ sender: UIBarButtonItem) {
        if sender.title == "Select" {
            sender.title = "Delete"
            notesTable.allowsMultipleSelection = true
        } else if sender.title == "Delete" {
            notesListVM.deleteNoteAtIndexes(notes: self.selectedNotes)
            sender.title = "Select"
            self.selectedNotes = [Note]()
            notesTable.allowsMultipleSelection = false
            self.reloadTableView()
        }
    }
    
    @IBAction func addNote(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "NewNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NoteViewController
        if segue.identifier == "NewNote" {
            destinationVC.note = Note(context: notesListVM.context)
            destinationVC.category = self.category
        } else if segue.identifier == "UpdateNote" {
            destinationVC.note = self.selectedNotes[0]
            destinationVC.category = self.category
            self.selectedNotes = [Note]()
        }
    }
    
}

// MARK: - TableView

extension NotesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesListCell") as! NotesListCell
        
        cell.noteTitle.text = notes[indexPath.row].noteTitle
        cell.noteDescription.text = notes[indexPath.row].noteDescription
        cell.lastEditDate.text = self.notesListVM.convertDateToString(date: notes[indexPath.row].date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedNotes.append(notes[indexPath.row])
        if self.selectButton.title == "Select" {
            performSegue(withIdentifier: "UpdateNote", sender: self)
        }
    }

}
