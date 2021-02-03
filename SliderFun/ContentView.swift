//
//  ContentView.swift
//  SliderFun
//
//  Created by Biao Xie on 2/3/21.
//

import SwiftUI

struct ContentView: View {
    @State var value: Double = 0.5

    var body: some View {
        VStack(spacing: 0) {
            Color.accentColor.adjust(by: CGFloat(value - 0.5))

            SliderView(value: $value, range: 0...1)
        }.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewedInAllColorSchemes
    }
}
