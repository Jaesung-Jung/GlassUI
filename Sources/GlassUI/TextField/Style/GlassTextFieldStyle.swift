//
//  GlassTextFieldStyle.swift
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

// MARK: - GlassTextFieldStyle

@MainActor
public protocol GlassTextFieldStyle {
  associatedtype Body: View
  typealias Configuration = GlassTextFieldStyleConfiguration

  @ViewBuilder @MainActor func makeBody(configuration: Configuration) -> Body
}

// MARK: - GlassTextFieldStyle Modifier

extension View {
  public func glassTextFieldStyle<S: GlassTextFieldStyle>(_ style: S) -> some View {
    environment(\.glassTextFieldStyle, AnyGlassTextFieldStyle(style))
  }
}

// MARK: - GlassTextFieldStyle Environment

struct GlassTextFieldStyleKey: @preconcurrency EnvironmentKey {
  @MainActor static var defaultValue: AnyGlassTextFieldStyle { AnyGlassTextFieldStyle(PillGlassTextFieldStyle()) }
}

extension EnvironmentValues {
  var glassTextFieldStyle: AnyGlassTextFieldStyle {
    get { self[GlassTextFieldStyleKey.self] }
    set { self[GlassTextFieldStyleKey.self] = newValue }
  }
}
