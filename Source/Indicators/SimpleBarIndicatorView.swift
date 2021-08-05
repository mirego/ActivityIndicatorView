//
//  SimpleBarIndicatorView.swift
//  ActivityIndicatorView
//
//  Created by Robert Hahn on 21/4/21.
//

import SwiftUI

struct SimpleBarIndicatorView: View {
    @State private var offsetPercentage: CGFloat = 0.0

    var backgroundColor: Color {
        #if os(iOS) || os(watchOS) || os(tvOS)
        return Color.black.opacity(0.2)
        #elseif os(macOS)
        return Color(NSColor.controlBackgroundColor)
        #endif
    }

    var body: some View {
        let animation = Animation
            .linear(duration: 1)
            .repeatForever(autoreverses: false)

        return GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(backgroundColor)
                Rectangle()
                    .frame(width: barWidth(fullWidth: geometry.size.width), height: geometry.size.height)
                    .cornerRadius(geometry.size.height / 2)
                    .offset(x: geometry.size.width * offsetPercentage, y: 0)
                    .onAppear(perform: {
                        offsetPercentage = 0
                        withAnimation(animation) {
                            offsetPercentage = 1
                        }
                    })
            }
            .cornerRadius(geometry.size.height / 2)
        }
    }

    private func barWidth(fullWidth: CGFloat) -> CGFloat {
        fullWidth * 0.15 * (1 + offsetPercentage * 3 / 4)
    }
}
