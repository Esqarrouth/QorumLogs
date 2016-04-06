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
//        setupOnlineLogs() //Uncomment to test it
        
        QL1("Show Debug")
        QL2("Show Info")
        QL3("Show Warning")
        awesomeFunction()
    }
    
    func awesomeFunction() {
        QL4("Show Error")
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
    
    
}

