//
//  CategoryListViewController.swift
//  TakeNote
//
//  Created by MEP LAB 01 on 30/06/22.
//

import UIKit

class CategoryListViewController: UIViewController {
    
    
    @IBOutlet weak var selectButton: UIBarButtonItem!
    @IBOutlet weak var numberOfCategories: UIBarButtonItem!
    
    @IBOutlet weak var categoriesTable: UITableView!
    var categories = [Category]()
    var selectedCategories = [Category]()
    var alertTextField = UITextField()
    let categoryAlert = UIAlertController(title: "Add Category", message: nil, preferredStyle: .alert)
    
    let categoryListVM = CategoryListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAlert()
        categories = categoryListVM.getCategories()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadTableView()
    }
    
    func reloadTableView() {
            self.categories = self.categoryListVM.getCategories()
            self.categoriesTable.reloadData()
            self.numberOfCategories.title = "\t    \(self.categories.count) Notes"
       
    }
    
    func setUpAlert() {
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            if let text = self.alertTextField.text, !text.isEmpty {
                let newCategory = Category(context: self.categoryListVM.context)
                newCategory.name = text
                self.categoryListVM.saveData()
                self.reloadTableView()
            }
            self.alertTextField.text = ""
        }
        self.categoryAlert.addTextField { textField in
            self.alertTextField = textField
            textField.placeholder = "Add your category"
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.categoryAlert.dismiss(animated: true, completion: nil)
        }
        self.categoryAlert.addAction(cancelAction)
        self.categoryAlert.addAction(addAction)
    }
    
    
    @IBAction func selectTapped(_ sender: UIBarButtonItem) {
        if sender.title == "Select" {
            sender.title = "Delete"
            categoriesTable.allowsMultipleSelection = true
        } else if sender.title == "Delete" {
            categoryListVM.deleteCategories(categories: self.selectedCategories)
            sender.title = "Select"
            self.selectedCategories = [Category]()
            categoriesTable.allowsMultipleSelection = false
            self.reloadTableView()
        }
    }
    
    
    @IBAction func addNoteTapped(_ sender: UIBarButtonItem) {
        self.present(self.categoryAlert, animated: true, completion: nil)
        self.reloadTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! NotesListViewController
        destinationVC.category = self.selectedCategories[0]
        self.selectedCategories = [Category]()
    }
    
}

// MARK: - Tableview

extension CategoryListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell") as! CategoryCell
        cell.category.text = self.categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCategories.append(categories[indexPath.row])
        if self.selectButton.title == "Select" {
            performSegue(withIdentifier: "ToNotes", sender: self)
        }
    }
    
}
