//
//  SheetVote.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI

struct SheetVote: View {
    @AppStorage("betCoins") var betCoins: Double = 100

    @State var createBet = CreateBet.shared
    @Binding var status: SheetStatus
    let bet: Bet

    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 10) {
                Image(systemName: "smallcircle.circle.fill")
                    .foregroundStyle(.accent)
                    .font(.system(size: 24).weight(.bold))

                Text("Vote")
                    .font(.system(size: 16).weight(.bold))
            }
            .opacity(0.8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.top, 20)

            Text(bet.title)
                .font(.system(size: 24).weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.bottom, 30)

            VStack(spacing: 20) {
                Button {
                    Task {
                        if try await WebAPI.vote(betID: bet.id.uuidString, side: true) {
                            status = .bottom
                            AllBets.shared.setVoted(id: bet.id)
                        }
                    }
                } label: {
                    Text("YES")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, design: .rounded).weight(.bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.accent)
                        .cornerRadius(25)
                }

                Button {
                    Task {
                        if try await WebAPI.vote(betID: bet.id.uuidString, side: false) {
                            status = .bottom
                            AllBets.shared.setVoted(id: bet.id)
                        }
                    }
                } label: {
                    Text("NO")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, design: .rounded).weight(.bold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(hexadecimal: "5D81FF"))
                        .cornerRadius(25)
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
    }

    func formatDateToMDD(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd"
        return dateFormatter.string(from: date)
    }
}
