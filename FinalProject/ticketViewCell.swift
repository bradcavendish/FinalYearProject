//
//  ticketViewCell.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 29/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit

class ticketViewCell: UITableViewCell {

    var ticket: Ticket?{
        didSet{
            dateLabel.text = ticket?.date
            textLabel?.text = ticket?.eventName
            detailTextLabel?.text = "Venue: " + (ticket?.venue)!
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //name and text labels
        textLabel?.frame = CGRect(x: 20, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 30, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    //create date label
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        //add time table to cell view
        addSubview(dateLabel)
        
        //constraints for time label
        dateLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 40).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        dateLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
