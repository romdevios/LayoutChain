//
//  DemensionBuilder.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public protocol DemensionBuilder: LayoutBuilder {}

extension DemensionBuilder {
    
    fileprivate func appendRule(_ anchorPath: KeyPath<LayoutObject, NSLayoutDimension>, relation: AnchorRelation, target: DemensionTarget, priority: UILayoutPriority) -> StageResult {
        append(rule: DemensionConstraintRule(anchor: object[keyPath: anchorPath], relation: relation, target: target.container(anchorPath: anchorPath), priority: priority))
    }
    
    fileprivate func appendRule(_ anchor: NSLayoutDimension, relation: AnchorRelation, container: DemensionTargetContainer, priority: UILayoutPriority) -> StageResult {
        append(rule: DemensionConstraintRule(anchor: anchor, relation: relation, target: container, priority: priority))
    }
    
    fileprivate func appendRule(_ anchor: NSLayoutDimension, relation: AnchorRelation, target: CompositeDemensionTarget, priority: UILayoutPriority) -> StageResult {
        append(rule: DemensionConstraintRule(anchor: anchor, relation: relation, target: target.container(), priority: priority))
    }
}

public extension DemensionBuilder {
    
    @discardableResult
    func width(_ relation: AnchorRelation = .equal, to target: DemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.widthAnchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func width(_ relation: AnchorRelation = .equal, to constant: CGFloat, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(object.widthAnchor, relation: relation, container: DemensionTargetContainerConstant(constant: constant), priority: priority)
    }
    
    @discardableResult
    func height(_ relation: AnchorRelation = .equal, to target: DemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.heightAnchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func height(_ relation: AnchorRelation = .equal, to constant: CGFloat, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(object.heightAnchor, relation: relation, container: DemensionTargetContainerConstant(constant: constant), priority: priority)
    }
    
    @discardableResult
    func aspect(_ relation: AnchorRelation = .equal, ratio: CGFloat = 1, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.heightAnchor, relation: relation, target: DemensionTargetContainerAnchor(anchor: object.widthAnchor, multiplier: ratio), priority: priority)
    }
}

public extension DemensionBuilder where Object: UIView {
    
    @discardableResult
    func inheritWidth(_ relation: AnchorRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.widthAnchor, relation: relation, target: DemensionTargetContainerAnchor(anchor: object.superview!.widthAnchor, multiplier: multiplier, constant: constant), priority: priority)
    }
    
    @discardableResult
    func inheritHeight(_ relation: AnchorRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.heightAnchor, relation: relation, target: DemensionTargetContainerAnchor(anchor: object.superview!.heightAnchor, multiplier: multiplier, constant: constant), priority: priority)
    }
    
}

@available(iOS 10.0, *)
public extension DemensionBuilder {
    
    
    @discardableResult
    func leftWith(_ anchor: NSLayoutXAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.leftAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func rightWith(_ anchor: NSLayoutXAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.rightAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func leadingWith(_ anchor: NSLayoutXAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.leadingAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func trailingWith(_ anchor: NSLayoutXAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.trailingAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func centerXWith(_ anchor: NSLayoutXAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.centerXAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    
    
    @discardableResult
    func topWith(_ anchor: NSLayoutYAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.topAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func bottomWith(_ anchor: NSLayoutYAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.bottomAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func centerYWith(_ anchor: NSLayoutYAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.centerYAnchor -- anchor, relation: relation, target: target, priority: priority)
    }

}

@available(iOS 10.0, *)
public extension DemensionBuilder where Object: UIView {
    
    
    @available(iOS 11.0, *)
    @discardableResult
    func safeLeadingWith(_ anchor: NSLayoutXAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.safeLeadingAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func safeTrailingWith(_ anchor: NSLayoutXAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.safeTrailingAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func leadingMarginWith(_ anchor: NSLayoutXAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.leadingMargin -- anchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func trailingMarginWith(_ anchor: NSLayoutXAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.trailingMargin -- anchor, relation: relation, target: target, priority: priority)
    }
    
    
    @discardableResult
    func firstBaselineWith(_ anchor: NSLayoutYAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.firstBaselineAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func lastBaselineWith(_ anchor: NSLayoutYAxisAnchor, _ relation: AnchorRelation = .equal, to target: CompositeDemensionTarget, priority: UILayoutPriority = .required) -> StageResult {
        appendRule(object.lastBaselineAnchor -- anchor, relation: relation, target: target, priority: priority)
    }
}
