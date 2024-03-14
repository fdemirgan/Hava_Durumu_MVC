//
//  UIView+Ext.swift
//  Hava Durumu
//
//  Created by Ferhat on 27.11.2023.
//

import Foundation
import UIKit

extension UIView {
    
    // MARK: - Properties
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
