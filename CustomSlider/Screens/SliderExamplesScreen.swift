//
//  SliderExamplesScreen.swift
//  CustomSlider

import SwiftUI

struct SliderExamplesScreen: View {
    @State private var circleSliderPercent: Double = 0
    @State private var rectangleSliderPercent: Double = 0.5
    @State private var defaultSliderPercent: Double = 0.6
    @State private var thinSliderPercent: Double = 0.25
    
    private let viewModel = SliderExamplesViewModel()
    private let sliderHeight: CGFloat = 48
    
    private var circleSliderBackgroundGradient: Gradient {
        Gradient(colors: [Color.blue.opacity(0.5), Color.blue])
    }
    
    private var circleSliderBackground: some View {
        GeometryReader { geometry in
            let cornerRadius = geometry.size.height
            
            LinearGradient(gradient: self.circleSliderBackgroundGradient,
                           startPoint: .leading,
                           endPoint: .trailing)
                .frame(height: self.sliderHeight)
                .cornerRadius(cornerRadius)
        }
    }
    
    private var circleSliderViewOverlay: some View {
        HStack {
            Spacer()
            
            VStack {
                Spacer()
                    .frame(height: 8)
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 4)
                    .foregroundColor(.gray)
                Spacer()
                    .frame(height: 8)
            }
            
            Spacer()
            
            VStack {
                Spacer()
                    .frame(height: 8)
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 4)
                    .foregroundColor(.gray)
                Spacer()
                    .frame(height: 8)
            }
            
            Spacer()
        }
    }
    
    private var circleSliderView: some View {
        Circle()
            .frame(width: self.sliderHeight, height: self.sliderHeight)
            .foregroundColor(.black)
            .overlay(self.circleSliderViewOverlay)
    }
    
    private var circleSlider: some View {
        HStack {
            Spacer()
                .frame(width: 16)
            
            CustomSliderView(percentage: self.$circleSliderPercent)
                .backgroundView(self.circleSliderBackground)
                .slidingView(self.circleSliderView, viewWidth: self.sliderHeight)
                .frame(height: self.sliderHeight)
            
            Spacer()
                .frame(width: 16)
        }
    }
    
    private var rectangleSliderBackground: some View {
        Rectangle()
            .foregroundColor(        Color.red.opacity(self.rectangleSliderPercent))
            .frame(height: self.sliderHeight)
    }
    
    private var rectangleSliderView: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: self.sliderHeight, height: self.sliderHeight)
            .overlay(self.getArrow())
    }
    
    private var rectangleSlider: some View {
        HStack {
            Spacer()
                .frame(width: 16)
            
            CustomSliderView(percentage: self.$rectangleSliderPercent)
                .backgroundView(self.rectangleSliderBackground)
                .slidingView(self.rectangleSliderView, viewWidth: self.sliderHeight)
                .frame(height: self.sliderHeight)
            
            Spacer()
                .frame(width: 16)
        }
    }
    
    private var defaultSlider: some View {
        HStack {
            Spacer()
                .frame(width: 16)
            
            CustomSliderView(percentage: self.$defaultSliderPercent)
                .background(
                    Color(UIColor.systemBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 0.5 * sliderHeight))
                        .shadow(radius: 6)
                )
                .frame(height: self.sliderHeight)
            
            Spacer()
                .frame(width: 16)
        }
    }
    
    private var thinSliderBackground: some View {
        RoundedRectangle(cornerRadius: 6)
            .frame(height: 12)
    }
    
    private var thinSlidingView: some View {
        Circle()
            .foregroundColor(.blue)
            .frame(width: self.sliderHeight, height: self.sliderHeight)
    }
    
    private var thinSlider: some View {
        HStack {
            Spacer()
                .frame(width: 16)
            
            CustomSliderView(percentage: self.$thinSliderPercent)
                .backgroundView(self.thinSliderBackground)
                .slidingView(self.thinSlidingView, viewWidth: self.sliderHeight)
                .frame(height: self.sliderHeight)
            
            Spacer()
                .frame(width: 16)
        }
    }
    
    // Groups to avoid SwiftUI 10 view limit
    private var circleSliderGroup: some View {
        Group {
            Text("Tempurature: \(self.viewModel.getTempurature(for: self.circleSliderPercent))")
            Spacer()
            self.circleSlider
        }
    }
    
    private var rectangleSliderGroup: some View {
        Group {
            Text("Opacity: \(self.rectangleSliderPercent)")
            Spacer()
            self.rectangleSlider
        }
    }
    
    private var defaultSliderGroup: some View {
        Group {
            Text("Volume: \(self.viewModel.getVolume(for: self.defaultSliderPercent))")
            Spacer()
            self.defaultSlider
        }
    }
    
    private var thinSliderGroup: some View {
        Group {
            Text("Thin percent: \(self.thinSliderPercent)")
            Spacer()
            self.thinSlider
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            self.circleSliderGroup
            Spacer()
            self.rectangleSliderGroup
            Spacer()
            self.defaultSliderGroup
            Spacer()
            self.thinSliderGroup
            Spacer()
        }
    }
    
    private func getArrow() -> some View {
        let startPoint = CGPoint(x: 0, y: 0)
        let arrowTip = CGPoint(x: self.sliderHeight, y: 0.5 * self.self.sliderHeight)
        let bottomPoint = CGPoint(x: 0, y: self.sliderHeight)
        
        return Path { path in
            path.move(to: startPoint)
            path.addLine(to: arrowTip)
            path.addLine(to: bottomPoint)
            path.addLine(to: startPoint)
        }
        .fill(Color.green)
    }
}

struct SliderExamplesScreen_Previews: PreviewProvider {
    static var previews: some View {
        SliderExamplesScreen()
    }
}
