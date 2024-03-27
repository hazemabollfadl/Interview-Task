//
//  AppDelegate.swift
//  InterviewTask
//
//  Created by Hazem Abou El Fadl on 27/03/2024.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        do{
            _ = try Realm()
        }catch{
            print("Realm initiallization failed \(error )")
        }
        
        return true
    }
    
    
}

