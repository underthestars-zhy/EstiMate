//
//  MeasureSize.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftUIX

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = Screen.size

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct MeasureSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self,
                                   value: geometry.frame(in: .local).size)
        })
    }
}

extension View {
    func measureSize(perform action: @escaping (CGSize) -> Void) -> some View {
        modifier(MeasureSizeModifier())
            .onPreferenceChange(SizePreferenceKey.self, perform: action)
    }
}
