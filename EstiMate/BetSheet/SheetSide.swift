//
//  SheetSide.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI

struct SheetSide: View {
    @State var createBet = CreateBet.shared
    @Binding var status: SheetStatus

    @State var betCoins: Double = 100

    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 10) {
                Image(systemName: "bitcoinsign.circle.fill")
                    .foregroundStyle(.accent)
                    .font(.system(size: 24).weight(.bold))

                Text("Amount")
                    .font(.system(size: 16).weight(.bold))
            }
            .opacity(0.8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.top, 20)

            HStack(spacing: 30) {
                Button {
                    createBet.amount -= 1
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.system(size: 22).weight(.bold))
                }
                .foregroundStyle(createBet.amount > 1 ? .accent : Color(hexadecimal: "FFC2E3"))
                .disabled(createBet.amount <= 1)

                Text("\(createBet.amount)")
                    .font(.system(size: 64, design: .rounded).weight(.bold))

                Button {
                    createBet.amount += 1
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 22).weight(.bold))
                }
                .foregroundStyle(createBet.amount < Int(betCoins) ? .accent : Color(hexadecimal: "FFC2E3"))
                .disabled(createBet.amount >= Int(betCoins))
            }

            Button {
                //                status = .amount
            } label: {
                Text("Submit")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, design: .rounded).weight(.bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.accent)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
    }
}
