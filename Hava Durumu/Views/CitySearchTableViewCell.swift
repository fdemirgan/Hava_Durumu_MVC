//
//  CitySearchTableViewCell.swift
//  Hava Durumu
//
//  Created by Ferhat on 13.12.2023.
//

import UIKit
import MapKit

class CitySearchTableViewCell: UITableViewCell {
    
    
    public func updateCell(with searchResult: MKLocalSearchCompletion){
        textLabel?.text = searchResult.title
        detailTextLabel?.text = searchResult.subtitle
        textLabel?.textColor = UIColor.white
        detailTextLabel?.textColor = UIColor.white
    }
}



