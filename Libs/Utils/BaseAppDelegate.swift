//
//  BaseAppDelegate.swift
//  fex-ios
//
//  Created by Vinicius Gibran on 23/06/17.
//  Copyright © 2017 fexsaude. All rights reserved.
//

import UIKit

class BaseAppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Variables
    open var window: UIWindow?
    var stackCoontrollValue = 0
    var application: UIApplication!
    var baseRootNavigation: UINavigationController!
    
    //MARK: - Application
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        return true
    }
    
    /**
     Cria um `UINavigationController` com o `UIViewController` inicial passado e associa a uma `UIWindow`.
     - important: Este método deve ser chamado no didFinishLaunchingWithOptions.
     - returns: Uma `UIWindow` configurada para este app.
     */
    open func createMainWindow() -> UIWindow {
        
        //status bar for this app
        UIApplication.shared.statusBarView()?.backgroundColor = StatusBarUtils.hexStringToUIColor(hex: "#0B6340")
        
        //custom window for this app
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = createSideMenu()
        window.clipsToBounds = true
        
        window.makeKeyAndVisible()
        
        return window
    }
    
    open func createSideMenu() -> UINavigationController {
//        let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "MainViewController") as UIViewController
        let vc = MapViewController(nibName: "MapViewController", bundle: nil)
        let rootNavigation = UINavigationController(rootViewController: vc)
      
        
        return rootNavigation
    }
}

//Singleton
extension BaseAppDelegate {
    
    //MARK: - Singleton
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func getStackValue() -> Int {
        return stackCoontrollValue
    }
    
    //MARK: - Setters
    func setSatckValue(stackValue value: Int) {
        self.stackCoontrollValue = value
    }
    
    //MARK: - Getters
    func getApplication() -> UIApplication {
        return application
    }
    
    func getRootNavigation() -> UINavigationController {
        return baseRootNavigation
    }
    
    
    
}
