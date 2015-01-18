# Structures

We had our first exposure to creating our own data types earlier with enumerations. Now, it's time to go mad with power. Up to this point, we've been playing with very simple data types. But's say we wanted to play around with some geometry for a bit.

Let's meditate on the following bit of Swift:

```swift
struct Rectangle {
  var width = 0
  var height = 0
  func perimeter() -> Int {
    return (2 * width) + (2 * height)
  }
  func area() -> Int {
    return width * height
  }
}

var rect = Rectangle(width: 100, height: 100)

rect.width = 200
rect.perimeter() // returns 600
```

What we've effectively done here is created a new data type: `Rectangle`. A `Rectangle` has a few properties to it: `width` and `height`. We also have a few utility functions: `perimeter` and `area`. Just like strings and integers, we can create new rectangles and assign them to constants or variables. If we assign them to constants, we give up the ability to change the width and height of the rectangle but gain the piece of mind that comes from knowing that nothing else in our application can adjust those properties from under our noses.

We can make more rectangles from scratch or we can make another rectangle by copying from the first one.

```swift
var otherRect = rect

otherRect.width = 500

rect.perimeter() // returns 600
otherRect.perimeter() // returns 1,200
```

Even though I set `otherRect` to that first rectangle. I'm working with a copy. This may not seem significant to you right at this moment, but store it into your brain for a little bit, it'll come up again in a little bit.

I don't love that that I have put the parentheses on the end to call the `perimeter` and `area` methods. I mean, they're just properties of the rectangle, right? Ideally, I'd like to refer to them the same way I refer to any other property.

Well, Swift will actually let me do that with something called _computed properties_.

```swift
struct Rectangle {
  var width = 0
  var height = 0
  var perimeter: Int {
    get {
      return (2 * width) + (2 * height)
    }
  }
  var area: Int {
    get {
      return width * height
    }
  }
}

var rect = Rectangle(width: 100, height: 100)
rect.perimeter
```

Look, no parentheses after that call to `perimeter`. Swift computes the property based on the width and height of the rectange. If either of those change, Swift will update the perimeter and area properties. If we wanted to, we could also dynamically set properties with computed properties as well.

It's a bit contrived, but let's say for a moment that I wanted to set the `perimeter` property and and have it update `width` and `height` properties accordingly.

```swift
struct Rectangle {
  var width = 0
  var height = 0
  var perimeter: Int {
    get {
      return (2 * width) + (2 * height)
    }
    set {
      width = newValue / 4
      height = newValue / 4
    }
  }
}

var rect = Rectangle(width: 100, height: 100)
rect.perimeter // returns 400
rect.perimeter = 800
rect.width // returns 200
rect.height // returns 200
```

Using computed properties to set other computed properties can get a little hairy. As a result, we tend to rely on getters more often than setters. As a result, Swift has a short hand if we only want to set a getter. We can omit the `get` and just put the business logic inside of a pair of curly brackets.

```swift
struct Rectangle {
  var width = 0
  var height = 0
  var perimeter: Int {
   return (2 * width) + (2 * height)
  }
  var area: Int {
    return width * height
  }
}

var rect = Rectangle(width: 100, height: 100)
rect.perimeter
```

### Quick Practice

Can you create some additional structs? Try you hand at creating a triangle, a pentagon, or a circle. Use computed properties for area and perimeter. For the adventurous, you can create a three-dimensional object and compute the volume as well.
