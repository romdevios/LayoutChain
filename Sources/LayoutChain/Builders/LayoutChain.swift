//
//  LayoutChain.swift
//
//  Created by Roman Filippov on 11.05.2021.
//

import UIKit

public class LayoutChain<Object: LayoutObject> {
    
    public let object: Object
    internal var rules: [ConstraintRule] = []
    
    public init(object: Object) {
        self.object = object
    }
    
    deinit {
        build()
    }

    /// Creates constraints on view immidiatly
    /// - Returns: last added to view constraint
    /// - Parameter activate: set isActive to created constraints
    @discardableResult
    public func build(activate: Bool = true) -> LayoutConstraintBatch<Object> {
        let constrints = rules.map({ $0.buildConstraint() })
        rules.removeAll()
        if activate {
            NSLayoutConstraint.activate(constrints)
        }
        return LayoutConstraintBatch(view: object, constraints: constrints)
    }
    
    internal func merge<O: LayoutObject>(_ builder: LayoutChain<O>) {
        self.rules.append(contentsOf: builder.rules)
    }

}

extension LayoutChain: YAxisBuilder, XAxisBuilder, DemensionBuilder {
    public func append(rule: ConstraintRule) -> LayoutChain<Object> {
        rules.append(rule)
        return self
    }
}

extension LayoutChain {
    
    /// sets widthAnchor and heightAnchor equal to argument view this anchors
    @discardableResult
    public func equalSize(to view: UIView) -> LayoutChain {
        return width(to: view.widthAnchor)
            .height(to: view.heightAnchor)
    }
    
    /// sets frame equal to its superview bounds with insets
    @discardableResult
    public func padding(to view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) -> LayoutChain {
        return leading(to: view.leadingAnchor + insets.left)
            .trailing(to: view.trailingAnchor - insets.right)
            .top(to: view.topAnchor + insets.top)
            .bottom(to: view.bottomAnchor - insets.bottom)
    }

}

extension LayoutChain where Object: UIView {
    
    /// sets centerXAnchor and centerYAnchor equal to its superview this anchors
    @discardableResult
    public func center(offsetX: CGFloat = 0, offsetY: CGFloat = 0) -> LayoutChain {
        return centerX(inset: offsetX).centerY(inset: offsetY)
    }
    
    /// sets frame equal to its superview bounds with insets
    @available(iOS 11.0, *)
    @discardableResult
    public func safePadding(to view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) -> LayoutChain {
        return safeLeading(to: view.safeLeadingAnchor + insets.left)
            .safeTrailing(to: view.safeTrailingAnchor - insets.right)
            .safeTop(to: view.safeTopAnchor + insets.top)
            .safeBottom(to: view.safeBottomAnchor - insets.bottom)
    }
    
    /// sets frame equal to its superview bounds with insets
    @discardableResult
    public func marginPadding(to view: UIView, insets: UIEdgeInsets = UIEdgeInsets.zero) -> LayoutChain {
        return leading(to: view.leadingMargin + insets.left)
            .trailing(to: view.trailingMargin - insets.right)
            .top(to: view.topMargin + insets.top)
            .bottom(to: view.bottomMargin - insets.bottom)
    }
}
