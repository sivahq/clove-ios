//
//  RoomsTableDataSource.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/22/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit
import CoreData

class RoomsTableDataSource: NSObject, UITableViewDataSource {

    let cellIdentifer = "RoomItem"
    var rooms: [NSManagedObject] = []
    
    override init() {
        var defaultRoom = RoomAPI.getDefaultRoom()
        if (defaultRoom == nil) {
            defaultRoom = RoomAPI.createDefaultRoom()
        }
        rooms = RoomAPI.getAllRooms()
    }
    
    func registerCellsForTableView(tableView: UITableView) {
        tableView.register(RoomsTableItem.self, forCellReuseIdentifier: cellIdentifer)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer, for: indexPath) as! RoomsTableItem
        let room = rooms[indexPath.row]
        let name = room.value(forKey: "name") as? String
        if(name != nil){
            cell.nameLabel.text = "\(name!)"
        }
        return cell
    }
}
