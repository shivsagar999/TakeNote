//
//  NoteViewModel.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 26/06/22.
//

import Foundation
import UIKit

class NoteViewModel {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveNote(note: Note) {
        do {
            try context.save()
        } catch {
            print("Could not save the changes \(error)")
        }
    }
}
