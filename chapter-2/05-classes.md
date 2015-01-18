# Classes

Classes are a lot like structures with a few distinctions.

Classes can inherit from one another.

```swift
class Animal {
  func speak() {
    println("I am an aminal")
  }
}

class Dog: Animal {
  var legs = 4
  let species = "canine"
}

let dog = Dog()
dog.speak()
```

`Dog` inherits from `Animal` and has access to all of it's functionality as well as some of it's own.

## Passing Reference

In the previous section, I asked to put a little mental bookmark in what happened when you did something like this:

```swift
var rect = Rectangle(width: 100, height: 100)
var otherRect = rect
```

If you remember, we ended up with two seperate rectangles. If you don't remember, let me fill you in: we ended up with two separate rectanges. Changing one did not affect the other one.

Let's take a look at that again, but this time with classes:

```swift
class Dog {
  var name: String
  var legs = 4
  let species = "canine"
  init(name: String) {
    self.name = name
  }
}

var dog = Dog(name: "Marley")
dog.name // returns "Marley"

var potentiallyAnotherDog = dog

potentiallyAnotherDog.name = "Riley"

dog.name // returns "Riley"
potentiallyAnotherDog.name // returns "Riley"
```

Oh. Wait. `dog` and `potentiallyAnotherDog` were both pointing to the same object. Changing it one place change it in the other.

We also saw something else in this code example. Previously, we were just setting some defaults for the parameters. Here we want to have to explictly pass a name to our dog. Dogs love responding to their names and it is a little messed up to ask them to go nameless. Also, if all of our dogs had the same name and we called one of them, we'd get all of them and there is definitely such a thing as too much dog.

`init()` fires when our object is initialized. It's a function even though it looks a little strange. We can use `self` to talk about the object we're currently instantiating. Swift also gives us a `deinit()`.

Other than what we covered above. Classes have all of the same goodies as structures. We can add methods and use computed properties. I'd suggest that the rule of thumb is that you treat the relationship between structures and classes like you would constants and variables: stick with the former unless you know you need something special from the latter.
