//
//  DemensionTarget.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public protocol DemensionTarget {
    func container(anchorPath: KeyPath<LayoutObject, NSLayoutDimension>) -> DemensionTargetContainer
}
extension DemensionTargetContainer {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutDimension>) -> DemensionTargetContainer {
        self
    }
}
extension NSLayoutDimension: DemensionTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutDimension>) -> DemensionTargetContainer {
        DemensionTargetContainerAnchor(anchor: self)
    }
}
extension UIView: DemensionTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutDimension>) -> DemensionTargetContainer {
        let anchor = self[keyPath: anchorPath]
        return DemensionTargetContainerAnchor(anchor: anchor)
    }
}
extension UILayoutGuide: DemensionTarget {
    public func container(anchorPath: KeyPath<LayoutObject, NSLayoutDimension>) -> DemensionTargetContainer {
        let anchor = self[keyPath: anchorPath]
        return DemensionTargetContainerAnchor(anchor: anchor)
    }
}


public protocol CompositeDemensionTarget {
    func container() -> DemensionTargetContainer
}
extension DemensionTargetContainer {
    public func container() -> DemensionTargetContainer {
        self
    }
}
extension NSLayoutDimension: CompositeDemensionTarget {
    public func container() -> DemensionTargetContainer {
        DemensionTargetContainerAnchor(anchor: self)
    }
}
