//
//  CustomTabBarController.swift
//  fbMessenger
//
//  Created by Vina Melody on 3/10/16.
//  Copyright © 2016 Vina Rianti. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the friendsController
        let layout = UICollectionViewFlowLayout()
        let friendsController = FriendsController(collectionViewLayout: layout)
        let recentMessagesNavController = UINavigationController(rootViewController: friendsController)
        recentMessagesNavController.tabBarItem.title = "Recent"
        recentMessagesNavController.tabBarItem.image = UIImage(named: "recent")
        
        
        viewControllers = [recentMessagesNavController, createDummyNavControllerWithTitle(title: "Calls", imageName: "calls"),
                           createDummyNavControllerWithTitle(title: "Groups", imageName: "groups"),
                           createDummyNavControllerWithTitle(title: "People", imageName: "people"),
                           createDummyNavControllerWithTitle(title: "Settings", imageName: "settings")]
    }
    
    private func createDummyNavControllerWithTitle(title: String, imageName: String) -> UINavigationController {
        
        let vc = UIViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        return  navController
    }
}
