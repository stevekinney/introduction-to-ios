---
status: work-in-progress
---

# Bartleby

This application is a simple notes application—a lot like the default note application for the iPhone.

Let's start by creating a new project with the following settings:

* Master/detail view
* Keep Core Data unchecked

## Creating a Note Class

The application uses a Note class which we're going to store in a Key/Value storage.

To create a new file, go to:

*File* > *New* > *Cocoa Touch Class*

For reasons we'll go into later, our `Note` object is going to be a subclass of `NSObject`.

We'll have two properties: a the body of the note and the date it was created.

It's going to end up looking like this:

```swift
import UIKit

class Note: NSObject {
  var date:String
  var note:String

  override init() {
    date = NSDate().description
    note = ""
  }
}
```

## Creating the Idea of "All Notes"

Go to `viewDidLoad` in `MasterViewController.swift` and set a new note to the variable `n`.

In the class file, we're going to create a few objects. Swift doesn't support class variables just yet. So we're just going to do it in the same file for the Note class.

At the top of our Note class file, just under the imports:

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

Let's run the simulator right now and see what happens.

* It fires up.
* We see the table.
* We can hit the plus sign and create a new time stamp.
* We can navigate to the note.
* We can navigate back.

At this point, your `Note` class looks as follows:

```swift
import UIKit

var allNotes:[Note] = []
var currentNoteIndex:Int = -1
var noteTable:UITableView?

class Note: NSObject {
  var date:String
  var note:String

  override init() {
    date = NSDate().description
    note = ""
  }
}
```


## Persisting Notes

When the view loads, let's set `noteTable` to the table view in our UI. Add the following line to `viewDidLoad()` in `MasterViewController`:

```swift
noteTable = self.tableView
```

There are bunch of ways of saving data in iOS. We're going to use an option called User Defaults, which is a super simple key/value store that allows us to persist data between sessions.

What are we going to have to do to make this work?

* Convert our note objects to something we can store in User Defaulrts
* Take something we stored in User Defaults and turn it back into `Note` objects.

At this point, `viewDidLoad()` in `MasterViewController` looks as follows:

```swift
override func viewDidLoad() {
  super.viewDidLoad()

  noteTable = self.tableView

  // Do any additional setup after loading the view, typically from a nib.
  self.navigationItem.leftBarButtonItem = self.editButtonItem()

  let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
  self.navigationItem.rightBarButtonItem = addButton
}
```

### Step One: Turning Our Notes into a Dictionary

Let's add a method to `Note` that turns it into a dictionary that we can store in User Defaults.

```swift
func dictionary() -> NSDictionary {
  return ["note": note, "date": date]
}
```

`Note` is a big complicated `NSObject`. In the method above, we boil it down to it's simplest form: a dictionary. This is something we can store in User Defaults.

#### Saving Notes

Let's also create a class method that will save all of our notes.

```swift
class func saveNotes() {
  var arrayOfNotes:[NSDictionary] = []
  for var i:Int = 0; i < allNotes.count; i++ {
    arrayOfNotes.append(allNotes[i].dictionary())
  }
  NSUserDefaults.standardUserDefaults().setObject(arrayOfNotes, forKey: "notes")
}
```

Alright, so what is going on in the code above?

* We are declaring an array of dictionaries.
* We are iterating through our `allNotes` array.
* We are turning each note into it's simple form and then appending it to the array of notes.
* We are then storing that simple data object into User Defaults under the key `notes`.

#### Loading Notes

We're also going to want to load some notes, right?

```swift
class func loadNotes() {
  var defaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
  var savedData:[NSDictionary]? = defaults.objectForKey(kAllNotes) as? [NSDictionary]
  if let data:[NSDictionary] = savedData {
    for var i:Int = 0; i < data.count; i++ {
      var n:Note = Note()
      n.setValuesForKeysWithDictionary(data[i])
      allNotes.append(n)
    }
  }
}
```

Okay, that was a lot. Let's stop for a bit and explain what's going on here.

* Get our User Defaults
* Look at the `notes` key
* Put all that in a new array of `NSDictionaries` called `savedData`
* If that worked out, iterate over it, rehydrate the simple data objects into `Note` objects and pop them back onto `allNotes`

#### Wiring It Up

We can save notes and we can load notes. Now we just need to hook into that functionality.

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

**Do this**: Let's take a *text view* and drag it on our storyboard. It has some dummy text and that's great, but it's not what we want.

* Let's snap it to the the four edges and then *Apply Missing Constraints*.

