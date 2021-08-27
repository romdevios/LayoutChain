//
//  XAxisTarget.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public protocol XAxisTarget {
    func container(anchorPath: KeyPath<LayoutObject, NSLayoutXAxisAnchor>) -> XAxisTargetContainer
}
extension XAxisTargetContainer: XAxisTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutXAxisAnchor>) -> XAxisTargetContainer {
        self
    }
}
extension NSLayoutXAxisAnchor: XAxisTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutXAxisAnchor>) -> XAxisTargetContainer {
        XAxisTargetContainer(anchor: self)
    }
}
extension UIView: XAxisTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutXAxisAnchor>) -> XAxisTargetContainer {
        let anchor = self[keyPath: anchorPath]
        return XAxisTargetContainer(anchor: anchor)
    }
}
extension UILayoutGuide: XAxisTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutXAxisAnchor>) -> XAxisTargetContainer {
        let anchor = self[keyPath: anchorPath]
        return XAxisTargetContainer(anchor: anchor)
    }
}
