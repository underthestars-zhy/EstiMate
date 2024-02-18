//
//  AllBets.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import Foundation
import SwiftDate

@Observable class AllBets {
    static let shared = AllBets()

    var bets = [Bet]()
    var recentAddBetID: UUID? = nil

    init() {
        bets.append(.init(id: UUID(), title: "Daniel will find a girlfriend in one week", emoji: "😘", start: Date() - 10.days, end: Date() + 6.days, amount: 10, status: .inProgress))

        bets.append(.init(id: UUID(), title: "Daniel will find a girlfriend in one week", emoji: "😘", start: Date() - 10.days, end: Date() + 6.days, amount: 10, status: .voted))

        bets.append(.init(id: UUID(), title: "Daniel will find a girlfriend in one week", emoji: "😘", start: Date() - 10.days, end: Date() + 6.days, amount: 10, status: .done))
    }

    func add(bet: Bet) {
        bets.append(bet)
        recentAddBetID = bet.id

        bets = bets.sorted { b1, b2 in
            b1.end > b2.end
        }
    }
}
