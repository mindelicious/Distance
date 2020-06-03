//
//  Place.swift
//  Distance
//
//  Created by Matt on 29/05/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import Foundation

struct Place: Codable {
    var address: Address
    
    var addressDescription: String {
        var firstPart: String?
        if let city = address.city {
            firstPart = city
        } else if let village = address.village {
            firstPart = village
        }
        
        guard let prefix = firstPart else { return address.country }
        return "\(prefix), " + address.country
    }
}
