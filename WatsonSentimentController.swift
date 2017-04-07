//
//  WatsonSentimentController.swift
//  WatsonSentimentAnalysisApp
//
//  Created by Achraf MAHHA on 21/03/2017.
//  Copyright © 2017 Achraf MAHHA. All rights reserved.
//

import UIKit
import NaturalLanguageUnderstandingV1

class WatsonSentimentController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!

    override func viewDidLoad() {
    
        super.viewDidLoad()
    }


    @IBAction func sendToWatsonPressed(sender: AnyObject) {
        
        
        let username = ""
        let password = ""
        let version = "2017-04-07"
        
        
        let url = textField.text!
        
        let features = Features(sentiment: SentimentOptions(document: true))
        let parameters = Parameters(features: features, url: url)
        let naturalLanguageUnderstanding = NaturalLanguageUnderstanding(username: username, password: password, version: version)

        let failure = { (error: Error) in print(error) }
        
        DispatchQueue.main.async(){
        naturalLanguageUnderstanding.analyzeContent(withParameters: parameters, failure: failure) {
            results in
            DispatchQueue.main.sync(){
            self.statusLabel.text = "STATUS : \(results.sentiment?.document?.label ?? "-")"
            }
        }
        }
    
        
        }

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}

