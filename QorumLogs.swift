//
//  QorumLogs.swift
//  Qorum
//
//  Created by Goktug Yilmaz on 27/08/15.
//  Copyright (c) 2015 Goktug Yilmaz. All rights reserved.
//

import Foundation

struct QorumLogs {
    /// While enabled QorumOnlineLogs does not work
    static var enabled = false
    /// 1 to 4
    static var minimumLogLevelShown = 1
    private static var showFile: String?
    
    //==========================================================================================================
    // MARK: - Public Methods
    //==========================================================================================================
 
    /// Ignores all logs from other files
    static func onlyShowThisFile<T>(fileName: T) {
        minimumLogLevelShown = 1
        if let name = fileName as? String {
            showFile = name
            print(ColorLog.purple("QorumDebug: Only Showing: \(name)"))
            return
        }

        var classString = ""
        if let obj: AnyObject = fileName as? AnyObject {
            classString = String(obj.dynamicType)
        } else {
            classString = String(fileName)
        }
        let classStringWithoutPrefix = classString.ns.pathExtension
        showFile = classStringWithoutPrefix
        print(ColorLog.purple("QorumLogs: Only Showing: \(classStringWithoutPrefix)"))
    }
    
    /// Test to see if its working
    static func test() {
        let oldDebugLevel = minimumLogLevelShown
        minimumLogLevelShown = 1
        QL1("Debug")
        QL2("Info")
        QL3("Warning")
        QL4("Error")
        minimumLogLevelShown = oldDebugLevel
    }
    
    //==========================================================================================================
    // MARK: - Private Methods
    //==========================================================================================================

    private static func shouldPrintLine(level level: Int, fileName: String) -> Bool {
        if !QorumLogs.enabled {
            return false
        } else if QorumLogs.minimumLogLevelShown <= level {
            if showFile == nil {
                return true
            } else {
                if showFile == fileName {
                    return true
                } else {
                    return false
                }
            }
        } else {
            return false
        }
    }
    
}

struct QorumOnlineLogs {
    private static let appVersion = versionAndBuild()
    private static var googleFormLink: String!
    private static var googleFormAppVersionField: String!
    private static var googleFormUserInfoField: String!
    private static var googleFormMethodInfoField: String!
    private static var googleFormErrorTextField: String!
    /// Online logs does not work while QorumLogs is enabled
    static var enabled = false
    /// 1 to 4
    static var minimumLogLevelShown = 1
    /// Empty dictionary, add extra info like user id, username here
    static var extraInformation = [String: String]()
    
    //==========================================================================================================
    // MARK: - Public Methods
    //==========================================================================================================
    
    /// Test to see if its working
    static func test() {
        let oldDebugLevel = minimumLogLevelShown
        minimumLogLevelShown = 1
        QL1("Debug")
        QL2("Info")
        QL3("Warning")
        QL4("Error")
        minimumLogLevelShown = oldDebugLevel
    }
    
    /// Setup Google Form links
    static func setupOnlineLogs(formLink formLink: String, versionField: String, userInfoField: String, methodInfoField: String, textField: String) {
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
        NSURLConnection(request: request, delegate: nil)?.start()
        
        let printText = "OnlineLogs: \(extraInformation.description) - \(versionLevel) - \(classInformation) - \(text)"
        print(" \(ColorLog.purple(printText))\n", terminator: "")
    }
    
    private static func shouldSendLine(level level: Int, fileName: String) -> Bool {
        if !QorumOnlineLogs.enabled {
            return false
        } else if QorumOnlineLogs.minimumLogLevelShown <= level {
            if QorumLogs.showFile == nil {
                return true
            } else {
                if QorumLogs.showFile == fileName {
                    return true
                } else {
                    return false
                }
            }
        } else {
            return false
        }
    }
    
}

///Detailed logs only used while debugging
func QL1<T>(debug: T, _ file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    let level = 1
    let levelText = "1Debug"
    let filename = file.ns.lastPathComponent.ns.stringByDeletingPathExtension
    if QorumLogs.shouldPrintLine(level: level, fileName: filename) {
        let informationPart = "\(filename).\(function)[\(line)]:"
        print(ColorLog.infoColor(informationPart), terminator: "")
        print(" \(ColorLog.lightGreen(debug))\n", terminator: "")
    } else if QorumOnlineLogs.shouldSendLine(level: level, fileName: filename) {
        let informationPart = "()\(filename).\(function)[\(line)]"
        QorumOnlineLogs.sendError(classInformation: informationPart, textObject: debug, level: levelText)
    }
}

