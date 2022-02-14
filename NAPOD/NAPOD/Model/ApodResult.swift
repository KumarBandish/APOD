//
//  ApodResult.swift
//  NAPOD
//
//  Created by Bandish Kumar on 13/02/22.
//

import Foundation

class ApodResult: Codable {
    var date: String?
    var explanation: String?
    var hdurl: String?
    var media_type: String?
    var service_version: String?
    var title: String?
    var url: String?

    //add result to core date so that, if internet data is not avaliable then we can fetch last updated data & show to the user.
    func storeApodResult() {
        guard let resultDetail = CoreDataManager.sharedInstance.add(ResultPictureDetail.self) else {
            return
        }
        if !CoreDataManager.sharedInstance.isExist(date: self.date!, PictureDetails.self) {
            resultDetail.date = self.date
            resultDetail.title = self.title
            resultDetail.url = self.url
            resultDetail.explanation = self.explanation
            resultDetail.media_type = self.media_type
            resultDetail.service_version = self.service_version
        }
        CoreDataManager.sharedInstance.save()
        debugPrint("---save api data----")
    }
}
