# Good Tipper

Tipping well is important. Let's write a small little program in Swift that will help us calculate how much of a tip to give at a restaurant.

We're going to do this in two motions: First we'll build our tip calculator in a playground and then we'll move it into an Xcode project and build an application around our project.

## Iteration One: Playground

We're going to use a class to encapsulate the logic of our tip calculator. We'll give it the bill amount and the tax percentage and it calculate 15%, 18%, and 20% tips on our behalf.

```swift
class TipCalculator {}
```

What do we need in order to calculate a tip?

* The bill amount
* The tip percentage

Let's set the bill amount up as constants, up front.

```swift
class TipCalculator {

  let billAmount: Double

}
```

Swift will yell at us at this point? Why? Well, we set some a constant without declaring them. Swift is upset because we're using a constant without an initializer or providing a default value. Let's assuage it's anger, shall we?

```swift
class TipCalculator {

  let billAmount: Double

  init(amount: Double) {
    self.billAmount = amount
  }
}
```

This should clear up any errors.

Next we probably want to do something with tax percentage, right? We probably need a subtotal.

```swift
class TipCalculator {

  let billAmount: Double

  init(amount: Double) {
    self.billAmount = amount
  }

  func calculateTip(tipPercentage: Double) -> Double {
    return billAmount * tipPercentage
  }

}

// This code is just to check if everything is working.
let tipCalculator = TipCalculator(amount: 20)
tipCalculator.calculateTip(0.20) // returns 4.0
```

Now we can leverage our function to calculate the total bill.

```swift
class TipCalculator {

  let billAmount: Double

  init(amount: Double) {
    self.billAmount = amount
  }

  func calculateTip(tipPercentage: Double) -> Double {
    return billAmount * tipPercentage
  }

  func calculateTotalBill(tipPercentage: Double) -> Double {
    return billAmount + calculateTip(tipPercentage)
  }

}

// This code is just to check if everything is working.
let tipCalculator = TipCalculator(amount: 20)
tipCalculator.calculateTip(0.20) // returns 4.0
tipCalculator.calculateTotalBill(0.20)
```

That works, but we don't really want to show our user the percentage as a floating point number. We're writing real software here, right? We want to format it as a as currency. Swift doesn't handle that by default, but the Foundation framework has a `NSNumberFormatter` class that will take care of this for us.

First, let's import the Foundation Framework at the top of our file.

```swift
import Foundation
```

The code that follows is a little squirrelly, but let's right it and then take some time to talk about it.

```swift
func calculateTotalBillFormattedAsCurrency(tipPercentage: Double) -> String {
  var formatter = NSNumberFormatter()
  formatter.numberStyle = .CurrencyStyle
  let totalBill = calculateTotalBill(tipPercentage)
  return formatter.stringFromNumber(totalBill)!
}
```

