//
//  InstagramManager.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/13/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import Foundation
import UIKit

/*
 
 open the instagram app: UIApplication.shared.open(instagramURL! as URL, completionHandler: nil)
 
 */


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
    
    
    func saveImageDocumentDirectory(image: UIImage){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(kfileNameExtension)  // !!!
        print(paths)
        let imageData = image.jpegData(compressionQuality: 1)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    func getDirectoryPath() -> String {
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(kfileNameExtension)
        return paths
    }
    
    
    func postImageToInstagramWithCaption(imageInstagram: UIImage, view: UIView) {
        saveImageDocumentDirectory(image: imageInstagram)
        let directPath = getDirectoryPath()
        
        let instagramURL = NSURL(string: kInstagramURL)
        if UIApplication.shared.canOpenURL(instagramURL! as URL) {
            saveImageDocumentDirectory(image: imageInstagram)
            let rect = CGRect(x: 0, y: 0, width: 612, height: 612)
            let fileurl = URL(fileURLWithPath: directPath)
            documentInteractionController.url = fileurl
            documentInteractionController.delegate = self
            documentInteractionController.uti = kUTI
            documentInteractionController.presentOpenInMenu(from: rect, in: view, animated: true)
        } else {
            UIAlertView(title: kAlertViewTitle, message: kAlertViewMessage, delegate:nil, cancelButtonTitle:"Ok").show()
        }
    }
}
