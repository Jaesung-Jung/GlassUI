//
//  RecessedPlatter.swift
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

/// A recessed-style visual platter with customizable corner radius.
///
/// `RecessedPlatter` creates a inset appearance using blended overlays
/// and soft strokes, simulating a sunken surface.
public struct RecessedPlatter: View {
  let cornerRadius: CGFloat

  /// Creates a `RecessedPlatter` with the specified corner radius.
  ///
  /// - Parameter cornerRadius: The radius applied to the platter's rounded corners. Defaults to `0`.
  public init(cornerRadius: CGFloat = 0) {
    self.cornerRadius = cornerRadius
  }

  public var body: some View {
    Rectangle()
      .fill(Color(white: 0.0, opacity: 0.1))
      .blendMode(.plusDarker)
      .overlay {
        GeometryReader { proxy in
          Path {
            $0.addRoundedRect(
              in: proxy.frame(in: .local)
                .insetBy(dx: 0, dy: 0)
                .offsetBy(dx: 1, dy: 1.5),
              cornerSize: CGSize(width: cornerRadius, height: cornerRadius),
              style: .circular
            )
          }
          .stroke(.black.opacity(0.08), lineWidth: 3)
          .blur(radius: 2)
          .blendMode(.plusDarker)

          Path {
            $0.addRoundedRect(
              in: proxy.frame(in: .local)
                .insetBy(dx: 0, dy: 0)
                .offsetBy(dx: 0, dy: -0.5),
              cornerSize: CGSize(width: cornerRadius, height: cornerRadius),
              style: .circular
            )
          }
          .stroke(.white.opacity(0.3), lineWidth: 1.5)
          .blur(radius: 1)
          .blendMode(.plusLighter)
        }
      }
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .circular))
  }
}

// MARK: - RecessedPlatter Preview

#if DEBUG

#Preview {
  Room {
    GlassPlatter(cornerRadius: 30)
      .frame(width: 300, height: 300)
      .overlay {
        VStack {
          RecessedPlatter(cornerRadius: 25)
            .frame(height: 50)
            .padding(.horizontal, 10)
        }
      }
  }
}

#endif
