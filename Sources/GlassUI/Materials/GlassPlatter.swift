//
//  GlassPlatter.swift
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

/// A glass-like visual effect view with customizable corner radius and style.
///
/// `GlassPlatter` provides a translucent, frosted glass appearance using a system material background,
/// semi-transparent overlay, and gradient border. This view is ideal for creating modern, visionOS-inspired UI elements.
public struct GlassPlatter: View {
  let cornerRadius: CGFloat
  let cornerStyle: RoundedCornerStyle

  /// Creates a `GlassPlatter` view with the specified corner radius and style.
  ///
  /// - Parameters:
  ///   - cornerRadius: The radius applied to the rounded corners of the view.
  ///   - style: The style of the rounded corners. Defaults to `.continuous`.
  public init(cornerRadius: CGFloat, style: RoundedCornerStyle = .continuous) {
    self.cornerRadius = cornerRadius
    self.cornerStyle = style
  }

  public var body: some View {
    BackgroundEffect(style: .systemThickMaterial)
      .overlay {
        Rectangle()
          .fill(Color(white: 0.584, opacity: 0.25))
      }
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: cornerStyle))
      .overlay {
        RoundedRectangle(cornerRadius: cornerRadius, style: cornerStyle)
          .strokeBorder(
            .linearGradient(
              stops: [
                Gradient.Stop(color: .white.opacity(0.3), location: 0.00),
                Gradient.Stop(color: .white.opacity(0.0), location: 0.41),
                Gradient.Stop(color: .white.opacity(0.0), location: 0.57),
                Gradient.Stop(color: .white.opacity(0.1), location: 1.00)
              ],
              startPoint: UnitPoint(x: 0.11, y: 0.06),
              endPoint: UnitPoint(x: 0.83, y: 0.78)
            ),
            lineWidth: 1
          )
      }
  }
}

// MARK: - GlassPlatter Preview

#if DEBUG

#Preview {
  Room {
    GlassPlatter(cornerRadius: 30)
      .frame(width: 300, height: 300)
  }
}

#endif
