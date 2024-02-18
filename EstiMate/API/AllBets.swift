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

    init() {}

    func add(bet: Bet) {
        if bets.map(\.id).contains(bet.id) { return }

        bets.append(bet)
        recentAddBetID = bet.id

        bets = bets.sorted { b1, b2 in
            b1.end > b2.end
        }
    }

    func refresh() async throws {
        bets = try await WebAPI.fetchAllBets().sorted { b1, b2 in
            b1.end > b2.end
        }

    }

    func getBet(by id: String) -> Bet? {
        bets.first { bet in
            bet.id.uuidString == id
        }
    }
}
