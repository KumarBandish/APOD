//
//  DetailsViewModel.swift
//  NAPOD
//
//  Created by Bandish Kumar on 13/02/22.
//

import Foundation

protocol DetailsViewModelDelegate {
    func didReceiveSuccess(response: ApodResult)
    func didReceiveFailure(response: NetworkError)
}

class DetailsViewModel {
     var deleage: DetailsViewModelDelegate?

    func getAstronomyPictureOfDay(date: String?) {
        let updatedDate = date ?? Date().currentDate()
        NetworkManager.shared.fetchApodDetails(date: updatedDate) { result in
            switch result {
            case .success(let data):
                //save new api data to coredata
                data.storeApodResult()
                self.deleage?.didReceiveSuccess(response: data)
            case .failure(let error):
                self.deleage?.didReceiveFailure(response: error)
            }
            
        }
    }
    
    //If there is no wifi data and some error in fetching api
    //then fetch data from core data & show it.
    func getStoreCacheData() -> ApodResult? {
        let apodResult = ApodResult()
        let data = CoreDataManager.sharedInstance.fetch(ResultPictureDetail.self)
        guard let firstResult = data.first else {
            return nil
        }
        apodResult.url = firstResult.url
        apodResult.date = firstResult.date
        apodResult.explanation = firstResult.explanation
        apodResult.title = firstResult.title
        return apodResult
    }
    
    //save favourite data to core data
    func saveFavouriteDataToStorage(apodResult: ApodResult) {
        guard let pictureDetail = CoreDataManager.sharedInstance.add(PictureDetails.self) else {
            return
        }
        if !CoreDataManager.sharedInstance.isExist(date: apodResult.date!, PictureDetails.self) {
            pictureDetail.date = apodResult.date
            pictureDetail.title = apodResult.title
            pictureDetail.url = apodResult.url
            pictureDetail.explanation = apodResult.explanation
            pictureDetail.media_type = apodResult.media_type
            pictureDetail.service_version = apodResult.service_version
        }
        CoreDataManager.sharedInstance.save()
    }
}
