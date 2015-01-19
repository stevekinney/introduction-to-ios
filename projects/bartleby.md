---
status: work-in-progress
---

# Bartleby

* Master/detail view
* Keep Core Data unchecked

The application uses a Note class which we're going to store in a Key/Value storage.

File > New > Cocoa Touch Class
Subclass of NSObject

Two properties:

```swift
Date (String)
Note (String)

override init() {
  date = NSDate().description
  note = ""
}
```

Go to `viewDidLoad` and set a new note to the variable `n`

In the class file, we're going to create a few objects. Swfit doesn't support class variables just yet. So we're just going to do it in the same file for the Notes class.

```swift
var allNotes:[Note] = []
var currentNoteIndex:Int = -1
var noteTable:UITableView
```

Hmm. So, we have a minor problem. This class is loaded before we access to the UI. Which means we don't have access to your our `UITableView` just yet. We can get around this by declaring it as an optional.


```swift
var allNotes:[Note] = []
var currentNoteIndex:Int = -1
var noteTable:UITableView?
```

When the view loads, let's set `noteTable` to the table view in our UI. Add the following line to `viewDidLoad()`:

```swift
noteTable = self.tableView
```

Let's add a method to `Note` that turns it into a dictionary that we can store in User Defaults.

```swift
func dictionary() -> NSDictionary {
  return ["note": note, "date": date]
}
```

Let's also create a class method that will save all of our notes.

```swift
class func saveNotes() {
  var arrayOfNotes:[NSDictionary] = []
  for var i = 0; i < allNotes.count; i++ {
    arrayOfNotes.append(allNotes[i].dictionary())
  }
  NSUserDefaults.standardUserDefault.setObject(arrayOfNotes, forKey: "notes")
}
```

We're also going to want to load some notes, right?

```swift
  var defaults = NSUserDefaults.standardUserDefaults()
  var savedData:[NSDictionary]? = defaults.objectForKey("notes") as? [NSDictionary]
  if let data:[NSDictionary] = savedData {
    for var i = 0; i < data.count; i++ {
      var n:Note = Note()
      n.setValuesForKeysWithDictionary(data[i])
      allNotes.append(n)
    }
  }
```

Okay, that was a lot. Let's stop for a bit and explain what's going on here.

(NOTE: Go back to the chapter on optionals and talk a bit about optional chaining.)

Let's head back over to our good old friend `viewDidLoad()` and add the following:

```swift
Note.loadNotes()
println("allNotes: \(allNotes)")
var note = Note()
allNotes.append(note)
Note.saveNotes()
```

Let's try this out in the simulator. We're going to use the home button, not slamming on the stop button in Xcode. Let's open the application. Press the home button and then revisit the application. Let's also take a look at our log. Notice that have an empty array the first time and we have a note in our array the second time.

This system works.