In `DetailViewController.swift`, let's delete everything but the `viewDidLoad()` and the `didRecieveWarning()` methods. (Lines 13-30, for those of you keeping score at home.)

We'll also have to delete the `self.configureView()` call on what's now Line 16.

There is also some code that needs to get taken out of `MasterViewController.swift`. This is because there are certain lines of code that reference the code that we just deleted and that's no good.

Let's hop over to the assistant editor. It's the Venn diagram in the toolbar on the upper-right.

Control-drag from our new text view to the DetailsViewController and create an Outlet.

Let's call it `noteTextView`.

Let's talk about what we made.

```swift
@IBOutlet weak var noteTextView: UITextView!
```

Our `DetailViewController` should now look like this:

```swift
import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var noteTextView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}
```

### AutoLayout

(Optional)

A lot of our note is cut off. This stinks!

We need to tell the note that it needs to fill the screen. Xcode is trying (poorly) to be everything to all screen sizes (including iPads and iPhone Plus models).

We're going to use some pins to pin the UITextView to the corners of the super (parent) view.

We're going to be really hand-wavy today about AutoLayout today and cover just enough to get us moving along.

### Connecting the MasterView to the Data

Xcode was nice and gave us a dummy NSMutableArray just to get the table view up and running.
We don't want to use their dummy data anymore. We want to use our real data now.

On Line 37, we want to change `insertNewObject` to add to our `allNotes` array from earlier. Let's replace it with the following:

```swift
allNotes.insert(Note(), atIndex: 0)
```

We're not using `append` because we want to put it on front of the array.

On Line 47, we're going to change the code on the right-side on of the constant assignment to:

```swift
let object = allNotes[indexPath.row]
```

On Line 57, let's change `objects.count` to `allNotes.count`.

On Line 65, change `let object = objects[indexPath.row] as NSDate` to `let object = allNotes[indexPath.row]`.

On Line 66, we're going change to `object.note`.

On 77, we're going to have another error.

We need to change `objects.removeObjectAtIndex(indexPath.row)` to `allNotes.removeAtIndex(indexPath.row)`.

That should be it. All of our errors should be gone. Let's fire up out application and take it for a spin.

### Writing Our Notes

We'd love to click the plus sign, have it create a new note, and pop up the keyboard.

In `MasterViewController`, we'll add some code.

Let's take a look at how we do this. In the `insertNewObject` method, add the following:

```swift
self.performSegueWithIdentifier("showDetail", sender: self)
```

`insertNewObject` should now look like this:

```swift
func insertNewObject(sender: AnyObject) {
  allNotes.insert(Note(), atIndex: 0)
  let indexPath = NSIndexPath(forRow: 0, inSection: 0)
  self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  self.performSegueWithIdentifier("showDetail", sender: self)
}
```

Let's pop down to `prepareForSegue`. We also want to set a reminder as to where we came from.

In our conditional, let's add a new line below Line 48 and add the following content in the `prepareForSegue` method:

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

`prepareForSegue` should now look like this:

```swift
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  if segue.identifier == "showDetail" {
    if let indexPath = self.tableView.indexPathForSelectedRow() {
      let object = allNotes[indexPath.row]
      currentNoteIndex = indexPath.row
    }
    else {
      currentNoteIndex = 0
    }
  }
}
```

The obvious question here is "Huh? What?" Good question. Allow me to explain what we did here. Previously, when we clicked on the "+", it popped an empty note on the beginning of `allNotes` and then we were able to click on it. That's not the greatest UX in the world.

Now, when we click on a note, it works. But if we never gave it a note (e.g. we clicked on the plus sign) then it will set the note to the top of the `allNotes` array.

### Showing the Note Contents

In the `viewDidLoad` method on `DetailViewController`, let's set the text of the text view to the text of our note. (Say that three times fast.)

```swift
noteTextView.text = allNotes[currentNoteIndex].note
```

### Get the Keyboard Up

```swift
noteTextView.becomeFirstResponder()
```

### Edit, Save, and Delete Notes

In `DetailViewController`, let's add a new method: `viewWillDisappear`. This will fire when the view is about to disappear. Duh.

Now, there are a few situations here that we need to deal with. We don't want to save blank notes. But we do want to save it if there is some content.

```swift
override func viewWillDisappear(animated: Bool) {
  super.viewWillDisappear(animated)
  if noteTextView.text == "" {
    allNotes.removeAtIndex(currentNoteIndex)
  } else {
    allNotes[currentNoteIndex].note = noteTextView.text
  }
  Note.saveNotes()
  noteTable?.reloadData()
}
```