//
//  AppDelegate.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = Realm.Configuration(readOnly: false, schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        return true
    }

}

