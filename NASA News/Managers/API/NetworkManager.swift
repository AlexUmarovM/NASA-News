//
//  NetworkManager.swift
//  NASA News
//
//  Created by Александр Умаров on 14.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import SwiftyJSON

class NetworkManager {
    
    var newsList = [Model]()
    
    func fetchData() {
        let url = URL(string: Appearance.StringValues.baseUrl + "\(getDate())")
        guard let downloadURL = url else {return}
        let session = URLSession.shared
        
        session.dataTask(with: downloadURL) { data, response, error in
            guard let data = data else {return}
            
            do {
                let myJSON = try JSON(data: data)
                let items = myJSON[Appearance.JSONames.collection][Appearance.JSONames.items]
                
                for item in items.arrayValue {
                    let title = item[Appearance.JSONames.data][0][Appearance.JSONames.title].stringValue
                    let nasa_id = item[Appearance.JSONames.data][0][Appearance.JSONames.nasa_id].stringValue
                    let description = item[Appearance.JSONames.data][0][Appearance.JSONames.description].stringValue
                    let href = item[Appearance.JSONames.links][0][Appearance.JSONames.href].stringValue
                    let date_created = item[Appearance.JSONames.data][0][Appearance.JSONames.dateCreated].stringValue
                    
                    self.newsList.append(Model(nasa_id: nasa_id,
                                               title: title,
                                               date_created: self.getStringFormattedDate(dateCreated: date_created),
                                               media_type: "",
                                               href: href,
                                               description: description,
                                               date_created_sort: self.getFormattedDate(dateCreated: date_created)))
                }
                self.newsList.sort(by: { $0.date_created_sort! > $1.date_created_sort! } )
            } catch { print(error) }
        }.resume()
    }
}
