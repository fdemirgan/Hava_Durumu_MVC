//
//  DateConfing.swift
//  Hava Durumu
//
//  Created by Ferhat on 27.11.2023.
//

import UIKit


final class Helpers{
    
    public static var shared: Helpers = Helpers()
    
    func dateConfing(date: String, identifier: String) -> String {
        var dayName: String!
        
        let dateFormatterForMainDate = DateFormatter()
        dateFormatterForMainDate.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterForDay = DateFormatter()
        dateFormatterForDay.dateFormat = identifier
        dateFormatterForDay.locale = Locale(identifier: "tr_TR")
        
        if let date = dateFormatterForMainDate.date(from: date) {
            dayName = dateFormatterForDay.string(from: date)
        } else {
            print("Tarih yapılandırılamadı.")
        }
        
        return dayName
    }
}



