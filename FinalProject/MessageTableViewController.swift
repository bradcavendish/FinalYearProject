//
//  MessageTableViewController.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 07/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class MessageTableViewController: UITableViewController {

    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get curent user info
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = User()
                user.name = dictionary["name"] as! String?
                //set title to user's name
                self.navigationItem.title = "Messages"
            }
        }, withCancel: nil)
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
    
        resetMessages()
    }
    
    //observe user messages
    
    func observeUserMessages(){
        //use uid to get messages for current user
        guard let uid = FIRAuth.auth()?.currentUser?.uid else{
            return
        }
        //get current users messages
        let ref = FIRDatabase.database().reference().child("user-messages").child(uid)
        //find all messages for user
        ref.observe(.childAdded, with: { (snapshot) in
            //get id of message
            let userId = snapshot.key
            FIRDatabase.database().reference().child("user-messages").child(uid).child(userId).observe(.childAdded, with: { (snapshot) in
                let messageId = snapshot.key
                //get reference to message id in messages
                self.fetchMessagesWithMessageID(messageId: messageId)
            }, withCancel: nil)
        }, withCancel: nil)
    }
    
    
    private func fetchMessagesWithMessageID(messageId: String){
        //get all message info for passed in ID
        let messagesRef = FIRDatabase.database().reference().child("messages").child(messageId)
        messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                //create message object from fetched message
                let message = Message()
                message.fromId = dictionary["fromId"] as! String?
                message.text = dictionary["text"] as! String?
                message.timestamp = dictionary["timestamp"] as! Int?
                message.toId = dictionary["toId"] as! String?
                //add message to array of messages
                self.messages.append(message)
                //holds one message per user - overwrites message if same toId is used
                if let chatPartnerId = message.chatPartnerId(){
                    //add the message to dictionary
                    self.messagesDictionary[chatPartnerId] = message
                }
                //sort out problem with relaoding table too many times
                self.attemptReloadTable()
            }
        }, withCancel: nil)
    }
    
    
    private func attemptReloadTable(){
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.handleReload), userInfo: nil, repeats: false)
    }
    
    
    var timer: Timer?
    
    func handleReload(){
        
        //add the value from dictionary to array of messages
        self.messages = Array(self.messagesDictionary.values)
        
        //sort
        self.messages.sort(by: { (message1, message2) -> Bool in
            return message1.timestamp! > message2.timestamp!
        })

        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    var messages = [Message]()
    var messagesDictionary = [String: Message]()
    
    /*
    //listen for messages
    func observeMessages(){
        let ref = FIRDatabase.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                
                let message = Message()
                message.fromId = dictionary["fromId"] as! String?
                message.text = dictionary["text"] as! String?
                message.timestamp = dictionary["timestamp"] as! Int?
                message.toId = dictionary["toId"] as! String?
                
                self.messages.append(message)
                
                //holds one message per user - overwrites message if same toId is used
                if let toId = message.toId{
                    //add the message to dictionary
                    self.messagesDictionary[toId] = message
                    //add the value from dictionary to array of messages
                    self.messages = Array(self.messagesDictionary.values)
                    
                    //sort 
                    self.messages.sort(by: { (message1, message2) -> Bool in
                        return message1.timestamp! > message2.timestamp!
                    })
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell
       
        let message = messages[indexPath.row]
        cell.message = message
       
        return cell
    }
    
    //set height of rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }    
    
    //clicking on a message row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //find the message clicked on
        let message = messages[indexPath.row]
        //get the ID of other user
        guard let chatPartnerId = message.chatPartnerId() else{
            return
        }
        
        let ref = FIRDatabase.database().reference().child("users").child(chatPartnerId)
        //find the other user in "users"
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            
            guard let dictionary = snapshot.value as? [String: AnyObject] else{
                return
            }
            //create a user object for other user
            let user = User()
            user.id = chatPartnerId
            user.name = dictionary["name"] as! String?
            user.email = dictionary["email"] as! String?
            //show the chat log for other user
            self.showChatControllerForUser(user: user)
        }, withCancel: nil)
    }
    
    //go to chat for the user clicked on
    func showChatControllerForUser(user: User){
        let ChatLogController = chatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        
        ChatLogController.user = user
        
        navigationController?.pushViewController(ChatLogController, animated: true)
    }
    
    func resetMessages(){
        messages.removeAll()
        messagesDictionary.removeAll()
        tableView.reloadData()
        observeUserMessages()
    }
    
    //when account button is pressed
    @IBAction func handleLogout(_ sender: Any) {
        let account = AccountViewController()
        let navController = UINavigationController(rootViewController: account)
        present(navController, animated: true, completion: nil)
    }

    
}
