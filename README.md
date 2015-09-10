# QorumLogs
Lightweight Swift Logging Utility for Xcode & Google Docs

#Not finished yet..

###Features

####Autocomplete Friendly: Type 2 Letters

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Like this: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not like this:

![demo](http://i.imgur.com/XEqB5Tg.gif)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;![demo](http://i.imgur.com/8x5T0mx.gif)

</br></br></br></br>

####Log Levels, Colors, Line Information:

![demo](http://i.imgur.com/UNarzUa.png)
</br></br></br></br>

####Hide Other Logs:
```swift
  QorumLogs.onlyShowThisClass(NewClass)
```

![demo](http://i.imgur.com/TbhTK1v.png)
</br></br></br></br>

####Google Docs Support:
```swift
  QorumOnlineLogs.enabled = true
```
![demo](http://i.imgur.com/TtYAHfW.png)
</br></br></br></br>

####Easily Spot System Logs:

- System logs are white after all, yours are not :)

</br></br></br></br>

This framework was created while working on the [Qorum app](http://www.joinqorum.com/). Check it out, you might like it.

###Easy to Install (~2 minutes)

1. Download and drop 'QorumLogs.swift' in your project. (Cocoapods forces you to import the framework in everyline, we ain't got time for dat. If anyone has a solution or workaround, inform me please)
2. If you don't have [Alcatraz](https://github.com/supermarin/Alcatraz) or [XcodeColors](https://github.com/robbiehanson/XcodeColors) installed, we are going to install them.
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
You will see something this:

![demo](http://i.imgur.com/xMRrgv2.png)

copy paste, google docs, 


###Easy to Use

###Requirements

- Xcode 6 or later (Tested on 6.4)
- iOS 7 or later (Tested on 7.1)

###Possible future features

- Colors for white Xcode
- Device information to Google Docs
- Google Docs shows in order

###Thanks for making this possible
- [XcodeColors](https://github.com/robbiehanson/XcodeColors)
- [Magic](https://github.com/ArtSabintsev/Magic)


###License
- QorumLogs is available under the MIT license. See the [LICENSE file](https://github.com/goktugyil/QorumLogs/blob/master/LICENSE).

###Keywords
Debugging, logging, remote logging, remote debugging, qorum app,  


