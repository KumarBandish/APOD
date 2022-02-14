//
//  PictureDetails+CoreDataProperties.swift
//  
//
//  Created by BANKUM-BLRM20 on 14/02/22.
//
//

import Foundation
import CoreData


extension PictureDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PictureDetails> {
        return NSFetchRequest<PictureDetails>(entityName: "PictureDetails")
    }

    @NSManaged public var date: String?
    @NSManaged public var explanation: String?
    @NSManaged public var media_type: String?
    @NSManaged public var service_version: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}
