//
//  YAxisBuilder.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public protocol YAxisBuilder: LayoutBuilder {}

extension YAxisBuilder {
    
    fileprivate func appendRule(_ anchorPath: KeyPath<LayoutObject, NSLayoutYAxisAnchor>, relation: AnchorRelation, target: YAxisTarget, priority: UILayoutPriority) -> StageResult {
        append(rule: YAxisConstraintRule(anchor: object[keyPath: anchorPath], relation: relation, target: target.container(anchorPath: anchorPath), priority: priority))
    }
    
    fileprivate func appendRule(_ anchorPath: KeyPath<Object, NSLayoutYAxisAnchor>, relation: AnchorRelation, container: YAxisTargetContainer, priority: UILayoutPriority) -> StageResult {
        append(rule: YAxisConstraintRule(anchor: object[keyPath: anchorPath], relation: relation, target: container, priority: priority))
    }
    
}

public extension YAxisBuilder {
    
    @discardableResult
    func top(_ relation: AnchorRelation = .equal, to target: YAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.topAnchor, relation: relation, target: target, priority: priority)
    }
    
    @discardableResult
    func bottom(_ relation: AnchorRelation = .equal, to target: YAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.bottomAnchor, relation: relation, target: target, priority: priority)
    }
    
    @discardableResult
    func centerY(_ relation: AnchorRelation = .equal, to target: YAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.centerYAnchor, relation: relation, target: target, priority: priority)
    }
    
    @discardableResult
    func above(of view: UIView, _ relation: AnchorRelation = .equal, spacing: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.bottomAnchor, relation: relation, target: YAxisTargetContainer(anchor: view.topAnchor, constant: -spacing), priority: priority)
    }
    @discardableResult
    func below(of view: UIView, _ relation: AnchorRelation = .equal, spacing: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.topAnchor, relation: relation, target: YAxisTargetContainer(anchor: view.bottomAnchor, constant: spacing), priority: priority)
    }
}

public extension YAxisBuilder where Object: UIView {
    @discardableResult
    func top(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.topAnchor, relation: relation, target: YAxisTargetContainer(anchor: object.superview!.topAnchor, constant: constant), priority: priority)
    }
    
    @discardableResult
    func bottom(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.bottomAnchor, relation: relation, target: YAxisTargetContainer(anchor: object.superview!.bottomAnchor, constant: -constant), priority: priority)
    }
    
    @discardableResult
    func centerY(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\LayoutObject.centerYAnchor, relation: relation, target: YAxisTargetContainer(anchor: object.superview!.centerYAnchor, constant: constant), priority: priority)
    }
    
    
    
    fileprivate func appendRule(_ anchorPath: KeyPath<Object, NSLayoutYAxisAnchor>, _ reservePath: KeyPath<LayoutObject, NSLayoutYAxisAnchor>, relation: AnchorRelation, target: YAxisTarget, priority: UILayoutPriority) -> StageResult {
        let container: YAxisTargetContainer
        if let targetObject = target as? Object {
            container = YAxisTargetContainer(anchor: targetObject[keyPath: anchorPath])
        } else {
            container = target.container(anchorPath: reservePath)
        }
        return appendRule(anchorPath, relation: relation, container: container, priority: priority)
    }
    
    
    @discardableResult
    func firstBaseline(_ relation: AnchorRelation = .equal, to target: YAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.firstBaselineAnchor, \LayoutObject.centerYAnchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func lastBaseline(_ relation: AnchorRelation = .equal, to target: YAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.lastBaselineAnchor, \LayoutObject.centerYAnchor, relation: relation, target: target, priority: priority)
    }
    
    
    @available(iOS 11.0, *)
    @discardableResult
    func safeTop(_ relation: AnchorRelation = .equal, to target: YAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.safeTopAnchor, \LayoutObject.topAnchor, relation: relation, target: target, priority: priority)
    }
    @available(iOS 11.0, *)
    @discardableResult
    func safeTop(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.safeTopAnchor, relation: relation, container: YAxisTargetContainer(anchor: object.superview!.safeTopAnchor, constant: constant), priority: priority)
    }
    
    
    @available(iOS 11.0, *)
    @discardableResult
    func safeBottom(_ relation: AnchorRelation = .equal, to target: YAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.safeBottomAnchor, \LayoutObject.bottomAnchor, relation: relation, target: target, priority: priority)
    }
    @available(iOS 11.0, *)
    @discardableResult
    func safeBottom(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.safeBottomAnchor, relation: relation, container: YAxisTargetContainer(anchor: object.superview!.safeBottomAnchor, constant: -constant), priority: priority)
    }
    
    
    @discardableResult
    func topMargin(_ relation: AnchorRelation = .equal, to target: YAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.topMargin, \LayoutObject.topAnchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func topMargin(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.topMargin, relation: relation, container: YAxisTargetContainer(anchor: object.superview!.topMargin, constant: constant), priority: priority)
    }
    
    
    @discardableResult
    func bottomMargin(_ relation: AnchorRelation = .equal, to target: YAxisTarget, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.bottomMargin, \LayoutObject.bottomAnchor, relation: relation, target: target, priority: priority)
    }
    @discardableResult
    func bottomMargin(_ relation: AnchorRelation = .equal, inset constant: CGFloat = 0, priority: UILayoutPriority = .required) -> StageResult {
        return appendRule(\Object.bottomMargin, relation: relation, container: YAxisTargetContainer(anchor: object.superview!.bottomMargin, constant: -constant), priority: priority)
    }
    
}
