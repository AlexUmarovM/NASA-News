//
//  Extensions.swift
//  NASA News
//
//  Created by Александр Умаров on 14.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//
import UIKit

class Appearance {
    
    enum StringValues {
        static let baseUrl = "https://images-api.nasa.gov/search?q=space&media_type=image&year_start=2019&year_end="
        static let cellName = "NewsCell"
        static let placeholderImageName = "placeholder.png"
        static let mainVCTitle = NSLocalizedString("NASA News", comment: "")
    }
    
    enum JSONames {
        static let collection = "collection"
        static let items = "items"
        static let data = "data"
        static let title = "title"
        static let nasa_id = "nasa_id"
        static let description = "description"
        static let dateCreated = "date_created"
        static let href = "href"
        static let links = "links"
    }
}

extension MainViewController {
    
    func delay(_ delay: Int, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    func networkAlert() {
        let alert = UIAlertController (title: NSLocalizedString("Ooops!", comment: ""),
                                       message: NSLocalizedString("Houston we got network problem", comment: ""),
                                       preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Try again", comment: ""),
                                      style: UIAlertAction.Style.default,
                                      handler: { (UIAlertAction) in
                                        self.loadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadData() {
        self.news = self.networkManager.newsList
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.tableView.reloadData()
        }
    }
}

extension NetworkManager {
    func getDate() -> Int {
        let date = Date()
        let calendar = Calendar.current
        let currentDate = calendar.component(.year, from: date)
        return currentDate
    }
    
    func getStringFormattedDate(dateCreated: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let date = dateFormatter.date(from: dateCreated)
        
        let uiDateFormatter = DateFormatter()
        uiDateFormatter.dateFormat = "dd MMM, yyyy"
        let uiDate = uiDateFormatter.string(from: date!)
        return uiDate
    }
    
    func getFormattedDate(dateCreated: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
        let date = dateFormatter.date(from: dateCreated)!
        return date
    }
}
