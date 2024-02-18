//
//  BetResult.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/18.
//

import Foundation

struct BetResult: Equatable {
    let betID: String
    let change: Double
    let userSide: Bool
    let voteSide: Bool
    let balance: Double

    var bet: Bet {
        AllBets.shared.getBet(by: betID)!
    }
}
