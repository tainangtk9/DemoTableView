//
//  ViewController.swift
//  TableViewDemo
//
//  Created by Phan Nang on 12/20/19.
//  Copyright © 2019 Phan Nang. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var txtMealName: UITextField!
    @IBOutlet weak var photoImage: UIImageView!
    
    @IBOutlet weak var btSave: UIBarButtonItem!
    @IBOutlet weak var ratingControl: RatingControl!
    
    var meal: Meal?
    
    @IBAction func cancel(_ sender: Any) {
        
        let isPrensentingInAddMealMode = presentingViewController is UINavigationController
        if isPrensentingInAddMealMode {
        dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController
        {
            owningNavigationController.popViewController(animated: true)
        }
        else{
            fatalError("The mealViewController is not inside a navigation controller")
        }
        
    }
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === btSave else {
            os_log("The button was not pressed , canceling", log: OSLog.default, type: .debug)
            return
        }
        let name = txtMealName.text ?? ""
        let photo = photoImage.image
        let rating = ratingControl.rating
        meal = Meal(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        txtMealName.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.setImageFromPhotoLibrary(_:)))
        photoImage.addGestureRecognizer(tap)
        photoImage.isUserInteractionEnabled = true
        updateSaveButtonState()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let meal = meal {
            navigationItem.title = meal.name
            txtMealName.text = meal.name
            photoImage.image = meal.photo
            ratingControl.rating = meal.rating
            btSave.isEnabled = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField:UITextField){
        
    }
    
    @IBAction func resetText(_ sender: Any) {
        
    }
    
    @IBAction func setImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        txtMealName.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true,completion: nil)
        
    }
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set photoImageView to display the selected image.
        photoImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btSave.isEnabled = false
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updateSaveButtonState()
        navigationItem.title = txtMealName.text
    }
    // MARK: private method
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = txtMealName.text ?? ""
        btSave.isEnabled = !text.isEmpty
    }
}

