import XCTest
@testable import LayoutChain

@available(iOS 11.0, *)
final class LayoutChainTests: XCTestCase {
    
    let mainview = UIView()
    let subview = UIView()
    
    let mainRect = CGRect(x: 0, y: 0, width: 500, height: 500)
    
    override func setUp() {
        super.setUp()
        
        mainview.frame = mainRect
        subview.frame = CGRect(x: 100, y: 50, width: 200, height: 400)
        
        mainview.addSubview(subview)
    }
    
    override func tearDown() {
        super.tearDown()
        subview.removeFromSuperview()
        subview.removeConstraints(subview.constraints)
        mainview.removeConstraints(mainview.constraints)
    }
    
    func testXAxisContainer() {
        let container = XAxisTargetContainer(anchor: mainview.centerXAnchor, constant: 20)
        let equalConstr = container.setupIn(viewAnchor: subview.leftAnchor, relation: .equal)
        XCTAssert(equalConstr.constant == 20)
        XCTAssert(equalConstr.relation == .equal)
        XCTAssert(equalConstr.firstAttribute == .left)
        XCTAssert(equalConstr.secondAttribute == .centerX)
        XCTAssert(equalConstr.firstAnchor === subview.leftAnchor)
        XCTAssert(equalConstr.secondAnchor === mainview.centerXAnchor)
        
        let lessConstr = container.setupIn(viewAnchor: subview.leftAnchor, relation: .lessOrEqual)
        XCTAssert(lessConstr.relation == .lessThanOrEqual)
        
        let greatConstr = container.setupIn(viewAnchor: subview.leftAnchor, relation: .greaterOrEqual)
        XCTAssert(greatConstr.relation == .greaterThanOrEqual)
        
    }
    
    func testYAxisContainer() {
        let container = YAxisTargetContainer(anchor: mainview.centerYAnchor, constant: 10)
        let equalConstr = container.setupIn(viewAnchor: subview.topAnchor, relation: .equal)
        XCTAssert(equalConstr.constant == 10)
        XCTAssert(equalConstr.relation == .equal)
        XCTAssert(equalConstr.firstAttribute == .top)
        XCTAssert(equalConstr.secondAttribute == .centerY)
        XCTAssert(equalConstr.firstAnchor === subview.topAnchor)
        XCTAssert(equalConstr.secondAnchor === mainview.centerYAnchor)
        
        let lessConstr = container.setupIn(viewAnchor: subview.topAnchor, relation: .lessOrEqual)
        XCTAssert(lessConstr.relation == .lessThanOrEqual)
        
        let greatConstr = container.setupIn(viewAnchor: subview.topAnchor, relation: .greaterOrEqual)
        XCTAssert(greatConstr.relation == .greaterThanOrEqual)
        
    }
    
    func testDemensionContainer() {
        let container = DemensionTargetContainerAnchor(anchor: mainview.widthAnchor, multiplier: 1.5, constant: 10)
        XCTAssert(container.constant == 10)
        XCTAssert(container.multiplier == 1.5)
        XCTAssert(container.anchor === mainview.widthAnchor)
        
    }
    
    func testXAxisAnchorOperatorNumber() {
        let containerPlus = mainview.centerXAnchor + 20
        XCTAssert(containerPlus.anchor == mainview.centerXAnchor)
        XCTAssert(containerPlus.constant == 20)
        
        let containerMinus = mainview.centerXAnchor - 20
        XCTAssert(containerMinus.anchor == mainview.centerXAnchor)
        XCTAssert(containerMinus.constant == -20)
    }
    
    func testYAxisAnchorOperatorNumber() {
        let containerPlus = mainview.centerYAnchor + 20
        XCTAssert(containerPlus.anchor == mainview.centerYAnchor)
        XCTAssert(containerPlus.constant == 20)
        
        let containerMinus = mainview.centerYAnchor - 20
        XCTAssert(containerMinus.anchor == mainview.centerYAnchor)
        XCTAssert(containerMinus.constant == -20)
    }
    
    func testDimensionAnchorOperatorNumber() {
        let containerPlus = mainview.widthAnchor + 20
        XCTAssert(containerPlus.anchor == mainview.widthAnchor)
        XCTAssert(containerPlus.constant == 20)
        XCTAssert(containerPlus.multiplier == 1)
        
        let containerMinus = mainview.widthAnchor - 20
        XCTAssert(containerMinus.anchor == mainview.widthAnchor)
        XCTAssert(containerMinus.constant == -20)
        XCTAssert(containerMinus.multiplier == 1)
        
        let containerMultiplier = mainview.widthAnchor * 1.5
        XCTAssert(containerMultiplier.anchor == mainview.widthAnchor)
        XCTAssert(containerMultiplier.constant == 0)
        XCTAssert(containerMultiplier.multiplier == 1.5)
        
        let containerMultiplierOfDeviding = mainview.widthAnchor * (3 / 2)
        XCTAssert(containerMultiplierOfDeviding.anchor == mainview.widthAnchor)
        XCTAssert(containerMultiplierOfDeviding.constant == 0)
        XCTAssert(containerMultiplierOfDeviding.multiplier == 1.5)
        
        let containerMultiplierPlus = mainview.widthAnchor * 1.5 + 20
        XCTAssert(containerMultiplierPlus.anchor == mainview.widthAnchor)
        XCTAssert(containerMultiplierPlus.constant == 20)
        XCTAssert(containerMultiplierPlus.multiplier == 1.5)
        
        let containerMultiplierMinus = mainview.widthAnchor * 1.5 - 20
        XCTAssert(containerMultiplierMinus.anchor == mainview.widthAnchor)
        XCTAssert(containerMultiplierMinus.constant == -20)
        XCTAssert(containerMultiplierMinus.multiplier == 1.5)
    }
    
