# Optionals

You may or may not be aware of this, but I've been secretly avoiding the topic of optionals. But, I can't avoid it any longer. Sit down. Let's talk.

I am totally happy if the only thing you've taken away up to this point is that Swift hates ambiguity (compared to dynamic languages, at least) and really likes it when we tell it upfront what types of data we're dealing with.

In a perfect world, that would be fine. But we don't always know if we're going to have something. What if we hit up and API and don't get a response?

Let's meditate on the following scenario.

When we're dealing with dictionaries, we can pull out a value by handing the dictionary a key.

```swift
leet shoppingList = ["apples": 1, "oranges": 5, "pizzas": 1000]

let numberOfPizzasToBuy = shoppingList["pizzas"]
```

We'll talk about what that little bit of code actually returns in just a bit. For the moment, let's just take it for granted that `shoppingList["pizzas"]` gives us the value, which is an integer, which then sets the type of `numberOfPizzasToBuy` to an integer. All is right in the world.

If only programming was that easy. Things happen in programs. Let's say `shoppingList` was mutable and there was some user interaction that adds stuff to `shoppingList`. This isn't out totally out of the realm of possibility and  the compiler can't check for all the possible scenarios. 
If we try to access a key in a dictionary that isn't there, it returns `nil`. Hmm. That's weird. This whole time I've been telling you that Swift is obsessive about types and now I'm telling you there is a very realy likelihood that you may not have a value to hand it.

There are two possibilities here: Either I've been lying to you about Swift's type obsession or Swift has some way to deal with this ambiguity. I'm pleased to say that I'm not a liar and Swift has this under control.
