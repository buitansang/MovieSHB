//
//  BaseTabBarController.swift
//  Movie-SangHiBui
//
//  Created by Sang Hi Bùi on 27/12/2021.
//

import UIKit

class BaseTabBarController: UITabBarController {

    var customTabBar: CustomTabBar!
    var tabBarHeight: CGFloat = 77.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
    }

    func loadTabBar() {
        
        let tabbarItems: [TabItem] = [.home, .favorite, .profile]
        setupCustomTabMenu(tabbarItems)
        
        selectedIndex = 0
    }

    func setupCustomTabMenu(_ menuItems: [TabItem]) {
        
        let frame = tabBar.frame

        // Ẩn tab bar mặc định của hệ thống đi
        tabBar.isHidden = true
        // Khởi tạo custom tab bar
        customTabBar = CustomTabBar(menuItems: menuItems, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.itemTapped = changeTab(tab:)
        
        view.addSubview(customTabBar)
        view.backgroundColor = UIColor(named: "xanhdam")

        // Auto layout cho custom tab bar
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            customTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: 35)
        ])
        view.layoutIfNeeded()

    }
    
    func setupViewControllers() {
        let navNewfeedVC = self.viewControllers![0] as! UINavigationController
        let newfeedTab = navNewfeedVC.viewControllers[0] as! NewFeedViewController
        
        let navFavoriteVC = self.viewControllers![1] as! UINavigationController
        let favoriteTab = navFavoriteVC.viewControllers[0] as! FavoriteMovieViewController
        
        
        let navProfileVC = self.viewControllers![2] as! UINavigationController
        let profileTab = navProfileVC.viewControllers[0] as! ProfileViewController
        
    }

    func changeTab(tab: Int) {
        
        self.selectedIndex = tab
    }

}

