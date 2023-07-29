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
                .frame(height: 450)
            sliderView
        }
        .padding([.horizontal, .vertical], 20)
    }
}

private extension PhotoRedactorView {
    
    // MARK: - Subviews
    
    @ViewBuilder
    var imageView: some View {
        if let image = viewModel.image {
            Image(uiImage: image).resizable()
        } else {
            Image(uiImage: .stub).resizable()
        }
    }
    
    var sliderView: some View {
        VStack(spacing: .zero) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("Intensity ").font(.title3)
                Text(viewModel.stringIntensityValue)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .bold()
                Spacer()
                resetButtonView
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Slider(value: $viewModel.intensityValue, in: viewModel.intensityRange)
                .tint(viewModel.intensityValue >= .zero ? Color(.systemBlue) : Color(.systemRed))
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
