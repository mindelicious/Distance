//
//  NetworkManager.swift
//  Distance
//
//  Created by Matt on 29/05/2020.
//  Copyright © 2020 mindelicious. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
   
    
    private init() {}
    
    func getPlace(latitude: Double, longitude: Double, completionHandler: @escaping (Result<Place, AFError>) -> Void) {
        
        let distanceParameters: [String: Any] = [
            "format" : "jsonv2",
            "lat" : latitude,
            "lon" : longitude
        ]
        
        let baseURL = "https://nominatim.openstreetmap.org/reverse"
        
        AF.request(baseURL, parameters: distanceParameters).responseDecodable(of: Place.self) { response in
            completionHandler(response.result)
        }
    }
}

