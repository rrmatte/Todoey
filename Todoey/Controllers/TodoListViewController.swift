//
//  ViewController.swift
//  Todoey
//
//  Created by rrmatte on 10/23/18.
//  Copyright © 2018 Ron R Matteson. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    @IBOutlet weak var ToDoItem: UILabel!
    
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Buy eggos"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Kill demigorgon"
        itemArray.append(newItem2)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - Tableview Datasource Methods
    
  
    
    //MARK - Declare numberOfRowsInSection here:

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //MARK - Declare cellForRowAtIndexPath here:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        //ternary operator
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none

     
        return cell
    }
    //MARK - Tableview Delegate Methods.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        //print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done   // = ! is a not operator cause toggle of state :-)
        
        tableView.reloadData()
        //print("didselectRowAt")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add New Todoey Item",message: "", preferredStyle: .alert)
        var textField = UITextField()
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when the user clicks the Add Item
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray,forKey: "TodoListArray")
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            //print("exiting add text field")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        //print("just after addAction")
    }
    
}

