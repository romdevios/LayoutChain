//
//  DemensionConstraintRule.swift
//  Layout
//
//  Created by Roman Filippov on 11.05.2021.
//

import UIKit

public struct DemensionConstraintRule: ConstraintRule {
    
    let anchor: NSLayoutDimension
    let relation: AnchorRelation
    let target: DemensionTargetContainer
    let priority: UILayoutPriority
    
    public func buildConstraint() -> NSLayoutConstraint {
        target.setupIn(viewAnchor: anchor, relation: relation, priority: priority)
    }
    
    public init(anchor: NSLayoutDimension, relation: AnchorRelation = .equal, target: DemensionTargetContainer, priority: UILayoutPriority = .required) {
        self.anchor = anchor
        self.relation = relation
        self.target = target
        self.priority = priority
    }

}

public protocol DemensionTargetContainer: DemensionTarget, CompositeDemensionTarget {
    func setupIn(viewAnchor: NSLayoutDimension, relation: AnchorRelation, priority: UILayoutPriority) -> NSLayoutConstraint
}

public struct DemensionTargetContainerAnchor: DemensionTargetContainer {
    
    var anchor: NSLayoutDimension
    var multiplier: CGFloat
    var constant: CGFloat
    
    public init(anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0) {
        self.anchor = anchor
        self.multiplier = multiplier
        self.constant = constant
    }
    
    public func setupIn(viewAnchor: NSLayoutDimension, relation: AnchorRelation, priority: UILayoutPriority) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return viewAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).priority(priority)
        case .lessOrEqual:
            return viewAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant).priority(priority)
        case .greaterOrEqual:
            return viewAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant).priority(priority)
        }
    }
    
}

public struct DemensionTargetContainerConstant: DemensionTargetContainer {
    
    var constant: CGFloat
    
    public init(constant: CGFloat) {
        self.constant = constant
    }

    public func setupIn(viewAnchor: NSLayoutDimension, relation: AnchorRelation, priority: UILayoutPriority) -> NSLayoutConstraint {
        switch relation {
        case .equal:
            return viewAnchor.constraint(equalToConstant: constant).priority(priority)
        case .lessOrEqual:
            return viewAnchor.constraint(lessThanOrEqualToConstant: constant).priority(priority)
        case .greaterOrEqual:
            return viewAnchor.constraint(greaterThanOrEqualToConstant: constant).priority(priority)
        }
    }
    
}
