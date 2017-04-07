//
//  WatsonSpeech2TextController.swift
//  WatsonAlchemyAPI
//
//  Created by MAHHA on 22/03/2017.
//  Copyright © 2017 MAHHA. All rights reserved.
//

import UIKit
import TextToSpeechV1
import AVFoundation

class WatsonText2SpeechController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var voiceSegment: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playPressed(_ sender: Any) {
        
        //add Watson Service
        let username = ""
        let password = ""
        let textToSpeech = TextToSpeech(username: username, password:
            password)
        let text = textField.text!
        
        let failure = { (error: Error) in print(error) }
        
        switch voiceSegment.selectedSegmentIndex.description {
        case "0":
            textToSpeech.synthesize(text, voice: SynthesisVoice.fr_Renee.rawValue, failure: failure) {
                
                data in
                do {
                    var audioPlayer: AVAudioPlayer
                    audioPlayer = try!
                        AVAudioPlayer(data: data)
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                    sleep(10)
                }
                
            }
        case "1":
            textToSpeech.synthesize(text, voice: SynthesisVoice.us_Michael.rawValue, failure: failure) {
                
                data in
                do {
                    var audioPlayer: AVAudioPlayer
                    audioPlayer = try!
                        AVAudioPlayer(data: data)
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                    sleep(10)
                }
                
            }
        case "2":
            textToSpeech.synthesize(text, voice: SynthesisVoice.es_Laura.rawValue, failure: failure) {
                
                data in
                do {
                    var audioPlayer: AVAudioPlayer
                    audioPlayer = try!
                        AVAudioPlayer(data: data)
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                    sleep(10)
                }
                
            }
        default:
            NSLog("Erreur Case")
        }
        
   
    }
        
        
    

    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true)
        
    }



}
