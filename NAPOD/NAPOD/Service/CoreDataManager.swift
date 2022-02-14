//
//  CoreDataManager.swift
//  NAPOD
//
//  Created by BANKUM-BLRM20 on 13/02/22.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    private init() {}
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func add<T: NSManagedObject>(_ type: T.Type) -> T? {
        guard let entityName = T.entity().name else {
            return nil
        }
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            return nil
        }
        
        let object = T(entity: entity, insertInto: context)
        return object
    }
    
    func fetch<T: NSManagedObject>(_ type: T.Type) -> [T] {
        
        do {
            let request = type.fetchRequest()
            let result = try context.fetch(request)
            return result as! [T]
        } catch let error {
            print("core data fetch error: \(error.localizedDescription)")
            return []
        }
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("core data saving error: \(error.localizedDescription)")
        }
    }
    
    //To avoid duplicate entry for any entity
    /// How to check already stored data is same as current data
    // data duplication
    func isExist<T: NSManagedObject>(date: String, _ type: T.Type) -> Bool {
        
        guard let entityName = T.entity().name else {
            return false
        }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "date = %s", argumentArray: [date])
        
        let result = try! context.fetch(fetchRequest)
        return result.count > 0 ? true : false
    }
}
