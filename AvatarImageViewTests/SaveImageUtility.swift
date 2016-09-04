//
//  SaveImageUtility.swift
//  AvatarImageView
//
//  Created by Ayush Newatia on 11/08/2016.
//  Copyright © 2016 Ayush Newatia. All rights reserved.
//

import UIKit
import XCTest
@testable import AvatarImageView

// THIS SHOULD NOT RUN AS PART OF A NORMAL TEST RUN. It is meant to be used to save generated images to then compare them in unit tests.
// This test case is disabled in the scheme.
class SaveImageUtility: XCTestCase {
    
    func testSaveImage() {
        let data = TestData(name: "")
        
        var config = TestConfig()
        config.shape = .square
        
        let avatarImageView = AvatarImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        avatarImageView.configuration = config
        avatarImageView.dataSource = data
        
//        let imageData = UIImagePNGRepresentation(avatarImageView.image!)!
        avatarImageView.asImage().saveToDesktop()
    }
}

extension UIView {
    func asImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()!
        layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIImage {
    func saveToDesktop(withName name: String = "image.png") {
        let imageData = UIImagePNGRepresentation(self)
        let simluatorDesktopPath = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true).first!
        let splitPath = simluatorDesktopPath.components(separatedBy: "/")
        let path = "/\(splitPath[1])/\(splitPath[2])/Desktop/\(name)"
        
        FileManager.default.createFile(atPath: path, contents: imageData, attributes: nil)
    }
}
