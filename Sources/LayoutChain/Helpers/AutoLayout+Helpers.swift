//
//  NSLayoutConstraint+activate.swift
//  bramti-customer
//
//  Created by David on 07/12/2018.
//  Copyright © 2018 Bramti Inc. All rights reserved.
//

import UIKit

extension UIView {
    
    @available(iOS 11.0, *)
    public var safeLeadingAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.leadingAnchor
    }
    
    @available(iOS 11.0, *)
    public var safeTopAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.topAnchor
    }
    
    @available(iOS 11.0, *)
    public var safeBottomAnchor: NSLayoutYAxisAnchor {
        return safeAreaLayoutGuide.bottomAnchor
    }
    
    @available(iOS 11.0, *)
    public var safeTrailingAnchor: NSLayoutXAxisAnchor {
        return safeAreaLayoutGuide.trailingAnchor
    }
    
    public var topMargin: NSLayoutYAxisAnchor {
        return layoutMarginsGuide.topAnchor
    }
    
    public var bottomMargin: NSLayoutYAxisAnchor {
        return layoutMarginsGuide.bottomAnchor
    }
    
    public var leadingMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.leadingAnchor
    }
    
    public var trailingMargin: NSLayoutXAxisAnchor {
        return layoutMarginsGuide.trailingAnchor
    }
}

internal extension NSLayoutConstraint {
    func priority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
