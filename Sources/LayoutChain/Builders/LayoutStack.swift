//
//  LayoutStack.swift
//
//  Created by Roman Filippov on 26.08.2021.
//

import UIKit

public class LayoutStack<Object: LayoutObject>: LayoutChain<Object> {
    
    let items: [UIView]
    let axis: Axis
    let pairs: [(UIView, UIView)]
    
    internal func merge<O: LayoutObject>(_ builder: LayoutStack<O>) {
        self.rules.append(contentsOf: builder.rules)
    }
    
    init(object: Object, axis: Axis, items: [UIView]) {
        self.axis = axis
        self.items = items
        if items.isEmpty {
            self.pairs = []
        } else {
            self.pairs = Array(zip(items.dropLast(), items.dropFirst()))
        }
        super.init(object: object)
    }
}

extension LayoutStack {
    
    @discardableResult
    public func stackSpacing(_ spacing: CGFloat = 0, priority: UILayoutPriority = .required) -> LayoutStack {
        if items.isEmpty { return self }
        switch axis {
        case .horizontal:
            pairs.forEach {
                self.merge($0.layoutChain.before(of: $1, spacing: spacing, priority: priority))
            }
        case .vertical:
            pairs.forEach {
                self.merge($0.layoutChain.above(of: $1, spacing: spacing, priority: priority))
            }
        }
        return self
    }
    
    @available(iOS 10.0, *)
    @discardableResult
    public func stackEqualSpacing(withEdges: Bool = false, priority: UILayoutPriority = .required) -> LayoutStack {
        if items.isEmpty { return self }
        var anchors = [NSLayoutDimension]()
        switch axis {
        case .horizontal:
            if withEdges {
                anchors.append(object.leadingAnchor -- items.first!.leadingAnchor)
                anchors.append(object.trailingAnchor -- items.last!.trailingAnchor)
            }
            pairs.forEach {
                anchors.append($0.trailingAnchor -- $1.leadingAnchor)
            }
        case .vertical:
            if withEdges {
                anchors.append(object.topAnchor -- items.first!.topAnchor)
                anchors.append(object.bottomAnchor -- items.last!.bottomAnchor)
            }
            pairs.forEach {
                anchors.append($0.bottomAnchor -- $1.topAnchor)
            }
        }
        if anchors.isEmpty { return self }
        let first = anchors.removeFirst()
        for anchor in anchors {
            let rule = DemensionConstraintRule(
                anchor: first,
                target: DemensionTargetContainerAnchor(anchor: anchor),
                priority: priority)
            rules.append(rule)
        }
        return self
    }
    
    @discardableResult
    public func stackInsets(_ insets: UIEdgeInsets = .zero, priority: UILayoutPriority = .required) -> LayoutStack {
        switch axis {
        case .horizontal:
            leading(to: items.first!.leadingAnchor - insets.left, priority: priority)
            trailing(to: items.last!.trailingAnchor + insets.right, priority: priority)
            for view in items {
                top(to: view.topAnchor - insets.top, priority: priority)
                bottom(to: view.bottomAnchor + insets.bottom, priority: priority)
            }
        case .vertical:
            top(to: items.first!.topAnchor - insets.top, priority: priority)
            bottom(to: items.last!.bottomAnchor + insets.bottom, priority: priority)
            for view in items {
                leading(to: view.leadingAnchor - insets.left, priority: priority)
                trailing(to: view.trailingAnchor + insets.right, priority: priority)
            }
        }
        return self
    }
    
    
    public enum Alignment {
        case top(inset: CGFloat = 0)
        case bottom(inset: CGFloat = 0)
        case leading(inset: CGFloat = 0)
        case trailing(inset: CGFloat = 0)
        case center(offset: CGFloat = 0)
        case fill(insets: CGFloat = 0)
    }
    
    @discardableResult
    public func stackAlignment(_ alignment: Alignment, priority: UILayoutPriority = .required) -> LayoutStack {
        switch (alignment, axis) {
        case (.top(let inset), .vertical):
            items.forEach({ self.top(to: $0.topAnchor - inset, priority: priority) })
        case (.bottom(let inset), .vertical):
            items.forEach({ self.bottom(to: $0.bottomAnchor + inset, priority: priority) })
            
        case (.leading(let inset), .horizontal):
            items.forEach({ self.leading(to: $0.leadingAnchor - inset, priority: priority) })
        case (.trailing(let inset), .horizontal):
            items.forEach({ self.trailing(to: $0.trailingAnchor + inset, priority: priority) })
            
        case (.center(let offset), .vertical):
            items.forEach({ self.centerY(to: $0.centerYAnchor - offset, priority: priority) })
        case (.center(let offset), .horizontal):
            items.forEach({ self.centerX(to: $0.centerXAnchor - offset, priority: priority) })
            
        case (.fill(let inset), .vertical):
            items.forEach({
                self.leading(to: $0.leadingAnchor - inset, priority: priority)
                self.trailing(to: $0.trailingAnchor + inset, priority: priority)
            })
        case (.fill(let inset), .horizontal):
            items.forEach({
                self.top(to: $0.topAnchor - inset, priority: priority)
                self.bottom(to: $0.bottomAnchor + inset, priority: priority)
            })
            
        case (.top, .horizontal), (.bottom, .horizontal),
             (.leading, .vertical), (.trailing, .vertical):
            assertionFailure("Stack is not allowed to make different orientation constraints")
        }
        return self
    }
    
    @discardableResult
    public func stackDistributionEqual(priority: UILayoutPriority = .required) -> LayoutStack {
        switch axis {
        case .horizontal:
            pairs.forEach({
                self.merge($0.layoutChain.width(to: $1.widthAnchor, priority: priority) )
            })
        case .vertical:
            pairs.forEach({
                self.merge($0.layoutChain.height(to: $1.heightAnchor, priority: priority) )
            })
        }
        return self
    }
    
    @discardableResult
    public func stackElementsWidth(constant: CGFloat, priority: UILayoutPriority = .required) -> LayoutStack {
        items.forEach({ self.merge($0.layoutChain.width(to: constant, priority: priority)) })
        return self
    }
    
    @discardableResult
    public func stackElementsHeight(constant: CGFloat, priority: UILayoutPriority = .required) -> LayoutStack {
        items.forEach({ self.merge($0.layoutChain.height(to: constant, priority: priority)) })
        return self
    }
    
}
