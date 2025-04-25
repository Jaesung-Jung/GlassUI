//
//  GlassTextFieldStyleContent.swift
//
//  Copyright © 2025 Jaesung Jung. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SwiftUI

struct GlassTextFieldStyleContent: View {
  @Environment(\.isEnabled) var isEnabled

  let configuration: GlassTextFieldStyle.Configuration
  let cornerRadius: CGFloat
  let padding: EdgeInsets

  var body: some View {
    ZStack(alignment: .leading) {
      configuration.label
        .foregroundStyle(.white.opacity(isEnabled ? 0.4 : 0.2))
        .lineLimit(1)
        .opacity(configuration.text.isEmpty ? 1 : 0)

      configuration.textField
        .foregroundStyle(.white)
    }
    .padding(padding)
    .background {
      if isEnabled {
        RecessedRectangle(cornerRadius: cornerRadius)
      } else {
        Rectangle().fill(.glassRegular)
      }
    }
    .background {
      Rectangle()
        .fill(.glassThin)
        .blur(radius: 15)
        .opacity(configuration.isFocused ? 1 : 0)
        .animation(.smooth, value: configuration.isFocused)
    }
    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
  }
}

// MARK: - GlassTextField Preview

#if DEBUG

@available(iOS 17.0, *)
#Preview {
  @Previewable @State var text: String = ""
  Room {
    GlassPlatter(cornerRadius: 30)
      .frame(width: 300, height: 300)
      .layoutPriority(1)

    VStack(spacing: 40) {
      GlassTextField("Pill Style", text: $text)
        .glassTextFieldStyle(.pill)
        .padding(.horizontal, 20)

      GlassTextField("Round Style", text: $text)
        .glassTextFieldStyle(.round)
        .padding(.horizontal, 20)
    }
  }
}

#endif
