//
//  ContentView.swift
//  SliderFun
//
//  Created by Biao Xie on 2/3/21.
//

import SwiftUI

struct ContentView: View {
    @State var value: Double = 0

    var body: some View {
        SliderView(value: $value, range: -200...200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewedInAllColorSchemes
    }
}
