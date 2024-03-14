//
//  ForeCast.swift
//  Hava Durumu
//
//  Created by Ferhat on 27.11.2023.
//

import Foundation
struct ForeCast: Codable {
   public var cityName: String
   public var countryCode: String
   public var data: [Weather]
    
        enum CodingKeys: String, CodingKey{
            case cityName = "city_name"
            case countryCode = "country_code"
            case data = "data"
            
        }
}
