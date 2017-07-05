//
//  Message.swift
//  FinalProject
//
//  Created by Bradley Cavendish on 21/03/2017.
//  Copyright © 2017 Bradley Cavendish. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {

    var fromId: String?
    var text: String?
    var timestamp: Int?
    var toId: String?
    
    func chatPartnerId() -> String?{
        return fromId == FIRAuth.auth()?.currentUser?.uid ? toId : fromId
    }
}
