//
//  CollectionViewCell.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/9/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class CollectionViewCellMain: UICollectionViewCell, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: - Variables
    var delegate: ImagePickerDelegateMain?
    
    // MARK: - Outlets
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var imageInCell: UIImageView!
    
    // MARK: - Actions
    @IBAction func addImageButtonTapped(_ sender: UIButton) {
        delegate?.pickImageMain(cell: self)
    }
    
    var image: UIImage? {
        didSet {
            self.imageInCell.image = image
        }
    }
    
    
}
