//
//  YAxisConstraintRule.swift
//  Layout
//
//  Created by Roman Filippov on 11.05.2021.
//

import UIKit

public struct YAxisConstraintRule: ConstraintRule {
    
    let anchor: NSLayoutYAxisAnchor
    let relation: AnchorRelation
    let target: YAxisTargetContainer
    let priority: UILayoutPriority
    
    public func buildConstraint() -> NSLayoutConstraint {
        return target.setupIn(viewAnchor: anchor, relation: relation).priority(priority)
    }
    
    public init(anchor: NSLayoutYAxisAnchor, relation: AnchorRelation = .equal, target: YAxisTargetContainer, priority: UILayoutPriority = .required) {
        self.anchor = anchor
        self.relation = relation
        self.target = target
        self.priority = priority
    }

}

public struct YAxisTargetContainer {
    
    var anchor: NSLayoutYAxisAnchor
    var constant: CGFloat
    
    public init(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        self.anchor = anchor
        self.constant = constant
    }
    
    func setupIn(viewAnchor: NSLayoutYAxisAnchor, relation: AnchorRelation) -> NSLayoutConstraint {
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
