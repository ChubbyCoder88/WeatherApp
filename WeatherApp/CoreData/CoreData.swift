//
//  CoreData.swift
//  WeatherApp
//
//  Created by Matthew on 2/5/21.
//

import Foundation
import UIKit
import CoreData

struct CoreData {

    func checkIfCoreDataExists(completion: @escaping(Result<String, DataError>) -> Void) throws {
        var people: [NSManagedObject] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest =  NSFetchRequest<NSManagedObject>(entityName: "CitiesSelected")
        do {
            people = try managedContext.fetch(fetchRequest)
            if people.count > 0 {
                var onOff = people[0].value(forKeyPath: "digits") as? String
                if let onOff = onOff {
                    Cities.added = onOff;
                    completion(.success("String digits passed back"))
                } else { throw DataError.noDataAvailable }
            } else { throw DataError.noDataAvailable }
        } catch let error as NSError {
            throw DataError.noDataAvailable
        }
    }

    func insertCoreData(String: String) {
        var people: [NSManagedObject] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let entities = appDelegate.persistentContainer.managedObjectModel.entities
        entities.flatMap({ $0.name }).forEach(clearDeepObjectEntity)
        var name = String
        Cities.added = String
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "CitiesSelected", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKeyPath: "digits")
        do {
            try managedContext.save()
            people.append(person)
            print("Whats?people.append(person)", name)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
   
    // CODE TO CLEAN CORE DATA
    func clearDeepObjectEntity(_ entity: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
}
