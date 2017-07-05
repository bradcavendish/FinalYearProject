//
//  TicketTableViewController.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 29/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class TicketTableViewController: UITableViewController {

    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .default
        tableView.register(ticketViewCell.self, forCellReuseIdentifier: cellId)
        self.navigationItem.title = "Buy"
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tickets.removeAll()
        tableView.reloadData()
        findTickets()
    }
    
    
    
    
    var tickets = [Ticket]()
    
    
    func findTickets(){
        //get reference to tickets node in database
        FIRDatabase.database().reference().child("tickets").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject]{
                //create a Ticket object
                let ticket = Ticket()
                //populate the attributes of Ticket
                ticket.date = dictionary["date"] as! String?
                ticket.eventName = dictionary["eventName"] as! String?
                ticket.location = dictionary["location"] as! String?
                ticket.price = dictionary["price"] as! String?
                ticket.sellerId = dictionary["sellerId"] as! String?
                ticket.venue = dictionary["venue"] as! String?
                ticket.ticketInfo = dictionary["ticketInfo"] as! String?
                ticket.ticketType = dictionary["ticketType"] as! String?
                ticket.status = dictionary["status"] as! String?
                ticket.ticketId = snapshot.key
                //add ticket to array of tickets to display if its status is "selling"
                if ticket.status == "selling"{
                    self.tickets.append(ticket)
                    //reload table view on async to avoid errors
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }, withCancel: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ticketViewCell
        
        let ticket = tickets[indexPath.row]
        cell.ticket = ticket
        
        return cell
    }
    
    //set height of rows
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //get the ticket the user clicked on
        let ticket = tickets[indexPath.row]
        //get a reference to the detail screen
        let detail = ticketDetail()
        //pass the ticket data to the detail screen
        detail.ticket = ticket
        detail.ticketId = ticket.ticketId
        //show the detail screen
        navigationController?.pushViewController(detail, animated: true)
    }
    
    @IBAction func handleLogout(_ sender: UIBarButtonItem) {
        let account = AccountViewController()
        let navController = UINavigationController(rootViewController: account)
        present(navController, animated: true, completion: nil)
    }

}
