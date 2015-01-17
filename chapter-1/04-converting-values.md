# Converting Values

Some of the other languages we've used let us be pretty liberal with mixing and matching types. For example, if you you can divide an integer by a float in Ruby and it will just figure it out for you.

```rb
10 / 3 # returns 3 (an integer)
10 / 3.0 # returns 3.3333333333333335 (a float)
```

JavaScript will allow you to add a number to a string. It will convert that number to a string the fly.

```js
1 + "2" // returns '12'
```

This probably doesn't seem like a big deal because we're just using plain old values, but as our applications grow in complexity, it's these kind of things that lead to bugs.

Swift is obsessively focused on safety and—as a result—not letting stuff change from under your nose.

This will *not* work in Swift:

```swift
let myInteger: Int = 5
let myFloat: Double = 5.0

myInteger + myFloat
```

Swift doesn't want to be in the position where it has to figure out what you wanted converted to a float and what you wanted converted to an integer—and it certainly doesn't want to choose wrong on your behalf.

Swift does, however, give us the ability to cast a value from one type to another (this is called _typecasting_):

```swift
let myInteger: Int = 5
let myFloat: Float = 5.0

myInteger + Int(myFloat)
Double(myInteger) + myFloat
```

We can also convert integers and floats to strings:

```swift
let myInteger: Int = 5

let myBaseString = "Here is a number: "
let stringWithInt = myBaseString + String(myInteger)
```

We can't—out of the box convert a float to a string, but we work around that by casting it to an integer first.

```swift
let myFloat: Float = 5.0

let myBaseString = "Here is a number: "
let stringWithDouble = myBaseString + String(Int(myFloat))
```

This is a little wonky, so we could also do it with our old friend, string interpolation.

```swift
let myInteger: Int = 5
let myFloat: Float = 5.0

let integerAsString = "\(myInteger)"
let floatAsString = "\(myFloat)"
```

You're next question is probably, "How do we convert a string to a numeric value?" That really is an excellent question, but we're going to wait a bit before we answer it.
