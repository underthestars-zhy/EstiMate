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
        var bets = try await WebAPI.fetchAllBets().sorted { b1, b2 in
            b1.end > b2.end
        }

        let voted = try await WebAPI.voted()

        for (i, bet) in bets.enumerated() {
            if voted.contains(bet.id.uuidString) {
                bets[i].status = .voted
            }
        }

        self.bets = bets
    }

    func getBet(by id: String) -> Bet? {
        bets.first { bet in
            bet.id.uuidString == id
        }
    }

    func setVoted(id: UUID) {
        var bet = bets.remove(at: bets.firstIndex(where: { b in
            b.id == id
        })!)

        bet.status = .voted

        bets.append(bet)

        bets = bets.sorted { b1, b2 in
            b1.end > b2.end
        }
    }
}
