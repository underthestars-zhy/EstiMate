//
//  BetItem.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftDate

struct BetItem: View {
    let bet: Bet

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            BetIndicator(bet: bet)

            VStack(alignment: .leading, spacing: 20) {
                Text(bet.title)
                    .font(.system(size: 18).weight(.bold))

                HStack(spacing: 12) {
                    Image(systemName: "clock.badge")
                        .font(.system(size: 18).weight(.bold))
                        .foregroundStyle(.accent)
                        .opacity(0.8)

                    Text("\(formatDateToMDD(bet.start)) -> \((formatDateToMDD(bet.end)))")
                        .font(.system(size: 15).weight(.bold))
                        .opacity(0.6)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 8)
        }
    }

    func formatDateToMDD(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M/dd"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    BetItem(bet: .init(id: UUID(), title: "Daniel will find a girlfriend in one week", emoji: "😘", start: Date() - 10.days, end: Date() + 6.days, amount: 10, status: .inProgress))
        .padding(.horizontal, 30)
}
