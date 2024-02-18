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
        Button {
            if areDatesOnSameDay(date1: bet.end, date2: Date()) {
                SheetStatusPublisher.shared.status = .vote(bet: bet)
            }
        } label: {
            HStack(alignment: .top, spacing: 16) {
                BetIndicator(bet: bet)

                VStack(alignment: .leading, spacing: 20) {
                    Text(bet.title)
                        .foregroundStyle(.black)
                        .font(.system(size: 18).weight(.bold))
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    HStack(spacing: 12) {
                        Image(systemName: "clock.badge")
                            .font(.system(size: 18).weight(.bold))
                            .foregroundStyle(.accent)
                            .opacity(0.8)

                        Text("\(formatDateToMDD(bet.start)) -> \((formatDateToMDD(bet.end)))")
                            .foregroundStyle(.black)
                            .font(.system(size: 15).weight(.bold))
                            .opacity(0.6)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 8)
            }
        }
        .disabled(!areDatesOnSameDay(date1: bet.end, date2: Date()))
    }

    func areDatesOnSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current

        // Extract year, month, and day components for both dates
        let date1Components = calendar.dateComponents([.year, .month, .day], from: date1)
        let date2Components = calendar.dateComponents([.year, .month, .day], from: date2)

        // Compare the year, month, and day components
        return date1Components.year == date2Components.year &&
        date1Components.month == date2Components.month &&
        date1Components.day == date2Components.day
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
