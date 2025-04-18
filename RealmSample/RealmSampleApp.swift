//
//  RealmSampleApp.swift
//  RealmSample
//
//  Created by Venkata Sudhakar Reddy on 17/04/25.
//

import SwiftUI
import RealmSwift

@main
struct RealmSampleApp: SwiftUI.App {  // ✅ Avoid naming conflict
    init() {
        configureRealmMigration()
    }

    var body: some Scene {
        WindowGroup {
            StudentListView()
        }
    }

    private func configureRealmMigration() {
        ///⚠️ Don’t use this in production, as it will wipe your DB if there's any schema change!
        /* var config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        Realm.Configuration.defaultConfiguration = config */
        
        /// migration
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    // Automatic migration for new properties
                }
            }
        )

        Realm.Configuration.defaultConfiguration = config
        print("Realm DB Path: \(String(describing: config.fileURL))")
    }
}
