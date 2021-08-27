//
//  XAxisConstraintRule.swift
//  Layout
//
//  Created by Roman Filippov on 11.05.2021.
//

import UIKit

public struct XAxisConstraintRule: ConstraintRule {
    
    let anchor: NSLayoutXAxisAnchor
    let relation: AnchorRelation
    let target: XAxisTargetContainer
    let priority: UILayoutPriority
    
    public func buildConstraint() -> NSLayoutConstraint {
        return target.setupIn(viewAnchor: anchor, relation: relation).priority(priority)
    }
    
    public init(anchor: NSLayoutXAxisAnchor, relation: AnchorRelation = .equal, target: XAxisTargetContainer, priority: UILayoutPriority = .required) {
        self.anchor = anchor
        self.relation = relation
        self.target = target
        self.priority = priority
    }

}

public struct XAxisTargetContainer {
    
    var anchor: NSLayoutXAxisAnchor
    var constant: CGFloat
    
    public init(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        self.anchor = anchor
        self.constant = constant
    }
    
    func setupIn(viewAnchor: NSLayoutXAxisAnchor, relation: AnchorRelation) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return viewAnchor.constraint(equalTo: anchor, constant: constant)
        case .lessOrEqual:
            return viewAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        case .greaterOrEqual:
            return viewAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        }
    }
    
}
