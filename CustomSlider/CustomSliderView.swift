//
//  CustomSliderView.swift
//  CustomSlider

import SwiftUI

struct CustomSliderView: View {
    @Binding var percentage: Double
    
    private let backgroundView: AnyView?
    private let slidingView: AnyView?
    private let slidingViewWidth: CGFloat?
    
    /// Custom Slider
    /// - Parameter percentage: Binding<Double> that acts as a percentage for how far the slider has been dragged. If given an initial value other than 0, the slider will start at that point. Use to make calculations based on how far the user drags the slider.
    init(percentage: Binding<Double>) {
        self._percentage = percentage
        self.backgroundView = nil
        self.slidingView = nil
        self.slidingViewWidth = nil
    }
    
    private init(percentage: Binding<Double>, backgroundView: AnyView?, slidingView: AnyView?, slidingViewWidth: CGFloat?) {
        self._percentage = percentage
        self.backgroundView = backgroundView
        self.slidingView = slidingView
        self.slidingViewWidth = slidingViewWidth
    }
    
    private var background: some View {
        GeometryReader { geometry in
            if let backgroundView = self.backgroundView {
                backgroundView
            } else {
                let cornerRadius = geometry.size.height / 2
                RoundedRectangle(cornerRadius: cornerRadius)
                    .foregroundColor(Color.gray.opacity(0.75))
            }
        }
    }
    
    private var slidingArea: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let height = geometry.size.height
            
            let draggableView = self.slidingView ?? self.defaultSlidingView(withHeight: height)
            let slideWidth = self.slidingViewWidth ?? height
            let offset = self.getOffset(totalWidth: totalWidth, slideWidth: slideWidth)
            
            let dragGesture = DragGesture()
                .onChanged { newValue in
                    self.draggingChanged(dragValue: newValue,
                                         currentOffset: offset,
                                         totalWidth: totalWidth,
                                         slideWidth: slideWidth)
                }
            
            HStack {
                Spacer()
                    .frame(width: offset)
                draggableView
                    .gesture(dragGesture)
                Spacer()
            }
        }
    }
    
    var body: some View {
        ZStack {
            self.background
            self.slidingArea
        }
    }
    
    private func defaultSlidingView(withHeight height: CGFloat) -> AnyView {
        AnyView (
            Circle()
                .foregroundColor(.white)
                .frame(width: height, height: height)
        )
    }
    
    private func draggingChanged(dragValue: DragGesture.Value, currentOffset: CGFloat, totalWidth: CGFloat, slideWidth: CGFloat) {
        let startX = dragValue.startLocation.x
        let newX = dragValue.location.x
        
        let offset = newX - startX
        let adjustedOffset = offset + currentOffset
        
        let width = totalWidth - slideWidth
        let percentage = adjustedOffset / width
        let adjustedPercentage = max(0, min(percentage, 1))
        
        self.percentage = Double(adjustedPercentage)
    }
    
    private func getOffset(totalWidth: CGFloat, slideWidth: CGFloat) -> CGFloat {
        let width = totalWidth - slideWidth
        let offset = width * CGFloat(self.percentage)
        
        return offset
    }
    
    /// Adds a custom background view to the slider
    /// - Parameter view: View to act as the background for the slider
    /// - Returns: CustomSliderView with the given background
    func backgroundView<BackgroundView: View>(_ view: BackgroundView) -> CustomSliderView {
        CustomSliderView(percentage: self.$percentage,
                         backgroundView: AnyView(view),
                         slidingView: self.slidingView,
                         slidingViewWidth: self.slidingViewWidth)
    }
    
    /// Adds a custom sliding view for the user to drag
    /// - Parameters:
    ///   - view: View to act as the sliding view for the slider
    ///   - viewWidth: CGFloat width of the given view. Necessary to take the width of the slider view into consideration when calculating the percentage as the user drags.
    /// - Returns: CustomSliderView with the given sliding view
    func slidingView<SlidingView: View>(_ view: SlidingView, viewWidth: CGFloat) -> CustomSliderView {
        CustomSliderView(percentage: self.$percentage,
                         backgroundView: self.backgroundView,
                         slidingView: AnyView(view),
                         slidingViewWidth: viewWidth)
    }
}

struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Spacer()
                .frame(width: 16)
            CustomSliderView(percentage: .constant(0))
                .frame(height: 48)
            Spacer()
                .frame(width: 16)
        }
    }
}
