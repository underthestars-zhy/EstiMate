//
//  Bet.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI

struct Bet: Identifiable {
    let id: UUID
    let title: String
    let emoji: String
    let start: Date
    let end: Date
    let amount: Double
    let status: BetStatus
}