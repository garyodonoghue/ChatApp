//
//  UIView+roundCorners.swift
//  ChatApp
//
//  Created by gary.odonoghue  on 08/06/2022.
//

import UIKit

/// Extension on `UIView` which provides a helper function for rounding the corners of the `UIView` given a set of corners to round and the radfus to round by
extension UIView {
    
    
    /// Utility function to round the corners of a UIView, given a set of corners to round and a radius value to round by
    /// - Parameters:
    ///   - corners: The collection of corners to round
    ///   - radius: The amount to round the corners by
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
