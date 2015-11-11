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

##Installation (~2 minutes)

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
  QorumLogs.enabled = true
  QorumLogs.test()
  ```
8. You will see something this:

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
```swift
    QorumLogs.colorsForLogLevels[0] = UIColor(red: 255/255, green: 255/255, blue: 0/255, alpha: 1)
    QorumLogs.colorsForLogLevels[1] = UIColor(red: 255/255, green: 20/255, blue: 147/255, alpha: 1)
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
