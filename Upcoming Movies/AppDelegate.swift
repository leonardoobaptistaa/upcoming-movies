//
//  AppDelegate.swift
//  Upcoming Movies
//
//  Created by Leonardo Baptista on 9/3/18.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Auto change to fake server when testing UI
        if ProcessInfo.processInfo.arguments.contains("--uitesting") {
            APIService.apiUrl = "http://localhost:8080/"
        }
        
        return true
    }
}
