//
//  TodoListTC.swift
//  Todoey
//
//  Created by Shivam Sharma on 23/02/19.
//  Copyright © 2019 Shivam Sharma. All rights reserved.
//

import UIKit

class TodoListTC: UITableViewController {

//    let defaults = UserDefaults.standard
    var itemArr = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    let dataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()


      
        print(dataPath!)

        //        let item = Item()
//        item.title = "bro"
//        itemArr.append(item)
//
//
//        let item1 = Item()
//        item1.title = "fffff"
//        itemArr.append(item1)
        
//        if let items = defaults.array(forKey:"ToDoListArray") as? [Item]{
//            itemArr = items
//        }
 
//        loadItems()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:"todoList", for: indexPath)
        
        cell.textLabel?.text = itemArr[indexPath.row].title
    
        cell.accessoryType = itemArr[indexPath.row].done ?.checkmark:.none
     
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArr[indexPath.row].done = !itemArr[indexPath.row].done
        
       saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addActionItem(_ sender: Any) {
        
        var textField = UITextField()
        let alert = UIAlertController.init(title: "Add new Todey Item", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "ADD ITEM", style: .default, handler: { (action) in
           
            
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
          
    
//            self.defaults.set(self.itemArr, forKey:"ToDoListArray")
            
            
            if  textField.text == "" {
                let abc = UIAlertController.init(title: "", message: "Empty string", preferredStyle: UIAlertController.Style.alert)
                abc.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(abc, animated: true, completion: nil)

            }else{
                self.itemArr.append(newItem)
                
            }
            self.saveItems()
         
            }))
        
        
            alert.addTextField(configurationHandler: { (alertTextField) in
                alertTextField.placeholder = "Create New Item"
              textField = alertTextField
             
        })
        present(alert, animated: true, completion: nil)
    }
    func saveItems(){
        
        do{
            try context.save()
            
        }catch{
            
        }
        
        self.tableView.reloadData()
        
    }
//    func loadItems(){
//        if let data = try? Data(contentsOf:dataPath!){
//            let decoder = PropertyListDecoder()
//            do{
//                itemArr = try decoder.decode([Item].self, from: data)
//
//            }catch{
//
//            }
//        }
    
    }
//}
