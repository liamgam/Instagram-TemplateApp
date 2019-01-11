//
//  CoreDataHelper.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/7/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import CoreData
import UIKit

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        return context
    }()
    
    static func newProfile() -> Profile {
        let profile = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context) as! Profile
        return profile
    }
    
    static func saveProfile() {
        do {
            try context.save()
        } catch let error {
            print("could not save \(error.localizedDescription)")
        }
    }
    
    static func deleteProfile(profile: Profile) {
        context.delete(profile)
        saveProfile()
    }
    
    static func retrieveprofile() -> [Profile] {
        do {
            let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
            let results = try context.fetch(fetchRequest)
            return results
        } catch let error {
            print("could not fetch \(error.localizedDescription)")
            return []
        }
    }
}
