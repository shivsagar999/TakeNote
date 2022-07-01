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
    let category: Category!
    init(category: Category) {
        self.category = category
        fetchNotes(category: self.category)
    }
    
    func fetchNotes(category: Category) {
        let fetchrequest: NSFetchRequest<Note> = Note.fetchRequest()
        
        fetchrequest.predicate = NSPredicate(format: "parentCategory.name MATCHEs %@", category.name!)
        do {
            notes = try context.fetch(fetchrequest)
        } catch {
            print("Encountered error while fetching \(error)")
        }
    }
    
    func getNotes() -> [Note] {
        fetchNotes(category: self.category)
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
