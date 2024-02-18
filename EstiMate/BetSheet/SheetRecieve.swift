//
//  SheetRecieve.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI

struct SheetRecieve: View {
    @State var createBet = CreateBet.shared
    @Binding var status: SheetStatus
    let betID: String

    @State var bet: Bet? = nil

    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 10) {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.accent)
                    .font(.system(size: 24).weight(.bold))

                Text("Bet Invitation")
                    .font(.system(size: 16).weight(.bold))
            }
            .opacity(0.8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.top, 20)

            Group {
                if let bet {
                    VStack(alignment: .leading, spacing: 30) {
                        Text(bet.title)
                            .font(.system(size: 24).weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)

                        VStack(alignment: .leading, spacing: 20) {
                            HStack(spacing: 12) {
                                Image(systemName: "clock.badge")
                                    .font(.system(size: 18).weight(.bold))
                                    .foregroundStyle(.accent)
                                    .opacity(0.8)

                                Text("\(formatDateToMDD(bet.start)) -> \((formatDateToMDD(bet.end)))")
                                    .font(.system(size: 15).weight(.bold))
                                    .opacity(0.6)
                            }

                            HStack(spacing: 12) {
                                Image(systemName: "bitcoinsign.circle.fill")
                                    .font(.system(size: 18).weight(.bold))
                                    .foregroundStyle(.accent)
                                    .opacity(0.8)

                                Text("\(String(format: "%.1f", bet.amount)) Bet Coin")
                                    .font(.system(size: 15).weight(.bold))
                                    .opacity(0.6)
                            }
                        }
                    }
                    .padding(.horizontal, 30)
                } else {
                    Text("Loading...")
                        .font(.system(size: 24).weight(.bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                }
            }
            .padding(.bottom, 30)

            Button {
                if let bet {
                    Task {
                        if try await WebAPI.joinBet(bet: bet) {
                            status = .side(bet: bet)
                        }
                    }
                }
            } label: {
                Text("Join")
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
        .task {
            do {
                bet = try await WebAPI.getBet(by: betID)
            } catch {
                print(error)
            }
        }
    }

    func formatDateToMDD(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd"
        return dateFormatter.string(from: date)
    }
}
