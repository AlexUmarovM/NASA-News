//
//  Modek.swift
//  NASA News
//
//  Created by Александр Умаров on 14.08.2020.
//  Copyright © 2020 Александр Умаров. All rights reserved.
//

import Foundation

struct Model {
    var nasa_id: String?
    var title: String
    var date_created: String?
    var media_type: String?
    var href: String?
    var description: String?
    var date_created_sort: Date?
    
    init(nasa_id: String, title: String, date_created: String, media_type: String, href: String, description: String, date_created_sort: Date) {
        self.href = href
        self.nasa_id = nasa_id
        self.title = title
        self.date_created = date_created
        self.media_type = media_type
        self.description = description
        self.date_created_sort = date_created_sort
    }
    
}
