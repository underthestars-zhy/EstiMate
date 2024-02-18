//
//  BetIndicator.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftDate

struct BetIndicator: View {
    let bet: Bet

    var body: some View {
        Group {
            switch bet.status {
            case .inProgress:
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(Color(hexadecimal: "F4F4F4"))
                    .overlay {
                        VStack {
                            Spacer()
                                .frame(minHeight: 0)

                            Rectangle()
                                .frame(width: 60, height: calculatePercentageOfToday(start: bet.start, end: bet.end, today: Date()) * 60)
                                .foregroundStyle(.accent)

                        }
                        .clipShape(Circle())
                    }
            case .voted:
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(Color(hexadecimal: "FFC2E3"))
                    .overlay(
                        Circle()
                            .inset(by: 2)
                            .stroke(Color(red: 1, green: 0.36, blue: 0.71), lineWidth: 4)
                    )
            case .done:
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(Color(hexadecimal: "FFC2E3"))
            case .canceled:
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(Color(hexadecimal: "FFC2E3"))
            }
        }
        .overlay {
            Text(bet.emoji)
                .font(Font.system(size: 28).weight(.bold))
        }
    }

    func calculatePercentageOfToday(start: Date, end: Date, today: Date) -> Double {

        let calendar = Calendar.current

        // Calculate the total number of days in the range
        let totalDays = calendar.dateComponents([.day], from: start, to: end).day! + 1
        // Calculate the number of days from start to today
        let daysUntilToday = calendar.dateComponents([.day], from: start, to: today).day! + 1

        // Calculate the percentage
        let percentage = (Double(daysUntilToday) / Double(totalDays))

        return percentage
    }
}
