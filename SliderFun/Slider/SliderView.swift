//
//  Slider.swift
//  SliderFun
//
//  Created by Biao Xie on 2/3/21.
//

import SwiftUI

let impact = UISelectionFeedbackGenerator()

let hapticPercentages: [CGFloat] = [0, 0.5, 1]

struct PolarrSlider<V: BinaryFloatingPoint>: View {
    @Binding var value: V

    let color: Color = .accentColor
    let range: ClosedRange<V>
    let height: CGFloat = 20
    let trackHeight: CGFloat = 5
    let backgroundColor = Color.black.opacity(0.9)
    let thumbBorderColor = Color.gray
    let thumbActivedBorderColor = Color.white
 
    @State var isActived = false
    @State var percentage: CGFloat = 0.5

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0))

                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        color.darken(),
                                        color.lighten()
                                    ]
                                ),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(3.0)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(Color.white.opacity(0.3))
                        .frame(
                            width: abs(0.5 - percentage) * geometry.size.width
                        )
                        .position(x: (percentage - 0.5 + 1) * geometry.size.width / 2, y: trackHeight / 2)
                    
                }
                .frame(height: trackHeight)

                Circle()
                    .strokeBorder(Color.black, lineWidth: 1.0)
                    .background(
                        Circle()
                            .strokeBorder(isActived ? thumbActivedBorderColor : thumbBorderColor, lineWidth: 2.5)
                            .background(
                                Circle()
                                    .foregroundColor(.black)
                            )
                    )
                    .position(
                        x: geometry.size.width * percentage + (0.5 - percentage) * height,
                        y: height / 2
                    )
            }
            .cornerRadius(12)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            isActived = false
                        }
                    }
                    .onChanged { value in
                        withAnimation(.spring()) {
                            isActived = true
                            
                            self.percentage = min(max(0, CGFloat(value.location.x / geometry.size.width)), 1)
                            
                            self.value = (range.upperBound - range.lowerBound) * V(percentage) + range.lowerBound
                        }
                        
                        if hapticPercentages.contains(percentage) {
                            impact.selectionChanged()
                        }
                    }
            )
        }
        .frame(height: height)
    }
}

struct SliderView<V: BinaryFloatingPoint>: View {
    @Binding var value: V

    let label: String = "Slider"
    let range: ClosedRange<V>
    let format: String = "%.1f"

    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .font(.callout)

                Spacer()
                
                Text(String(format: format, Double(value)))
                    .font(.system(.body, design: .monospaced))
            }

            PolarrSlider(value: $value, range: range)
        }
        .padding()
        .cornerRadius(5.0)
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        SliderView(value: .constant(0.0), range: -200...200)
            .previewedInAllColorSchemes
    }
}
