//
//  BWToDoListViewController.swift
//  BWToDoListSwift
//
//  Created by BobWong on 2018/5/29.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

import UIKit

class BWToDoListViewController: BWBaseViewController, UITableViewDataSource, UITableViewDelegate {
    // UI
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listTableView: UITableView!
    
    // Data
    var toDoList: NSArray? = ["first", "second", "third"]
    var searchToDoResultList: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To Do List"
        
        let rightItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addAction))
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.toDoList!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BWToDoListCell? = tableView.dequeueReusableCell(withIdentifier: String(describing: BWToDoListCell.self)) as? BWToDoListCell
        if (cell == nil) { return UITableViewCell.init() }
        
        let title: String? = self.toDoList![indexPath.row] as? String
        cell!.titleLabel!.text = title
        
        return cell!
    }
    
    @objc func addAction() {
        let toDoItemVC: BWToDoItemViewController = BWToDoItemViewController()
        toDoItemVC.hasAdded = { (title) in
            print(title)
        }
        self.navigationController?.pushViewController(toDoItemVC, animated: true)
    }

}
