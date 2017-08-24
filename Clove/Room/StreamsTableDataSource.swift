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

    let cellIdentifer = "StreamItem"
    var streams: [NSManagedObject] = []
    
    init(room: NSManagedObject) {
        streams = StreamAPI.getAllStreams(room: room)
    }
    
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(StreamsTableItem.self, forCellReuseIdentifier: cellIdentifer)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! StreamsTableItem
        let stream = streams[indexPath.row]
        
        let duration = stream.value(forKey: "duration") as? Int
        let startTime = stream.value(forKey: "startTime") as? Date
        if(duration != nil && startTime != nil){
            
            cell.durationLabel.text = "(\(Utilities.durationText(duration: duration!)))"
            
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            
            cell.startLabel.text = formatter.string(from: startTime!)
            let endTime = startTime?.addingTimeInterval(Double(duration!))
            cell.endLabel.text = formatter.string(from: endTime!)
        }
        
        return cell
    }
}
