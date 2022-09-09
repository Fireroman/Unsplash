//
//  Model.swift
//  Unsplash
//
//  Created by Roman Kuryanov (aka Matovsky) on 09/08/2022.
//  Copyright © 2022 Roman Matovsky (aka Kuryanov). All rights reserved.
//

import Foundation

class Model {
    
    struct Search {
        static let photos = "https://api.unsplash.com/search/photos"
    }
    
    struct Parameters {
        static let page = "page=1"
        static let query = "query"
        static let per_page = "per_page"
        static let accessKey = "client_id=c6xJPgZ8Ij5nuaYWdFYc7HjmtPHzSQnHGvoIlLaKCEs"
        static let results = "results"
        static let urls = "urls"
        static let thumb = "thumb"
        static let regular = "regular"
    }
    
}
