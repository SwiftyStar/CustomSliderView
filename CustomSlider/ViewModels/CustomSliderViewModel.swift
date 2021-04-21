//
//  CustomSliderViewModel.swift
//  CustomSlider
//
//  Created by Jacob Starry on 4/20/21.
//

import SwiftUI

struct CustomSliderViewModel {
    
    /// Gets the percentage of the slidable area that the user has dragged
    /// - Parameters:
    ///   - dragValue: DragGesture.Value
    ///   - currentOffset: CGFloat offset at the start of the drag gesture. Required to adjust the offset as the sliding area is dragged
    ///   - totalWidth: CGFloat total width of the sliding area
    ///   - slideWidth: CGFlaot width of the sliding view. Required to adjust the dragging area to account for the sliding view width
    /// - Returns: Double percentage the user has dragged to
    func getPercentage(dragValue: DragGesture.Value, currentOffset: CGFloat, totalWidth: CGFloat, slideWidth: CGFloat) -> Double {
        let startX = dragValue.startLocation.x
        let newX = dragValue.location.x
        
        let offset = newX - startX
        let adjustedOffset = offset + currentOffset
        
        let width = totalWidth - slideWidth
        let percentage = adjustedOffset / width
        let adjustedPercentage = max(0, min(percentage, 1))
        
        return Double(adjustedPercentage)
    }
    
    /// Gets the offset for the sliding view, given the percentage of the area the user has dragged to
    /// - Parameters:
    ///   - percentage: Double percentage the user has dragged to
    ///   - totalWidth: CGFloat total width of the sliding area
    ///   - slideWidth: CGFloat width of the sliding view. Required to adjust the dragging area to account for the sliding view width
    /// - Returns: CGFloat offset for the sliding view
    func getOffset(percentage: Double, totalWidth: CGFloat, slideWidth: CGFloat) -> CGFloat {
        let width = totalWidth - slideWidth
        let offset = width * CGFloat(percentage)
        
        return offset
    }
}

