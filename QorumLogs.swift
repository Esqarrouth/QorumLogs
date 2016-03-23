//
//  QorumLogs.swift
//  Qorum
//
//  Created by Goktug Yilmaz on 27/08/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import Foundation

#if os(OSX)
    import Cocoa
    
    public typealias QLColor = NSColor
#elseif os(iOS) || os(tvOS)
    import UIKit
    
    public typealias QLColor = UIColor
#endif


///  Debug error level
private let kLogDebug : String = "Debug";

///  Info error level
private let kLogInfo : String = "Info";

///  Warning error level
private let kLogWarning : String = "Warning";

///  Error error level
private let kLogError : String = "Error";

public struct QorumLogs {
    
    /// While enabled QorumOnlineLogs does not work
    public static var enabled = false
    
    /// 1 to 4
    public static var minimumLogLevelShown = 1
    
    /// Change the array element with another UIColor. 0 is info gray, 5 is purple, rest are log levels
    public static var colorsForLogLevels: [QLColor] = [
        QLColor(redC: 120, greenC: 120, blueC: 120), //0
        QLColor(redC: 0, greenC: 180, blueC: 180),  //1
        QLColor(redC: 0, greenC: 150, blueC: 0),  //2
        QLColor(redC: 255, greenC: 190, blueC: 0), //3
        QLColor(redC: 255, greenC: 0, blueC: 0),   //4
        QLColor(redC: 160, greenC: 32, blueC: 240)] //5
    
    /// Enable console link with KZLinkedConsole plugin
    public static var KZLinkedConsoleSupportEnabled = false
    private static var showFiles = [String]()
    
    //==========================================================================================================
    // MARK: - Public Methods
    //==========================================================================================================
    
    /// Ignores all logs from other files
    public static func onlyShowTheseFiles(fileNames: Any...) {
        minimumLogLevelShown = 1
        
        let showFiles = fileNames.map {fileName in
            return fileName as? String ?? {
                let classString: String = {
                    if let obj: AnyObject = fileName as? AnyObject {
                        let classString = String(obj.dynamicType)
                        return classString.ns.pathExtension
                    } else {
                        return String(fileName)
                    }
                }()
                
                return classString
            }()
        }
        
        self.showFiles = showFiles
        print(ColorLog.colorizeString("QorumLogs: Only Showing: \(showFiles)", colorId: 5))
    }
    
    /// Ignores all logs from other files
    public static func onlyShowThisFile(fileName: Any) {
        onlyShowTheseFiles(fileName)
    }
    
    /// Test to see if its working
    public static func test() {
        let oldDebugLevel = minimumLogLevelShown
        minimumLogLevelShown = 1
        QLogDebug(kLogDebug)
        QLogInfo(kLogInfo)
        QLogWarning(kLogWarning)
        QLogError(kLogError)
        minimumLogLevelShown = oldDebugLevel
    }
    
    //==========================================================================================================
    // MARK: - Private Methods
    //==========================================================================================================
    
    private static func shouldPrintLine(level level: Int, fileName: String) -> Bool {
        if !QorumLogs.enabled {
            return false
        } else if QorumLogs.minimumLogLevelShown <= level {
            return QorumLogs.shouldShowFile(fileName)
        } else {
            return false
        }
    }
    
    private static func shouldShowFile(fileName: String) -> Bool {
        return QorumLogs.showFiles.isEmpty || QorumLogs.showFiles.contains(fileName)
    }
}

///  Debug error level
private let kOnlineLogDebug : String = "1Debug";

///  Info error level
private let kOnlineLogInfo : String = "2Info";

///  Warning error level
private let kOnlineLogWarning : String = "3Warning";

///  Error error level
private let kOnlineLogError : String = "4Error";

public struct QorumOnlineLogs {
    
    private static let appVersion = versionAndBuild()
    private static var googleFormLink: String!
    private static var googleFormAppVersionField: String!
    private static var googleFormUserInfoField: String!
    private static var googleFormMethodInfoField: String!
    private static var googleFormErrorTextField: String!
    /// Online logs does not work while QorumLogs is enabled
    public static var enabled = false
    
    /// 1 to 4
    public static var minimumLogLevelShown = 1
    
    /// Empty dictionary, add extra info like user id, username here
    public static var extraInformation = [String: String]()
    
    //==========================================================================================================
    // MARK: - Public Methods
    //==========================================================================================================
    
    /// Test to see if its working
    public static func test() {
        let oldDebugLevel = minimumLogLevelShown
        minimumLogLevelShown = 1
        QLogDebug(kLogDebug)
        QLogInfo(kLogInfo)
        QLogWarning(kLogWarning)
        QLogError(kLogError)
        minimumLogLevelShown = oldDebugLevel
    }
    
    /// Setup Google Form links
    public static func setupOnlineLogs(formLink formLink: String, versionField: String, userInfoField: String, methodInfoField: String, textField: String) {
        googleFormLink = formLink
        googleFormAppVersionField = versionField
        googleFormUserInfoField = userInfoField
        googleFormMethodInfoField = methodInfoField
        googleFormErrorTextField = textField
    }
    
    //==========================================================================================================
    // MARK: - Private Methods
    //==========================================================================================================
    
