QorumLogs
==========
Swift Logging Utility in Xcode & Google Docs

##Log Levels

```swift
class MyAwesomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        QL1("Debug")
        QL2("Info")
        QL3("Warning")
        awesomeFunction()
    }
    func awesomeFunction() {
        QL4("Error")
    }
}
```


![demo](http://i.imgur.com/SzxTXyv.png)

<br><br><br>
##Works for both night mode and lightmode

![demo](http://i.imgur.com/Zq4yUM6.png)
<br><br><br>
##Autocomplete Friendly: Type 2 Letters

-![demo](http://i.imgur.com/3gPJHaY.gif)
<br><br><br>
##Filter File Specific Logs:
Paste this where QorumLogs is initiliazed:
```swift
  QorumLogs.onlyShowThisFile(NewClass)
```

![demo](http://i.imgur.com/K7OWqBw.gif)
<br><br><br>
##Google Docs Support:

In production, send all your logs to Google Docs with only 1 line of extra code.
```swift
  QorumLogs.enabled = false
  QorumOnlineLogs.enabled = true
```
![demo](http://i.imgur.com/TtYAHfW.png)

<br><br><br>
##Spot System Logs:
System logs are white (or black) after all, yours are not :)

![demo](http://i.imgur.com/rJKInKk.png)

##Installation

### Prerequisites

1. If you don't have [Alcatraz](https://github.com/supermarin/Alcatraz) or [XcodeColors](https://github.com/robbiehanson/XcodeColors) installed, lets install them.
Open up your terminal and paste this:

  ``` bash
curl -fsSL https://raw.github.com/supermarin/Alcatraz/master/Scripts/install.sh | sh
   ```
2. Restart Xcode after the installation
3. Alcatraz requires Xcode Command Line Tools, which can be installed in Xcode > Preferences > Downloads. (You might not need this in the latest Xcode version)
4. In Xcode click Window > Package Manager, type in 'XcodeColors' in the search bar. Click Install.
5. Restart Xcode after the installation

### Install via CocoaPods

You can use [Cocoapods](http://cocoapods.org/) to install `QorumLogs` by adding it to your `Podfile`:
```ruby
platform :ios, '8.0'
use_frameworks!

pod 'QorumLogs'
```

(Cocoapods forces you to import the framework in every file. If anyone has a solution or workaround, inform me please)

### Install Manually

Download and drop 'QorumLogs.swift' in your project.

### Check Installation Works Correctly
1. In your AppDelegate or anywhere else enter this: (If Cocoapods you must add `import QorumLogs`)
 
  ```swift
  QorumLogs.enabled = true
  QorumLogs.test()
  ```
2. You will see something this:

![demo](http://i.imgur.com/xMRrgv2.png)

Congratulations!

##Log Storage in GoogleDocs (Optional, ~4 minutes)
[Learn to integrate GoogleDocs](./Log To GoogleDocs.md)

##Detailed Features:

####Log Levels

Sets the minimum log level that is seen in the debug area:

1. Debug - Detailed logs only used while debugging
2. Info - General information about app state
3. Warning - Indicates possible error
4. Error - An unexpected error occured, its recoverable
```swift
  QorumLogs.minimumLogLevelShown = 2
  QorumOnlineLogs.minimumLogLevelShown = 4 // Its a good idea to have OnlineLog level a bit higher
  QL1("mylog") // Doesn't show this level anywhere, because minimum level is 2
  QL2("mylog")  // Shows this only in debugger
  QL3("mylog") // Shows this only in debugger
  QL4("mylog") // Shows this in debugger and online logs
```
QL methods can print in both Debugger and Google Docs, depending on which is active.

####Hide Other Classes

You need to write the name of the actual file, you can do this by a string and also directly the class name can be appropriate if it is the same as the file name. Add the following code where you setup QorumLogs:
```swift
  QorumLogs.onlyShowThisFile(MyAwesomeViewController)
  QorumLogs.onlyShowThisFile("MyAwesomeViewController")
```

You do not need the extension of the file.

####Print Lines
```swift
  QLPlusLine()
  QL2("Text between line")
  QLShortLine()
```
![demo](http://i.imgur.com/hQWOYit.png)

####Add Custom Colors

For iOS:
```swift
    QorumLogs.colorsForLogLevels[0] = UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)
    QorumLogs.colorsForLogLevels[1] = UIColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 1)
```

For Mac:
```swift
    QorumLogs.colorsForLogLevels[0] = NSColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)
    QorumLogs.colorsForLogLevels[1] = NSColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 1)
```

For Mac and iOS:
```swift
    QorumLogs.colorsForLogLevels[0] = QLColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)
    QorumLogs.colorsForLogLevels[1] = QLColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 1)
```

```swift
    QL1("Mylog")
```
![demo](http://i.imgur.com/yTmNnU6.png)

####OnlineLogs - User Information
```swift
   QorumOnlineLogs.extraInformation["userId"] = "sfkoFvvbKgr"
   QorumOnlineLogs.extraInformation["name"] = "Will Smith"
   QL1("Will is awesome!")
   QL5("Will rules!")
```
![demo](http://i.imgur.com/5xoVRrY.png)

You only need to set the extraInformation one time.

#### KZLinkedConsole support:
KZLinkedConsole is a plugin for Xcode which add clickable link to place in code from log was printed. For more information go to https://github.com/krzysztofzablocki/KZLinkedConsole  

Set KZLinkedConsoleSupportEnabled flag on true (default false) to enable KZLinkedConsole support :
```swift
QorumLogs.KZLinkedConsoleSupportEnabled = true
```

##### WARRNIG
KZLinkedConsoleSupportEnabled change log output from for example:
```
 QorumLogs.test()[60]: Debug
 QorumLogs.test()[61]: Info
 QorumLogs.test()[62]: Warning
 QorumLogs.test()[63]: Error
```

to
```
 QorumLogs.swift:62 test(): Debug
 QorumLogs.swift:63 test(): Info
 QorumLogs.swift:64 test(): Warning
 QorumLogs.swift:65 test(): Error
```

Online log stay in classic format.

##FAQ

#### How to delete rows inside google docs?
Unfortunately you can't just select the rows inside Google Docs and delete them. You need to select the rows where there are row numbers, then right click, then press delete click "Delete rows x-y" http://i.imgur.com/0XyAAbD.png

##Requirements

- Xcode 6 or later (Tested on 6.4)
- iOS 7 or later (Tested on 7.1)

##Possible features

- Different colors for white and black Xcode themes
- Easily editable colors
- Device information to Google Docs
- Google Docs shows in exact order
- Automaticly getting entry ids for Google Docs 
- Pod support with QL methods written customly

##Thanks for making this possible
- [XcodeColors](https://github.com/robbiehanson/XcodeColors)
- [Magic](https://github.com/ArtSabintsev/Magic)


##License
QorumLogs is available under the MIT license. See the [LICENSE file](https://github.com/goktugyil/QorumLogs/blob/master/LICENSE).

##Keywords
Debugging, logging, remote logging, remote debugging, qorum app, swift log, library, framework, tool, google docs, google drive, google forms
