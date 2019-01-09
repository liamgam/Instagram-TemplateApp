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
