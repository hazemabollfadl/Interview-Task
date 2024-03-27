//
//  DataModel.swift
//  InterviewTask
//
//  Created by Hazem Abou El Fadl on 27/03/2024.
//

import Foundation
import RealmSwift

class DataModel:Object{
    dynamic var names=List<String>()
    dynamic var numbers=List<String>()
    @objc dynamic var total:Int=0
    
//    var parentCategory=LinkingObjects(fromType: DateModel.self, property: "data")

}
