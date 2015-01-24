# Tuples

Tuples are way to return multiple values. You can access those values with dot syntax.

```swift
let iAmATuple = (1, 2, "Something")

iAmATuple.0 // returns 0
iAmATuple.1 // returns 1
iAmATuple.2 // returns 2
```

We can also name the properties of a tuple.

```swift
let iAmATupleWithNames = (statusCode: 404, message: "Forbidden")

iAmATupleWithNames.statusCode // returns 404
iAmATupleWithNames.message // returns "Forbidden"
```

If you remember, arrays and dictionaries are statically typed. Tuples give us a way to return multiple values from a function.

```swift
func getWebPage(url: String) -> (statusCode: Int, message: "Forbidden") {
  // Do some web page fetching
  let statusCode = // Something we parsed from the webpage.
  let message = // Something we parsed from the web page.
  return (statusCode: statusCode, message: message)
}
```

You can then access those properties through dot notation, or you can split them out and assign them to properties.

```swift
let iAmATuple = (1, 2, "Something")
let (one, two, something) = iAmATuple

one // returns 1
two // returns 2
something // returns "Something"
```

