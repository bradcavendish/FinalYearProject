//
//  AccountViewController.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 29/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase
class AccountViewController: UIViewController {

    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r:110,g:110,b:110)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor(r:255, g:149, b:0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()
    
    let sellingButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r:110,g:110,b:110)
        button.setTitle("View your tickets up for sale", for: .normal)
        button.setTitleColor(UIColor(r:255, g:149, b:0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(viewSellingTickets), for: .touchUpInside)
        return button
        
    }()
    
    let soldButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r:110,g:110,b:110)
        button.setTitle("View your sold tickets", for: .normal)
        button.setTitleColor(UIColor(r:255, g:149, b:0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(viewSoldTickets), for: .touchUpInside)
        return button
        
    }()
    
    let boughtButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r:110,g:110,b:110)
        button.setTitle("View tickets bought", for: .normal)
        button.setTitleColor(UIColor(r:255, g:149, b:0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(viewBoughtTickets), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r:128, g: 128, b: 128)
        self.navigationItem.title = "Account"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        self.navigationController?.navigationBar.tintColor = UIColor(r:255, g:149, b:0)
        
        
        view.addSubview(logoutButton)
        view.addSubview(sellingButton)
        view.addSubview(soldButton)
        view.addSubview(boughtButton)
        
        constraints()
    }
    
    func constraints(){
        
        //logout button
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        
        //selling button
        sellingButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        sellingButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        sellingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sellingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        
        //sold button
        soldButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        soldButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        soldButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        soldButton.topAnchor.constraint(equalTo: sellingButton.bottomAnchor, constant: 20).isActive = true
        
        //bought button
        boughtButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/4).isActive = true
        boughtButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        boughtButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        boughtButton.topAnchor.constraint(equalTo: soldButton.bottomAnchor, constant: 20).isActive = true
    }

    func viewSellingTickets(){
        let sellingTickets = SellingTicketsTableView()
        let navController = UINavigationController(rootViewController: sellingTickets)
        present(navController, animated: true, completion: nil)
    }
    
    func viewSoldTickets(){
        let soldTickets = SoldTicketTableView()
        let navController = UINavigationController(rootViewController: soldTickets)
        present(navController, animated: true, completion: nil)
    }
    
    func viewBoughtTickets(){
        let boughtTickets = BoughtTicketsTableView()
        let navController = UINavigationController(rootViewController: boughtTickets)
        present(navController, animated: true, completion: nil)
    }
  
    func handleDone(){
        dismiss(animated: true, completion: nil)
    }
    
    func handleLogout(){
        do{
            try FIRAuth.auth()?.signOut()
        }
        catch let logoutError{
            print(logoutError)
        }
        print("logout successful")
        
        let login = LoginViewController()
        present(login, animated: true, completion: nil)
    }

}
