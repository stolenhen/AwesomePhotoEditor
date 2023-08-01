//
//  PhotoRedactorView.swift
//  AwesomePhotoRedactor
//
//  Created by Ivan Iashes on 27.07.2023.
//

import SwiftUI

struct PhotoRedactorView: View {
    @StateObject private var viewModel: PhotoRedactorViewModel = .init()
    
    var body: some View {
        VStack {
            imageView
                .scaledToFit()
                .frame(height: 450.0)
            sliderView
        }
        .padding([.horizontal, .vertical], 20.0)
    }
}

private extension PhotoRedactorView {
    
    // MARK: - Private logic
    
    func calculateColor() -> Color {
        guard viewModel.intensityValue != .zero else {
            return .secondary
        }
        return viewModel.intensityValue >= .zero ? Color(.systemGreen) : Color(.systemRed)
    }
}

private extension PhotoRedactorView {
    
    // MARK: - Subviews
    
    var imageView: some View {
        Image(uiImage: viewModel.image ?? .stub).resizable()
    }
    
    var sliderView: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .firstTextBaseline, spacing: 4.0) {
                Text("Intensity ").font(.title3)
                Text(viewModel.stringIntensityValue)
                    .font(.caption2)
                    .foregroundColor(calculateColor())
                    .bold()
                Spacer()
                resetButtonView
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Slider(value: $viewModel.intensityValue, in: viewModel.intensityRange)
                .tint(calculateColor())
        }
        .padding(10)
    }
    
    @ViewBuilder
    var resetButtonView: some View {
        if viewModel.intensityValue != .zero {
            Button {
                withAnimation {
                    viewModel.resetFilter()
                }
            } label: {
                Text("RESET")
                    .font(.caption2)
                    .foregroundColor(Color(.systemBlue))
            }
            .buttonStyle(.plain)
        }
    }
}

struct PhotoRedactorView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRedactorView()
    }
}