    private static func sendError<T>(classInformation classInformation: String, textObject: T, level: String) {
        var text = ""
        if let stringObject = textObject as? String {
            text = stringObject
        }
        let versionLevel = (appVersion + " - " + level)
        
        let url = NSURL(string: googleFormLink)
        var postData = googleFormAppVersionField + "=" + versionLevel
        postData += "&" + googleFormUserInfoField + "=" + extraInformation.description
        postData += "&" + googleFormMethodInfoField + "=" + classInformation
        postData += "&" + googleFormErrorTextField + "=" + text
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = postData.dataUsingEncoding(NSUTF8StringEncoding)
        
        #if os(OSX)
            if kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber10_10 {
                let session = NSURLSession.sharedSession()
                let task = session.dataTaskWithRequest(request)
                task.resume()
            } else {
                NSURLConnection(request: request, delegate: nil)?.start()
            }
        #elseif os(iOS)
            NSURLSession.sharedSession().dataTaskWithRequest(request);
        #endif
        
        let printText = "OnlineLogs: \(extraInformation.description) - \(versionLevel) - \(classInformation) - \(text)"
        print(" \(ColorLog.colorizeString(printText, colorId: 5))\n", terminator: "")
    }
    
    private static func shouldSendLine(level level: Int, fileName: String) -> Bool {
        if !QorumOnlineLogs.enabled {
            return false
        } else if QorumOnlineLogs.minimumLogLevelShown <= level {
            return QorumLogs.shouldShowFile(fileName)
        } else {
            return false
        }
    }
}


///Detailed logs only used while debugging
public func QLogDebug<T>(debug: T, _ file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    QLManager(debug,file: file,function: function,line: line,level:1)
}

///General information about app state
public func QLogInfo<T>(info: T, _ file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    QLManager(info,file: file,function: function,line: line,level:2)
}

///Indicates possible error
public func QLogWarning<T>(warning: T, _ file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    QLManager(warning,file: file,function: function,line: line,level:3)
}

///En unexpected error occured
public func QLogError<T>(error: T, _ file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    QLManager(error,file: file,function: function,line: line,level:4)
}



private func printLog<T>(informationPart: String, text: T, level: Int) {
    print(" \(ColorLog.colorizeString(informationPart, colorId: 0))", terminator: "")
    print(" \(ColorLog.colorizeString(text, colorId: level))\n", terminator: "")
}

///=====
public func QLShortLine(file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    let lineString = "======================================"
    QLineManager(lineString, file: file, function: function, line: line)
}

///+++++
public func QLPlusLine(file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    let lineString = "+++++++++++++++++++++++++++++++++++++"
    QLineManager(lineString, file: file, function: function, line: line)
}

///Print data with level
private func QLManager<T>(debug: T, file: String, function: String, line: Int, level : Int){
    
    let levelText : String;
    
    switch (level) {
    case 1:
        levelText = kOnlineLogDebug;
        break;
    case 2:
        levelText = kOnlineLogInfo;
        break;
    case 3:
        levelText = kOnlineLogWarning;
        break;
    case 4:
        levelText = kOnlineLogError;
        break;
    default:
        levelText = kOnlineLogDebug;
        break;
    }
    
    
    let fileExtension = file.ns.lastPathComponent.ns.pathExtension
    let filename = file.ns.lastPathComponent.ns.stringByDeletingPathExtension
    
    if QorumLogs.shouldPrintLine(level: level, fileName: filename) {
        let informationPart: String
        if QorumLogs.KZLinkedConsoleSupportEnabled {
            informationPart = "\(filename).\(fileExtension):\(line) \(function):"
        } else {
            informationPart = "\(filename).\(function)[\(line)]:"
        }
        printLog(informationPart, text: debug, level: level)
    } else if QorumOnlineLogs.shouldSendLine(level: level, fileName: filename) {
        let informationPart = "\(filename).\(function)[\(line)]"
        QorumOnlineLogs.sendError(classInformation: informationPart, textObject: debug, level: levelText)
    }
}

///Print line
private func QLineManager(lineString : String, file: String, function: String, line: Int){
    let fileExtension = file.ns.lastPathComponent.ns.pathExtension
    let filename = file.ns.lastPathComponent.ns.stringByDeletingPathExtension
    if QorumLogs.shouldPrintLine(level: 2, fileName: filename) {
        let lineString = "+++++++++++++++++++++++++++++++++++++"
        let informationPart: String
        if QorumLogs.KZLinkedConsoleSupportEnabled {
            informationPart = "\(filename).\(fileExtension):\(line) \(function):"
        } else {
            informationPart = "\(filename).\(function)[\(line)]:"
        }
        printLog(informationPart, text: lineString, level: 5)
    }
}

private struct ColorLog {
    private static let ESCAPE = "\u{001b}["
    private static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    private static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    private static let RESET = ESCAPE + ";"      // Clear any foreground or background color
    
    static func colorizeString<T>(object: T, colorId: Int) -> String {
        return "\(ESCAPE)fg\(QorumLogs.colorsForLogLevels[colorId].redC),\(QorumLogs.colorsForLogLevels[colorId].greenC),\(QorumLogs.colorsForLogLevels[colorId].blueC);\(object)\(RESET)"
    }
}

private func versionAndBuild() -> String {
    
    let version = NSBundle.mainBundle().infoDictionary? ["CFBundleShortVersionString"] as! String
    let build = NSBundle.mainBundle().infoDictionary? [kCFBundleVersionKey as String] as! String
    
    return version == build ? "v\(version)" : "v\(version)(\(build))"
}

private extension String {
    /// Qorum Extension
    var ns: NSString {
        return self as NSString
    }
}

private extension QLColor {
    convenience init(redC: CGFloat, greenC: CGFloat, blueC: CGFloat) {
        self.init(red: redC / 255.0, green: greenC / 255.0, blue: blueC / 255.0, alpha: 1)
    }
    var redC: Int {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }
    var greenC: Int {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }
    var blueC: Int {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
}
