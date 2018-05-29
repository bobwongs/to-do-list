//
//  BWToDoListViewController.swift
//  BWToDoListSwift
//
//  Created by BobWong on 2018/5/29.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

import UIKit

class BWToDoListViewController: BWBaseViewController {
    // UI
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listTableView: UITableView!
    
    // Data
    var toDoList: NSArray = []
    var searchToDoResultList: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
