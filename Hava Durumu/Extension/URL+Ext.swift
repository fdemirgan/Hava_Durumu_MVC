//
//  URL+Ext.swift
//  Hava Durumu
//
//  Created by Ferhat on 27.11.2023.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String:String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true) // self, yani extension da belirttiğimiz url in kendisi.
        components?.queryItems = queries.map{URLQueryItem(name: $0.0, value: $0.1)}
        return components?.url
        
    }
    
}
