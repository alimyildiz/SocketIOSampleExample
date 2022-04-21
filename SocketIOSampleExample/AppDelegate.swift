//
//  AppDelegate.swift
//  SocketIOSampleExample
//
//  Created by Alim Yıldız on 4/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let socketIOView = MenuViewController(nibName: "MenuViewController", bundle: nil)
        //socketIOView.view.backgroundColor = .red
        let nv = UINavigationController(rootViewController: socketIOView)
       // nv.navigationBar.backgroundColor = .red
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nv
        window?.makeKeyAndVisible()
        return true
    }

   


}

