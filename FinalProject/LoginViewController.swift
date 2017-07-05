//
//  LoginViewController.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 07/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //input container view properties
    let inputsContainerView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = true
        return view
        
    }()
    
    //make button underneath container view
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r:110,g:110,b:110)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(r:255, g:149, b:0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    //make text field for container view
    let nameTextField: UITextField = {
        let nameTF = UITextField()
        nameTF.placeholder = "Name"
        nameTF.returnKeyType = UIReturnKeyType.done
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        return nameTF
    }()
    
    //make line under name text field
    let nameSeperator: UIView = {
        let nameLine = UIView()
        nameLine.backgroundColor = UIColor(r:220,g:220,b:220)
        nameLine.translatesAutoresizingMaskIntoConstraints = false
        return nameLine
    }()
    
    //make email text field
    let emailTextField: UITextField = {
        let emailTF = UITextField()
        emailTF.placeholder = "Email"
        emailTF.returnKeyType = UIReturnKeyType.done
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        return emailTF
    }()
    
    //make line under email text field
    let emailSeperator: UIView = {
        let emailLine = UIView()
        emailLine.backgroundColor = UIColor(r:220,g:220,b:220)
        emailLine.translatesAutoresizingMaskIntoConstraints = false
        return emailLine
    }()
    
    //make password text field
    let passwordTextField: UITextField = {
        let passwordTF = UITextField()
        passwordTF.placeholder = "Password"
        passwordTF.returnKeyType = UIReturnKeyType.done
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.isSecureTextEntry = true
        return passwordTF
    }()
    
    //logo image
    let logoImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "eq image.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //make label for logo
    let logoLabel: UILabel = {
        let logo = UILabel()
        logo.text = "Can I sell this ticket?"
        logo.font = UIFont(name: "Copperplate-Light", size: 24)
        logo.textColor = UIColor(r:255,g:149,b:0)
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    //make segmented controller for login/register
    let loginRegisterSC: UISegmentedControl = {
        let SC = UISegmentedControl(items: ["Login", "Register"])
        SC.translatesAutoresizingMaskIntoConstraints = false
        SC.selectedSegmentIndex = 0
        SC.layer.cornerRadius = 7
        SC.backgroundColor = UIColor.white
        SC.tintColor = UIColor(r:255, g:149, b:0)
        SC.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return SC
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set background colour - grey
        view.backgroundColor = UIColor(r:128, g: 128, b: 128)
        
        self.nameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        //add suviews to main view
        view.addSubview(logoLabel)
        view.addSubview(logoImage)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginButton)
        view.addSubview(loginRegisterSC)
        
        //set contraints each subview
        setUpLogoLabel()
        setUpInputsContainerView()
        setUpLoginButton()
        setUpLoginRegisterSC()
        
        handleLoginRegisterChange()
        
    }//END OF VIEW DID LOAD
    
    override func viewWillAppear(_ animated: Bool) {
        
        //set status bar to light
        UIApplication.shared.statusBarStyle = .lightContent
        
        clearLoginRegisterTextfields()
        loginRegisterSC.selectedSegmentIndex = 0
        
        handleLoginRegisterChange()
    }
    
    func setUpLogoLabel(){
        
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 240).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        //x and y
        logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoLabel.centerYAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 20).isActive = true
        
        
        
    }

    //hold the height for input container view
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    //hold height of name text field
    var nameTextFieldHeightAnchor: NSLayoutConstraint?
    //hold height for email text field
    var emailTextFieldHeightAnchor: NSLayoutConstraint?
    //hold height for password text field
    var passwordTextFieldHeightAnchor: NSLayoutConstraint?
    
    func setUpInputsContainerView(){
        //Contraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        //w and h
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 100)
        inputsContainerViewHeightAnchor?.isActive = true
        
        //insert name text field
        inputsContainerView.addSubview(nameTextField)
        
        //insert line under name text field
        inputsContainerView.addSubview(nameSeperator)
        
        //insert email text field
        inputsContainerView.addSubview(emailTextField)
        
        //insert line under email text field
        inputsContainerView.addSubview(emailSeperator)
        
        //insert password textbox
        inputsContainerView.addSubview(passwordTextField)
        
        //constraints for name text view
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        nameTextFieldHeightAnchor?.isActive = true
        
        //constriants for line under name text view
        nameSeperator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeperator.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeperator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //constraints for email text field
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSeperator.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //constraints for line under email text field
        emailSeperator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeperator.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeperator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        //constraints for password text field
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeperator.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
        
    }
    
    func setUpLoginButton(){
        //Constraints
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        
        //w and h
        loginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setUpLoginRegisterSC(){
        //x and y
        loginRegisterSC.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSC.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        
        //w and h
        loginRegisterSC.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterSC.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    //button action
    func buttonAction(sender: UIButton!){
        
        //is the user trying to log in or register?
        if sender.titleLabel?.text == "Register"
        {
            handleRegister()
        }
        else{
            handleLogin()
        }
       
        
    }
    
    
    func handleLogin(){
        //guard let statement to create variables for email + password
        guard let email = emailTextField.text, let password = passwordTextField.text else{
            print("login form not valid")
            return
        }
        //use Firebase Auth to log in
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            //handle errors
            if error != nil{
                print(error!)
                //alert user of incorrect password/email
                let alert = UIAlertController(title: "Incorrect Login Details", message: "Email and/or password incorrect", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            //log in was successful
            //reset messages in the message screen to avoid bug that shows previous users messages
            let messagesController = MessageTableViewController()
            messagesController.resetMessages()
            //user will go into the app
            let mainST = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = mainST.instantiateViewController(withIdentifier: "tabBarController")
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    func handleRegister(){
        //guard statement to create variables for name, email, password
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else{
            print("register form not valid")
            return
        }
        
        //user Firebase Auth to create a user - this will also log user in if successful
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user: FIRUser?, error) in
            
            //if there is an error
            if error != nil{
                print(error!)
                //alert user of error
                let alert = UIAlertController(title: "Invalid Details", message: "Email must be valid and password must be at least 6 characters", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            //successfully authenticated user - no error
            //create user ID
            guard let uid = user?.uid else{
                return
            }
            //create reference to database
            let ref = FIRDatabase.database().reference(fromURL: "https://finalproject-11aa3.firebaseio.com/")
            //add a child reference of "users" and user ID
            let usersRef = ref.child("users").child(uid)
            //set values to pass into previous reference
            let values = ["name": name, "email": email]
            //update the reference with these values
            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                //handle any error
                if err != nil{
                    print(err!)
                    print("user not saved")
                    return
                }
                //user will go into the app
                let mainST = UIStoryboard(name: "Main", bundle: Bundle.main)
                let vc = mainST.instantiateViewController(withIdentifier: "tabBarController")
                self.present(vc, animated: true, completion: nil)
            })
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    
    //login or register
    func handleLoginRegisterChange(){
        
        //set login/register button title = to title at the segment on the switch
        let title = loginRegisterSC.titleForSegment(at: loginRegisterSC.selectedSegmentIndex)
        loginButton.setTitle(title, for: .normal)
        
        //function that clears the text in the fields
        clearLoginRegisterTextfields()
        
        //change height of input view container
        inputsContainerViewHeightAnchor?.constant = loginRegisterSC.selectedSegmentIndex == 0 ? 100 : 150
        
        //change height of name text field
        nameTextFieldHeightAnchor?.isActive = false
        nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSC.selectedSegmentIndex == 0 ? 0 : 1/3)
        
        //hide name text field
        nameTextField.isHidden = loginRegisterSC.selectedSegmentIndex == 0
        nameTextFieldHeightAnchor?.isActive = true
        
        //change height of email text field
        emailTextFieldHeightAnchor?.isActive = false
        emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSC.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        emailTextFieldHeightAnchor?.isActive = true
        
        //change height of password 
        passwordTextFieldHeightAnchor?.isActive = false
        passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSC.selectedSegmentIndex == 0 ? 1/2 : 1/3)
        passwordTextFieldHeightAnchor?.isActive = true
    }
    
    
    func clearLoginRegisterTextfields(){
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    
}

//convenience to make picking colours easier
//can be used by any class
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}


