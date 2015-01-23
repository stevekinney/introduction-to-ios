# Enumerations

If you're a Ruby programmer, you're probably familiar with Ruby's enumerable module, which makes it easy to work with collections of objects. Swift's `enum` is nothing like that, but it is our first chance to create our own data type. Let's take it for a whirl.

Here is an example from Apple's Swift guide:

```swift
enum CompassPoint {
  case North
  case South
  case East
  case West
}
```

We can now set a compass direction to a variable.

```swift
var direction = CompassPoint.North

// Alternatively
var direction: CompassPoint = CompassPoint.North
```

`CompassPoint` is a data type of our own creation. An enumeration is like a switch that we can adjust. The name might be a little confusing, but think of it like an enumeration of the different states that your `CompassPoint` data type is allowed to have.

Swift's strong typing means that once we declare a variable, we'll only be able to adjust it to different states of compass point. So, we get to use a little bit of shorthand.

```swift
direction = .South
```

We're now pointing south. We didn't need to re-announce that we're talking about a `CompassPoint`, Swift already knew that from way back when we declared it.

We're not going to be making many enumerations today, so I'm not going to go too deep into how they work, but we'll be using some enumerations made by Apple when we go to create an alert box and I didn't want the syntax to be completely foreign to you.
If you're interested in learning more about enumerations, I encourage you to read up on [Apple's documentation](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Enumerations.html).
