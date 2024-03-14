//
//  NextDaysCollectionViewCellViewModel.swift
//  Hava Durumu
//
//  Created by Ferhat on 11.01.2024.
//

import UIKit

final class NextDaysCollectionViewCellViewModel {
    
    private let weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    var dayName: String { weather.dayName }
    var icon: UIImage { weather.weather.icon ?? UIImage(systemName: "photo")! }
    var maxTemp: String { String(Int(weather.maxTemp)) }
    var minTemp: String { String(Int(weather.minTemp)) }
}
