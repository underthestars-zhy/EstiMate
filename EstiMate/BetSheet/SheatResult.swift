//
//  SheatResult.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/18.
//

import SwiftUI

struct SheatResult: View {
    @State var createBet = CreateBet.shared
    @Binding var status: SheetStatus

    let betResult: BetResult

    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 10) {
                Image(systemName: "lasso.and.sparkles")
                    .foregroundStyle(.accent)
                    .font(.system(size: 24).weight(.bold))

                Text("Result")
                    .font(.system(size: 16).weight(.bold))
            }
            .opacity(0.8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.top, 20)

            HStack {
                Group {
                    Text("You ").foregroundStyle(.black).font(.system(size: 24).weight(.bold)) +
                    Text((betResult.change - betResult.bet.amount) > 0 ? "won " : "lost ").foregroundStyle(.accent).font(.system(size: 24).weight(.bold)) +
                    Text("\(String(format: "%.1f", betResult.change))").foregroundStyle(.black).font(.system(size: 24).weight(.bold)) +
                    Text("\(Image(systemName: "bitcoinsign.circle.fill"))").foregroundStyle(.black).font(.system(size: 16).weight(.bold)) +
                    Text(" on:\n").foregroundStyle(.black).font(.system(size: 24).weight(.bold)) +
                    Text(betResult.bet.title).foregroundStyle(Color(hexadecimal: "4D4D4D")).font(.system(size: 24).weight(.bold))
                }

                Spacer()
            }
            .padding(.horizontal, 30)

            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 12) {
                    Image(systemName: "smallcircle.filled.circle")
                        .font(.system(size: 18).weight(.bold))
                        .foregroundStyle(.accent)
                        .opacity(0.8)

                    Text("Your Side: \(betResult.userSide ? "Yes" : "No")")
                        .font(.system(size: 15).weight(.bold))
                        .opacity(0.6)

                    Spacer()
                }

                HStack(spacing: 12) {
                    Image(systemName: "smallcircle.circle.fill")
                        .font(.system(size: 18).weight(.bold))
                        .foregroundStyle(.accent)
                        .opacity(0.8)

                    Text("Vote Side: \(betResult.voteSide ? "Yes" : "No")")
                        .font(.system(size: 15).weight(.bold))
                        .opacity(0.6)

                    Spacer()
                }

                HStack(spacing: 12) {
                    Image(systemName: "creditcard")
                        .font(.system(size: 18).weight(.bold))
                        .foregroundStyle(.accent)
                        .opacity(0.8)

                    Text("Your Wallet: \(String(format: "%.1f", betResult.balance)) coins")
                        .font(.system(size: 15).weight(.bold))
                        .opacity(0.6)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 30)
            .padding(.top, 20)
            .padding(.horizontal, 30)

            Button {
                status = .bottom
            } label: {
                Text("Done")
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
