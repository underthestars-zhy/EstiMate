//
//  GuideItem.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftUIX

struct GuideItem: View {
    let title: String
    let color: String
    let image: String
    let text: String

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(Color(hexadecimal: color))
                    .frame(width: 40, height: 40)
                    .overlay {
                        Image(systemName: image)
                            .font(Font.system(size: 16).weight(.bold))
                            .foregroundStyle(.white)
                            .opacity(0.8)
                    }

                Text(title)
                    .font(Font.system(size: 18).weight(.bold))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 25)
            .padding(.top, 20)

            Text(text)
                .font(Font.system(size: 14).weight(.medium))
                .foregroundStyle(Color(hexadecimal: "4D4D4D"))
                .padding(.bottom, 20)
                .padding(.horizontal, 25)
        }
        .background(Color(red: 0.99, green: 0.99, blue: 0.99))
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .inset(by: 0.5)
                .stroke(Color(red: 0.90, green: 0.90, blue: 0.90), lineWidth: 1)
        )
        .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.10), radius: 20
        )
        .padding(.horizontal, 30)
    }
}

#Preview {
    GuideItem(title: "Friends Fueled Fun", color: "46D123", image: "digitalcrown.horizontal.arrow.counterclockwise.fill", text: "Bring your friends together and place your bets on everyday occurrences, from weather to campus events. Just bring your phones close to confirm your guesses and let the fun begin!")
}
