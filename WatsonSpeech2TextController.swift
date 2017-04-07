//
//  WatsonSpeech2TextController.swift
//  WatsonAPI
//
//  Created by MAHHA on 27/03/2017.
//  Copyright © 2017 Achraf Mahha. All rights reserved.
//

import UIKit
import AVFoundation
import SpeechToTextV1

class WatsonSpeech2TextController: UIViewController,  AVAudioRecorderDelegate  {
    
    @IBOutlet weak var startRecordingBtn: UIButton!
    @IBOutlet weak var transcrireAvecWatson: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    var speechToText: SpeechToText!
    var speechSample: URL!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()

        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        //Permission non accordée
                    }
                }
            }
        } catch {
            // failed to record!
        }
        
        speechToText = SpeechToText(
            username: "",
            password: ""
        )
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       func startRecording() {
        
        // Le nom du fichier de sortie
        let audioFilename = getDocumentsDirectory().appendingPathComponent("mavoix.wav")
        print(audioFilename)

        // Paramètres de l'enregistrement
        let settings: [String : Any] = [
            AVFormatIDKey:Int(kAudioFormatLinearPCM),
            AVSampleRateKey:44100.0,
            AVNumberOfChannelsKey:1,
            AVEncoderAudioQualityKey:AVAudioQuality.max.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            print(audioFilename)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            startRecordingBtn.setImage(UIImage(named: "stop.png"), for: UIControlState.normal)
            speechSample = audioFilename
            
        } catch {
            finishRecording(success: false)
        }
        
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            //Enregistrement réussi!
            startRecordingBtn.setImage(UIImage(named: "record.png"), for: UIControlState.normal)
        } else {
            //Echec d'enregistrement!
            startRecordingBtn.setImage(UIImage(named: "record.png"), for: UIControlState.normal)
        }
    }

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    @IBAction func recordBtnPressed(_ sender: Any) {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }

    }
  
    
    @IBAction func transcrireAvecWatson(_ sender: Any) {
        
        var settings = RecognitionSettings(contentType: .wav)
        settings.continuous = true
        settings.interimResults = true
        let failure = { (error: Error) in print(error) }
        
        speechToText.recognize(audio: speechSample, settings: settings, failure: failure) {
            results in
            self.resultLabel.text = results.bestTranscript
        }
        
        
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    func loadRecordingUI() {
        
        startRecordingBtn.isHidden = false
        transcrireAvecWatson.isHidden = false
        resultLabel.isHidden = false
       
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
