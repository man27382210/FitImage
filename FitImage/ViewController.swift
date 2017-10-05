//
//  ViewController.swift
//  FitImage
//
//  Created by Tseng, Taiwei | Davis | ASRHQ on 05/10/2017.
//  Copyright © 2017 davis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imagePlace: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func PickImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .photoLibrary
            self.present(imgPicker, animated: true, completion: nil)
        }
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let img = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePlace.image = img
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveImage(_ sender: Any) {
        let maxSize =  max(imagePlace.image!.size.height, imagePlace.image!.size.width)
        let squareSize = CGSize(width: maxSize, height: maxSize)
        let rect = CGRect(x: 0, y: 0, width: maxSize, height: maxSize)
        
        let dx = (maxSize - imagePlace.image!.size.width) / 2.0
        let dy = (maxSize - imagePlace.image!.size.height) / 2.0
        
        UIGraphicsBeginImageContext(squareSize)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.white.cgColor)
        context!.fill(rect)
        
        rect.insetBy(dx: dx, dy: dy)
        let topRect = CGRect(x: 0, y: dy, width: imagePlace.image!.size.width, height: imagePlace.image!.size.height)
        imagePlace.image!.draw(in: topRect, blendMode: CGBlendMode.normal, alpha: 1.0)
        let bottomImage = UIImage()
        bottomImage.draw(in: rect, blendMode: CGBlendMode.normal, alpha: 1.0)
        
        
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let imgData = UIImageJPEGRepresentation(newImg!, 1.0)
        let jpgImage = UIImage(data: imgData!)
        UIImageWriteToSavedPhotosAlbum(jpgImage!, nil, nil, nil)
        let alert = UIAlertController(title: "save", message: "save success", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))

        self.present(alert, animated: true) {
            print("OK")
        }
    }
    
    
    
}

