//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Евгений Фирман on 16.05.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    // Inititalizing Categories
    var categories = [Category]()
    
    
    // Context initialization
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
        
    }
    
    
    // MARK: - Table View DataSourse method
    
    // Initializing number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        
        return cell
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textField.text
            
            self.categories.append(newCategory)
            
            self.saveCategories()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add New Category"
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    // MARK: - Table View Data Manipulation Methods
    
    func saveCategories(){
        do {
            try context.save()
        } catch {
            print("Error saving categorie")
        }
        
        tableView.reloadData()
      
    }
    
    func loadCategories() {
            
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("There was an error")
        }
        tableView.reloadData()
            
        }
    
    // MARK: - Add New Categories
    
    
    // MARK: - Table View Delegate Methods
    
}
