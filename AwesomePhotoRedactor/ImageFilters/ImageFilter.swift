//
//  ImageFilter.swift
//  AwesomePhotoRedactor
//
//  Created by Ivan Iashes on 29.07.2023.
//

import CoreImage

protocol ImageFilter {
    var inputImage: CIImage? { get set }
    var value: CGFloat? { get set }
    
    var outputImage: CIImage? { get }
}
