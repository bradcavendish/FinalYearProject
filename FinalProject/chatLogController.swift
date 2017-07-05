//
//  chatLogController.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 20/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class chatLogController: UICollectionViewController, UITextFieldDelegate, UICollectionViewDelegateFlowLayout{
    
    //set page title to logged in user when this variable gets set
    var user: User?{
        didSet{
            navigationItem.title = user?.name
            observeMessages()
        }
    }
    
    
    var messages = [Message]()
    
    //get all messages for user
    func observeMessages(){
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid, let toID = user?.id else{
            return
        }
        
        let userMessagesRef = FIRDatabase.database().reference().child("user-messages").child(uid).child(toID)
        userMessagesRef.observe(.childAdded, with: { (snapshot) in
            let messageId = snapshot.key
            let messagesRef = FIRDatabase.database().reference().child("messages").child(messageId)
            
            messagesRef.observeSingleEvent(of: .value, with: { (snapshot) in
                
                guard let dictionary = snapshot.value as? [String: AnyObject] else{
                    return
                }
                let message = Message()
                message.fromId = dictionary["fromId"] as! String?
                message.toId = dictionary["toId"] as! String?
                message.text = dictionary["text"] as! String?
                message.timestamp = dictionary["timestamp"] as! Int?
 
                self.messages.append(message)
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }, withCancel: nil)
            
        }, withCancel: nil)
    }
    
    //make text field
    lazy var inputTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Enter message..."
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.returnKeyType = UIReturnKeyType.send
        textfield.delegate = self
                
        return textfield
    }()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //change colour of back button on nav bar
        self.navigationController?.navigationBar.tintColor = UIColor(r:255, g:149, b:0)
        
        //space above top message
        collectionView?.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        //change height of scroll indicator
        //collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        //use my chat message cell for collection view cell
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellId)
        //make keyboard interactive
        collectionView?.keyboardDismissMode = .interactive
        
        //setUpInputComponents()
        //setupKeyboardObservers()
    }
    
    lazy var inputContainerView: UIView = {
        let containerView = UIView()
        containerView.frame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        containerView.backgroundColor = UIColor.white
        
        //make send button
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.tintColor = UIColor(r:255, g:149, b:0)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        
        //add button to view
        containerView.addSubview(sendButton)
        
        //contraints of send button
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        //add textfield to container view
        containerView.addSubview(self.inputTextField)
        //contraints for textfield
        self.inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        self.inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        self.inputTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -80).isActive = true
        
        //create separator line
        let line = UIView()
        line.backgroundColor = UIColor.gray
        line.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(line)
        //line constraints
        line.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        line.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        line.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return containerView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupKeyboardObservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func handleKeyboardWillShow(notification: Notification){
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        containerViewBottomAnchor?.constant = -keyboardFrame!.height + 50
        UIView.animate(withDuration: duration!) { 
            self.view.layoutIfNeeded()
        }
    }
    
    func handleKeyboardWillHide(notification: Notification){
        containerViewBottomAnchor?.constant = 0
        let duration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        UIView.animate(withDuration: duration!) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageCell
        
        let message = messages[indexPath.item]
        cell.textview.text = message.text
        
        //should bubble be orange or grey??
        setUpCell(cell: cell, message: message)
        
        
        //set width of bubble
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: message.text!).width + 32
        
        return cell
    }
    
    private func setUpCell(cell: ChatMessageCell, message: Message){
        if message.fromId == FIRAuth.auth()?.currentUser?.uid{
            //outgoing orange bubble
            cell.bubbleView.backgroundColor = UIColor(r:255, g:149, b:0)
            cell.textview.textColor = UIColor.white
            cell.bubbleViewLeftAnchor?.isActive = false
            cell.bubbleViewRightAnchor?.isActive = true
            
        }else{
            //incoming grey bubble
            cell.bubbleView.backgroundColor = UIColor(r:240, g:240, b:240)
            cell.textview.textColor = UIColor.black
            cell.bubbleViewRightAnchor?.isActive = false
            cell.bubbleViewLeftAnchor?.isActive = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        //estiamte height of textview for message
        if let text = messages[indexPath.item].text {
            height = estimateFrameForText(text: text).height + 20
        }
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    private func estimateFrameForText(text: String) -> CGRect{
        
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    
    let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    func setUpInputComponents(){
        
        //make view
        
        view.addSubview(containerView)
        
        //contraints
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        containerViewBottomAnchor = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        containerViewBottomAnchor?.isActive = true
        
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func handleSend(){
        
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toId = user!.id!
        let fromId = FIRAuth.auth()!.currentUser!.uid
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let values = ["text": inputTextField.text!, "toId": toId, "fromId": fromId, "timestamp": timestamp] as [String : Any]
        
        
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil{
                print(error!)
                return
            }
            self.inputTextField.text = nil
            
            let userMessagesRef = FIRDatabase.database().reference().child("user-messages").child(fromId).child(toId)
            
            let messageId = childRef.key
            userMessagesRef.updateChildValues([messageId:1])
            
            let recipientUserMessagesRef = FIRDatabase.database().reference().child("user-messages").child(toId).child(fromId)
            recipientUserMessagesRef.updateChildValues([messageId:1])
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
    
    
    
}
















