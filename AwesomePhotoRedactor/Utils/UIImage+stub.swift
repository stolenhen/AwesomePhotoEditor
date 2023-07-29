//
//  UIImage+stub.swift
//  AwesomePhotoRedactor
//
//  Created by Ivan Iashes on 29.07.2023.
//

import class UIKit.UIImage

extension UIImage {
    static var stub: UIImage {
        UIImage(named: "awesome_monkey") ?? .init()
    }
}
