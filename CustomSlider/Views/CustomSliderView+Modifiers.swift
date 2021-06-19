//
//  CustomSliderView+Modifiers.swift
//  CustomSlider
//
//  Created by Jacob Starry on 6/19/21.
//

import SwiftUI

extension CustomSliderView {
    /// Adds a custom background view to the slider
    /// - Parameter view: View to act as the background for the slider
    /// - Returns: CustomSliderView with the given background
    func backgroundView<BackgroundView: View>(_ view: BackgroundView) -> CustomSliderView {
        var mutableSelf = self
        mutableSelf.backgroundView = AnyView(view)
        return mutableSelf
    }
    
    /// Adds a custom sliding view for the user to drag
    /// - Parameters:
    ///   - view: View to act as the sliding view for the slider
    ///   - viewWidth: CGFloat width of the given view. Necessary to take the width of the slider view into consideration when calculating the percentage as the user drags.
    /// - Returns: CustomSliderView with the given sliding view
    func slidingView<SlidingView: View>(_ view: SlidingView, viewWidth: CGFloat) -> CustomSliderView {
        var mutableSelf = self
        mutableSelf.slidingView = AnyView(view)
        mutableSelf.slidingViewWidth = viewWidth
        return mutableSelf
    }
}
