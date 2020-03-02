//
//  ViewController.swift
//  WhatFlower
//
//  Created by Jesse Anderson on 9/19/18.
//  Copyright © 2018 Jesse Anderson. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var flowerImage: UIImageView!
    @IBOutlet weak var flowerLabel: UILabel!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imageTaken = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            flowerImage.image = imageTaken
            
            guard let ciImage = CIImage(image: imageTaken) else {
                fatalError("Could not convert the image")
            }
            
            detectFlower(image: ciImage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func detectFlower(image: CIImage) {
        
        do {
            
            let model = try VNCoreMLModel(for: OxfordFlowerImageClassifier().model)
            
            let request = VNCoreMLRequest(model: model) { (request, error) in
                
                guard let results = request.results as? [VNClassificationObservation] else {
                    fatalError("The model did not return the expected results")
                }
                
                // print(results)
                
                if let firstResult = results.first {
                    print("\(firstResult.identifier)")
                    // self.navigationItem.title = firstResult.identifier
                    self.flowerLabel.text = firstResult.identifier
                    
//                    let language = WikipediaLanguage("en")
//                    self.wiki.requestOptimizedSearchResults(language: language, term: firstResult.identifier) { (searchResults, error) in
//
//                        guard error == nil else {
//                            // print(error)
//                            return
//                        }
//
//                        guard let results = searchResults else {
//                            return
//                        }
//
//                        for item in results.items
//                        {
//                            print(item.displayTitle)
//                        }
//
//
//
//                    }
                }
            }
            
            let handler = VNImageRequestHandler(ciImage: image)
            
            do {
                try handler.perform([request])
            } catch {
                print("The follow error occured: \(error)")
            }
            
        } catch {
            print("The following error has occured: \("error")")
        }
        
    }

    @IBAction func takePicture(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

