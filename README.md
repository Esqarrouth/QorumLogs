# QorumLogs
Lightweight Swift Logging Utility for Xcode & Google Docs

#Not finished yet..

###Features:

####Autocomplete Friendly: Type 2 Letters

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Like this: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not like this:

![demo](http://i.imgur.com/XEqB5Tg.gif)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![demo](http://i.imgur.com/8x5T0mx.gif)

</br></br></br></br>

####Log Levels

Maybe write the code here like this?
```swift
class MyAwesomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        QL1Debug("Debug")
        QL2Info("Info")
        QL3Warning("Warning")
        awesomeFunction()
    }
    func awesomeFunction() {
        QL4Error("Error")
        QL5Severe("Severe")
    }
}
```


![demo](http://i.imgur.com/WR5C9mB.png)
</br></br></br></br>

####Hiding Other Logs:
```swift
  QorumLogs.onlyShowThisClass(NewClass)
```
Maybe write the code in the middle of pics?

![demo](http://i.imgur.com/350Xexj.png)
</br></br></br></br>

####Google Docs Support:
```swift
  QorumLogs.enabled = false
  QorumOnlineLogs.enabled = true
```
![demo](http://i.imgur.com/TtYAHfW.png)
</br></br></br></br>

####Spot System Logs:

- System logs are white (or black) after all, yours are not :)

</br></br></br></br>

This framework was created while working on the [Qorum app (Hacker News For iOS Startups)](http://www.joinqorum.com/). Check it out, you might like it.

###Installation (~2 minutes)

1. Download and drop 'QorumLogs.swift' in your project. (Cocoapods forces you to import the framework in everyline. If anyone has a solution or workaround, inform me please)
2. If you don't have [Alcatraz](https://github.com/supermarin/Alcatraz) or [XcodeColors](https://github.com/robbiehanson/XcodeColors) installed, lets install them.
Open up your terminal and paste this:

  ``` bash
curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
   ```
3. Restart Xcode after the installation
4. Alcatraz requires Xcode Command Line Tools, which can be installed in Xcode > Preferences > Downloads. (You might not need this in the latest Xcode version)
5. In Xcode click Window > Package Manager, type in 'XcodeColors' in the search bar. Click Install.
6. Restart Xcode after the installation
7. In your AppDelegate or anywhere else enter this:
 
  ```swift
  QorumLogs.test()
  ```
8. You will see something this:

![demo](http://i.imgur.com/xMRrgv2.png)

Congratulations!
</br></br>
###Google Docs Support Install (Optional, ~2 minutes)

1. Open [Google Drive](https://drive.google.com/), click New > More > Google Forms. http://i.imgur.com/f3tJNTS.png
2. Enter a title to your form form top left corner
3. The first field Question Title should be "App Version" and Question Type should be "Text" http://i.imgur.com/799xH6D.png
4. Click Done. Add 3 more items like this, their texts should be "User Information", "Code Information", "Log Text". 
5. Be sure it looks something like this at the end: http://i.imgur.com/uTFVSMu.png 
6. Click "View Live Form", https://docs.google.com/forms/d/19MbGnGA54cj9nobK5FxvRNcXJ-Gtudb_xSA3VChzSxU/viewform a link like this opens up. Use link as the first paramater in your code like this:
  
  ```swift
QorumOnlineLogs.setupOnlineLogs(formLink: "https://docs.google.com/forms/d/19MbGnGA54cj9nobK5FxvRNcXJ-Gtudb_xSA3VChzSxU/formResponse", 
versionField: <#String#>, userInfoField: <#String#>, methodInfoField: <#String#>, textField: <#String#>)
  ```
With one difference: change "viewform" to "formResponse".

7. Go back to your live form, under App Version, select the text field, right click and select "Inspect Element" (I am using Chrome, might be different in your browser) 
8. Get the value of "id" from that text fields HTML. http://i.imgur.com/eZKlzjq.png
9. Use that as the second parameter in your code:

  ```swift
QorumOnlineLogs.setupOnlineLogs(formLink: "https://docs.google.com/forms/d/19MbGnGA54cj9nobK5FxvRNcXJ-Gtudb_xSA3VChzSxU/formResponse", 
versionField: "entry_631576183", userInfoField: <#String#>, methodInfoField: <#String#>, textField: <#String#>)
  ```
10. Repeat the same process for the other text fields:

  ```swift
QorumOnlineLogs.setupOnlineLogs(formLink: "https://docs.google.com/forms/d/19MbGnGA54cj9nobK5FxvRNcXJ-Gtudb_xSA3VChzSxU/formResponse", 
versionField: "entry_631576183", userInfoField: "entry_922538006", methodInfoField: "entry_836974774", textField: "entry_526236259")
  ```
11. Type these after your setup:

  ```swift
  QorumLogs.enabled = false // This should be disabled for OnlineLogs to work
  QorumOnlineLogs.enabled = true
  QorumOnlineLogs.test()
  ```
12. Go back to the screen where you edited the form and click "View Responses"
13. Run your application, you should see this in the Xcode debugger:

![demo](http://i.imgur.com/DLzZmfl.png)

and this in your form responses:

![demo](http://i.imgur.com/LJmc13G.png)

Here is the public demo sheet: https://docs.google.com/spreadsheets/d/1rYRStyI46L2sjiFF9DTDMlCb2qR2FMtKrZk3USRdXkA/

Congratulations!
</br></br>
###Detailed Features:

####Log Levels

Sets the minimum log level that is seen in the debug area:

1. Debug - Detailed logs only used while debugging
2. Info - General information about app state
3. Warning - Indicates possible error
4. Error - En unexpected error occured, its recoverable
5. Severe - Serious error, likely to crash now
```swift
  QorumLogs.logLevel = 2
  QorumOnlineLogs.logLevel = 4 // Its a good idea to have OnlineLog level a bit higher
  QL1Debug("mylog") // Doesn't show this level anywhere, because minimum level is 2
  QL2Info("mylog")  // Shows this only in debugger
  QL3Warning("mylog") // Shows this only in debugger
  QL4Error("mylog") // Shows this in debugger and online logs
  QL5Severe("mylog") // Shows this in debugger and online logs
```

####Hide Other Classes

You need to write the name of the actual file, you can do this by a string and also directly the class name can be appropiate if it is the same as the file name.
```swift
  QorumLogs.onlyShowThisClass(MyAwesomeViewController)
  QorumLogs.onlyShowThisClass("MyAwesomeViewController")
```

####Print Lines
```swift
  QLPlusLine()
  QL2Info("Text between line")
  QLShortLine()
```
![demo](http://i.imgur.com/hQWOYit.png)

####OnlineLogs - User Information
```swift
   QorumOnlineLogs.extraInformation["userId"] = "sfkoFvvbKgr"
   QorumOnlineLogs.extraInformation["name"] = "Will Smith"
   QL1Debug("Will is awesome!")
   QL5Severe("Will rules!")
```
![demo](http://i.imgur.com/5xoVRrY.png)

####OnlineLogs - Delete Information
Unfortunately you can't just select the rows inside Google Docs and delete them. You need to select the rows where there are row numbers, then right click, then press delete click "Delete rows x-y" http://i.imgur.com/0XyAAbD.png

###Requirements

- Xcode 6 or later (Tested on 6.4)
- iOS 7 or later (Tested on 7.1)

###Possible future features

- Different colors for white and black Xcode themes
- Easily editable colors
- Device information to Google Docs
- Google Docs shows in exact order
- Pod support with QL methods written customly

###Thanks for making this possible
- [XcodeColors](https://github.com/robbiehanson/XcodeColors)
- [Magic](https://github.com/ArtSabintsev/Magic)


###License
- QorumLogs is available under the MIT license. See the [LICENSE file](https://github.com/goktugyil/QorumLogs/blob/master/LICENSE).

###Keywords
Debugging, logging, remote logging, remote debugging, qorum app,  
