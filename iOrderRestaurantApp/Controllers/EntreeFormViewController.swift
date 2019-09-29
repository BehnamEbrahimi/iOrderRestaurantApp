//
//  EntreeFormViewController.swift
//  iOrderRestaurantApp
//
//  Created by user159453 on 9/29/19.
//  Copyright © 2019 Behnam Ebrahimi. All rights reserved.
//

import UIKit
import CoreData

class EntreeFormViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var dishToEdit: Dish?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var dishImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (dishToEdit != nil) && (dishToEdit!.name != nil) {
            nameField.text = dishToEdit?.name
        }
        if (dishToEdit != nil) && (dishToEdit!.unitPrice != nil) {
            priceField.text = NSString(format: "%.2f", dishToEdit!.unitPrice) as String
        }
        if (dishToEdit != nil) && (dishToEdit!.desc != nil) {
            descField.text = dishToEdit?.desc
        }
        if (dishToEdit != nil) && (dishToEdit!.image != nil) {
            dishImage.image =  UIImage(data: dishToEdit!.image!)
        }

        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.chooseImage))
        tapGestureRecognizer.numberOfTouchesRequired = 1
        
        dishImage.addGestureRecognizer(tapGestureRecognizer)
        dishImage.isUserInteractionEnabled = true

    }
    
    @objc func chooseImage(recognizer:UITapGestureRecognizer){
        let imagePicker:UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(imagePicker, animated: true, completion:nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImage: UIImage?
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        let smallPicture = scaleImageWith(image: selectedImage!, newSize: CGSize(width: 100,height: 100))
        
        var sizeOfImageView:CGRect = dishImage.frame
        sizeOfImageView.size = smallPicture.size
        dishImage.frame = sizeOfImageView
        
        dishImage.image = smallPicture
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func scaleImageWith(image:UIImage, newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0,y: 0,width: newSize.width, height: newSize.height))
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsGetImageFromCurrentImageContext()
        
        return newImage
    }
    
    
    
     // MARK: - Add new entree
    
    @IBAction func addEntreeBtnPressed(_ sender: UIButton) {
        
        let newEntree = Dish(context: self.context)
        
        newEntree.name = self.nameField.text!
        newEntree.type = "entree"
        newEntree.unitPrice = (self.priceField.text! as NSString).floatValue
        newEntree.desc = self.descField.text
        
        if dishImage.image != nil {
            let dishImageData:NSData = dishImage.image!.pngData()! as NSData
        
            newEntree.image = dishImageData as Data
        }
        
        self.saveEntrees()
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Model Manipulation Methods
    func saveEntrees(){
        
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
    }
    
}
