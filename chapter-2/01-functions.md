# Functions

In Chapter One, we spent a long time talking about the different types availabe to us in Swift. In this chapter, we're going to talk about how to work with data and how to create our own data structures.

In Swift, like JavaScript, functions are first class objects. That means we can treat them like any other data in our application. Their syntax is similar to JavaScript, but we must define the types of data going into our function as well as the types coming out of our function.

Let's start with a super simple function.

```swift
func sayHello() {
  println("Oh hello!")
}

sayHello() // prints "Oh hello!"
```

So far, so good. But like I mentioned above. Swift is very particular about what comes into a function and what goes out.

Imagine for a moment, if you will, that we'd like to pass an argument into this function. Let's say it's a number.

```swift
func announceFavoriteNumber(favoriteNumber: Int) {
  println("My favorite number is \(favoriteNumber)")
}

announceFavoriteNumber(6) // prints "My favorite number is 6"
```

Notice how we had to be particular abour the type of the argument our function was willing to take. This is pretty great. Unlike dynamic languages, we never have to worry about what kind of argument was passed in. We can sleep soundly knowing it was an integer.

The two functions above don't actually return a value. As you've probably guessed by now, we're going to need to be pretty specific about that as well.

```swift
func addTwo(addend: Int) -> Int {
  return addend + 2
}
```

That `-> Int` lets Swift know that we fully intend for this function to return an integer. We've let Swift know exactly what's going into this function as well as what's coming out.

### Quick Practice

* Can you write a function that takes a number and multiplies it by three?
* Can you write a function that takes two numbers, adds them together, and then multiplies the sum by two?
* Can you write a function that takes two numbers, adds them together, and then returns them to a float?

## Named Arguments

Let's write a function that counts from one integer from another, alright?

```swift
func countUp(startingValue: Int, endingValue: Int) {
  for i in startingValue...endingValue {
    println(i)
  }
}

countUp(1, 10)
```

In this super contrived example, this isn't so bad. If we wanted count from one up to ten, we'd call `countUp(1, 10)`. But remembering things is hard, right? What if it took a third argument that multiplied each number? What if it took a fourth argument that pointed towards some part of the UI you wanted to update? What if it took a fifth argument? A sixth? How would you keep them all straight?

You could just try to remember all of the arguments. Maybe you're a better person than me.

Another alternative is that we could use named arguments. For the sake of simplicity, let's stick with our `countUp` function.

```swift
func countUp(from startingValue: Int, to endingValue: Int) {
  for i in startingValue...endingValue {
    println(i)
  }
}

countUp(from: 1, to: 10)
```

The big different here is how I call the function on the last line and how I declare the parameters on the first line. If I had 7 arguments, it wouldn't be hard to keep them all straight--especially since Xcode will show us the parameter names.

Let's tackle some vocabulary. The first parameter has is written as `from startingValue: Int`. We already know what the `Int` part means; it's the return value. The first part, the `from` is what's know as the "external parameter", or how we refer to the parameter outside of the function itself. `startingValue` is the internal parameter. It's how we're talking about the parameter inside of the function.

Here is another version where we adjust the syntax slightly to keep the named parameters, but use the same parameters both internally and externally.

```swift
func countUp(#from: Int, #to: Int) {
  for i in from...to {
    println(i)
  }
}

countUp(from: 1, to: 10)
```

Cool. Let's say we usually wanted to count up from 1, unless we didn't. In other words, if we pass in a starting value, use that. Otherwise, use a default that we set. That's possible in Swift.

```swift
func countUp(#from: Int = 1, #to: Int) {
  for i in from...to {
    println(i)
  }
}

countUp(to: 10)
countUp(from: 15, to: 20)
```

You'll see this pattern a lot in Apple's frameworks. Most of the time a default if what you want, but there is a way to override that default parameter if you want/need to.

### Quick Practice

Can you adjust our function so that by default it counts from 1 to 100 unless you say otherwise?
