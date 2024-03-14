//
//  NextDaysCollectionViewCell.swift
//  Hava Durumu
//
//  Created by Ferhat on 21.12.2023.
//

import UIKit

class NextDaysCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nDNameLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nDmaxTempLabel: UILabel!
    @IBOutlet weak var nDminTempLabel: UILabel!
    
   public func update(with viewModel: NextDaysCollectionViewCellViewModel) {
        nDNameLabel.text = viewModel.dayName
        iconView.image = viewModel.icon
       nDmaxTempLabel.text = viewModel.maxTemp
       nDminTempLabel.text = viewModel.minTemp
    }
}
