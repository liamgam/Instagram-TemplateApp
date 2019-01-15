//
//  ViewController.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/5/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit
import CoreData
import Photos

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewAccessibilityDelegate, UIDocumentInteractionControllerDelegate{
    
    // MARK: - Variables
    let imagePicker = UIImagePickerController()
    var selectedCell: CollectionViewCellMain?
    var images = [UIImage?](repeating: nil, count: 12)
    
    
    // MARK: - Variables
    fileprivate var longPressGesture: UILongPressGestureRecognizer!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(displayP3Red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker.delegate = self
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongGesture(gesture:)))
        collectionView.addGestureRecognizer(longPressGesture)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = (scrollView.contentOffset.y > 5)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            
            dismiss(animated: true, completion: nil)
            guard
                let cell = selectedCell,
                let indexPath = collectionView.indexPath(for: cell) else {
                    return
            }
            images[indexPath.row] = image
            cell.image = image
            cell.setNeedsLayout()
        }
    }
    
    @objc func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .possible:
            print("possible")
        case .began:
            let gesturePoint = gesture.location(in: self.collectionView)
            guard let selectedIndex = self.collectionView.indexPathForItem(at: gesturePoint) else {
                break
            }
            collectionView.beginInteractiveMovementForItem(at: selectedIndex)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view))
        case .ended:
            collectionView.endInteractiveMovement()
        case .cancelled:
            collectionView.cancelInteractiveMovement()
        case .failed:
            collectionView.endInteractiveMovement()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! CollectionViewCellMain
        
        if let imageForIndexPath  = images[indexPath.row] {
            cell.image = imageForIndexPath
        } else {
            cell.image = UIImage(named: "addImages")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        PHPhotoLibrary.requestAuthorization{ (status) in
            switch status {
            case .authorized:
                DispatchQueue.main.async {
                    self.imagePicker.sourceType = .photoLibrary
                    self.imagePicker.allowsEditing = true
                    self.selectedCell = collectionView.cellForItem(at: indexPath) as? CollectionViewCellMain
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
        
        if images[indexPath.row] != nil {
            InstagramManager.sharedManager.postImageToInstagramWithCaption(imageInstagram: images[indexPath.row]!, view: self.view)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = images.remove(at: sourceIndexPath.row)
        images.insert(item, at: destinationIndexPath.row)
        print(images)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "mainHeader", for: indexPath)
        return header
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // shows the usersname when user opens up this page
        let profiles = CoreDataHelper.retrieveprofile()
        let profile = profiles.first
        usernameTextField.text = profile?.username // ?? ""
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // use to make the view or any subview that is the first responder resign (optionally force)
        self.view.endEditing(true)
        
        // set the username text field to the one saved in coredata (?)
        let profiles = CoreDataHelper.retrieveprofile()
        let profile = profiles.first
        profile?.username = usernameTextField.text
        
        // create a new profile and set the username to the textfield user input
        let username = CoreDataHelper.newProfile()
        username.username = usernameTextField.text
        CoreDataHelper.saveProfile()
    }
}



extension ViewController: UICollectionViewDelegateFlowLayout {
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
