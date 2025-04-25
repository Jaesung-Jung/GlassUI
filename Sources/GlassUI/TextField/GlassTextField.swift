//
//  GlassTextField.swift
//  GlassUI
//
//  Created by 정재성 on 4/25/25.
//

import SwiftUI

public struct GlassTextField<Label: View>: View {
  @Environment(\.font) var font
  @Environment(\.glassTextFieldStyle) var textFieldStyle
  @FocusState var isFocused: Bool

  let label: Label
  let text: Binding<String>
  let textField: TextField<EmptyView>

  public var body: some View {
    textFieldStyle.makeBody(
      configuration: GlassTextFieldStyleConfiguration(
        label: GlassTextFieldStyleConfiguration.Label(label),
        textField: GlassTextFieldStyleConfiguration.Field(textField),
        text: text.wrappedValue,
        isFocused: isFocused
      )
    )
    .font(font ?? .body.weight(.medium))
    .focused($isFocused)
    .onTapGesture {
      isFocused = true
    }
  }
}

// MARK: - GlassTextField<Label> (Initializer)

extension GlassTextField {
  public init(text: Binding<String>, @ViewBuilder label: () -> Label) {
    self.label = label()
    self.text = text
    self.textField = TextField(text: text, prompt: nil, label: { EmptyView() })
  }

  public init(text: Binding<String>, axis: Axis, @ViewBuilder label: () -> Label) {
    self.label = label()
    self.text = text
    self.textField = TextField(text: text, prompt: nil, axis: axis, label: { EmptyView() })
  }

  public init<V>(value: Binding<V>, formatter: Formatter, @ViewBuilder label: () -> Label) {
    self.label = label()
    self.text = Binding(get: { formatter.string(for: value.wrappedValue) ?? "" }, set: { _ in })
    self.textField = TextField(value: value, formatter: formatter, prompt: nil, label: { EmptyView() })
  }

  public init<F: ParseableFormatStyle>(value: Binding<F.FormatInput>, format: F, @ViewBuilder label: () -> Label) where F.FormatOutput == String {
    self.label = label()
    self.text = Binding(get: { format.format(value.wrappedValue) }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }

  public init<F: ParseableFormatStyle>(value: Binding<F.FormatInput?>, format: F, @ViewBuilder label: () -> Label) where F.FormatOutput == String {
    let textFieldLabel = label()
    self.label = textFieldLabel
    self.text = Binding(get: { value.wrappedValue.map { format.format($0) } ?? "" }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }
}

// MARK: - GlassTextField<Text> (Initializer)

extension GlassTextField where Label == Text {
  public init(_ titleKey: LocalizedStringKey, text: Binding<String>) {
    self.label = Text(titleKey)
    self.text = text
    self.textField = TextField(text: text, prompt: nil, label: { EmptyView() })
  }

  public init<S: StringProtocol>(_ title: S, text: Binding<String>) {
    self.label = Text(title)
    self.text = text
    self.textField = TextField(text: text, prompt: nil, label: { EmptyView() })
  }

  public init(_ titleKey: LocalizedStringKey, text: Binding<String>, axis: Axis) {
    let textFieldLabel = Text(titleKey)
    self.label = textFieldLabel
    self.text = text
    self.textField = TextField(text: text, prompt: nil, axis: axis, label: { EmptyView() })
  }

  public init<S: StringProtocol>(_ title: S, text: Binding<String>, axis: Axis) {
    self.label = Text(title)
    self.text = text
    self.textField = TextField(text: text, prompt: nil, axis: axis, label: { EmptyView() })
  }

  public init<V>(_ titleKey: LocalizedStringKey, value: Binding<V>, formatter: Formatter) {
    self.label = Text(titleKey)
    self.text = Binding(get: { formatter.string(for: value.wrappedValue) ?? "" }, set: { _ in })
    self.textField = TextField(value: value, formatter: formatter, prompt: nil, label: { EmptyView() })
  }

  public init<S: StringProtocol, V>(_ title: S, value: Binding<V>, formatter: Formatter) {
    self.label = Text(title)
    self.text = Binding(get: { formatter.string(for: value.wrappedValue) ?? "" }, set: { _ in })
    self.textField = TextField(value: value, formatter: formatter, prompt: nil, label: { EmptyView() })
  }

  public init<F: ParseableFormatStyle>(_ titleKey: LocalizedStringKey, value: Binding<F.FormatInput>, format: F) where F.FormatOutput == String {
    self.label = Text(titleKey)
    self.text = Binding(get: { format.format(value.wrappedValue) }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }

  public init<F: ParseableFormatStyle>(_ titleKey: LocalizedStringKey, value: Binding<F.FormatInput?>, format: F) where F.FormatOutput == String {
    self.label = Text(titleKey)
    self.text = Binding(get: { value.wrappedValue.map { format.format($0) } ?? "" }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }

  public init<S: StringProtocol, F: ParseableFormatStyle>(_ title: S, value: Binding<F.FormatInput>, format: F) where F.FormatOutput == String {
    self.label = Text(title)
    self.text = Binding(get: { format.format(value.wrappedValue) }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
  }

  public init<S: StringProtocol, F: ParseableFormatStyle>(_ title: S, value: Binding<F.FormatInput?>, format: F) where F.FormatOutput == String {
    self.label = Text(title)
    self.text = Binding(get: { value.wrappedValue.map { format.format($0) } ?? "" }, set: { _ in })
    self.textField = TextField(value: value, format: format, prompt: nil, label: { EmptyView() })
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
      GlassTextField("Placeholder", text: $text)
        .glassTextFieldStyle(.pill)
        .padding(.horizontal, 20)

      GlassTextField("Placeholder", text: $text)
        .glassTextFieldStyle(.round)
        .padding(.horizontal, 20)
    }
  }
}

#endif
