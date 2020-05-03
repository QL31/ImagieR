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
        
        imagePiker.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func image(_ sender: UIBarButtonItem) {
        
        present(imagePiker, animated: true, completion: nil)
        
        
    }
    
}

