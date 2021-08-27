//
//  LayoutConstraintBatch.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public class LayoutConstraintBatch<Object: LayoutObject> {
    
    private(set) public weak var view: Object?
    public let constraints: [NSLayoutConstraint]
    
    public init(view: Object, constraints: [NSLayoutConstraint]) {
        self.view = view
        self.constraints = constraints
    }

    public func activate() {
        constraints.forEach({ $0.isActive = true })
    }
    public func deactivate() {
        constraints.forEach({ $0.isActive = false })
    }
    
    public func setConstant(_ constant: CGFloat) {
        constraints.forEach({ $0.constant = constant })
    }
}

extension LayoutConstraintBatch where Object == UIView {
    public func removeFromView() {
        view?.removeConstraints(constraints)
    }
    public func recoverToView() {
        view?.addConstraints(constraints)
    }
}
