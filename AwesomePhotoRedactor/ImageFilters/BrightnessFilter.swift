//
//  BrightnessFilter.swift
//  AwesomePhotoRedactor
//
//  Created by Ivan Iashes on 29.07.2023.
//

import CoreImage

final class BrightnessFilter: CIFilter, ImageFilter {
    var inputImage: CIImage?
    var value: CGFloat?
    
    static var kernel: CIColorKernel? = {
        guard let url = Bundle.main.url(forResource: "FilterKernel",  withExtension: "ci.metallib"),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return try? CIColorKernel(functionName: "brightnessFilterKernel", fromMetalLibraryData: data)
    }()
    
    override var outputImage: CIImage? {
        guard let value, let inputImage else { return .none }
        return Self.kernel?.apply(
            extent: inputImage.extent,
            arguments: [inputImage, value]
        )
    }
}
