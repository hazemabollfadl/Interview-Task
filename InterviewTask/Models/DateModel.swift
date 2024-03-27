//
//  DateModel.swift
//  InterviewTask
//
//  Created by Hazem Abou El Fadl on 27/03/2024.
//

import Foundation
import RealmSwift

class DateModel:Object{
    @objc dynamic var date:String?
    @objc dynamic var data:DataModel?
}
