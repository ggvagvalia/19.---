//
//  News.swift
//  19. დავალება - ვებ სერვისებთან კომუნიკაცია
//
//  Created by gvantsa gvagvalia on 4/19/24.
//

import Foundation

struct News: Codable {
    
    var list: [NewsDetails]
    
    struct NewsDetails: Codable {
        var title: String
        var time: String
        var photoUrl: String
        
        enum CodingKeys: String, CodingKey {
            case title = "Title"
            case time = "Time"
            case photoUrl = "PhotoUrl"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case list = "List"
    }
    
}
