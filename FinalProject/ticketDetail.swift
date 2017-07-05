//
//  ticketDetail.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 29/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class ticketDetail: UIViewController {
    
    var ticketId: String?
        
    
    
    var ticket: Ticket?{
        didSet{
            eventNameTextfield.text = ticket?.eventName
            venueTextfield.text = ticket?.venue
            locationTextfield.text = ticket?.location
            dateTextfield.text = ticket?.date
            priceTextfield.text = ticket?.price
            infoTextfield.text = ticket?.ticketInfo
            ticketTypeSegment.selectedSegmentIndex = ticket?.ticketType == "Digital" ? 0 : 1
        }
    }
    

    //make event name label
    let eventNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Event name"
        label.textColor = UIColor(r:255, g:149, b:0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //make event name textfield
    let eventNameTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.white
        textfield.layer.cornerRadius = 7
        textfield.isUserInteractionEnabled = false
        textfield.returnKeyType = UIReturnKeyType.done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()
    
    //make venue label
    let venueLabel:UILabel = {
        let label = UILabel()
        label.text = "Venue"
        label.textColor = UIColor(r:255, g:149, b:0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //make venue text field
    let venueTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.white
        textfield.layer.cornerRadius = 7
        textfield.isUserInteractionEnabled = false
        textfield.returnKeyType = UIReturnKeyType.done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()
    
    //make location label
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location"
        label.textColor = UIColor(r:255, g:149, b:0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //make location text field
    let locationTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.white
        textfield.isUserInteractionEnabled = false
        textfield.layer.cornerRadius = 7
        textfield.returnKeyType = UIReturnKeyType.done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()
    
    //make date label
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.textColor = UIColor(r:255, g:149, b:0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //make date picker text box
    let dateTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.white
        textfield.isUserInteractionEnabled = false
        textfield.layer.cornerRadius = 7
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        return textfield
    }()
    
    //make price label
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Price"
        label.textColor = UIColor(r:255, g:149, b:0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //make price text field
    let priceTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.white
        textfield.isUserInteractionEnabled = false
        textfield.layer.cornerRadius = 7
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.returnKeyType = UIReturnKeyType.done
        
        return textfield
    }()
    
    //other info label
    let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Ticket info"
        label.textColor = UIColor(r:255, g:149, b:0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //other info text field
    let infoTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = UIColor.white
        textfield.isUserInteractionEnabled = false
        textfield.layer.cornerRadius = 7
        textfield.returnKeyType = UIReturnKeyType.done
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        return textfield
    }()
    
    //make ticket type label
    let ticketTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Ticket type"
        label.textColor = UIColor(r:255, g:149, b:0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //make ticket type segmented controller
    let ticketTypeSegment: UISegmentedControl = {
        let items = ["Digital","Paper"]
        let SC = UISegmentedControl(items: items)
        SC.selectedSegmentIndex = 0
        SC.layer.cornerRadius = 7
        SC.backgroundColor = UIColor.white
        SC.tintColor = UIColor(r:255, g:149, b:0)
        SC.translatesAutoresizingMaskIntoConstraints = false
        SC.isUserInteractionEnabled = false
        return SC
    }()

    //make buy button
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r:110,g:110,b:110)
        button.setTitle("Buy ticket", for: .normal)
        button.setTitleColor(UIColor(r:255, g:149, b:0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buyButtonClicked), for: UIControlEvents.touchUpInside)
        
        return button
    }()
    
    
    let messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Message seller", for: .normal)
        button.backgroundColor = UIColor(r:110,g:110,b:110)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(messageButtonClicked), for: UIControlEvents.touchUpInside)
        
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r:128, g: 128, b: 128)
        
        self.navigationController?.navigationBar.tintColor = UIColor(r:255, g:149, b:0)
        self.navigationItem.title = "Ticket"
        
        //add each subview to view
        view.addSubview(eventNameLabel)
        view.addSubview(eventNameTextfield)
        view.addSubview(venueLabel)
        view.addSubview(venueTextfield)
        view.addSubview(locationLabel)
        view.addSubview(locationTextfield)
        view.addSubview(dateLabel)
        view.addSubview(dateTextfield)
        view.addSubview(priceLabel)
        view.addSubview(priceTextfield)
        view.addSubview(infoLabel)
        view.addSubview(infoTextfield)
        view.addSubview(ticketTypeLabel)
        view.addSubview(ticketTypeSegment)
        view.addSubview(buyButton)
        view.addSubview(messageButton)
        
        //set up constraints for each view
        setUpEventNameLabel()
        setUpEventNameTextField()
        setUpVenueLabel()
        setUpVenueTextfield()
        setUplocationLabel()
        setUpLocationTextfield()
        setUpDateLabel()
        setUpDateTextfield()
        setUpPriceLabel()
        setUpPriceTextfield()
        setUpInfoLabel()
        setUpInfoTextfield()
        setUpTicketTypeLabel()
        setUpTicketSegment()
        setUpBuyButton()
        setUpMessageButton()
    }
    
    func buyButtonClicked(){
        //get current user ID
        let userId = FIRAuth.auth()?.currentUser?.uid
        //stop user buying own ticket
        if userId != ticket?.sellerId{
            //show alert asking user to confirm
            let alertController = UIAlertController(title: "Buy ticket?", message: "You can message the seller in Account > View Tickets Bought", preferredStyle: .alert)
            alertController.view.tintColor = UIColor(r:255, g:149, b:0)
            let action1 = UIAlertAction(title: "Yes", style: .default){
                UIAlertAction in
                //user has confirmed
                self.handleBuyTicket()
            }
            let action2 = UIAlertAction(title: "No", style: .default)
            alertController.addAction(action1)
            alertController.addAction(action2)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func handleBuyTicket(){
        //set status of ticket to sold
        FIRDatabase.database().reference().child("tickets").child(ticketId!).updateChildValues(["status": "sold"])
        //add ticket to bought-tickets node user the ID of user who bought
        let userId = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("bought-tickets").child(userId!).updateChildValues([ticketId!:1])
        //go back to screen that displays tickets for sale
        let navController = self.navigationController
        navController?.popViewController(animated: true)
    }
    
    func messageButtonClicked(){
        
        let sellerId = ticket?.sellerId
        
        //cant message self
        if sellerId != FIRAuth.auth()?.currentUser?.uid{
            
            let ChatLogController = chatLogController(collectionViewLayout: UICollectionViewFlowLayout())
            
            FIRDatabase.database().reference().child("users").child(sellerId!).observe(.value, with: { (snapshot) in
                print(snapshot)
                
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    let user = User()
                    user.id = snapshot.key
                    user.email = dictionary["email"] as! String?
                    user.name = dictionary["name"] as! String?
                    ChatLogController.user = user
                }
                
            }, withCancel: nil)
            
            navigationController?.pushViewController(ChatLogController, animated: true)
        }
    }

 
    func setUpEventNameLabel(){
        //x any y
        eventNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        eventNameLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
    }
    
    func setUpEventNameTextField(){
        //x and y
        eventNameTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        eventNameTextfield.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 4).isActive = true
        
        //w and h
        eventNameTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        eventNameTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpVenueLabel(){
        //x and y
        venueLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        venueLabel.topAnchor.constraint(equalTo: eventNameTextfield.bottomAnchor, constant: 16).isActive = true
    }
    
    func setUpVenueTextfield(){
        //x and y
        venueTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        venueTextfield.topAnchor.constraint(equalTo: venueLabel.bottomAnchor, constant: 4).isActive = true
        
        //w and h
        venueTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        venueTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUplocationLabel(){
        //x and y
        locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        locationLabel.topAnchor.constraint(equalTo: venueTextfield.bottomAnchor, constant: 16).isActive = true
    }
    
    func setUpLocationTextfield(){
        //x and y
        locationTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        locationTextfield.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4).isActive = true
        
        //w and h
        locationTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2,constant: -24).isActive = true
        locationTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpDateLabel(){
        //x and y
        dateLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant:12).isActive = true
        dateLabel.topAnchor.constraint(equalTo: venueTextfield.bottomAnchor, constant: 16).isActive = true
    }
    
    func setUpDateTextfield(){
        //x and y
        dateTextfield.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive = true
        dateTextfield.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 4).isActive = true
        
        //w and h
        dateTextfield.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier:1/2, constant: -24).isActive = true
        dateTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpPriceLabel(){
        //x and y
        priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        priceLabel.topAnchor.constraint(equalTo: dateTextfield.bottomAnchor, constant: 16).isActive = true
    }
    
    func setUpPriceTextfield(){
        //x and y
        priceTextfield.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive = true
        priceTextfield.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4).isActive = true
        
        //w and h
        priceTextfield.widthAnchor.constraint(equalTo: view.widthAnchor,multiplier: 1/2, constant: -24).isActive = true
        priceTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpInfoLabel(){
        //x and y
        infoLabel.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 12).isActive = true
        infoLabel.topAnchor.constraint(equalTo: dateTextfield.bottomAnchor, constant: 16).isActive = true
    }
    
    func setUpInfoTextfield(){
        //x and y
        infoTextfield.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 12).isActive = true
        infoTextfield.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 4).isActive = true
        
        //w and h
        infoTextfield.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2, constant: -24).isActive = true
        infoTextfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpTicketTypeLabel(){
        //x and y
        ticketTypeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ticketTypeLabel.topAnchor.constraint(equalTo: priceTextfield.bottomAnchor, constant: 16).isActive = true
    }
    
    func setUpTicketSegment(){
        //x and y
        ticketTypeSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ticketTypeSegment.topAnchor.constraint(equalTo: ticketTypeLabel.bottomAnchor, constant: 4).isActive = true
        
        //w and h
        ticketTypeSegment.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:1/2).isActive = true
        ticketTypeSegment.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpBuyButton(){
        //x and y
        buyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buyButton.topAnchor.constraint(equalTo: ticketTypeSegment.bottomAnchor, constant: 30).isActive = true
        
        //w and h
        buyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpMessageButton(){
        //x and y
        messageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        messageButton.topAnchor.constraint(equalTo: buyButton.bottomAnchor, constant:8).isActive = true
        //w and height
        messageButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        messageButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
