//
//  AppDelegate.swift
//  ClickSrvicesApp
//
//  Created by Vinicius Gibran on 07/11/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: BaseAppDelegate {

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Session.shared.appLocationManager.requestLocation()
        
        self.application = application
        
        //init main window
        window = createMainWindow()
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        return FacebookUtils.didFinishLaunchWith(application: application, launchOptions: launchOptions)
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {
        FacebookUtils.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {}
    
    //MARK: Facebook
    //facebook
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FacebookUtils.openSourceApplication(application: application, url: url, sourceApplication: sourceApplication, annotation: annotation)
    }
}

