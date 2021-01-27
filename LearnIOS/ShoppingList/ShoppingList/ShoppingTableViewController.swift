//
//  ShoppingTableViewController.swift
//  ShoppingList
//
//  Created by eavictor on 2020/12/25.
//

import UIKit
import ARKit

class ShoppingTableViewController: UITableViewController {
    
    var shoppingItems:[String] = []

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        popUpAlertWithDefault(nil, withCompletionHandler: {
            (success:Bool, result:String?) in
            if success {
                if let okResult = result {
                    self.shoppingItems.append(okResult)
                    // self.tableView.reloadData()
                    let newItemIndexPath = IndexPath(row: self.shoppingItems.count - 1, section: 0)
                    self.tableView.insertRows(at: [newItemIndexPath], with: UITableView.RowAnimation.automatic)
                    self.saveList()
                }
            }
        })
    }
    
    func saveList() {
        UserDefaults.standard.set(shoppingItems, forKey: "list")
    }
    
    func loadList() {
        if let okList = UserDefaults.standard.stringArray(forKey: "list") {
            shoppingItems = okList
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        popUpAlertWithDefault(shoppingItems[indexPath.row], withCompletionHandler: {
            (success:Bool, result:String?) in
            if success {
                if let okResult = result {
                    self.shoppingItems[indexPath.row] = okResult
                    self.tableView.reloadData()
                    self.saveList()
                }
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            self.shoppingItems.remove(at: indexPath.row)
            self.saveList()
            self.tableView.reloadData()
        }
    }
    
    func popUpAlertWithDefault(_ defaultValue: String?, withCompletionHandler handler: @escaping (Bool, String?)->Void) {
        let alert = UIAlertController(title: "Add new item", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addTextField(configurationHandler: {
            (textField:UITextField) in
            textField.placeholder = "Add new item here"
            textField.text = defaultValue
        })
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            (action:UIAlertAction) in
            // what to do after pressing ok button
            // retrieve text from textfield
            if let inputText:String = alert.textFields?[0].text {
                if inputText != "" {
                    handler(true, inputText)
                } else {
                    handler(false, nil)
                }
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action:UIAlertAction) in
            handler(false, nil)
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadList()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return shoppingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shoppingItems[indexPath.row]
        // Configure the cell...

        return cell
    }
}
