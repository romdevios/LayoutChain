# LayoutChain

Yet another AutoLayout abstraction framework that halps to simplify managing NSLayoutConstraints.

LayoutChain has simple intuitive syntax and decreased compilation time of views layout setup. Easy access to creating single constraint and features to setup own UIStackView with a little amount of constraints.

### Motivation
The idea was to create lightweight wrapper on AutoLayout without lossing acces to native API. Other frameworks may have a lot of generics and operators overload that can significantly increase the time for type-checking during compilation. Some frameworks has complex API to construct layout but even do not has simple functions to take a single constraint for its managing.

## Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Example](#example)
- [Usage](#usage)
    * [LayoutOne builder](#layoutone-builder)
    * [LayoutChain builder](#layoutchain-builder)
    * [LayoutStack builder](#layoutstack-builder)
    * [Operators](#operators)
    * [Additional anchors](#additional-anchors)
    * [Composite anchors](#composite-anchors)
- [Compilation speed](#compilation-speed)
    


## Requirements

- iOS 9.0+ / tvOS 10.0+
- Xcode 12.0+
- Swift 5.0+

## Installation

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

> Xcode 12+ is required to build LayoutChain using Swift Package Manager.

To integrate LayoutChain into your Xcode project using Swift Package Manager, add it to the dependencies value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/romdevios/LayoutChain.git", .upToNextMajor(from: "1.0.0"))
]
```

Or add dependency manually in Xcode. File -> Swift Packages -> Add Package Dependency... then enter the package URL 'https://github.com/romdevios/LayoutChain.git' and click Next button.


## Example

<details>
  <summary>Setup ViewController</summary>
    ```swift
    import LayoutChain
    
    class ViewController: UIViewController {
        
        let container = UIView()
        let view2 = UIView()
        let view3 = UIView()
        let view4 = UIView()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            container.backgroundColor = .systemTeal
            view2.backgroundColor = .systemYellow
            view3.backgroundColor = .systemBlue
            view4.backgroundColor = .systemIndigo
            
            view.addSubview(container)
            container.addSubview(view2)
            container.addSubview(view3)
            container.addSubview(view4)
            
            layoutBuilder()
        }

    }
    ```
<\details>

```swift
func layoutBuilder() {

    container.layoutChain
        .centerX()
        .centerY()
        .width(to: view.widthAnchor * 0.8 - (20 * CGFloat(2))) // explicit type hack to speed up type-check
        .height(to: 100)

    view2.layoutChain
        .top(inset: 20)
        .leading(inset: 20)
        .trailing(inset: 20)

    view3.layoutChain
        .leading(to: view2)
        .bottom(inset: 20)
        .height(to: 30)

    view4.layoutChain
        .trailing(to: view2)
        .top(to: view3.topAnchor)
        .bottom(to: view3)
        .width(to: view3.widthAnchor * 2)

    heightConstraint = view2.layoutChain.height(to: 20).build()
    
    view2.layoutChain.bottomWith(view3.topAnchor, to: view3.trailingAnchor -- view4.leadingAnchor * 2)
}
```
### Result

<img width="288" alt="Screenshot 2021-08-27 at 11 02 24" src="https://user-images.githubusercontent.com/12981093/131094002-e2f585b0-4e74-4688-9c10-f18d4f2fe841.png">


## Usage
UIView and UILayoutGuid extended by three properties that return one of helper. All this helpers confirms to LayoutBuilders for each orientation with set of functions for each anchor type.

### LayoutOne builder
With `UIView().layoutOne` you can call function of builder and it return created and activated NSLayoutConstraint.

```swift
var heightConstraint: NSLayoutConstraint!
// ...
heightConstraint = box.layoutOne.height(to: 50)
// ...
heightConstraint.constrant = 200
```

### LayoutChain builder
With `UIView().layoutChain` each function of builder will return LayoutChain object back and you can call it multiple times.

After all anchors is setted up you can leave this "chain" and come to configure a next view, LayoutChain will automaticaly activate constraints after deinit. But also you could build chain and store its result and deactivate or remove all constraints from the batch.

```swift
var layoutBatch: LayoutConstraintBatch!
// ...
layoutBatch = box.layoutChain
    .width(to: 50)
    .height(to: 50)
    .build()
// ...
layoutBatch.deactivate()
```

Also LayoutChain has additional functionality:
```swift
box.layoutChain
    .equalSize(to: containerView) // set widthAnchor and heightAnchor equaly
    .padding(to: containerView, insets: UIEdgeInsets()) // arrange box into containerView with specified insets from edges
    .center() // make center constraints to superview
```

### LayoutStack builder
With `UIView().layoutStack(axis: Axis, _ items: UIView...)` you have additional chain functions to arrange items like in UIStackView.

```swift
box.layoutStack(axis: .vertical, view1, view2, view3)
    .stackSpacing(16) // to make spacing between items equal to 16
    .stackEqualSpacing() // to keep spacing between items equal
    .stackInsets(UIEdgeInsets(top: 16, bottom: 16, left: 16, right: 16)) // insets from box view
    .stackAlignment(.center()) // to align all elements in center of box
    .stackDistributionEqual() // to keep equal size for all elements in selected stack orientation
    .stackElementsWidth(constant: 200) // will set width constraint for all elements
    .stackElementsHeight(constant: 200) // will set height constraint for all elements
```

### Operators
To add multiplication or constant to constraint you can use overloaded operators `+`, `-` and `*` for dimension anchors.
```swift
box.layoutOne.top(to: container.topAnchor + 32)
box.layoutOne.width(to: box.heightAnchor * 2 - 10)
box.layoutOne.width(to: box.heightAnchor * (1/3)) // but be careful with associativity
```

### Additional anchors
In addition to standard anchors, there are other features here.
```swift
box.layoutChain
    .aspect(ratio: 0.5) // to make width depend on height with ratio
    .inheritWidth(multiplier: 0.8, constant: -16) // to depend on width of superview (also inheritHeight here)
    .before(of: view, spacing: 8) // to constrain box trailing to view leading
    .after(of: view, spacing: 8) // to constrain box leading to view trailing
    .above(of: view) // box bottom to view top
    .below(of: view) // box top to view bottom
```

### Composite anchors
For composite anchors it is special operator `--` to make demension anchor from two xAxis or yAxis anchors.
```swift
view1.leftAnchor.anchorWithOffset(to: view2.rightAnchor) // native approach
view1.leftAnchor -- view2.rightAnchor // LayoutChain feature
```

To use this anchor in builder it is alternate functions for each xAxis and yAxis anchors.
```swift
box.layoutChain
    .bottomWith(view2.topAnchor, to: view3.trailingAnchor -- view4.leadingAnchor * 2)
```

## Compilation speed
For massive projects inevitably increases the amount of code for views layout. It is important to chose right framework to deal with it easy. Apart from being easy to read, it also must not have a big impact on compile time either.

<details>
  <summary>LayoutChain took 60-66ms</summary>
  <img width="660" alt="Screenshot 2021-08-26 at 12 57 48" src="https://user-images.githubusercontent.com/12981093/131037003-31c03398-b9e4-4d18-898d-53530a9469c7.png">
</details>

<details>
  <summary>SnapKit took 80ms</summary>
  <img width="670" alt="Screenshot 2021-08-26 at 13 01 49" src="https://user-images.githubusercontent.com/12981093/131036938-1537b191-1c4d-43e8-a358-72e1f0c7e4b2.png">
</details>

<details>
  <summary>Standart AutoLayout took 58ms</summary>
  <img width="673" alt="Screenshot 2021-08-26 at 13 03 02" src="https://user-images.githubusercontent.com/12981093/131036511-8879da45-5544-4a93-815b-5c2704158453.png">
</details>

As you can see that LayoutChain does not concede to native approach, but much better then some other popular frameworks.


For a better experience I also recomend you to specify some CGFloat parameters explicit, because using simple numbers decrease type-checking efficiency.

<details>
  <summary>Decreased compile type for implicit numbers</summary>
  <img width="456" alt="Screenshot 2021-08-26 at 12 59 59" src="https://user-images.githubusercontent.com/12981093/131037876-d5d3cc85-4e35-4668-a476-648a711d1d60.png">
</details>
