//
//  LayoutOne.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public class LayoutOne<Object: LayoutObject> {
    
    public let object: Object
    
    public init(object: Object) {
        self.object = object
    }
    
}

extension LayoutOne: YAxisBuilder, XAxisBuilder, DemensionBuilder {
    public func append(rule: ConstraintRule) -> NSLayoutConstraint {
        let constraint = rule.buildConstraint()
        constraint.isActive = true
        return constraint
    }
}
