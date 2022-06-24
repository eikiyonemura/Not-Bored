//
//  TabBarController.swift
//  Not Bored
//
//  Created by Douglas Eiki Yonemura on 23/06/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    var participantsInitial: String?
    var priceRange: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupViewController() {
        
        guard let participantsInitial = participantsInitial else {
            return
        }
        
        guard let priceRange = priceRange else {
            return
        }

        
        let firstTabTitle = "Activities"
        let firstTabImage = UIImage(systemName: "list.dash")
        let firstTab = ActivitiesViewController(nibName: "ActivitiesViewController", bundle: nil)
        firstTab.participantsInitial = participantsInitial
        firstTab.priceRange = priceRange
        firstTab.title = firstTabTitle
        let firstNavigationController = UINavigationController(rootViewController: firstTab)
        firstNavigationController.tabBarItem = UITabBarItem(title: firstTabTitle, image: firstTabImage, selectedImage: firstTabImage)
        
        let secondTabTitle = "Sugestion"
        let secondTabImage = UIImage(systemName: "shuffle")
        let secondTab = SugestionViewController(nibName: "SugestionViewController", bundle: nil)
        secondTab.participantsInitial = participantsInitial
        secondTab.priceRange = priceRange
        secondTab.titulo = "Random"
        secondTab.title = secondTabTitle
        let secondNavigationController = UINavigationController(rootViewController: secondTab)
        secondNavigationController.tabBarItem = UITabBarItem(title: secondTabTitle, image: secondTabImage, selectedImage: secondTabImage)
        
        viewControllers = [firstNavigationController, secondNavigationController]
    }

}
