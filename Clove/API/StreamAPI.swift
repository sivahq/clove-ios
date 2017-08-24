//
//  StreamAPI.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/23/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit
import CoreData

class StreamAPI {
    
    static let managedContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    static let entityName = "Stream"

    
    static func addStream(room: NSManagedObject, id: String, startTime: Date, duration: Int) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: "Stream", in: managedContext!)!
        let stream = NSManagedObject(entity: entity, insertInto: managedContext)
        stream.setValue(id, forKeyPath: "id")
        stream.setValue(startTime, forKeyPath: "startTime")
        stream.setValue(duration, forKeyPath: "duration")
        stream.setValue(room.value(forKey: "id") as! String, forKeyPath: "roomId")
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return stream
    }
    
    static func getAllStreams(room: NSManagedObject) -> [NSManagedObject] {
        let roomId = room.value(forKey: "id") as! String
        var streams: [NSManagedObject] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "%K == %@", "roomId", roomId)
        do {
            streams = try managedContext!.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return streams
    }
}
