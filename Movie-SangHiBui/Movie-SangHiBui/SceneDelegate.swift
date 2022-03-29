//
//  SceneDelegate.swift
//  Movie-SangHiBui
//
//  Created by Tien Cong on 21/10/2021.
//

import UIKit
import FBSDKCoreKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        // add these lines
        let storyboard = UIStoryboard(name: "NewFeed", bundle: nil)
        
        // if user is logged in before
        if let sessionID = UserDefaults.standard.string(forKey: "UserService_Session_ID"),
           let accountID = UserDefaults.standard.value(forKey: "UserService_Account_ID") as? Int {
            // instantiate the main tab bar controller and set it as root view controller
            // using the storyboard identifier we set earlier
            UserService.shared.setSessionID(with: sessionID)
            UserService.shared.setAccountID(with: accountID)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "BaseTabBarController")
            window?.rootViewController = mainTabBarController
        } else {
            // if user isn't logged in
            // instantiate the navigation controller and set it as root view controller
            // using the storyboard identifier we set earlier
            let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
            window?.rootViewController = loginNavController
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        // change the root view controller to your specific view controller
        window.rootViewController = vc
        
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)
    }
    
    
}

