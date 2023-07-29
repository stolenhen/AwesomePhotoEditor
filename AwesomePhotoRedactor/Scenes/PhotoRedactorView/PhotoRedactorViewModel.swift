//
//  PhotoRedactorViewModel.swift
//  AwesomePhotoRedactor
//
//  Created by Ivan Iashes on 28.07.2023.
//

import class UIKit.UIImage
import CoreImage
import Combine

final class PhotoRedactorViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private var filter: ImageFilter
    private let intensityQueue = DispatchQueue(label: "intensity_filter_queue", qos: .userInteractive)
    
    private var cancellables: Set<AnyCancellable> = []
    
    let intensityRange: ClosedRange<CGFloat> = -100...100
    
    // MARK: - Publishers
    
    @Published private(set) var stringIntensityValue: String = ""
    @Published private(set) var image: UIImage?
    
    @Published var intensityValue: CGFloat = .zero
    
    // MARK: - Init
    
    init(filter: ImageFilter = BrightnessFilter()) {
        self.filter = filter
        
        setInputFilterImage()
        setupSubscribers()
    }
    
    // MARK: - Public methods
    
    func resetFilter() {
        intensityValue = .zero
    }
    
    func applyFilter(with value: CGFloat) {
        guard value != .zero else {
            filter.value = nil
            return image = .stub
        }
        
        setFilterValue(value)
        setFilteredImage()
    }
}

private extension PhotoRedactorViewModel {
    
    // MARK: - Private
    
    func setupSubscribers() {
        $intensityValue
            .map(\.roundedTitle)
            .assign(to: &$stringIntensityValue)
        $intensityValue
            .sink { [weak self] in self?.applyFilter(with: $0) }
            .store(in: &cancellables)
    }
    
    func setInputFilterImage() {
        guard let cgImage = UIImage.stub.cgImage else { return }
        filter.inputImage = CIImage(cgImage: cgImage)
    }
    
    func setFilterValue(_ value: CGFloat) {
        guard value > .zero else {
            return filter.value = value / 3.5 + 30.0
        }
        filter.value = (value + 30.0)
    }
    
    func setFilteredImage() {
        intensityQueue.async { [weak self] in
            let output = self?.filter.outputImage.convertToCGImage
            let converted = self?.convertToUIImage(cgImage: output)
            DispatchQueue.main.async {
                self?.image = converted
            }
        }
    }
    
    func convertToUIImage(cgImage: CGImage?) -> UIImage {
        guard let cgImage else { return .stub }
        return UIImage(cgImage: cgImage)
    }
}

// MARK: - ViewModel helpers

private extension CGFloat {
    var roundedTitle: String {
        ("\(String(format: "%.2f", self))")
    }
}

private extension CIImage? {
    var convertToCGImage: CGImage? {
        guard let self else { return nil }
        return CIContext(options: nil).createCGImage(self, from: self.extent)
    }
}
