//
//  File.swift
//  
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

infix operator -- : BitwiseShiftPrecedence
extension NSLayoutXAxisAnchor {
    public static func +(lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> XAxisTargetContainer {
        return XAxisTargetContainer(anchor: lhs, constant: rhs)
    }

    public static func -(lhs: NSLayoutXAxisAnchor, rhs: CGFloat) -> XAxisTargetContainer {
        return lhs + -rhs
    }
    
    @available(iOS 10.0, *)
    public static func --(lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutDimension {
        return lhs.anchorWithOffset(to: rhs)
    }
}

extension NSLayoutYAxisAnchor {
    public static func +(lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> YAxisTargetContainer {
        return YAxisTargetContainer(anchor: lhs, constant: rhs)
    }

    public static func -(lhs: NSLayoutYAxisAnchor, rhs: CGFloat) -> YAxisTargetContainer {
        return lhs + -rhs
    }
    
    @available(iOS 10.0, *)
    public static func --(lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutDimension {
        return lhs.anchorWithOffset(to: rhs)
    }
}

extension NSLayoutDimension {
    public static func *(lhs: NSLayoutDimension, rhs: CGFloat) -> DemensionTargetContainerAnchor {
        return DemensionTargetContainerAnchor(anchor: lhs, multiplier: rhs)
    }

    public static func +(lhs: NSLayoutDimension, rhs: CGFloat) -> DemensionTargetContainerAnchor {
        return DemensionTargetContainerAnchor(anchor: lhs, constant: rhs)
    }

    public static func -(lhs: NSLayoutDimension, rhs: CGFloat) -> DemensionTargetContainerAnchor {
        return lhs + -rhs
    }
}

extension DemensionTargetContainerAnchor {
    public static func +(lhs: DemensionTargetContainerAnchor, rhs: CGFloat) -> DemensionTargetContainerAnchor {
        var lhs = lhs
        lhs.constant = rhs
        return lhs
    }

    public static func -(lhs: DemensionTargetContainerAnchor, rhs: CGFloat) -> DemensionTargetContainerAnchor {
        return lhs + -rhs
    }
}
