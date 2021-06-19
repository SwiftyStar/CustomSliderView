//
//  CustomSliderView.swift
//  CustomSlider

import SwiftUI

struct CustomSliderView: View {
    @Binding var percentage: Double
    
    var backgroundView: AnyView?
    var slidingView: AnyView?
    var slidingViewWidth: CGFloat?
    
    private let viewModel = CustomSliderViewModel()
    
    /// Custom Slider
    /// - Parameter percentage: Binding<Double> that acts as a percentage for how far the slider has been dragged. If given an initial value other than 0, the slider will start at that point. Use to make calculations based on how far the user drags the slider.
    init(percentage: Binding<Double>) {
        self._percentage = percentage
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                self.background(with: geometry)
                self.slidingArea(with: geometry)
            }
        }
    }
    
    private func background(with geometry: GeometryProxy) -> some View {
        let height = geometry.size.height
        
        return self.backgroundView ?? self.defaultBackgroundView(withHeight: height)
    }
    
    private func defaultBackgroundView(withHeight height: CGFloat) -> AnyView {
        AnyView (
            RoundedRectangle(cornerRadius: height / 2)
                .foregroundColor(Color.gray.opacity(0.75))
        )
    }
    
    private func slidingArea(with geometry: GeometryProxy) -> some View {
        let width = geometry.size.width
        let height = geometry.size.height
        
        let draggableView = self.slidingView ?? self.defaultSlidingView(withHeight: height)
        let slideWidth = self.slidingViewWidth ?? height
        let offset = self.viewModel.getOffset(percentage: self.percentage,
                                              totalWidth: width,
                                              slideWidth: slideWidth)
        
        let dragGesture = DragGesture()
            .onChanged { newValue in
                self.percentage = self.viewModel.getPercentage(dragValue: newValue,
                                                               currentOffset: offset,
                                                               totalWidth: width,
                                                               slideWidth: slideWidth)
            }
        
        return HStack {
            Spacer()
                .frame(width: offset)
            draggableView
                .gesture(dragGesture)
            Spacer()
                .frame(minWidth: 0) // Oddly, the minWidth was 8 - a bug?
        }
    }
    
    private func defaultSlidingView(withHeight height: CGFloat) -> AnyView {
        AnyView (
            Circle()
                .foregroundColor(.white)
                .frame(width: height, height: height)
        )
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
