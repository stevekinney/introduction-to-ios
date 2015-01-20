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

### Storyboards

In Xcode our UI is organized into storyboards.

* We have a master node with a navigation view.
* We have a table view (this is our master view).
* We have a detail view.

Let's take a look at the detail view. Ideally, we don't want to have just some text in the middle, we want to have a field where we can edit our notes.

We'll visit the object library and search for a text field that fits our needs.

Let's take a text view and drag it on our storyboard. It has some dummy text and that's great, but it's not what we want.

In DetailViewController.swift, let's delete everything but the `viewDidLoad()` and the `didRecieveWarning()` methods. (Lines 13-30)

We'll also have to delete the `self.configureView()` call on what's now Line 16.

There is also some code that needs to get taken out of MasterViewController.swift. This is because there are certain lines of code that reference the code that we just deleted and that's no good.

Think of a scene has an individual screen on your phone.

Let's hop over to the assistant editor. It's the guy with the bowtie.

Control-drag from the new text view to the DetailsViewController and create an Outlet.

Let's talk about what we made.

```swift
@IBOutlet weak var tView: UITextView!
```

### AutoLayout

A lot of our note is cut off. This stinks!

We need to tell the note that it needs to fill the screen. Xcode is trying (poorly) to be everything to all screen sizes (including iPads and iPhone Plus models).

We're going to use some pins to pin the UITextView to the corners of the super (parent) view.

We're going to be really hand-wavy today about AutoLayout today and cover just enough to get us moving along.

### Connecting the MasterView to the Data

Xcode was nice and gave us a dummy NSMutableArray just to get the table view up and running.
We don't want to use their dummy data anymore. We want to use our real data now.

On line 35, we want to change `insertNewObject` to add to our `allNotes` array from earlier. Let's replace it with the following:

```swift
allNotes.insert(Note(), atIndex: 0)
```

We're not using `append` because we want to put it on front of the array.

On Line 45, we're going to change the code on the right-side on of the constant assignment to:

```js
allNotes[indexPath.row]
```

On Line 57, let's change `objects.count` to `allNotes.count`.

On Line 63, change `let object = objects[indexPath.row] as NSDate` to `let object = allNotes[indexPath.row]`.

On Line 64, we're going change to `object.note`.

On 75, we're going to have another error.

We need to change `objects.removeObjectAtIndex(indexPath.row)` to `allNotes.removeAtIndex(indexPath.row)`.

That should be it. All of our errors should be gone. Let's fire up out application and take it for a spin.

### Writing Our Notes

We're love to click the plus sign, have it create a new note, and pop up the keyboard.

Let's take a look at how we do this. On Line 38.

```swift
self.performSegueWithIdentifier("showDetail", sender: self)
```

Let's pop down to `prepareForSegue`. We also want to set a reminder as to where we came from. 

In our conditional, let's add a new line below Line 46 and add the following content.

```swift
currentNoteIndex = indexPath.row
```

Let's also add an `else` to our conditional:

```swift
if let indexPath = self.tableView.indexPathForSelectedRow() {
  let object = allNotes[indexPath.row]
  currentNoteIndex = indexPath.row
} else {
  currentNoteIndex = 0
}
```

The obvious question here is "Huh? What?" Good question. Allow me to explain what we did here. Previously, when we clicked on the "+", it popped an empty note on the begginning of `allNotes` and then we were able to click on it. That's not the greatest UX in the world.

Now, when we click on a note, it works. But if we never gave it a note (e.g. we clicked on the plus sign) then it will set the note to the top of the `allNotes` array.

### Showing the Note Contents

In the `viewDidLoad` method on `DetailViewController`, let's set the text of the text view to the text of our note. (Say that three times fast.)

```swift
tView.text = allNotes[currentNoteIndex].note
```

### Get the Keyboard Up

```swift
tView.becomeFirstResponder()
```

### Edit, Save, and Delete Notes

In `DetailViewController`, let's add a new method: `viewWillDisappear`. This will fire when the view is about to disappear. Duh.

Now, there are a view situations here. We don't want to save blank notes. But we do want to save it if there is some content.

```swift
override func viewWillDisappear(animated: Bool) {
  super.viewWillDisappear(animated)
  if tView.text == "" {
    allNotes.removeAtIndex(currentNoteIndex)
  } else {
    allNotes[currentNoteIndex].note = tView.text
  }
  Notes.saveNotes()
  noteTable?.reloatData()
}
```


