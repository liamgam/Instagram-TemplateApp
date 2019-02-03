//
//  InstagramMockViewController.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/15/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit
import Photos

class InstagramMockViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    var imagePicker = UIImagePickerController()
    var selectedCell: InstaMockCollectionViewCell?
    var images = [UIImage?](repeating: nil, count: 18)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // updating the edit button to be round with a border color:
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        imagePicker.delegate = self
    }
    
    
    
}





extension InstagramMockViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postImagesCell", for: indexPath) as! InstaMockCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if images[indexPath.row] == nil {
            openPhotoLibrary(indexPath: indexPath)
        } else {
            let alert = UIAlertController()
            alert.addAction(UIAlertAction(title: NSLocalizedString("Change Image", comment: "Default action"), style: .default, handler: {_ in
                self.openPhotoLibrary(indexPath: indexPath)
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Share", comment: "Default action"), style: .default, handler: {_ in
                InstagramManager.sharedManager.postImageToInstagramWithCaption(imageInstagram: self.images[indexPath.row]!, view: self.view)
            }))
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .cancel, handler: { _ in
                print("cancel")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}


extension InstagramMockViewController {
    
    func openPhotoLibrary(indexPath: IndexPath) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.allowsEditing = true
                    self.selectedCell = self.collectionView.cellForItem(at: indexPath) as? InstaMockCollectionViewCell
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            case .notDetermined:
                print("not determined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicked = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            dismiss(animated: true, completion: nil)
            guard
                let cell = selectedCell,
                let indexPath = collectionView.indexPath(for: cell) else { return }
            
            images[indexPath.row] = imagePicked
            cell.image = imagePicked
            cell.setNeedsLayout()
        }
    }
}



extension InstagramMockViewController: UICollectionViewDelegateFlowLayout {
    
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
        return 1.5
    }
}
