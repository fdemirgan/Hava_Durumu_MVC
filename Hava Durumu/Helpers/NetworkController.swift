//
//  NetworkController.swift
//  Hava Durumu
//
//  Created by Ferhat on 27.11.2023.
//

import Foundation
import CoreLocation

class NetworkController {
    
    private let baseUrl = URL(string: "https://api.weatherbit.io/v2.0/forecast/daily")!
    private let apiKey = "e07ffcc247924b089e4afd38267bf401"
    private let jsonDecoder = JSONDecoder()
    
    func fetchInfo(for location: CLLocationCoordinate2D, completion: @escaping (ForeCast?) -> Void)
    {
        
        let query = [
            "lat": String(location.latitude),//"39.91987"
            "lon": String(location.longitude),//"32.85427"
            "key": apiKey,
            "lang": "tr"
        ]
        
        let requestUrl = baseUrl.withQueries(query)!
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard let foreCastData = data else {
                completion(nil)
                return
            }
            
            do {
                let foreCastObject = try self.jsonDecoder.decode(ForeCast.self, from: foreCastData)
                DispatchQueue.main.async {
                    completion(foreCastObject)
                }
            } catch {
                completion(nil)
                print("hatalar gösteriliyor.\(error.localizedDescription)")
            }
        }.resume()
    }
}
