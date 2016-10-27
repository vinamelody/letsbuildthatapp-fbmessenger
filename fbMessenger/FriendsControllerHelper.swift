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
            
            createSteveMessagesWithContext(context: context)
            
            let donald = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            donald.name = "Donald Trump"
            donald.profileImageName = "donald_trump_profile"
            
            createMessageWithText(text: "You're fired!", friend: donald, minutesAgo: 5, context: context)
            
            let gandhi = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            gandhi.name = "Mahatma Gandhi"
            gandhi.profileImageName = "gandhi"
            
            createMessageWithText(text: "Love, peace and joy.....", friend: gandhi, minutesAgo: 60 * 24, context: context)
            
            let hillary = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            hillary.name = "Hillary Clinton"
            hillary.profileImageName = "hillary_profile"
            
            createMessageWithText(text: "Please do not vote fore me, you did for Billy!", friend: hillary, minutesAgo: 8 * 60 * 24, context: context)

            do {
                try(context.save())
            } catch let err {
                print(err)
            }
            
            //messages = [message, messageSteve]
        }
        
        loadData()
        
    }
    
    func createSteveMessagesWithContext(context: NSManagedObjectContext) {
        
        let steve = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
        steve.name = "Steve Jobs"
        steve.profileImageName = "steve_profile"
        
        createMessageWithText(text: "Good morning...", friend: steve, minutesAgo: 3, context: context)
        createMessageWithText(text: "Hello, how are you? Hope you are having a good breakfast.", friend: steve, minutesAgo: 2, context: context)
        createMessageWithText(text: "Are you interested in buying an Apple device? We just launched new iPhone 7 that has three different capacity options which are 64GB, 128GB and 256GB. ", friend: steve, minutesAgo: 1, context: context)
        
        // response message
        
        createMessageWithText(text: "Yes i want to buy iPhone 7, what's the price?", friend: steve, minutesAgo: 1, context: context, isSender: true)
        
        createMessageWithText(text: "Totally understand that you want the new iphone 7 but you will have to wait until Setpmber ", friend: steve, minutesAgo: 1, context: context)
        
        createMessageWithText(text: "Absolutely i just bear with my current second hand iphone", friend: steve, minutesAgo: 1, context: context, isSender: true)
        
    }
    
    func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext, isSender: Bool = false) {
        
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = Date().addingTimeInterval(-minutesAgo * 60) as NSDate?
        message.isSender = NSNumber(booleanLiteral: isSender) as Bool
    }
    
    func loadData() {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            if let friends = fetchFriends() {
                
                messages = [Message]()
                
                for friend in friends {
                    
                    let fetchRequest: NSFetchRequest<Message> = Message.fetchRequest()
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do {
                        let fetchedMessages = try(context.fetch(fetchRequest)) as [Message]
                        messages?.append(contentsOf: fetchedMessages)
                        
                    } catch let err {
                        print(err)
                    }
                    
                }
                
                messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
                //messages = messages?.sorted(by: areInIncreasingOrder($0.date!, $1.date!) -> false)
            }
            
            
            
            
        }
    }
    
    private func fetchFriends() -> [Friend]? {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext {
            
            let request: NSFetchRequest<Friend> = Friend.fetchRequest()
            
            do {
                return try(context.fetch(request)) as [Friend]
            } catch let err {
                print(err)
            }
        }
        return nil
    }
    
    
}
