//
//  ViewController.swift
//  Todoey
//
//  Created by Daniel Cabral on 29/08/18.
//  Copyright © 2018 Daniel Cabral. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.tittle = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.tittle = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.tittle = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - TableView Datasource Methods
    
    //Especificar o número de linhas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //Definir a célula de cada linha
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.tittle
        
        cell.acessoryTyoe = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    //Quando a célular for selecionada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //Para aparecer um checkmark quando a célula for selecionada e desaparece quando for selecionada novamente
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            let newItem = Item()
            newItem.tittle = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
            //Método usado para recarregar a lista com o item adicionado
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
    
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

