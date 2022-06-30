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
    
    func getCategories() -> [Category] {
        return self.categories
    }
    
    func getCategoryAtIndex(indexpath: IndexPath) -> Category {
        self.categories[indexpath.count]
    }
    
    func deleteCategories(categories: [Category]) {
        for category in categories {
            self.context.delete(category)
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
