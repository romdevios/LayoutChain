# LayoutChain

Yet another AutoLayout abstraction framework that halps to simplify managing NSLayoutConstraints.

LayoutChain has simple intuitive syntax and decreased compilation time of views layout setup. Easy access to creating single constraint and features to setup own UIStackView with a little amount of constraints.

### Motivation
The idea was to create lightweight wrapper on AutoLayout without lossing access to native API. Other frameworks may have a lot of generics and operators overload that can significantly increase the time for type-checking during compilation. Some frameworks has complex API to construct layout but even do not has simple functions to take a single constraint for its managing.

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
    .package(url: "https://github.com/romdevios/LayoutChain.git", .upToNextMajor(from: "0.1.0"))
]
```

Or add dependency manually in Xcode. File -> Swift Packages -> Add Package Dependency... then enter the package URL 'https://github.com/romdevios/LayoutChain.git' and click Next button.


### CocoaPods

[CocoaPods](#https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:
```
$ gem install cocoapods
```
To integrate **LayoutChain** into your Xcode project using CocoaPods, specify it in your `Podfile`:
```ruby
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
  pod 'LayoutChain'
end
```
Then, run the following command:
```
$ pod install --repo-update
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate LayoutChain into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "romdevios/LayoutChain"
```

Run `$ carthage update --use-xcframeworks` and drag the built `.xcframework` bundles from `Carthage/Build` into the "Frameworks and Libraries" section of your application’s Xcode project. If you are using Carthage for an application, select "Embed & Sign", otherwise "Do Not Embed".


<br />

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
      
      func layoutBuilder() {
         // ...
      }

   }
   ```
</details>

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
#### Result

<img width="288" alt="Screenshot 2021-08-27 at 11 02 24" src="https://user-images.githubusercontent.com/12981093/131094002-e2f585b0-4e74-4688-9c10-f18d4f2fe841.png">

<br />

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
view1.leftAnchor -- view2.rightAnchor // LayoutChain featur
```

To use this anchor in builder it is alternate functions for each xAxis and yAxis anchors. For example, to keep distance between view3.trailing and view4.leading twice smaller then distance between box.bottom and view2.top just add the following line of code:
```swift
box.layoutChain
    .bottomWith(view2.topAnchor, to: view3.trailingAnchor -- view4.leadingAnchor * 2)
```
<br />

