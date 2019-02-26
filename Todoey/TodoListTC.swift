//
//  TodoListTC.swift
//  Todoey
//
//  Created by Shivam Sharma on 23/02/19.
//  Copyright © 2019 Shivam Sharma. All rights reserved.
//

import UIKit

class TodoListTC: UITableViewController {

    let defaults = UserDefaults.standard
  var itemArr = ["find","eggs","be","ready"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = defaults.value(forKey: "ToDoList") as? [String]{
            itemArr = item
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoList", for: indexPath)
        
        cell.textLabel?.text = itemArr[indexPath.row]
    
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark
        {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addActionItem(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController.init(title: "Add new Todey Item", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "ADD ITEM", style: .default, handler: { (action) in
            
            self.itemArr.append(textField.text!)
            self.tableView.reloadData()
           
            self.defaults.set(self.itemArr, forKey: "ToDoList")
            
            }))
            alert.addTextField(configurationHandler: { (alertTextField) in
                alertTextField.placeholder = "Create New Item"
                textField = alertTextField
        })
        present(alert, animated: true, completion: nil)
    }
}
