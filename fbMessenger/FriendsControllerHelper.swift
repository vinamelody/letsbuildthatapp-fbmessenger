//
//  FriendsControllerHelper.swift
//  fbMessenger
//
//  Created by Vina Melody on 1/10/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class Friend: NSObject {
    
    var name: String?
    var profileImageName: String?
    
}

class Message: NSObject {
    
    var text: String?
    var date: Date?
    
    var friend: Friend?
}

extension FriendsController {
    
    func setupData() {
        
        let mark = Friend()
        mark.name = "Mark Zuckerberg"
        mark.profileImageName = "zuckprofile"
        
        let message = Message()
        message.friend = mark
        message.text = "Hello, my name is Mark. Nice to meet you ..."
        message.date = Date()
        
        let steve = Friend()
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        let messageSteve = Message()
        messageSteve.friend = steve
        messageSteve.text = "Apple creates the greates iOS devices for the world ..."
        messageSteve.date = Date()
        
        messages = [message, messageSteve]
    }
    
}
