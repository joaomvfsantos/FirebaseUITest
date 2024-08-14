//
//  AppDelegate.swift
//  FirebaseUITest
//
//  Created by João Santos on 12/08/2024.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseOAuthUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate, FUIAuthDelegate {

    var authUI: FUIAuth?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        self.authUI = FUIAuth.defaultAuthUI()
        self.authUI?.delegate = self
        
        let providers = [
            self.googleProvider(),
            self.appleProvider()
        ].compactMap({ $0 })
        
        self.authUI?.providers = providers
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
        if self.authUI?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
            return true
        }
        return false
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
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        // Never called
        print("-------->")
        print(authDataResult)
        print(error)
    }

    private func googleProvider() -> FUIAuthProvider? {
        guard let authUI = self.authUI else { return nil }
        
        return FUIGoogleAuth(authUI: authUI)
    }
    
    private func appleProvider() -> FUIAuthProvider? {
        guard let authUI = self.authUI else { return nil }
        
        return FUIOAuth.appleAuthProvider(withAuthUI: authUI)
    }

}

