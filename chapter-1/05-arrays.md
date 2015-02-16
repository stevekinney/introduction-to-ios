# Arrays

By this point, you won't be surprised to learn that arrays in Swift look a lot like their counterparts in Ruby and JavaScript, but if we dig in a little bit, they have some important differences.

But, let's talk start at the surface. This is how we would go about declaring an array in Swift.

```swift
let beatles = ["John", "Paul", "George", "Ringo"]
```

How many Beatles are there?

```swift
beatles.count // returns 4
```

If we wanted to iterate through this array, we could do that just like we did with strings earlier.

```swift
for beatle in beatles {
  println(beatle)
}
```

Let's say Eric Clapton wanted to join the Beatles. We'll append him to the array.

```swift
let beatles = ["John", "Paul", "George", "Ringo"]

beatles.append("Eric")
```

Uh oh! This won't actually work. Can you take a guess why?

It's because we declared our array as a constant when we used the `let` keyword. This means our array is immutable.

Objective C used to have two versions of every data type. It had `NSMutableArray` and `NSImmutableArray`. Swift allows us to cut down on that nonsense by taking it's cue from the keyword we use when we define the variable or constant.

If we switch the `let` to a `var`, it will work.

```swift
var beatles = ["John", "Paul", "George", "Ringo"]

beatles.append("Eric")
```

But what if the number of 5 wanted to join our array of Beatles? In a dynamic language like Ruby, Python, or JavaScript, this would be no big deal.

In Swift, it's a big deal. This doesn't work:

```swift
var beatles = ["John", "Paul", "George", "Ringo"]

beatles.append(5)
```

On assignment, Swift will infer the type of the array. In this case, it will infer the type as `<String>` since this is what was initially in the array when it was created.

With this in mind, realize that Swift can create multi-type arrays, just not as simply as other dynamically typed languages. For instance, you could create an array like this:

```swift
var beatlesAndNumber = ["John", "Paul", "George", "Ringo", 10]

beatlesAndNumber.append(5)
```

The append would now work correctly. This is because when you instantiated this array, Swift saw that it contained multiple types of objects, so it inferred the array to be of type `<AnyObject>`.

Specifying an array instantiation as an `<AnyObject>` will allow your array to contain any type, even other arrays.

```swift
var beatlesAndOtherThings:[AnyObject] = ["John", "Paul", "George", "Ringo", 10, ["hello", 1]]

beatlesAndOtherThings.append(5)
```

Even though it is valid code to create arrays with multiple types, and it is not recommended by Apple to do so, so try and avoid it.

If you recall from when we talked about variables and constants, Swift takes a lucky guess when you first declare your variable or constant.

But sometimes, we want to start out with an empty array and add stuff to it as we go along. In that case, how will Swift know what kind of an array it is?

There is a special syntax for declaring an empty array.

```swift
var beatles: [String] = []

beatles.isEmpty // returns true

beatles.append("John")
beatles.append("Paul")
beatles.append("George")
beatles.append("Ringo")

beatles.isEmpty // returns false

var numbers: [Int] = []

numbers.append(1)
numbers.append(2)
```

The important part to note is that we put the type inside of the square brackets to let Swift know what kind of data we plan on storing in the array.

We can get values out of arrays, the same way we do in other languages.

```swift
let numbers = [1,2,3]

numbers[0] // returns 1
numbers[1] // returns 2
numbers[2] // returns 3
```

We can also pop values in at specific plays in our array.

```swift
var numbers = [1,2,3,4,5]

numbers.insert(6, atIndex: 3)
numbers.insert(7, atIndex: 6)

println(numbers) //  [1,2,3,6,4,5,7]
```

We can also append multiple items to a given array with the `+=`:

```swift
var numbers = [1, 2, 3]

numbers += [4, 5, 6] // numbers will be [1, 2, 3, 4, 5, 6]

numbers += [7] // numbers will be [1, 2, 3, 4, 5, 6, 7]
```

And add values contained in the array indices:

```swift
var numbers = [3, 4, 5, 6]

var addedIndicies = numbers[0] + numbers[1] // returns 7
```

Or replace items in an array with something else:

```swift
var numbers = [1, 2, 3, 4]

numbers[1] = 5 // numbers will now be [1, 5, 3, 4]

numbers[0...2] = [6, 7, 8] // numbers will now be [6, 7, 8, 4]
```

Swift can giveth and Swift can taketh away:

```swift
var numbers = [1, 2, 3, 4]

numbers.removeAtIndex(1) // numbers is now [1, 3, 4]

numbers.removeLast() // numbers is now [1, 3]
```

### Quick Practice

Towards the end of the Beatles' time together, George Harrison threatened to leave the band. John callously told a reporter that he didn't care, the band would just replace him with Eric Clapton.

* Can you remove George from the `beatles` array that we created earlier?
* Can you put Eric Clapton in his spot?
