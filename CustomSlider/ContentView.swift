//
//  ContentView.swift
//  CustomSlider

import SwiftUI

struct ContentView: View {
    @State private var circleSliderPercent: Double = 0
    @State private var rectangleSliderPercent: Double = 0.5
    @State private var defaultSliderPercent: Double = 0.67
    
    private let sliderHeight: CGFloat = 48
    
    private var rectangleSliderViewWidth: CGFloat {
        0.8 * self.sliderHeight
    }
    
    private var circleSliderBackgroundGradient: Gradient {
        Gradient(colors: [Color.blue.opacity(0.5), Color.blue])
    }
    
    private var circleSliderBackground: some View {
        GeometryReader { geometry in
            let cornerRadius = geometry.size.height
            
            LinearGradient(gradient: self.circleSliderBackgroundGradient,
                           startPoint: .leading,
                           endPoint: .trailing)
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
            .frame(width: self.sliderHeight)
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
        Color.red.opacity(self.rectangleSliderPercent)
    }
    
    private var rectangleSliderViewOverlay: some View {
        GeometryReader { geometry in
            self.getArrow(from: geometry)
        }
    }
    
    private var rectangleSliderView: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: self.sliderHeight, height: self.sliderHeight)
            .overlay(self.rectangleSliderViewOverlay)
    }
    
    private var rectangleSlider: some View {
        HStack {
            Spacer()
                .frame(width: 16)
            
            CustomSliderView(percentage: self.$rectangleSliderPercent)
                .backgroundView(self.rectangleSliderBackground)
                .slidingView(self.rectangleSliderView, viewWidth: self.rectangleSliderViewWidth)
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
    
    // Groups to avoid SwiftUI 10 view limit
    private var circleSliderGroup: some View {
        Group {
            Text("\(self.circleSliderPercent)")
            Spacer()
            self.circleSlider
        }
    }
    
    private var rectangleSliderGroup: some View {
        Group {
            Text("\(self.rectangleSliderPercent)")
            Spacer()
            self.rectangleSlider
        }
    }
    
    private var defaultSliderGroup: some View {
        Group {
            Text("\(self.defaultSliderPercent)")
            Spacer()
            self.defaultSlider
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
        }
    }
    
    private func getArrow(from geometry: GeometryProxy) -> some View {
        let arrowDimension = geometry.size.height * 0.8
        let topMargin = geometry.size.height * 0.1
        
        let startPoint = CGPoint(x: 0, y: topMargin)
        let arrowTip = CGPoint(x: arrowDimension, y: topMargin + 0.5 * arrowDimension)
        let bottomPoint = CGPoint(x: 0, y: topMargin + arrowDimension)
        
        return Path { path in
            path.move(to: startPoint)
            path.addLine(to: arrowTip)
            path.addLine(to: bottomPoint)
            path.addLine(to: startPoint)
        }
        .fill(Color.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
