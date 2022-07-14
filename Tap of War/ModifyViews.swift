//
//  ShadowStuff.swift
//  Tap of War
//
//  Created by DPI Student 47 on 7/12/22.
//

import UIKit

@IBDesignable
extension UIButton {
    @IBInspectable
    public var shadowColor: UIColor {
        set (color) {
            self.layer.shadowColor = color.cgColor
        }

        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
    }
    
    @IBInspectable
    public var shadowOffset: CGSize {
        set (size) {
            self.layer.shadowOffset = size
        }
        
        get {
            return self.layer.shadowOffset
        }
    }
    
    @IBInspectable
    public var shadowRadius: CGFloat {
        set (rad) {
            self.layer.shadowRadius = rad
        }
        
        get {
            return self.layer.shadowRadius
        }
    }
    
    @IBInspectable
    public var shadowOpacity: Float {
        set (alpha) {
            self.layer.shadowOpacity = alpha
        }
        
        get {
            return self.layer.shadowOpacity
        }
    }
}
