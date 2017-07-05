//
//  ChatMessageCell.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 22/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {

    let textview: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.backgroundColor = UIColor.clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        
        return tv
    }()
    
    let bubbleView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(r:255, g:149, b:0)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleViewLeftAnchor: NSLayoutConstraint?
    var bubbleViewRightAnchor: NSLayoutConstraint?
    
    override init(frame: CGRect){
         super.init(frame: frame)
        
        addSubview(bubbleView)
        addSubview(textview)
        
        //bubbleview contraints
        bubbleViewRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)
        
        bubbleViewRightAnchor?.isActive = true
        
        bubbleViewLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8)
        
        
        bubbleView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bubbleWidthAnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnchor?.isActive = true
        bubbleView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        //textview contraints
        textview.leftAnchor.constraint(equalTo: bubbleView.leftAnchor, constant: 8).isActive = true
        textview.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textview.rightAnchor.constraint(equalTo: bubbleView.rightAnchor).isActive = true
        textview.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

