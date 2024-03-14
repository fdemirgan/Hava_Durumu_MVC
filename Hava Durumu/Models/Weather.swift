//
//  Weather.swift
//  Hava Durumu
//
//  Created by Ferhat on 28.11.2023.
//

import Foundation
struct Weather: Codable {
   public var weather: WeatherDescription
   public var date: String
   public var temperature: Double
   public var maxTemp: Double
   public var minTemp: Double
   public var probability: Int // yağış olasılığı
   public var appMax: Double // max hissedilen sıcaklık
   public var appMin: Double // min hissedilen sıcaklık
   public var windSpeed: Double
   public var humidity: Int // nem
   public var uv: Double
    
    public var appAverage: Double { // ortalama hissedilen sıcaklık
        (appMax + appMin) / 2
    }
    public var dayName: String {
        Helpers.shared.dateConfing(date: date, identifier: "EEE") // JSON dan gelen date verisi gün ay yıl şeklinde tairh olarak geliyordu. Onu 3 harfli bir gün ismine dönüştürdüm.
    }
    
        enum CodingKeys: String, CodingKey {
            case date = "datetime"
            case temperature = "temp"
            case maxTemp = "high_temp"
            case minTemp = "low_temp"
            case probability = "pop"
            case appMax = "app_max_temp"
            case appMin = "app_min_temp"
            case windSpeed = "wind_spd"
            case humidity = "rh"
            case uv
            case weather
        }
}
