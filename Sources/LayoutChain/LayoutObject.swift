//
//  LayoutObject.swift
//  
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public protocol LayoutObject: AnyObject {
    
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    
}

extension UIView: LayoutObject {
    public var layoutOne: LayoutOne<UIView> {
        translatesAutoresizingMaskIntoConstraints = false
        return LayoutOne(object: self)
    }
    public var layoutChain: LayoutChain<UIView> {
        translatesAutoresizingMaskIntoConstraints = false
        return LayoutChain(object: self)
    }
    public func layoutStack(axis: Axis, _ items: UIView...) -> LayoutStack<UIView> {
        layoutStack(axis: axis, items)
    }
    public func layoutStack(axis: Axis, _ items: [UIView]) -> LayoutStack<UIView> {
        translatesAutoresizingMaskIntoConstraints = false
        items.forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        return LayoutStack(object: self, axis: axis, items: items)
    }
}

extension UILayoutGuide: LayoutObject {
    public var layoutOne: LayoutOne<UILayoutGuide> {
        LayoutOne(object: self)
    }
    public var layoutChain: LayoutChain<UILayoutGuide> {
        LayoutChain(object: self)
    }
    public func layoutStack(axis: Axis, _ items: UIView...) -> LayoutStack<UILayoutGuide> {
        layoutStack(axis: axis, items)
    }
    public func layoutStack(axis: Axis, _ items: [UIView]) -> LayoutStack<UILayoutGuide> {
        LayoutStack(object: self, axis: axis, items: items)
    }
}