    func testXAxisRule() {
        let constraint = subview.layoutOne.centerX(inset: 20, priority: .defaultHigh)
        
        XCTAssert(mainview.constraints.contains(constraint))
        XCTAssert(constraint.isActive)
        XCTAssert(constraint.priority == .defaultHigh)
        XCTAssert(constraint.constant == 20)
        XCTAssert(constraint.relation == .equal)
        
        let constraintLess = subview.layoutOne.centerX(.lessOrEqual)
        XCTAssert(constraintLess.relation == .lessThanOrEqual)
        
        let constraintGreat = subview.layoutOne.centerX(.greaterOrEqual)
        XCTAssert(constraintGreat.relation == .greaterThanOrEqual)
        
    }
    
    func testYAxisRule() {
        let constraint = mainview.layoutOne.centerY(to: subview.centerYAnchor + 20, priority: .defaultHigh)
        
        XCTAssert(mainview.constraints.contains(constraint))
        XCTAssert(constraint.isActive)
        XCTAssert(constraint.priority == .defaultHigh)
        XCTAssert(constraint.constant == 20)
        XCTAssert(constraint.relation == .equal)
        
        let constraintLess = subview.layoutOne.centerY(.lessOrEqual)
        XCTAssert(constraintLess.relation == .lessThanOrEqual)
        
        let constraintGreat = subview.layoutOne.centerY(.greaterOrEqual)
        XCTAssert(constraintGreat.relation == .greaterThanOrEqual)
        
    }
    
    func getDemensionConstraintRuleAnchor(relation: AnchorRelation) -> DemensionConstraintRule {
        DemensionConstraintRule(anchor: mainview.heightAnchor, relation: relation, target: DemensionTargetContainerAnchor(anchor: subview.widthAnchor, multiplier: 2, constant: 10), priority: .defaultHigh)
    }
    func testDemensionRule() {
        let constraint = getDemensionConstraintRuleAnchor(relation: .equal).buildConstraint()
        constraint.isActive = true
        
        XCTAssert(mainview.constraints.contains(constraint))
        XCTAssert(constraint.priority == .defaultHigh)
        XCTAssert(constraint.constant == 10)
        XCTAssert(constraint.multiplier == 2)
        XCTAssert(constraint.relation == .equal)
        XCTAssert(constraint.firstAttribute == .height)
        XCTAssert(constraint.secondAttribute == .width)
        
        let constraintWidthLess = getDemensionConstraintRuleAnchor(relation: .lessOrEqual).buildConstraint()
        XCTAssert(constraintWidthLess.firstAttribute == .height)
        XCTAssert(constraintWidthLess.relation == .lessThanOrEqual)
        
        let constraintGreat = getDemensionConstraintRuleAnchor(relation: .greaterOrEqual).buildConstraint()
        XCTAssert(constraintGreat.relation == .greaterThanOrEqual)
        
    }
    
    func getDemensionConstraintRuleConstant(relation: AnchorRelation) -> DemensionConstraintRule {
        DemensionConstraintRule(anchor: mainview.heightAnchor, relation: relation, target: DemensionTargetContainerConstant(constant: 120), priority: .defaultHigh)
    }
    func testConstantRule() {
        
        let constraint = getDemensionConstraintRuleConstant(relation: .equal).buildConstraint()
        constraint.isActive = true
        
        XCTAssert(mainview.constraints.contains(constraint))
        XCTAssert(constraint.priority == .defaultHigh)
        XCTAssert(constraint.constant == 120)
        XCTAssert(constraint.multiplier == 1)
        XCTAssert(constraint.relation == .equal)
        XCTAssert(constraint.firstAttribute == .height)
        
        let constraintWidthLess = getDemensionConstraintRuleConstant(relation: .lessOrEqual).buildConstraint()
        XCTAssert(constraintWidthLess.firstAttribute == .height)
        XCTAssert(constraintWidthLess.relation == .lessThanOrEqual)
        
        let constraintGreat = getDemensionConstraintRuleConstant(relation: .greaterOrEqual).buildConstraint()
        XCTAssert(constraintGreat.relation == .greaterThanOrEqual)
        
    }
    
