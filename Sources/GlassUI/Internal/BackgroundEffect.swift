//
//  BackgroundEffect.swift
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

struct BackgroundEffect: UIViewRepresentable {
  let style: UIBlurEffect.Style
  let filterRegex: Regex<(Substring, Substring)>?

  init(style: UIBlurEffect.Style, filters: Set<Filter> = [.colorSaturate, .colorBrightness, .gaussianBlur]) {
    self.style = style
    self.filterRegex = try? Regex("(\(filters.map(\.rawValue).joined(separator: "|")))")
  }

  func makeUIView(context: Context) -> UIVisualEffectView {
    UIVisualEffectView(effect: UIBlurEffect(style: style))
  }

  func updateUIView(_ view: UIVisualEffectView, context: Context) {
    DispatchQueue.main.async {
      guard let layer = view.layer.sublayers?.first else {
        return
      }
      if let filterRegex {
        layer.filters = layer.filters?.filter {
          String(describing: $0).lowercased().contains(filterRegex)
        }
      } else {
        layer.filters = []
      }
    }
  }
}

// MARK: - BackgroundEffect.Filter

extension BackgroundEffect {
  enum Filter: String {
    case luminanceCurveMap = "luminance"
    case colorSaturate = "saturate"
    case colorBrightness = "brightness"
    case gaussianBlur = "blur"
  }
}

// MARK: - BlurEffect Preview

#if DEBUG

#Preview {
  Room {
    BackgroundEffect(style: .systemThickMaterial)
      .clipShape(RoundedRectangle(cornerRadius: 30))
      .frame(width: 300, height: 300)
  }
}

#endif
