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
        fetchNotes()
    }
    
    func fetchNotes() {
        let fetchrequest: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try context.fetch(fetchrequest)
        } catch {
            print("Encountered error while fetching \(error)")
        }
    }
    
    func getNotes() -> [Note] {
        fetchNotes()
        return notes
    }
    
    func getNoteAtIndex(indexPath: IndexPath) -> Note {
        return notes[indexPath.row]
    }
    
    func deleteNoteAtIndexes(notes: [Note]) {
        for note in notes {
            context.delete(note)
            saveData()
        }
        
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Encountered error while saving error - \(error)")
        }
    }
    
    func convertDateToString(date: Date?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let date = date {
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
