//
//  BWToDoItemViewController.swift
//  BWToDoListSwift
//
//  Created by BobWong on 2018/5/29.
//  Copyright © 2018年 BobWongStudio. All rights reserved.
//

import UIKit

class BWToDoItemViewController: BWBaseViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    var hasAdded: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "To Do Item"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
    }
    
    @objc func doneAction() {
        let title = self.titleTextField.text
        if (title == nil || title!.count == 0) { return }
        
        if self.hasAdded != nil { self.hasAdded!(title!) }
    }

}
