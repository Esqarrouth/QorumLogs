//
//  ViewController.swift
//  QorumLogsExample
//
//  Created by Goktug Yilmaz on 4/6/16.
//  Copyright © 2016 Goktug Yilmaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        QorumLogs.enabled = true
        QorumLogs.test()
        
        QLShortLine()
//        customColors() //Uncomment to test custom colors
//        setupOnlineLogs() //Uncomment to test it
        
        QorumLogs.trackLogFunction = trackFunc
        
        QL1("Show Debug")
        QL2("Show Info")
        QL3("Show Warning")
        awesomeFunction()
        
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 300, height: 100))
        label.text = "Check your console :)"
        view.addSubview(label)
    }
    
    func awesomeFunction() {
        QL4("Show Error")
    }

    func customColors() {
        //These colors are used by me in dark theme -goktugyil
        QorumLogs.colorsForLogLevels[1] = QLColor(r: 0, g: 255, b: 255)
        QorumLogs.colorsForLogLevels[2] = QLColor(r: 0, g: 255, b: 0)
    }
    
    func setupOnlineLogs() {
        QorumOnlineLogs.setupOnlineLogs(formLink: "https://docs.google.com/forms/d/19MbGnGA54cj9nobK5FxvRNcXJ-Gtudb_xSA3VChzSxU/formResponse", versionField: "entry_631576183", userInfoField: "entry_922538006", methodInfoField: "entry_836974774", textField: "entry_526236259")
        QorumLogs.enabled = false
        QorumOnlineLogs.enabled = true
        QorumOnlineLogs.extraInformation["creator"] = "goktugyil"
        QorumOnlineLogs.extraInformation["tester"] = "ENTER_YOUR _NAME"
        QorumOnlineLogs.test()
        QL2("After this point its going to save to Google Docs")
        //Results will be here:
        //https://docs.google.com/spreadsheets/d/1rYRStyI46L2sjiFF9DTDMlCb2qR2FMtKrZk3USRdXkA/
    }
    
    func trackFunc(log: String) {
//       print("Tracking: " + log)
    }
    
}

