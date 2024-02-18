//
//  CreateBet.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import Foundation

@Observable
class CreateBet {
    static let shared = CreateBet()

    var title = ""
    var emoji = ""
    var end = Date()
    var amount = 10

    func reset() {
        title = ""
        emoji = ""
        end = Date()
        amount = 10
    }

    func createBet() -> Bet {
        Bet(id: UUID(), title: title, emoji: emoji, start: Date(), end: end, amount: Double(amount), status: .inProgress)
    }
}
