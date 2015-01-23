# Optionals

You may or may not be aware of this, but I've been secretly avoiding the topic of optionals. But, I can't avoid it any longer. Sit down. Let's talk.

I am totally happy if the only thing you've taken away up to this point is that Swift hates ambiguity (compared to dynamic languages, at least) and really likes it when we tell it upfront what types of data we're dealing with.

In a perfect world, that would be fine. But we don't always know if we're going to have something. What if we hit up and API and don't get a response?

Let's meditate on the following scenario.

When we're dealing with dictionaries, we can pull out a value by handing the dictionary a key.

```swift
let shoppingList = ["apples": 1, "oranges": 5, "pizzas": 1000]

let numberOfPizzasToBuy = shoppingList["pizzas"]
```

We'll talk about what that little bit of code actually returns in just a bit. For the moment, let's just take it for granted that `shoppingList["pizzas"]` gives us the value, which is an integer, which then sets the type of `numberOfPizzasToBuy` to an integer. All is right in the world.

If only programming was that easy. Things happen in programs. Let's say `shoppingList` was mutable and there was some user interaction that adds stuff to `shoppingList`. This isn't out totally out of the realm of possibility and  the compiler can't check for all the possible scenarios.

If we try to access a key in a dictionary that isn't there, it returns `nil`. Hmm. That's weird. This whole time I've been telling you that Swift is obsessive about types and now I'm telling you there is a very real likelihood that you may not have a value to hand it.

There are two possibilities here: Either I've been lying to you about Swift's type obsession or Swift has some way to deal with this ambiguity. I'm pleased to say that I'm not a liar and Swift has this under control.

Swift has something called _optionals_ for exactly this kind of situation. Let's look at an optional in action.

```swift
var number: Int?

number // returns nil

number = 67 // returns {Some 67}

number! // returns 67

println("Your secret number is \(number!)")
```

Okay, there are a few things going on here. First we have that question mark at the end of the first line. That let's Swift know that this value is going to be an optional. Swift knows that `number` is going to be a integer or nothing at all. Right now it's nothing at all. We can confirm on line 3 that the value of number is nil. If you were to take away the question mark on line 1, you'd get a error that the variable was used before it was initialized. That's because it's not longer an optional.

On line 5, we set the variables value to 67. But, it's still an optional. We know it's 67, but Swift isn't sure just yet. We have to unwrap the optional. How do we unwrap an optional? We use an exclamation point!

An optional is a lot like Schrödinger's cat. It could exist or not exist. When we use the exclamation point. We open the box, take a look, and Swift applies all off it's type rules to the value.

Let's go back to the dictionary example above. `shoppingList` is a mutable dictionary of string keys and integer values. But, we could potentially get back `nil` if we ask for a key that is not in the dictionary. Rather than crash and burn when someone asks for a key that's in the dictionary, Swift covers its rear by just always returning an optional when someone asks for a value from a dictionary and then lets the developer figure out what to do with the value.

```swift
var shoppingList = ["pizzas": 2, "apples": 5000]

var numberOfPizzas = shoppingList["pizzas"]

println("Let's order \(numberOfPizzas!) pizzas.")
```

`numberOfPizzas`'s type is `Int?`. It's an optional. We aren't totally sure that there is a `"pizzas"` key in the dictionary. So, we hypothetically protect ourselves by returning an optional. Except we haven't really protected ourselves because we're throwing caution to the wind and immediately unwrapping it in the string interpolation that follows. If, for some reason, `numberOfPizzas` is `nil`, it'll blow up here. Bad news bears.

We can do better:

```swift
var shoppingList = ["pizzas": 2, "apples": 5000]

var numberOfPizzas = shoppingList["pizzas"]

if numberOfPizzas != nil {
  println("Let's order \(numberOfPizzas!) pizzas.")
} else {
  println("I don't really know anything about pizzas.")
}
```

We can even shorten this up a little bit by doing the assignment in the conditional itself. We can assign a value to `numberOfPizzas`, go for it. If not, then don't. It's cool by us.

```swift
var shoppingList = ["pizzas": 2, "apples": 5000]

if let numberOfPizzas = shoppingList["pizzas"] {
  println("Let's order \(numberOfPizzas) pizzas.")
} else {
  println("I don't really know anything about pizzas.")
}
```

Optionals can be a little confusing, for sure. But they're an important concept in Swift that we'll see more of when we start designing a user interface. Often, we have to as our UI for a value and we have to hope that there is one. In these cases, iOS will an optional that we can deal with responsibly.

