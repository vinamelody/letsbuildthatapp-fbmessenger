//
//  FriendsControllerHelper.swift
//  fbMessenger
//
//  Created by Vina Melody on 1/10/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit
import CoreData

//class Friend: NSObject {
//    
//    var name: String?
//    var profileImageName: String?
//    
//}
//
//class Message: NSObject {
//    
//    var text: String?
//    var date: Date?
//    
//    var friend: Friend?
//}

extension FriendsController {
    
    func setupData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let mark = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            mark.name = "Mark Zuckerberg"
            mark.profileImageName = "zuckprofile"
            
            let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            message.friend = mark
            message.text = "Hello, my name is Mark. Nice to meet you ..."
            message.date = Date() as NSDate?
            
            let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            steve.name = "Steve Jobs"
            steve.profileImageName = "steve_profile"
            
            let messageSteve = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
            messageSteve.friend = steve
            messageSteve.text = "Apple creates the greates iOS devices for the world ..."
            messageSteve.date = Date() as NSDate?
            
            do {
                try(context.save())
            } catch let err {
                print(err)
            }
            
            messages = [message, messageSteve]
        }
        
    }
    
}
