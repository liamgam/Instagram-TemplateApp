//
//  InstagramManager.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/13/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

class InstagramManager: NSObject, UIDocumentInteractionControllerDelegate {
    
    private let kInstagramURL = "instagram://app"
    private let kUTI = "com.instagram.exclusivegram"
    private let kfileNameExtension = "instagram.igo"
    private let kAlertViewTitle = "Error"
    private let kAlertViewMessage = "Please install the Instagram application"
    
    var documentInteractionController = UIDocumentInteractionController()
    
    // singleton manager
    class var sharedManager: InstagramManager {
        struct Singleton {
            static let instance = InstagramManager()
        }
        return Singleton.instance
    }
    
    func postImageToInstagramWithCaption(imageInstagram: UIImage, view: UIView, result: Bool? = nil) {
        // called to post image to the instagram application
        
        let instagramURL = NSURL(string: kInstagramURL)
        if UIApplication.shared.canOpenURL(instagramURL! as URL) {
            let jpgPath = (NSTemporaryDirectory() as NSString).appendingPathComponent(kfileNameExtension)
            do {
//                imageInstagram.jpegData(compressionQuality: 1.0)?.write(to: URL(string: jpgPath)!)
                let jpeg = imageInstagram.jpegData(compressionQuality: 1.0)
                try jpeg?.write(to: URL(string: jpgPath)!)
            } catch {
                print(error)
            }
            let rect = CGRect(x: 0, y: 0, width: 612, height: 612)
            let fileURL = NSURL.fileURL(withPath: jpgPath)
            documentInteractionController.url = fileURL
            documentInteractionController.delegate = self
            documentInteractionController.uti = kUTI

            // adding caption for the image
//             documentInteractionController.annotation = ["InstagramCaption": instagramCaption]
            documentInteractionController.presentOpenInMenu(from: rect, in: view, animated: true)
        } else {

//             alert displayed when the instagram application is not available in the device
            UIAlertView(title: kAlertViewTitle, message: kAlertViewMessage, delegate:nil, cancelButtonTitle:"Ok").show()
        }
    }
}
