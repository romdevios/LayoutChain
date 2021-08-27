//
//  XAxisBuilder.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public protocol XAxisBuilder: LayoutBuilder {}

extension XAxisBuilder {
    
    fileprivate func appendRule(_ anchorPath: KeyPath<LayoutObject, NSLayoutXAxisAnchor>, relation: AnchorRelation, target: XAxisTarget, priority: UILayoutPriority) -> StageResult {
        append(rule: XAxisConstraintRule(anchor: object[keyPath: anchorPath], relation: relation, target: target.container(anchorPath: anchorPath), priority: priority))
    }
    
    fileprivate func appendRule(_ anchorPath: KeyPath<Object, NSLayoutXAxisAnchor>, relation: AnchorRelation, container: XAxisTargetContainer, priority: UILayoutPriority) -> StageResult {
        append(rule: XAxisConstraintRule(anchor: object[keyPath: anchorPath], relation: relation, target: container, priority: priority))
    }
}

public extension XAxisBuilder {
    
    @discardableResult
    func left(_ relation: AnchorRelation = .equal, to target: XAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.leftAnchor, relation: relation, target: target, priority: priority)
    }
    
    @discardableResult
    func right(_ relation: AnchorRelation = .equal, to target: XAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.rightAnchor, relation: relation, target: target, priority: priority)
    }
    
    @discardableResult
    func leading(_ relation: AnchorRelation = .equal, to target: XAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.leadingAnchor, relation: relation, target: target, priority: priority)
    }
    
    @discardableResult
    func trailing(_ relation: AnchorRelation = .equal, to target: XAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.trailingAnchor, relation: relation, target: target, priority: priority)
    }
    
    @discardableResult
    func centerX(_ relation: AnchorRelation = .equal, to target: XAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.centerXAnchor, relation: relation, target: target, priority: priority)
    }

    
    @discardableResult
    func before(of view: UIView, _ relation: AnchorRelation = .equal, spacing: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.trailingAnchor, relation: relation, target: XAxisTargetContainer(anchor: view.leadingAnchor, constant: -spacing), priority: priority)
    }
    @discardableResult
    func after(of view: UIView, _ relation: AnchorRelation = .equal, spacing: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.leadingAnchor, relation: relation, target: XAxisTargetContainer(anchor: view.trailingAnchor, constant: spacing), priority: priority)
    }
    
}

public extension XAxisBuilder where Object: UIView {
    @discardableResult
    func left(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.leftAnchor, relation: relation, target: XAxisTargetContainer(anchor: object.superview!.leftAnchor, constant: constant), priority: priority)
    }
    @discardableResult
    func right(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.rightAnchor, relation: relation, target: XAxisTargetContainer(anchor: object.superview!.rightAnchor, constant: -constant), priority: priority)
    }
    @discardableResult
    func leading(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.leadingAnchor, relation: relation, target: XAxisTargetContainer(anchor: object.superview!.leadingAnchor, constant: constant), priority: priority)
    }
    @discardableResult
    func trailing(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.trailingAnchor, relation: relation, target: XAxisTargetContainer(anchor: object.superview!.trailingAnchor, constant: -constant), priority: priority)
    }
    @discardableResult
    func centerX(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.centerXAnchor, relation: relation, target: XAxisTargetContainer(anchor: object.superview!.centerXAnchor, constant: constant), priority: priority)
    }
    
    
    
    fileprivate func appendRule(_ anchorPath: KeyPath<Object, NSLayoutXAxisAnchor>, _ reservePath: KeyPath<LayoutObject, NSLayoutXAxisAnchor>, relation: AnchorRelation, target: XAxisTarget, priority: UILayoutPriority) -> StageResult {
        let container: XAxisTargetContainer
        if let targetObject = target as? Object {
            container = XAxisTargetContainer(anchor: targetObject[keyPath: anchorPath])
        } else {
            container = target.container(anchorPath: reservePath)
        }
        return appendRule(anchorPath, relation: relation, container: container, priority: priority)
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func safeLeading(_ relation: AnchorRelation = .equal, to target: XAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.safeLeadingAnchor, \LayoutObject.leadingAnchor, relation: relation, target: target, priority: priority)
    }
    @available(iOS 11.0, *)
    @discardableResult
    func safeLeading(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.safeLeadingAnchor, relation: relation, container: XAxisTargetContainer(anchor: object.superview!.safeLeadingAnchor, constant: constant), priority: priority)
    }
    
    @available(iOS 11.0, *)
    @discardableResult
    func safeTrailing(_ relation: AnchorRelation = .equal, to target: XAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.safeTrailingAnchor, \LayoutObject.trailingAnchor, relation: relation, target: target, priority: priority)
    }
    @available(iOS 11.0, *)
    @discardableResult
    func safeTrailing(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.safeTrailingAnchor, relation: relation, container: XAxisTargetContainer(anchor: object.superview!.safeTrailingAnchor, constant: -constant), priority: priority)
    }
    
    @discardableResult
    func leadingMargin(_ relation: AnchorRelation = .equal, to target: XAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.leadingMargin, \LayoutObject.leadingAnchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func leadingMargin(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.leadingMargin, relation: relation, container: XAxisTargetContainer(anchor: object.superview!.leadingMargin, constant: constant), priority: priority)
    }
    
    @discardableResult
    func trailingMargin(_ relation: AnchorRelation = .equal, to target: XAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.trailingMargin, \LayoutObject.trailingAnchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func trailingMargin(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.trailingMargin, relation: relation, container: XAxisTargetContainer(anchor: object.superview!.trailingMargin, constant: -constant), priority: priority)
    }
}
