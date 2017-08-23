//
//  StreamsTableDataSource.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/22/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit
import CoreData

class StreamsTableDataSource: NSObject, UITableViewDataSource {

    var streams: [NSManagedObject] = []
    var managedContext: NSManagedObjectContext!
    
    override init() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Stream")
        do {
            streams = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let stream = streams[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StreamItem", for: indexPath) as! StreamsTableItem
        
        let duration = stream.value(forKey: "duration") as? Int
        let startTime = stream.value(forKey: "startTime") as? Date
        
        if(duration != nil && startTime != nil){
            
            cell.durationLabel.text = "(\(durationText(duration: duration!)))"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            
            cell.startLabel.text = formatter.string(from: startTime!)
            let endTime = startTime?.addingTimeInterval(Double(duration!))
            cell.endLabel.text = formatter.string(from: endTime!)
        }
        
        
        
        return cell
    }
    
    func durationText(duration: Int) -> String {
        let hours = duration / 3600
        let minutes = (duration % 3600) / 60
        let seconds = (duration % 60)
        
        if(hours > 0) {
            return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        } else {
            return "\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
        }
    }
    
    func addStream(id: String, startTime: Date, duration: Int) {
        let entity = NSEntityDescription.entity(forEntityName: "Stream", in: managedContext)!
        let stream = NSManagedObject(entity: entity, insertInto: managedContext)
        stream.setValue(id, forKeyPath: "id")
        stream.setValue(startTime, forKeyPath: "startTime")
        stream.setValue(duration, forKeyPath: "duration")
        do {
            try managedContext.save()
            streams.append(stream)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}
