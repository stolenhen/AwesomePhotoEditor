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
    
    override var outputImage: CIImage? {
        guard let value, let inputImage else { return .none }
        return Self.kernel?.apply(extent: inputImage.extent, arguments: [inputImage, value])
    }
}

private extension BrightnessFilter {
    
    // MARK: - Kernel
    
    private static var kernelURL: URL? {
        Bundle.main.url(forResource: "FilterKernel",  withExtension: "ci.metallib")
    }
    
    private static var kernel: CIColorKernel? {
        guard let kernelURL, let data = try? Data(contentsOf: kernelURL) else {
            return .none
        }
        return data.extractKernel(funcName: "brightnessFilterKernel")
    }
}

// MARK: - Private helpers

private extension Data {
    func extractKernel(funcName: String) -> CIColorKernel? {
        try? CIColorKernel(functionName: funcName, fromMetalLibraryData: self)
    }
}
