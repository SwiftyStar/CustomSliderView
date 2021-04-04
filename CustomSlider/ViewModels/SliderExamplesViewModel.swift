//
//  SliderExamplesViewModel.swift
//  CustomSlider

import Foundation

struct SliderExamplesViewModel {
    func getTempurature(for percentage: Double) -> Int {
        let minimumTempurature: Double = 32
        let maximumTempurature: Double = 80
        let range = maximumTempurature - minimumTempurature
        let tempurature = percentage * range + minimumTempurature
        let roundedTempurature = Int(tempurature)
        
        return roundedTempurature
    }
    
    func getVolume(for percentage: Double) -> Int {
        let maximumVolume: Double = 10
        let volume = percentage * maximumVolume
        let roundedVolume = Int(volume)
        
        return roundedVolume
    }
}