We're grabbing `NSNumberFormatter` from Foundation and then setting it's formatting style to `.currencyStyle` (that's an enumerator, if you recall) and then we generate a string from the number using our newly setup formatter.

Let's also generate some computed properties for the most common tip amounts. We'll do the first one together and then you can take a shot at the other two.

```swift
var fifteenPercentTip: String {
  return calculateTipFormattedAsCurrency(0.15)
}
```

We may also want a total bill (bill + tip) formatted as currency as well. Let's write that too:

var totalBillForFifteenPercentTip: String {
  return calculateTotalBillFormattedAsCurrency(0.15)
}

Recall if we only setting a getter on a computed property, we can write the entire thing using a closure (that's the thing in curly braces there).

### Quick Practice

Can you write computed properties for 18% and 20% tips.

## Iteration Two: Xcode Project

Let's set up a new Single-View Application Project in Xcode called GoodTipper.

We got a working prototype set up in a playground, but Playgrounds are exclusively for experimentation. We're going to have to do a little work to port it into something we can work in our Xcode project.

Let's create a new file that called "TipCalculatorModel.swift". This will house our `TipCalculatorModel`. We will need to make a few minor tweaks to get everything working.

Most notably, we're going to need to change our constant `billAmount` to a variable as it's going to be updated throught the user interface of our application.

Your `TipCalculatorModel` should look something like this:

```swift
//
//  TipCalculatorModel.swift
//  GoodTipper
//
//  Created by Steve Kinney on 1/24/15.
//  Copyright (c) 2015 Steve Kinney. All rights reserved.
//

import Foundation

class TipCalculatorModel {

  var billAmount: Double

  var formatter = NSNumberFormatter()

  init(amount: Double) {
    self.billAmount = amount
    formatter.numberStyle = .CurrencyStyle
  }

  func calculateTip(tipPercentage: Double) -> Double {
    return billAmount * tipPercentage
  }

  func calculateTipFormattedAsCurrency(tipPercentage: Double) -> String {
    return formatter.stringFromNumber(calculateTip(tipPercentage))!
  }

  func calculateTotalBill(tipPercentage: Double) -> Double {
    return billAmount + calculateTip(tipPercentage)
  }

  func calculateTotalBillFormattedAsCurrency(tipPercentage: Double) -> String {
    let totalBill = calculateTotalBill(tipPercentage)
    return formatter.stringFromNumber(totalBill)!
  }

  var fifteenPercentTip: String {
    return calculateTipFormattedAsCurrency(0.15)
  }

  var eighteenPercentTip: String {
    return calculateTipFormattedAsCurrency(0.18)
  }

  var twentyPercentTip: String {
    return calculateTipFormattedAsCurrency(0.20)
  }

  var totalBillForFifteenPercentTip: String {
    return calculateTotalBillFormattedAsCurrency(0.15)
  }

  var totalBillForEighteenPercentTip: String {
    return calculateTotalBillFormattedAsCurrency(0.18)
  }

  var totalBillForTwentyPercentTip: String {
    return calculateTotalBillFormattedAsCurrency(0.20)
  }

}
```

### Building the Basic Interface

#### Setting Up a Top Bar

* Visit the `Main.storyboard`
* Select our View Controller in the document outline of the storyboard
* Go to the _Editor_ menu; select _Embed In_; select _Navigation Controller_
* Set the text to "Good Tipper"

#### Adding Some Labels

* Go to the object library and search for "Label"
* Bring a label and change the text to "Bill Amount"
* Bring in a text field and set it's keyboard type to "Decimal Pad"
* Bring in a "Button" and change it's text to "Calculate"

#### Setting Up the Results View

* Drag in a TextView from the object library.
* Delete the placeholder text
* Uncheck editable and selectable

#### Fixing the Layout

If we ran the simulator right now, we're see that things look a little, umm, off. iOS developers used to only have to worry about one size of device and they could put everything exactly where it needed to be. These days we have many different sized devices. So, we need to create interfaces that can adapt to just about any size.

* Select the View from the document outline
* In the lower-right of your Storyboard, there should be a triangle in between two lines.
* Click that icon and under "All Views" there will be an option called "Add Missing Constraints." Click that.

Run our application in the simulator and we should have an application has a functioning user interface--even if it doesn't actually do anything yet.

### Wiring Up the User Interface

* Open up the Assistant Editor (using the icon that kind of looks like a Venn diagram in the upper-right of your window).
* Control-click and drag from the text field and the text view to the ViewController. We'll name the text field, `billAmountTextField`, and the text field, `tipCalculationTextView`. I like descriptive names.

You should have two additional lines in your `ViewController`:

```swift
@IBOutlet weak var billAmountTextField: UITextField!
@IBOutlet weak var tipCalculationTextView: UITextView!
```

We probably want to get that "Calculate" button working as well, right?

Let's do the same process of control-clicking an dragging.

In the resulting pop-over, make sure you change "Outlet" to "Action." We've created an action that will fire anytime this button is clicked.

Let's give it some dummy functionality for now.

```swift
@IBAction func calculateButtonTapped(sender: AnyObject) {
  println("I was clicked!")
}
```

Run the simulator and click the button. In your Xcode window, a logger should show up and you should see our message.

We're getting there, right?

### Refreshing the User Interface

So, we can respond to a tap on the button. Let's update the user interface when the "Calcuate Button" is tapped. In order to this, we're going to need that model we created earlier. We're also going to need a function to refresh the user interface.

Let's work on updating the user interface first.

The first and simplest thing we could do is this:

```swift
@IBAction func calculateButtonTapped(sender: AnyObject) {
  tipCalculationTextView.text = "Someone clicked the calculate button."
}
```

This will work in a simple case, but let's abstract this out into its own method.

```swift
@IBAction func calculateButtonTapped(sender: AnyObject) {
  refreshUserInterface()
}

func refreshUserInterface() {
  tipCalculationTextView.text = "Someone clicked the calculate button."
}
```

Seems silly right now, but it will come in handy later.

The first thing we're going to need is the bill amount. This is a little bit tricky, so bear with me. Swift doesn't have a way to convert a string to a floating point that we can do math with. Bummer. Objective-C's `NSString` class has something we can use. But first, we have to cast our string as an `NSString`, get its double value, and then cast _that_ into a Swift double. Here we go:

```swift
let billAmount = Double((billAmountTextField.text as NSString).doubleValue)
```

That's probably the trickiest piece of code we're going to write all afternoon.

Next, we'll update the `billAmount` property in our tip calculator to whatever is in the `billAmountTextField`, which we parsed in the squirrely line of code above and then we're update the contents of the `tipCalculationTextField`.

The resulting method should look like this:

```swift
  func refreshUserInterface() {
    let billAmount = Double((billAmountTextField.text as NSString).doubleValue)
    tipCalculator.billAmount = billAmount
    tipCalculationTextView.text = "A twenty precent tip would be \(tipCalculator.twentyPercentTip) and your total bill would be \(tipCalculator.totalBillForTwentyPercentTip)"
  }
```

Let's fire up the simulator. If all went well, we should be able generate a tip and total bill amount.

Let's do one other fun tweak. There is not a lot going on in this application so it's fair to say that when someone fires up the application that they pretty much always want to enter a bill amount. We can have the `billAmountTextField` be what's called the `firstResponder`. The `firstResponder` is the UI element that takes focus when we first enter that view.

Let's implement this feature:

```swift
override func viewDidLoad() {
  super.viewDidLoad()
  billAmountTextField.becomeFirstResponder()
}
```

At the end of this iteration. Our ViewController should look as follows:

```swift
import UIKit
import Foundation

class ViewController: UIViewController {

  let tipCalculator = TipCalculatorModel(amount: 20)

  @IBOutlet weak var billAmountTextField: UITextField!
  @IBOutlet weak var tipCalculationTextView: UITextView!

  @IBAction func calculateButtonTapped(sender: AnyObject) {
    refreshUserInterface()
  }

  func refreshUserInterface() {
    let billAmount = Double((billAmountTextField.text as NSString).doubleValue)
    tipCalculator.billAmount = billAmount
    tipCalculationTextView.text = "A twenty precent tip would be \(tipCalculator.twentyPercentTip) and your total bill would be \(tipCalculator.totalBillForTwentyPercentTip)"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    billAmountTextField.becomeFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
```

## Iteration Three: More Better

Let's add two labels: A static label that says "Tip Amount" and then a label for the actual tip amount that we'll update with code. We'll also add a slider.

Make sure to "Add Missing Constraints" and "Update Existing Constraints".

The goal is that we'll update the tip and total bill amount as the user adjusts the parameters in the UI.

We'll have a few subiterations as we go along.

### Subiteration: Update the Tip Percentage

Step one, let's wire up this slider we just added to the UI. We're going to do a bit more of that control-drag action. The end result should be the following code.

```swift
@IBOutlet weak var tipPercentageSlider: UISlider!
@IBOutlet weak var tipPercentageLabel: UILabel!

@IBAction func tipPercentageSliderChanged(sender: AnyObject) {
  println(tipPercentageSlider.value)
}
```

Let's start by updating that label. Here is a reasonable first pass:

```swift
@IBAction func tipPercentageSliderChanged(sender: AnyObject) {
  let tipPercentage = Int(tipPercentageSlider.value)
  tipPercentageLabel.text = "\(tipPercentage)%"
}
```

We're casting the slider value to an integer to get a value without a ton of decimal places.

### Subiteration: Refactoring our Tip Calculator Model

Now, before we go on and write some bad code. Let's refactor `TipCalculatorModel`. We're getting the tip percentage from the UI now, it would be nice if we could just have it maintain the state of the tip percentage and do its calculations internally.

In this refactoring, we're going to:

* Give our model a tip percentage that can be updated
* Have all of our internal methods rely on that tip percentage

The name of the game here is converting our functions to computed properties:

```swift
import Foundation

class TipCalculatorModel {

  var billAmount: Double
  var tipPercentage: Int = 20

  let formatter = NSNumberFormatter()

  init(amount: Double) {
    self.billAmount = amount
    formatter.numberStyle = .CurrencyStyle
  }

  var tipAmount: Double {
    return billAmount * Double(tipPercentage)
  }

  var totalBill: Double {
    return billAmount + tipAmount
  }

  var tipAmountAsCurrency: String {
    return formatter.stringFromNumber(tipAmount)!
  }

  var totalBillAsCurrency: String {
    return formatter.stringFromNumber(totalBill)!
  }

}
```

Much better. The calculator knows about it's own tip percentage and we just use a few computed properties.

Our changes are going to break `refreshUserInterface`, so let's just remove the broken code for now.

```swift
func refreshUserInterface() {
  let billAmount = Double((billAmountTextField.text as NSString).doubleValue)
  tipCalculator.billAmount = billAmount
}
```

We can also update our `tipPercentageSliderChanged` function as well:

```swift
@IBAction func tipPercentageSliderChanged(sender: AnyObject) {
  let tipPercentage = Int(tipPercentageSlider.value)
  tipCalculator.tipPercentage = tipPercentage
  tipPercentageLabel.text = "\(tipCalculator.tipPercentage)%"
}
```

### Subiteration: Get Rid of the Calculate Button

Let's apply our new knowledge of updating the UI when a value changes and it apply it to that text box as well.

Control-drag from the bill amount input field to the ViewController. We're going to set an action on "Editing Changed". Let's call it `billAmountChanged`. Let's steal that code we wrote before for changing the bill amount in `refreshUserInterface` and put it up here instead. The resulting code should look like this:

```swift
@IBAction func billAmountChanged(sender: AnyObject) {
  tipCalculator.billAmount = Double((billAmountTextField.text as NSString).doubleValue)
}
```

We can remove it from our `refreshUserInterface` method as well, which should now be a nice slim little one liner:

```swift
func refreshUserInterface() {
  tipCalculationTextView.text = "The tip will be \(tipCalculator.tipAmountAsCurrency) for a total bill of \(tipCalculator.totalBillAsCurrency)."
}
```

We can now totally remove the the action that fires when the "Calculate" button is hit. Let's then refactor what's left to look like the following:

```swift
@IBAction func billAmountChanged(sender: AnyObject) {
  tipCalculator.billAmount = Double((billAmountTextField.text as NSString).doubleValue)
  refreshUserInterface()
}

@IBAction func tipPercentageSliderChanged(sender: AnyObject) {
  let tipPercentage = Int(tipPercentageSlider.value)
  tipCalculator.tipPercentage = tipPercentage
  refreshUserInterface()
}

func refreshUserInterface() {
  tipCalculationTextView.text = "The tip will be \(tipCalculator.tipAmountAsCurrency) for a total bill of \(tipCalculator.totalBillAsCurrency)."
  tipPercentageLabel.text = "\(tipCalculator.tipPercentage)%"
}
```

Lastly, let's remove the calculate button and update the constraints on our UI.

The final result of our ViewController should look as follows:

```swift
import UIKit
import Foundation

class ViewController: UIViewController {

  let tipCalculator = TipCalculatorModel(amount: 0)
  var tipPercentage = 0.20

  @IBOutlet weak var tipPercentageSlider: UISlider!
  @IBOutlet weak var tipPercentageLabel: UILabel!
  @IBOutlet weak var billAmountTextField: UITextField!
  @IBOutlet weak var tipCalculationTextView: UITextView!

  @IBAction func billAmountChanged(sender: AnyObject) {
    tipCalculator.billAmount = Double((billAmountTextField.text as NSString).doubleValue)
    refreshUserInterface()
  }

  @IBAction func tipPercentageSliderChanged(sender: AnyObject) {
    let tipPercentage = Int(tipPercentageSlider.value)
    tipCalculator.tipPercentage = tipPercentage
    refreshUserInterface()
  }

  func refreshUserInterface() {
    tipCalculationTextView.text = "The tip will be \(tipCalculator.tipAmountAsCurrency) for a total bill of \(tipCalculator.totalBillAsCurrency)."
    tipPercentageLabel.text = "\(tipCalculator.tipPercentage)%"
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    billAmountTextField.becomeFirstResponder()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}
```

### Your Turn

Can you get rid of that big, ugly text view where were putting that little narrative (e.g. "The tip will be \(tipCalculator.tipAmountAsCurrency) for a total bill of \(tipCalculator.totalBillAsCurrency)").

Let's add four UI labels. The first two will just be static values: "Tip Amount" and "Bill Amount". Add two more that we'll update whenever the values change.
