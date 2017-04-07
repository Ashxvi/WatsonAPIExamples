//
//  WatsonImageRecognitionController.swift
//  WatsonAlchemyAPI
//
//  Created by MAHHA on 22/03/2017.
//  Copyright © 2017 MAHHA. All rights reserved.
//

import UIKit
import VisualRecognitionV3

class WatsonImageRecognitionController: UIViewController {
    
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var visageLbl: UILabel!
    @IBOutlet weak var sexeLbl: UILabel!
    @IBOutlet weak var ageMaxLbl: UILabel!
    @IBOutlet weak var ageMinlLbl: UILabel!
    
    @IBAction func sendToWatsonPressed(_ sender: Any) {
        
        //Adding Watson Visual Recognition
        let apiKey = ""
        
        let version = "2017-04-07" // Utiliser la date d'aujourd'hui pour la version la plus récente
        
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
       
        let urlString = urlTextField.text!
        
        let url = URL(string: urlString)!
        
        let failure = { (error: Error) in print(error) }
        


        DispatchQueue.main.async(){

            visualRecognition.classify(image: urlString, failure: failure) { classifiedImages in


            // Si on détecte une classification non vide de type people *********************
          
            if (!classifiedImages.images.isEmpty && !classifiedImages.images[0].classifiers.isEmpty && !classifiedImages.images[0].classifiers[0].classes.isEmpty) {
                
                
            // Détection des visages sur l'image ********************************************
                if (!classifiedImages.images[0].classifiers[0].classes[0].classification.isEmpty && "people" == classifiedImages.images[0].classifiers[0].classes[0].classification) {
                    
                    DispatchQueue.main.sync {
                    self.visageLbl.text = "Oui"
                    }

                    
                    // Plus de détails sur le visage   ***********************************
                    visualRecognition.detectFaces(inImageFile: url, success: {
                        imagesWithFaces in
                    
                        if (!imagesWithFaces.images[0].faces.isEmpty) {
                        

                            DispatchQueue.main.sync {

                            self.sexeLbl.text = imagesWithFaces.images[0].faces[0].gender.gender
                            self.ageMaxLbl.text = imagesWithFaces.images[0].faces[0].age.max!.description
                            self.ageMinlLbl.text = imagesWithFaces.images[0].faces[0].age.min!.description
                            
                            }
                           
                    
                            }
                        
                        else
                        {
                            DispatchQueue.main.sync {
                                self.sexeLbl.text = "Pas de données"
                                self.ageMaxLbl.text = "Pas de données"
                                self.ageMinlLbl.text = "Pas de données"
                            }
                        }


                        
                    })
                        
                    
                    //*******************************************************************
                    
                }
                else {
                
                    DispatchQueue.main.sync {
                        self.visageLbl.text = "Non"
                        self.sexeLbl.text = "-"
                        self.ageMaxLbl.text = "-"
                        self.ageMinlLbl.text = "-"
                    }
                
                }
            
                
            }
                
                
                
    
        }
            
     }
    
    
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backPressed(_ sender: Any) {
        
        dismiss(animated: true)

    }
   
}
