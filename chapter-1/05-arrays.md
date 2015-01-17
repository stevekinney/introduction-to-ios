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

Swift, like Java and C, can only store one type of object in its array. So, you can have an a array of strings or you can have an array of integers, but you can't mix and match.

If you recall from when we talked about variables and constants, Swift takes a lucky guess when you first declare your variable or constant.

But sometimes, we want to start out with an empty array and add stuff to it as we go along. In that case, how will Swift know what kind of an array it is?

There is a special syntax for declaring an empty array.

```swift
var beatles: [String]

beatles.append("John")
beatles.append("Paul")
beatles.append("George")
beatles.append("Ringo")

var numbers: [Int]

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

We can also combine arrays with `+=`:

```swift
var numbers = [1, 2, 3]

numbers += [4, 5, 6] // numbers will be [1, 2, 3, 4, 5, 6]

numbers += [7] // numbers will be [1, 2, 3, 4, 5, 6, 7]
```

Swift can giveth and Swift can taketh away:

```swift
var numbers = [1, 2, 3]

numbers.removeAtIndex(1) // numbers is now [1, 3]
```

### Quick Practice

Towards the end of the Beatles' time together, George Harrison threatened to leave the band. John callously told a reporter that he didn't care, the band would just replace him with Eric Clapton.

* Can you remove George from the `beatles` array that we created earlier?
* Can you put Eric Clapton in his spot?
