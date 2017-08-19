//
//  ViewController.swift
//  CrashExample
//
//  Created by Anthony Dito on 8/18/17.
//  Copyright © 2017 Anthony Dito. All rights reserved.
//

import DTModelStorage
import DTTableViewManager
import RealmSwift
import UIKit

class ViewController: UIViewController, DTTableViewManageable {
    
    // MARK: - IB Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data
    
    lazy var realm: Realm = {
        return try! Realm()
    }()
    
    lazy var sect1Query: Results<TestObject> = {
        return self.realm.objects(TestObject.self).filter("number == 1")
    }()
    
    lazy var sect2Query: Results<TestObject> = {
        return self.realm.objects(TestObject.self).filter("number == 2")
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! realm.write {
            realm.deleteAll()
        }
        
        setupTableView()
    }

    // MARK: - Configuration
    
    private func setupTableView() {
        
        manager.startManaging(withDelegate: self)
        
        manager.registerNibNamed("Cell", for: Cell.self)
        
        let storage = RealmStorage()
        storage.configureForTableViewUsage()
        storage.addSection(with: sect1Query)
        storage.addSection(with: sect2Query)
        manager.storage = storage
        
    }

    // MARK: - Actions
    
    @IBAction func addSection1Pressed(_ sender: Any) {
        addElem(toSection: 1)
    }
    
    @IBAction func addSection2Pressed(_ sender: Any) {
        addElem(toSection: 2)
    }
    
    @IBAction func moveSection1To2Pressed(_ sender: Any) {
        removeFromSection1AddTo2()
    }
    
    func addElem(toSection: Int) {
        let newElem = TestObject()
        newElem.number = toSection
        try! realm.write {
            realm.add(newElem)
        }
    }
    
    func removeFromSection1AddTo2() {
        guard sect1Query.count > 0 else {
            let alertController = UIAlertController(title: "Error", message: "Need to add at least one cell to section 1 for this action to work.", preferredStyle: UIAlertControllerStyle.alert)
            present(alertController, animated: true)
            return
        }
        let first = sect1Query.first!
        try! realm.write {
            first.number = 2
        }
    }
}

