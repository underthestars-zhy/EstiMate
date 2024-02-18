//
//  SheetContainer.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftUIX

struct SheetContainer: View {
    @State var status = SheetStatus.bottom

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            BeetSheet(status: $status)
                .offset(y: status == .bottom ? Screen.height * 0.7 - 147 : 0)
        }
        .maxWidth(.infinity)
        .background(Color.black.opacity(status == .bottom ? 0 : 0.2)
            .onTapGesture {
                if status == .input {
                    status = .bottom
                }
            })
        .animation(.easeInOut, value: status)
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    SheetContainer()
        .ignoresSafeArea(.all)
}
