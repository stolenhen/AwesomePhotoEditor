//
//  FilterKernel.ci.metal
//  AwesomePhotoRedactor
//
//  Created by Ivan Iashes on 28.07.2023.
//

#include <metal_stdlib>
#include <CoreImage/CoreImage.h>

using namespace metal;

extern "C" float4 brightnessFilterKernel(coreimage::sample_t img, float value) {
    float v = value / 30;
    return float4(img.r * v, img.g * v, img.b * v, img.a);
}
