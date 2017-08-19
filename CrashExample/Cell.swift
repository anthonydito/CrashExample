//
//  Cell.swift
//  CrashExample
//
//  Created by Anthony Dito on 8/18/17.
//  Copyright © 2017 Anthony Dito. All rights reserved.
//

import DTModelStorage

class Cell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
}

extension Cell: ModelTransfer {
    func update(with model: TestObject) {
        self.label.text = model.createdAt.timeIntervalSince1970.description
    }
}
