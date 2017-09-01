//
//  HomeViewController.swift
//  Clove
//
//  Created by Sivaprakash Ragavan on 8/23/17.
//  Copyright © 2017 Clove HQ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var roomsDataSource: RoomsTableDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomsDataSource = RoomsTableDataSource()
        tableView.dataSource = roomsDataSource
        roomsDataSource?.registerCellsForTableView(tableView: tableView)
        
        initViewElements()
    }
    
    override func updateViewConstraints() {
        positionViewElements()
        super.updateViewConstraints()
    }
    
    lazy var tableView: UITableView! = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    func initViewElements() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        let settingsButton = UIBarButtonItem(title: NSString(string: "\u{2699}\u{0000FE0E}") as String, style: .plain, target: self, action: #selector(addRoom(_:)))
        let font = UIFont.systemFont(ofSize: 24)
        let attributes = [NSFontAttributeName : font]
        settingsButton.setTitleTextAttributes(attributes, for: .normal)
        navigationItem.rightBarButtonItem = settingsButton
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Journal \u{25BE}\u{0000FE0E}", style: .plain, target: self, action: #selector(addRoom(_:)))
        navigationController?.navigationBar.barTintColor = UIColor.primaryLightColor()
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.navigationBar.isTranslucent = false;
        navigationController?.navigationBar.barStyle = .blackTranslucent
        
        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
    }
    
    func positionViewElements() {
        tableView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: -16).isActive = true
        view.layoutMarginsGuide.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -16).isActive = true
        bottomLayoutGuide.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
    }
    
    func addRoom(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Room", message: "Add a new room", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            guard let textField = alert.textFields?.first,
            let name = textField.text else { return }
            
            let room = RoomAPI.addRoom(id: Utilities.randomString(length: 8), name: name)
            self.roomsDataSource?.rooms.append(room)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let room = roomsDataSource?.rooms[indexPath.row]
        let roomViewController = RoomViewController()
        roomViewController.room = room
        navigationController?.pushViewController(roomViewController, animated: true)
    }
}
