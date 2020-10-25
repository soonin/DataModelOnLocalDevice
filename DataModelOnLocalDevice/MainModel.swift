//
//  MainModel.swift
//  DataModelOnLocalDevice
//
//  Created by Pooya on 2020-10-11.
//  Copyright © 2020 centurytrail.com. All rights reserved.
//

import Foundation

struct MainModel : Codable {
    var title:String
    var details:String
    var completed:Bool
    var createdAt:Date
    var itemIdentifier:UUID
    
    func saveItem() {
        //TODO save
        DataManager.save(self, with: itemIdentifier.uuidString)
    }

    func deleteItem() {
        //TODO delete
        DataManager.delete(itemIdentifier.uuidString)

    }

    mutating func markAsCompleted() {
        //TODO completed
        self.completed = true
        DataManager.save(self, with: itemIdentifier.uuidString)
    }

    func toString() -> String {
        var output = ""
        output += "title : " + self.title + "\n"
        output += "details : " + self.details + "\n"
        output += "completed : " + self.completed.description + "\n"
        output += "createdAt : " + self.createdAt.description + "\n"
        output += "itemIdentifier : " + self.itemIdentifier.uuidString + "\n"

        return output
    }
    
}
