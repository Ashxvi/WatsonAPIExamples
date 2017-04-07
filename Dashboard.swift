//
//  Dashboard.swift
//  WatsonAlchemyAPI
//
//  Created by MAHHA on 22/03/2017.
//  Copyright © 2017 MAHHA. All rights reserved.
//

import UIKit


class Dashboard: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func sentimentPressed(_ sender: Any) {
        performSegue(withIdentifier: "sentiment", sender: nil)

    }

    
    @IBAction func imgRecognitionPressed(_ sender: Any) {
        performSegue(withIdentifier: "image_recognition", sender: nil)

    }
    
    @IBAction func text2speechPressed(_ sender: Any) {
        performSegue(withIdentifier: "text2speech", sender: nil)

    }
    
    @IBAction func speech2textPressed(_ sender: Any) {
        performSegue(withIdentifier: "speech2text", sender: nil)

    }
   
    


}
