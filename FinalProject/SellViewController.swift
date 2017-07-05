//
//  SellViewController.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 08/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class SellViewController: UIViewController, UITextFieldDelegate {
    
    
    var ticket: Ticket?{
        didSet{
            eventNameTextfield.text = ticket?.eventName
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
        textfield.placeholder = "e.g. Propaganda"
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
        textfield.placeholder = "e.g. O2 Acadamy"
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
        textfield.placeholder = "e.g. Birmingham"
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
        textfield.placeholder = "e.g. 04-10-2018"
        textfield.layer.cornerRadius = 7
        textfield.translatesAutoresizingMaskIntoConstraints = false
        
        //bring up date picker
        textfield.addTarget(self, action: #selector(showDatePicker), for: .editingDidBegin)
        
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
        textfield.placeholder = "e.g. 12.50"
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
        textfield.placeholder = "e.g. Standing/Seat"
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
        
        return SC
    }()
    
    //make sell button
    let sellButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r:110,g:110,b:110)
        button.setTitle("Sell ticket", for: .normal)
        button.setTitleColor(UIColor(r:255, g:149, b:0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sellButtonClicked), for: UIControlEvents.touchUpInside)
        
        return button
    }()
    
    //make button to clear textfields
    let clearButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.backgroundColor = UIColor(r:110,g:110,b:110)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearButtonClicked), for: UIControlEvents.touchUpInside)
        
        return button
    }()
    
    //text field delegate for done button being pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //stuff to get date picker for date text field
    
    func showDatePicker(sender: UITextField){
        //create the view for date picker
        let inputView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 240))
        
        //make the textfields input view this new input view
        sender.inputView = inputView
        
        //make date picker
        let datePickerView: UIDatePicker = UIDatePicker(frame: CGRect(x:0,y:40,width:0,height:0))
        datePickerView.datePickerMode = UIDatePickerMode.date
        //format date picker to english
        datePickerView.locale = Locale.init(identifier: "en_GB")
        datePickerView.translatesAutoresizingMaskIntoConstraints = false
        
        //add date picker to input view
        inputView.addSubview(datePickerView)
        //constraints for date picker
        datePickerView.centerXAnchor.constraint(equalTo: inputView.centerXAnchor).isActive = true
        datePickerView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor).isActive = true
        
        //make done buton
        let doneButton = UIButton(frame: CGRect(x:(self.view.frame.size.width/2) - (100/2),y: 0,width: 100, height:50))
        
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor(r:255, g:149, b:0), for: UIControlState.normal)
        
        
        //add butotn to view
        inputView.addSubview(doneButton)
        
        //button click event
        doneButton.addTarget(self, action: #selector(doneButtonClicked), for: UIControlEvents.touchUpInside)
        //make the input of the keyboard the new view just created
        sender.inputView = inputView
        //called function every time date picker is changed
        handleDatePicker(sender: datePickerView)
        datePickerView.addTarget(self, action: #selector(handleDatePicker), for: UIControlEvents.valueChanged)
    }
    
    //format and set textfield date
    func handleDatePicker(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateTextfield.text = dateFormatter.string(from: sender.date)
    }
    
    //handle button click event
    func doneButtonClicked(){
        dateTextfield.resignFirstResponder()
    }
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r:128, g: 128, b: 128)
        
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
        view.addSubview(sellButton)
        view.addSubview(clearButton)
        
        //set textfield delegates
        eventNameTextfield.delegate = self
        venueTextfield.delegate = self
        locationTextfield.delegate = self
        priceTextfield.delegate = self
        infoTextfield.delegate = self
      
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
        setUpSellButton()
        setUpClearButton()
        
        //clear all textfields
        eventNameTextfield.text = ""
        venueTextfield.text = ""
        locationTextfield.text = ""
        priceTextfield.text = ""
        infoTextfield.text = ""
        dateTextfield.text = ""
        ticketTypeSegment.selectedSegmentIndex = 0
       
    }//end of viewDidLoad
    
    
    
    //ALL CONSTRAINTS
    
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
 
    func setUpSellButton(){
        //x and y
        sellButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sellButton.topAnchor.constraint(equalTo: ticketTypeSegment.bottomAnchor, constant: 30).isActive = true
        
        //w and h
        sellButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        sellButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpClearButton(){
        //x and y
        clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        clearButton.topAnchor.constraint(equalTo: sellButton.bottomAnchor, constant:8).isActive = true
        //w and height
        clearButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        clearButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @IBAction func handleLogout(_ sender: Any) {
        
        let account = AccountViewController()
        let navController = UINavigationController(rootViewController: account)
        present(navController, animated: true, completion: nil)
    }
    
    func sellButtonClicked(){
        checkForFilledInForms()
    }
    
    func checkForFilledInForms(){
        //check for empty forms
        if ((eventNameTextfield.text == "") || (venueTextfield.text == "") || (locationTextfield.text == "") || (dateTextfield.text == "") || (priceTextfield.text == "") || (infoTextfield.text == "")) {
            //alert user that form is not complete
            let alertController = UIAlertController(title: "Please fill in all forms", message: "", preferredStyle: .alert)
            alertController.view.tintColor = UIColor(r:255, g:149, b:0)
            let action1 = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action1)
            present(alertController, animated: true, completion: nil)
        }
        else{
            //if forms are filled in, check if price is formatted correctly
            if (checkPriceFormat(price: priceTextfield.text!)){
               //alert user to confirm sell ticket
                let alertController = UIAlertController(title:"About to sell ticket", message: "Are all details correct?", preferredStyle: .alert)
                alertController.view.tintColor = UIColor(r:255, g:149, b:0)
                let action1 = UIAlertAction(title: "Yes, sell ticket", style: .default){
                    UIAlertAction in
                    self.uploadTicketToDatabase()
                    self.tabBarController?.selectedIndex = 0
                    self.clearTextfields()
                }
                let action2 = UIAlertAction(title: "No, edit ticket", style: .cancel, handler: nil)
                alertController.addAction(action2)
                alertController.addAction(action1)
                present(alertController, animated: true, completion: nil)
            }
            //price is not correct
            else{
                //alert user that price is not correct
                let alertController = UIAlertController(title: "Please use correct price format", message: "e.g. 9.99 or 15.50", preferredStyle: .alert)
                alertController.view.tintColor = UIColor(r:255, g:149, b:0)
                let action1 = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action1)
                present(alertController, animated: true, completion: nil)
            }           
        }
    }
    
    
    func checkPriceFormat(price: String) -> Bool{
        var isValidCurrencyFormat = false
        
        guard let priceAsDouble = Double(price) else {
            return false
        }
        
       
        
        isValidCurrencyFormat = true
        if Double(priceAsDouble) * 100 != floor(Double(priceAsDouble) * 100) {
            isValidCurrencyFormat = false
            return isValidCurrencyFormat
        }
        
        if price != price.trimmingCharacters(in: .whitespacesAndNewlines) {
            isValidCurrencyFormat = false
            return isValidCurrencyFormat
        }
        
        return isValidCurrencyFormat
    }
    
    func uploadTicketToDatabase(){
        //create refernce to tickets node in database
        let ref = FIRDatabase.database().reference().child("tickets")
        //create a unique ID for the ticket
        let childRef = ref.childByAutoId()
        //get the seller ID from current user
        let sellerId = FIRAuth.auth()?.currentUser?.uid
        //create variables for each input data
        let eventName = eventNameTextfield.text
        let venue = venueTextfield.text
        let location = locationTextfield.text
        let date = dateTextfield.text
        let price = priceTextfield.text
        let ticketInfo = infoTextfield.text
        let ticketType = ticketTypeSegment.selectedSegmentIndex == 0 ? "Digital" : "Paper"
        let status = "selling"
        //convert price into currency
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "en_UK")
        numberFormatter.usesGroupingSeparator = true
        let priceAsDouble = Double(price!)
        let priceString = numberFormatter.string(from: priceAsDouble! as NSNumber)
        //create dictionary of data to upload to database
        let values = ["sellerId": sellerId!, "eventName": eventName!, "venue": venue!, "location": location!, "date": date!, "price": priceString!, "ticketInfo": ticketInfo!, "ticketType": ticketType, "status": status] as [String: Any]
        //add the values into the ticket reference under the ticket ID
        childRef.updateChildValues(values) { (error, ref) in
            //check for errors
            if error != nil{
                print(error!)
                return
            }
            //upload successful
            //get the ticket ID
            let ticketID = childRef.key
            //add the ticket ID to "selling-tickets" node - used for accounts section and displaying selling tickets
            FIRDatabase.database().reference().child("selling-tickets").child(sellerId!).updateChildValues([ticketID:1])
        }
    }
    
    func clearButtonClicked(){
        let alertController = UIAlertController(title: "Clear all?", message: "", preferredStyle: .alert)
        alertController.view.tintColor = UIColor(r:255, g:149, b:0)
        let action1 = UIAlertAction(title: "No", style: .default, handler: nil)
        let action2 = UIAlertAction(title: "Yes", style: .default){
            UIAlertAction in
            self.clearTextfields()
        }
        
        alertController.addAction(action1)
        alertController.addAction(action2)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    func clearTextfields(){
        eventNameTextfield.text = ""
        venueTextfield.text = ""
        locationTextfield.text = ""
        priceTextfield.text = ""
        infoTextfield.text = ""
        dateTextfield.text = ""
        ticketTypeSegment.selectedSegmentIndex = 0
    }
    
    
}
