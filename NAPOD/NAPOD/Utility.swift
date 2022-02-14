//
//  Utility.swift
//  NAPOD
//
//  Created by Bandish Kumar on 13/02/22.
//

import Foundation

class Utility {
    
    func convertDateFormatterToDate(_ date: String) -> String {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy-MM-dd"
       let date = dateFormatter.date(from: date)
       dateFormatter.dateFormat = "MMM dd, yyyy"
       return  dateFormatter.string(from: date!)
   }
}

struct APIConstant {
    static let baseEndPoint = "https://api.nasa.gov/planetary/apod"
    static let apiKey = "9NaEXAp2mN1tHR7e8Wfb5otTCvAa8lWfhKiMufXc"
}

struct Constant {
    static let dateFormat = "yyyy-MM-dd"
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
    static let noFavouriteListMessage = "There is no favourite list"
    static let noDetailsMessage = "enter date is not in range"
    static let addToFavorites = "Add to favorites"
}

extension Date {
    func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = Constant.dateFormat
        return formatter.string(from: self)
    }
}

