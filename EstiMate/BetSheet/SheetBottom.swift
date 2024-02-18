//
//  SheetBottom.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftUIX

struct SheetBottom: View {
    var body: some View {
        VStack {
            HStack(spacing: 12) {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.accent)
                    .font(.system(size: 32).weight(.bold))

                Group {
                    Text("New Bet ")
                        .foregroundStyle(.black)
                        .font(.system(size: 20).weight(.bold))
                    +
                    Text("(Long Press to Speak)")
                        .foregroundStyle(Color(hexadecimal: "808080"))
                        .font(.system(size: 14).weight(.bold))
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            .padding(.top, 40)

            Spacer()
        }
    }
}

#Preview {
    SheetBottom()
}
