//
//  LayoutBuilder.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public protocol LayoutBuilder {
    associatedtype Object: LayoutObject
    associatedtype StageResult
    var object: Object { get }
    func append(rule: ConstraintRule) -> StageResult
}

public protocol ConstraintRule {
    func buildConstraint() -> NSLayoutConstraint
}

public enum AnchorRelation {
    case equal
    case lessOrEqual
    case greaterOrEqual
}

public enum Axis {
    case horizontal
    case vertical
}
