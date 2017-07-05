//
//  SellingTicketsTableView.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 29/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class SellingTicketsTableView: UITableViewController {

    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ticketViewCell.self, forCellReuseIdentifier: cellId)
        self.navigationItem.title = "Selling tickets"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        self.navigationController?.navigationBar.tintColor = UIColor(r: 255, g: 149, b: 0)
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        tickets.removeAll()
        tableView.reloadData()
        findTickets()
        
        
    }

    var tickets = [Ticket]()

    func findTickets(){
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        FIRDatabase.database().reference().child("selling-tickets").child(uid!).observe(.childAdded, with: { (snapshot) in
            
            let ticketId = snapshot.key
            
            FIRDatabase.database().reference().child("tickets").child(ticketId).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    let ticket = Ticket()
                    ticket.date = dictionary["date"] as! String?
                    ticket.eventName = dictionary["eventName"] as! String?
                    ticket.location = dictionary["location"] as! String?
                    ticket.price = dictionary["price"] as! String?
                    ticket.sellerId = dictionary["sellerId"] as! String?
                    ticket.venue = dictionary["venue"] as! String?
                    ticket.ticketInfo = dictionary["ticketInfo"] as! String?
                    ticket.ticketType = dictionary["ticketType"] as! String?
                    ticket.status = dictionary["status"] as! String?
                    
                    if ticket.status == "selling"{
                        self.tickets.append(ticket)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                    
                }
                
                
                
            }, withCancel: nil)
            
        }, withCancel: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ticket = tickets[indexPath.row]
        
        let detail = ticketDetail()
        detail.ticket = ticket
        detail.buyButton.isHidden = true
        detail.messageButton.isHidden = true
        navigationController?.pushViewController(detail, animated: true)
        
    }
 
    func handleDone(){
        dismiss(animated: true, completion: nil)
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

}
