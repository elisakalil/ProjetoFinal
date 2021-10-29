
//  AppDelegate.swift
//  ProjetoFinal
//  Created by Elisa Kalil, Rayana Prata Neves and Marilise Cristine Morona on 18/10/21.

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupRootViewController()
        return true
    }
    
    private func setupRootViewController() {
        
        let viewController: UIViewController = InitialViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
            DataBaseController.saveContext()
        }

}
