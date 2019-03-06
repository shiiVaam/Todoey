//
//  CategoryTc.swift
//  Todoey
//
//  Created by Shivam Sharma on 05/03/19.
//  Copyright © 2019 Shivam Sharma. All rights reserved.
//

import UIKit
import CoreData

class CategoryTc: UITableViewController {

    
    var categoryArr = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

//    let request:NSFetchRequest<Item>
//    request = Item.fetchRequest()
       loadCat()
    }
    
    
    
    
    //    MARK: - tableView data source method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArr.count
    }
    
    
    //    MARK: - tableView Delegate method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
  
        cell.textLabel?.text = categoryArr[indexPath.row].name
        
        
        return cell
    
    
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVc = segue.destination as! TodoListTC
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVc.selectedCategory = categoryArr[indexPath.row]
            
       }
    
    }
    
    @IBAction func onClickAddBtn(_ sender: Any) {
        
        
        var alertTextField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction.init(title: "Add", style: UIAlertAction.Style.default, handler: { (alert) in
            
            let newItem = Category(context: self.context)
            newItem.name = alertTextField.text
            self.categoryArr.append(newItem)
            
            self.tableView.reloadData()
            self.saveCat()
            
        }))
        alert.addTextField { (textField) in
            alertTextField = textField
        }
        
        present(alert, animated: true, completion: nil)

        
        
    }
    
    //    MARK: - Data manipulation methods
    
    func saveCat(){
        
        do
        {
            try context.save()
        }catch{
            
        }
        tableView.reloadData()
    }
    
        func loadCat(request:NSFetchRequest<Category> = Category.fetchRequest()){
            
            
            do{
                categoryArr = try context.fetch(request)
            }catch{
                
            }
            
        }
  
}
    
    

