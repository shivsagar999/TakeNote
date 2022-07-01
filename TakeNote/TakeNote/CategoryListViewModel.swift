//
//  CategoryListViewModel.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 30/06/22.
//

import Foundation
import CoreData
import UIKit

class CategoryListViewModel {
    
    var categories = [Category]()
    var notes = [Note]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
        fetchCategories()
    }
    
    func fetchCategories() {
        let fetchrequest: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            categories = try context.fetch(fetchrequest)
        } catch {
            print("Encountered error while fetching \(error)")
        }
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
    
    func deleteNotes() {
        for note in notes {
            self.context.delete(note)
            saveData()
        }
    }
    
    func getCategories() -> [Category] {
        self.fetchCategories()
        return self.categories
    }
    
    func getCategoryAtIndex(indexpath: IndexPath) -> Category {
        self.categories[indexpath.count]
    }
    
    func deleteCategories(categories: [Category]) {
        for category in categories {
            self.context.delete(category)
            self.fetchNotes(category: category)
            self.deleteNotes()
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
}
