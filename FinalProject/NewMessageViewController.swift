//
//  NewMessageViewController.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 15/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class NewMessageViewController: UITableViewController {

    
    let CellID = "cellId"
    
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIBarButtonItem.appearance().tintColor = UIColor(r:255,g:149,b:0)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        fetchUser()
    }
    
    //fetches everything in users - USE FOR TICKETS
    func fetchUser(){
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            print("user found:")
            print(snapshot)
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = User()
                user.id = snapshot.key
                user.name = dictionary["name"] as! String?
                user.email = dictionary["email"] as! String?
                
                self.users.append(user)
                
                print(user.name!, user.email!)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                
            }
            
            
            
        }, withCancel: nil )
    }
    

    func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: CellID)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
    
    var messagesController: MessageTableViewController?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
        
        let user = self.users[indexPath.row]
        
        self.messagesController?.showChatControllerForUser(user: user)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
