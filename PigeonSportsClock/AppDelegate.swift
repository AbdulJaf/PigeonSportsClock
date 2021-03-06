//
//  AppDelegate.swift
//  PigeonSportsClock
//
//  Created by Anand on 18/03/22.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyDAXEPWB9n-gFZZAfszIQoUiQX8poyodTk")
        GMSPlacesClient.provideAPIKey("AIzaSyDAXEPWB9n-gFZZAfszIQoUiQX8poyodTk")
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white

      



//        let left = UIStoryboard(name: "Storyboard", bundle: nil).instantiateInitialViewController()
//        let center = UIStoryboard(name: "OnBoard", bundle: nil).instantiateInitialViewController()!
        
      //  let drawer = DrawerMenu(center: center, left: left)
       // drawer.style = Overlay()
       // window?.rootViewController = drawer
        window?.makeKeyAndVisible()
        IQKeyboardManager.shared.enable = true
        
        
        return true
        
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

