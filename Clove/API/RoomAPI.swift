//
//  RoomAPI.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/23/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit
import CoreData

class RoomAPI {
    
    static let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    static let entityName = "Room"

    static func addRoom(id: String, name: String, isDefault: Bool = false) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext!)!
        let room = NSManagedObject(entity: entity, insertInto: managedContext)
        room.setValue(id, forKeyPath: "id")
        room.setValue(name, forKeyPath: "name")
        room.setValue(isDefault, forKeyPath: "isDefault")
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return room
    }
    
    static func getAllRooms() -> [NSManagedObject] {
        var rooms: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        do {
            rooms = try managedContext!.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return rooms
    }

    static func getRoom(roomId: String) -> NSManagedObject? {
        
        var room: NSManagedObject?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id == \(roomId)")
        
        do {
            var rooms = try managedContext!.fetch(fetchRequest)
            if (rooms.count != 0) {
                room = rooms[0]
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return room
    }
    
    static func getDefaultRoom() -> NSManagedObject? {
        
        var room: NSManagedObject?
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "isDefault == true")
        
        do {
            var rooms = try managedContext!.fetch(fetchRequest)
            if (rooms.count != 0) {
                room = rooms[0]
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return room
    }
    
    static func createDefaultRoom() -> NSManagedObject {
        return addRoom(id: Utilities.randomString(length: 8), name: "My Room", isDefault: true)
    }
}
