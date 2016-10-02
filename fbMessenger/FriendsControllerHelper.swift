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
    
    func clearData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            do {
                
                let entityNames = ["Friend", "Message"]
                
                for entity in entityNames {
                    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
                    //let fetchRequest = NSFetchRequest(entityName: entity)
                    
                    let objects = try(context.fetch(fetchRequest)) as? [NSManagedObject]
                    
                    for object in objects! {
                        context.delete(object)
                    }
                }
                
                try(context.save())
               
            } catch let err {
                print(err)
            }
        }
    }
    
    func setupData() {
        
        clearData()
        
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
            
            createMessageWithText(text: "Good morning...", friend: steve, minutesAgo: 2, context: context)
            createMessageWithText(text: "Hello, how are you?", friend: steve, minutesAgo: 1, context: context)
            createMessageWithText(text: "Are you interested in buying an Apple device?", friend: steve, minutesAgo: 0, context: context)

            do {
                try(context.save())
            } catch let err {
                print(err)
            }
            
            //messages = [message, messageSteve]
        }
        
        loadData()
        
    }
    
    func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext) {
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60) as NSDate?
        
    }
    
    func loadData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
            
            do {
                messages = try(context.fetch(fetchRequest)) as [Message]
            } catch let err {
                print(err)
            }
        }
    }
    
    
}
