//
//  ResultPictureDetail+CoreDataProperties.swift
//  
//
//  Created by BANKUM-BLRM20 on 14/02/22.
//
//

import Foundation
import CoreData


extension ResultPictureDetail {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ResultPictureDetail> {
        return NSFetchRequest<ResultPictureDetail>(entityName: "ResultPictureDetail")
    }

    @NSManaged public var url: String?
    @NSManaged public var date: String?
    @NSManaged public var explanation: String?
    @NSManaged public var media_type: String?
    @NSManaged public var title: String?
    @NSManaged public var service_version: String?

}
