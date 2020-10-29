//
//  DbSymbols.swift
//  JarCurrency
//
//  Created by Yaroslav Lutsenko on 28.10.2020.
//

import CoreData

extension DbSymbols {
    @NSManaged var id: Int16
    @NSManaged var jsonData: String
    @NSManaged var timestamp: Int64
}

final class DbSymbols: NSManagedObject {
    
    convenience init(time: Int64, json: String) {
        self.init(entity: CoreDataManager.instance.entityForName(entityName: "DbSymbols"), insertInto: CoreDataManager.instance.managedObjectContext)
        self.id = 1
        self.timestamp = time
        self.jsonData = json
    }
    
    func update(time: Int64, json: String){
        self.timestamp = time
        self.jsonData = json
    }
    
}


