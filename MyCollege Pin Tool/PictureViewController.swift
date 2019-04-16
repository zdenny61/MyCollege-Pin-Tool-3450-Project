//
//  PictureViewController.swift
//  MyCollege Pin Tool
//
//  Created by Apple Developer on 4/5/19.
//  Copyright © 2019 Denny Homes. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage


class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    @IBOutlet weak var imageViewSpring: UIImageView!
    @IBOutlet weak var imageViewWinter: UIImageView!
    @IBOutlet weak var imageViewSummer: UIImageView!
    
    var filename = ""
    var pictureKeys = [String?](repeating: nil, count: 3)
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    enum SelectionType {
        case Spring
        case Winter
        case Summer
    }
    
    var CurrentSelection: SelectionType = SelectionType.Spring
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func SelectedSpring_Tap(_ sender: Any) {
        
        CurrentSelection = SelectionType.Spring
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
    
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func SelectedWinter_Tap(_ sender: Any) {
        CurrentSelection = SelectionType.Winter
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    @IBAction func SelectedSummer_Tap(_ sender: Any) {
        CurrentSelection = SelectionType.Summer
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Upload a Image", message: "Choose how you would like to upload a image", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
        
        
    }
    
    //submit and then it will go to pin tool
    @IBAction func btnSubmit_Tap(_ sender: Any) {
        
        
        
        
        

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        let actionSheet = UIAlertController(title: "Are you sure?", message: "Double check to make sure you have selected the correct images.", preferredStyle: .actionSheet)

                actionSheet.addAction(UIAlertAction(title: "Upload", style: .default, handler: { (action:UIAlertAction) in
                    
                    let group = DispatchGroup()
                    group.enter()
                    
                    //go though each image type and upload it to firebase
                    let pictureTypes = ["Spring", "Winter", "Summer"]
                    for pictureType in pictureTypes {
                        
                        switch (pictureType){
                        //upload spring picture
                        case "Spring":
                            
//                            let group = DispatchGroup()
//                            group.enter()
//
                            //self.pictureKeys[0] = UUID().uuidString + ".jpg"
                            self.filename = UUID().uuidString + ".jpg"
                            guard let image = self.imageViewSpring.image else { return }
                            
                            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
                            
                            let uploadImageRef = self.imageReference.child(self.filename)
                            print("test")
                            
                            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                                
                                print(metadata ?? "NO METADATA")
                                print(error ?? "NO ERROR")
                                PictureManager.shared.numOfUpload += 1
                            }
                            
                            uploadTask.observe(.progress) { (snapshot) in
                                
                                print(snapshot.progress ?? "NO MORE PROGRESS")
                                
                            }
                            
                            uploadTask.resume()
                            
                            print("upload Image refernce \(uploadImageRef)")
                            self.pictureKeys[0] = uploadImageRef.name
                            
                            break
                            
                        case "Winter":
                            //self.pictureKeys[1] = UUID().uuidString + ".jpg"
                            self.filename = UUID().uuidString + ".jpg"
                            guard let image = self.imageViewWinter.image else { return }
                            
                            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
                            
                            let uploadImageRef = self.imageReference.child(self.filename)
                            
                            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                                
                                print(metadata ?? "NO METADATA")
                                print(error ?? "NO ERROR")
                                PictureManager.shared.numOfUpload += 1
                            }
                            
                            uploadTask.observe(.progress) { (snapshot) in
                                
                                print(snapshot.progress ?? "NO MORE PROGRESS")
                            }
                            
                            uploadTask.resume()
                            
                            print("upload Image refernce \(uploadImageRef)")
                            self.pictureKeys[1] = uploadImageRef.name
                            break
                            
                        case "Summer":
                            //self.pictureKeys[2] = UUID().uuidString + ".jpg"
                            self.filename = UUID().uuidString + ".jpg"
                            guard let image = self.imageViewSummer.image else { return }
                            
                            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
                            
                            let uploadImageRef = self.imageReference.child(self.filename)
                            
                            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                                
                                print(metadata ?? "NO METADATA")
                                print(error ?? "NO ERROR")
                                PictureManager.shared.numOfUpload += 1
                            }
                            
                            uploadTask.observe(.progress) { (snapshot) in
                                
                                print(snapshot.progress ?? "NO MORE PROGRESS")
                            }
                            
                            uploadTask.resume()
                            
                            print("upload Image refernce \(uploadImageRef)")
                            self.pictureKeys[2] = uploadImageRef.name
                            group.leave()
                            
                            break
                        default:
                            //self.pictureKeys[0] = UUID().uuidString + ".jpg"
                            self.filename = UUID().uuidString + ".jpg"
                            guard let image = self.imageViewSpring.image else { return }
                            
                            guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
                            
                            let uploadImageRef = self.imageReference.child(self.filename)
                            
                            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                                
                                print(metadata ?? "NO METADATA")
                                print(error ?? "NO ERROR")
                                PictureManager.shared.numOfUpload += 1
                            }
                            
                            uploadTask.observe(.progress) { (snapshot) in
                                
                                print(snapshot.progress ?? "NO MORE PROGRESS")
                            }
                            
                            uploadTask.resume()
                            
                            print("upload Image refernce \(uploadImageRef)")
                            self.pictureKeys[0] = uploadImageRef.name
                            
                            break
                        }
                        
                        //self.txtImageID.text = UUID().uuidString + ".jpg"
                        //self.filename = UUID().uuidString + ".jpg"//self.txtImageID.text!
                        
                        //guard let image = self.uploadImage.image else { return }
//                        guard let imageData = UIImageJPEGRepresentation(image, 1) else { return }
//
//                        let uploadImageRef = self.imageReference.child(self.filename)
//
//                        let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
//
//                            print(metadata ?? "NO METADATA")
//                            print(error ?? "NO ERROR")
//                        }
//
//                        uploadTask.observe(.progress) { (snapshot) in
//
//                            print(snapshot.progress ?? "NO MORE PROGRESS")
//                        }
//
//                        uploadTask.resume()
//
//                        print("upload Image refernce \(uploadImageRef)")
//
                        
                        
                        
                        
                    }
                    
                    group.wait()
                    
                    //after each picture is loaded into firebase, we can now save the key values
                    self.saveKeys()
                    
                    

                    

                }))
                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

        self.present(actionSheet, animated: true, completion: nil)


        

    }
    
    func saveKeys() {
        //send picture keys to user manager
        PictureManager.shared.currentSet = PictureSet(Picture_Spring: pictureKeys[0]!, Picture_Winter: pictureKeys[1]!, Picture_Summer: pictureKeys[2]!)
//        DispatchQueue.main.async {
            self.performSegue(withIdentifier: ViewIdentifier().PIN_MAIN, sender: self)
        //}
    }
    
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//
//        imageViewSpring.image = image
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set image passed on which one was selected to display the selected image.
        switch CurrentSelection {
        case SelectionType.Spring:
            imageViewSpring.image = selectedImage
        case SelectionType.Winter:
            imageViewWinter.image = selectedImage
        case SelectionType.Summer:
            imageViewSummer.image = selectedImage
        }
        
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    
    
    

}

