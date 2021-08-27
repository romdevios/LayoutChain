//
//  YAxisTarget.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public protocol YAxisTarget {
    func container(anchorPath: KeyPath<LayoutObject, NSLayoutYAxisAnchor>) -> YAxisTargetContainer
}
extension YAxisTargetContainer: YAxisTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutYAxisAnchor>) -> YAxisTargetContainer {
        self
    }
}
extension NSLayoutYAxisAnchor: YAxisTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutYAxisAnchor>) -> YAxisTargetContainer {
        YAxisTargetContainer(anchor: self)
    }
}
extension UIView: YAxisTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutYAxisAnchor>) -> YAxisTargetContainer {
        let anchor = self[keyPath: anchorPath]
        return YAxisTargetContainer(anchor: anchor)
    }
}
extension UILayoutGuide: YAxisTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutYAxisAnchor>) -> YAxisTargetContainer {
        let anchor = self[keyPath: anchorPath]
        return YAxisTargetContainer(anchor: anchor)
    }
}
