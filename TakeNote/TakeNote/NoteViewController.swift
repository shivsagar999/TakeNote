//
//  NoteViewController.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 25/06/22.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteDescription: UITextView!
    
    var note: Note!
    var noteVM = NoteViewModel()
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        if (self.noteTitle.text?.isEmpty ?? true) && (self.noteDescription.text?.isEmpty ?? true) {
            noteVM.rollBack()
        } else {
            self.note.noteTitle = noteTitle.text
            self.note.noteDescription = noteDescription.text
            self.note.date = Date()
            noteVM.saveNote(note: note)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
