//
//  NotesListViewModel.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 24/06/22.
//

import Foundation
import CoreData
import UIKit

class NotesListViewModel {
    
    var notes: [Note] = [Note]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        let fetchrequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try context.fetch(fetchrequest)
        } catch {
            print("Encountered error while fetching \(error)")
        }
    }
    
    func getNotes() -> [Note] {
        return notes
    }
    
    func getNoteAtIndex(indexPath: IndexPath) -> Note {
        return notes[indexPath.row]
    }
    
    func deleteNoteAtIndexes(indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let note = notes[indexPath.row]
            context.delete(note)
        }
        saveData()
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Encountered error while saving error - \(error)")
        }
    }
}
