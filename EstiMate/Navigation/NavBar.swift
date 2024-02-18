//
//  NavBar.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftUIX
import VisualEffectView

struct NavBar: View {
    @State var betCoins: Double = 100

    var body: some View {
        VStack {
            HStack {
                Group {
                    Text("All ").foregroundStyle(.black) + Text("Bets").foregroundStyle(.accent)
                }
                .font(Font.system(size: 32, design: .rounded).weight(.bold))
                .padding(.leading, 35)

                Spacer()

                HStack(spacing: 10) {
                    Image(systemName: "bitcoinsign.circle.fill")
                        .font(Font.system(size: 20).weight(.semibold))
                        .opacity(0.5)
                        .padding(.leading, 12)

                    Text(String(format: "%.1f", betCoins))
                        .font(Font.system(size: 14, design: .rounded).weight(.bold))
                        .opacity(0.6)
                        .padding(.trailing, 16)
                }
                .height(38)
                .background(Color(hexadecimal: "F4F4F4"))
                .cornerRadius(19)
                .padding(.trailing, 35)
            }
            .padding(.top, 80)

            Spacer()
        }
        .frame(height: 138)
        .frame(maxWidth: .infinity)
        .background(VisualEffect(colorTint: .white, colorTintAlpha: 0.8, blurRadius: 20))
    }
}

#Preview {
    ZStack {
        Rectangle()
            .foregroundStyle(.red)

        NavBar()
    }
}
