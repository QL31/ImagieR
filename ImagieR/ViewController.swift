//
//  ViewController.swift
//  ImagieR
//
//  Created by li qinglian on 03/05/2020.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageTaken: UIImageView!
    
    let imagePiker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePiker.delegate = self
        imagePiker.sourceType = .photoLibrary
        imagePiker.allowsEditing = false
        
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.originalImage] as? UIImage else {fatalError("Error taking image")}
        imageTaken.image = userPickedImage
            guard let ciImage = CIImage(image: userPickedImage) else {fatalError("Could not convert to CIImage")}
        
            detect(image: ciImage)
        
        imagePiker.dismiss(animated: true, completion: nil)
        
    }

    func detect(image:CIImage){
        
        guard let model = try? VNCoreMLModel(for: MobileNetV2().model) else{fatalError("Loading core ML model failed")}
       
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let result = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to processe image")
            }
            print(result)
            
            if let title = result.first?.identifier {
                
                print("presition =\(result.first?.confidence)")
                
                self.navigationItem.title = title
            }
            
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do{
            try handler.perform([request])
        }catch{
            print(error)
        }
        
        
    }
    @IBAction func image(_ sender: UIBarButtonItem) {
        
        present(imagePiker, animated: true, completion: nil)
        
        
    }
    
}