///General information about app state
func QL2<T>(info: T, _ file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    let level = 2
    let levelText = "2Info"
    let filename = file.ns.lastPathComponent.ns.stringByDeletingPathExtension
    if QorumLogs.shouldPrintLine(level: level, fileName: filename) {
        let informationPart = "\(filename).\(function)[\(line)]:"
        print(ColorLog.infoColor(informationPart), terminator: "")
        print(" \(ColorLog.green(info))\n", terminator: "")
    } else if QorumOnlineLogs.shouldSendLine(level: level, fileName: filename) {
        let informationPart = "\(filename).\(function)[\(line)]"
        QorumOnlineLogs.sendError(classInformation: informationPart, textObject: info, level: levelText)
    }
}

///Indicates possible error
func QL3<T>(warning: T, _ file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    let level = 3
    let levelText = "3Warning"
    let filename = file.ns.lastPathComponent.ns.stringByDeletingPathExtension
    if QorumLogs.shouldPrintLine(level: level, fileName: filename) {
        let informationPart = "\(filename).\(function)[\(line)]:"
        print(ColorLog.infoColor(informationPart), terminator: "")
        print(" \(ColorLog.yellow(warning))\n", terminator: "")
    } else if QorumOnlineLogs.shouldSendLine(level: level, fileName: filename) {
        let informationPart = "\(filename).\(function)[\(line)]"
        QorumOnlineLogs.sendError(classInformation: informationPart, textObject: warning, level: levelText)
    }
}

///En unexpected error occured
func QL4<T>(error: T, _ file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    let level = 4
    let levelText = "4Error"
    let filename = file.ns.lastPathComponent.ns.stringByDeletingPathExtension
    if QorumLogs.shouldPrintLine(level: level, fileName: filename) {
        let informationPart = "\(filename).\(function)[\(line)]:"
        print(ColorLog.infoColor(informationPart), terminator: "")
        print(" \(ColorLog.red(error))\n", terminator: "")
    } else if QorumOnlineLogs.shouldSendLine(level: level, fileName: filename) {
        let informationPart = "\(filename).\(function)[\(line)]"
        QorumOnlineLogs.sendError(classInformation: informationPart, textObject: error, level: levelText)
    }
}

///=====
func QLShortLine(file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    let filename = file.ns.lastPathComponent.ns.stringByDeletingPathExtension
    if QorumLogs.shouldPrintLine(level: 2, fileName: filename) {
        let lineString = "====================================="
        let informationPart = "\(filename).\(function)[\(line)]:"
        print(ColorLog.infoColor(informationPart), terminator: "")
        print(" \(ColorLog.purple(lineString))\n", terminator: "")
    }
}

///+++++
func QLPlusLine(file: String = __FILE__, _ function: String = __FUNCTION__, _ line: Int = __LINE__) {
    let filename = file.ns.lastPathComponent.ns.stringByDeletingPathExtension
    if QorumLogs.shouldPrintLine(level: 2, fileName: filename) {
        let lineString = "+++++++++++++++++++++++++++++++++++++"
        let informationPart = "\(filename).\(function)[\(line)]:"
        print(ColorLog.infoColor(informationPart), terminator: "")
        print(" \(ColorLog.purple(lineString))\n", terminator: "")
    }
}

private struct ColorLog {
    private static let ESCAPE = "\u{001b}["
    private static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    private static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    private static let RESET = ESCAPE + ";"      // Clear any foreground or background color
    
    static func infoColor<T>(object:T) -> String {
        return "\(ESCAPE)fg120,120,120;\(object)\(RESET)"
    }
    
    static func purple<T>(object:T) -> String {
        return "\(ESCAPE)fg160,32,240;\(object)\(RESET)"
    }
    
    static func lightGreen<T>(object:T) -> String {
        return "\(ESCAPE)fg0,180,180;\(object)\(RESET)"
    }
    //0 255 255
    static func green<T>(object:T) -> String {
        return "\(ESCAPE)fg0,150,0;\(object)\(RESET)"
    }
    
    static func yellow<T>(object:T) -> String {
        return "\(ESCAPE)fg255,190,0;\(object)\(RESET)"
    }
    
//    static func orange<T>(object:T) -> String {
//        return "\(ESCAPE)fg255,128,0;\(object)\(RESET)"
//    }
    
    static func red<T>(object:T) -> String {
        return "\(ESCAPE)fg255,0,0;\(object)\(RESET)"
    }
    
}

private func versionAndBuild() -> String {
    let version = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
    let build = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleVersionKey as String) as! String
    return version == build ? "v\(version)" : "v\(version)(\(build))"
}

private extension String {
    /// Qorum Extension
    var ns: NSString {
        return self as NSString
    }
}