    func testViewConstraint() {
        let constraint = subview.layoutOne
            .bottom(to: mainview.centerYAnchor - 1, priority: .defaultLow)
        
        XCTAssert(constraint.constant == -1)
        XCTAssert(constraint.firstAttribute == .bottom)
        XCTAssert(constraint.secondAttribute == .centerY)
        XCTAssert(constraint.firstAnchor === subview.bottomAnchor)
        XCTAssert(constraint.secondAnchor === mainview.centerYAnchor)
        XCTAssert(constraint.priority == .defaultLow)
        
        constraint.isActive = true
        XCTAssert(subview.constraints.contains(constraint) == false)
        XCTAssert(subview.translatesAutoresizingMaskIntoConstraints == false)
        XCTAssert(mainview.constraints.contains(constraint))
        XCTAssert(mainview.translatesAutoresizingMaskIntoConstraints)
        
    }
    
    func testViewConstraintWithDeviding() {
        let constraint = subview.layoutOne
            .height(to: mainview.widthAnchor * (3 / 2), priority: .defaultLow)
        
        XCTAssert(constraint.constant == 0)
        XCTAssert(constraint.multiplier == 1.5)
        XCTAssert(constraint.firstAttribute == .height)
        XCTAssert(constraint.secondAttribute == .width)
        XCTAssert(constraint.firstAnchor === subview.heightAnchor)
        XCTAssert(constraint.secondAnchor === mainview.widthAnchor)
        XCTAssert(constraint.priority == .defaultLow)
        
        constraint.isActive = true
        XCTAssert(subview.constraints.contains(constraint) == false)
        XCTAssert(subview.translatesAutoresizingMaskIntoConstraints == false)
        XCTAssert(mainview.constraints.contains(constraint))
        XCTAssert(mainview.translatesAutoresizingMaskIntoConstraints)
        
    }
    
    func testViewConstrains() {
        subview.layoutChain
            .leading(to: mainview.trailingAnchor)
            .top()
            .build()
        
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .leading}))
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .top}))
        
        XCTAssert(mainview.constraints.contains(where: {$0.secondAttribute == .trailing}))
        XCTAssert(mainview.constraints.contains(where: {$0.secondAttribute == .top}))
        
    }
    
    func testViewConstrainsWithDeviding() {
        subview.layoutChain
            .leading(to: mainview.trailingAnchor)
            .top()
            .height(to: mainview.widthAnchor * (3 / 2))
            .build()
        
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .height}))
        XCTAssert(mainview.constraints.contains(where: {$0.secondAttribute == .width}))
        
        if let constraint = mainview.constraints.first(where: {$0.secondAttribute == .width}) {
            XCTAssert(constraint.constant == 0)
            XCTAssert(constraint.multiplier == 1.5)
        } else {
            XCTFail()
        }
        
    }
    
    func testViewCenterXConstrains() {
        subview.layoutChain
            .centerX(inset: 3)
            .build()
        
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .centerX && $0.secondAttribute == .centerX}))
        
    }
    
    func testViewCenterYConstrains() {
        subview.layoutChain
            .centerY(inset: 3)
            .build()
        
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .centerY && $0.secondAttribute == .centerY}))
        
    }
    
    func testViewCenterConstrains() {
        subview.layoutChain
            .center()
            .build()
        
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .centerX && $0.secondAttribute == .centerX}))
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .centerY && $0.secondAttribute == .centerY}))
        
        mainview.layoutIfNeeded()
        XCTAssert(mainview.center == subview.center)
        
    }
    
    func testViewEqualSizesSuperviewConstrains() {
        subview.layoutChain
            .equalSize(to: mainview)
            .build()
        
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .width && $0.secondAttribute == .width}))
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .height && $0.secondAttribute == .height}))
        
        subview.layoutChain
            .center()
            .build()
        mainview.layoutIfNeeded()
        XCTAssert(mainview.bounds == subview.frame)
        
    }
    
    func testViewEqualSuperviewConstrains() {
        
        let insets = UIEdgeInsets(top: 5, left: 20, bottom: 30, right: 100)
        subview.layoutChain
            .padding(to: mainview, insets: insets)
        
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .top && $0.secondAttribute == .top}))
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .bottom && $0.secondAttribute == .bottom}))
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .leading && $0.secondAttribute == .leading}))
        XCTAssert(mainview.constraints.contains(where: {$0.firstAttribute == .trailing && $0.secondAttribute == .trailing}))
        
        mainview.layoutIfNeeded()
        XCTAssert(subview.frame == mainRect.inset(by: insets))
        
    }
    
    func testViewSizeConstrains() {
        
        subview.layoutChain
            .width(to: 20)
            .height(to: 50)
            .build()
        
        XCTAssert(subview.constraints.contains(where: {$0.firstAttribute == .width && $0.secondAttribute == .notAnAttribute && $0.constant == 20}))
        XCTAssert(subview.constraints.contains(where: {$0.firstAttribute == .height && $0.secondAttribute == .notAnAttribute && $0.constant == 50}))
        
        mainview.layoutIfNeeded()
        XCTAssert(subview.frame.height == 50)
        XCTAssert(subview.frame.width == 20)
        
    }
    
}

