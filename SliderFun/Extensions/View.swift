//
//  View.swift
//  SliderFun
//
//  Created by Biao Xie on 2/3/21.
//

import SwiftUI

extension View {
    var previewedInAllColorSchemes: some View {
        ForEach(ColorScheme.allCases, id: \.self, content: preferredColorScheme)
    }
}
