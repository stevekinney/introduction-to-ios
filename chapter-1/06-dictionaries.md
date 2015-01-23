# Dictionaries

If you're from Ruby, they're called hashes. If you're from JavaScript, they're called objects. If you're from Python, they're called dictionaries. In Swift, they're also called dictionaries. Regardless of the name, it's a data structure that is a collection of keys and their associated values.

Let's start with a very simple dictionary so we can get a feel for their syntax:

```swift
let shoppingList = [apples: 2, oranges: 1]
```

The first thing that might have occurred to you is "Holy square brackets, Batman!" Yea, dictionaries in Swift have square brackets. I don't really know what else to tell you.

A common recurring theme that we've encountered is that, from time to time, we have to initialize an empty collection before we put anything in it. Let's get that out of the way now, shall we?

```swift
var shoppingList: [String:Int]
shoppingList = ["pizza": 1]
```

Like arrays, dictionaries are very particular about the kind of values their willing to hold. In the above syntax, we're promising Swift that we're going to use strings for the keys and integers for the values. The Swift compiler will keep us honest by refusing the compile if we try to do anything otherwise.

But, what if you wanted an empty dictionary that you could add keys to later? The code sample above is telling Swift that you're eventually going to put a dictionary here and it's going to live up to having these types of keys and values.

If we wanted to start out with an empty dictionary. We're going to need to actually instantiate it.

```swift
var shoppingList = [String:Int]()
shoppingList["pizza"] = 1
shoppingList["pizza"] // returns 1
```

As you probably gathered from the code example above, we can access our dictionary passing in a key in square brackets. The same rules apply for `let` versus `var`. If we use `let`, the dictionary will be immutable (or read-only). If we use `var`, then well be able to change values and set additional keys to our collective heart's content.

If you need to delete a value, you can just set it to `nil`.

```swift
var shoppingList = [String:Int]()

shoppingList["pizza"] = 1
shoppingList.count // returns 1

shoppingList["pizza"] = nil
shoppingList.count // returns 0
```

