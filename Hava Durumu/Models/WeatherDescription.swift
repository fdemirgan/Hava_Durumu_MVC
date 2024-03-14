//
//  WeatherDescription.swift
//  Hava Durumu
//
//  Created by Ferhat on 28.11.2023.
//

import Foundation
import UIKit

struct WeatherDescription: Codable {
   public var description: String
   private var iconName: String
    
   public var icon: UIImage? {
        return UIImage(named: iconName)
    }
    
   public var todayImage: UIImage? {
        var todayName = iconName
        todayName.append("td")
        return UIImage(named: todayName)
    }
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case iconName = "icon"
    }
}

