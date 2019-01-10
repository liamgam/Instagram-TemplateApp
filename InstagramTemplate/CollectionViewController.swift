//
//  CollectionViewController.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/7/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit
import Photos

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImagePickerDelegate {
    
    // MARK: - outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - variables
    let imagePicker = UIImagePickerController()
    var selectedCell : CollectionViewCell?
    var images = [UIImage?](repeating: nil, count: 12)                    // storing images in the correct index
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        imagePicker.delegate = self
        
    }
    
    // MARK: - delegate function
    
    
    func pickImage(cell: CollectionViewCell) {
        // ImagePickerDelegate
        // request access. If authorized, show the image picker
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                // sets the imagepicker which presents the photolibrary
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.allowsEditing = true
                self.selectedCell = cell
                self.present(self.imagePicker, animated: true, completion: nil)
            case .denied:
                print("denied")
            case .notDetermined:
                print("not determined")
            case .restricted:
                print("resstricted")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // UIImagePickerControllerDelegate
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // dismiss view controller once user picks an image
            dismiss(animated: true, completion: nil)
            guard
                let cell = selectedCell,
                let indexPath = collectionView.indexPath(for: cell) else {
                    return
            }
            
            // append image to the correct index path in the images array?
            images[indexPath.row] = image
            
            cell.image = image
            cell.addImageButton.isHidden = true
            cell.img.isHidden = false
            
            cell.setNeedsLayout()   // call when you want to update a view's subviews.
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.delegate = self
        
        // add the images to the correct index?
        let imageForIndexPath = images[indexPath.row]
        // set the image of the cell at the index path
        cell.img.image = imageForIndexPath
        
        return cell
    }
}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width / 3) - 1
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // horizontal spacing
        return 1.5
    }
}



/*
 
 1) create a delegate(ImagePickerDelegate) to transfer data from the collectionViewCell to the collectionViewController since we want to present the imagePicker. because we set the delegate in the collectionViewCell
 2) set a function(pickImage(cell:)) in the delegate that passes the collectionViewCell in as the parameter to be able to access the index of the cell
 3) set a varibale in the collectionViewCell to be of type ImagePickerDelegate, and call the function pickImage(cell:) in the action where we pass self in as the cell since its in the collectionViewCell.
 4) set the collectionViewContoller to conform to the ImagePickerdelegate protocol and put the required functions in.
 5) in the collectionViewController:
    6) in the pickImage(cell) function, the cell would be of type CollectionViewCell, set the UIImagePickerController and set the cell previously called as a variable to equal the cell passed in by the pickImage(cell) function.
    7) in the didFinishPickingMediaWithInfo function, make sure there's a cell and get the index path of that cell in the collectionView
    8) in the didFinishPickingMediaWithInfo add the image into the correct index of the images array depending on the selectedcell.
 
 */
