//
//  ViewController.swift
//  DataModelOnLocalDevice
//
//  Created by Pooya on 2020-10-11.
//  Copyright © 2020 centurytrail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let mainItem = MainModel(title:"WordBook",details: "Word format",completed:false,createdAt: Date(), itemIdentifier: UUID())
//        mainItem.saveItem()
        
        let loadMainItems = DataManager.loadAll(MainModel.self)
        
        //print(loadMainItems)
        for oneItem in loadMainItems {
            print(oneItem.toString())
        }
        
    }


}

