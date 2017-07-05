//
//  UserCell.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 22/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class UserCell: UITableViewCell{
    
    //
    
    var message: Message?{
        didSet{
            
            
            
            
            
            if let id = message?.chatPartnerId() {
                let ref = FIRDatabase.database().reference().child("users").child(id)
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject]{
                        self.textLabel?.text = dictionary["name"] as? String
                    }
                    
                }, withCancel: nil)
            }
            
            detailTextLabel?.text = message?.text
            
            if let seconds = message?.timestamp{
                let timestampDate = NSDate(timeIntervalSince1970: TimeInterval(seconds))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm dd-MM-yyyy"
                timeLabel.text = dateFormatter.string(from: timestampDate as Date)
            }
            
            
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //name and text labels
        textLabel?.frame = CGRect(x: 20, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: 30, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    //create time label
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        //add time table to cell view
        addSubview(timeLabel)
        
        //constraints for time label
        timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 40).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        timeLabel.widthAnchor.constraint(equalToConstant: 160).isActive = true
        timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
