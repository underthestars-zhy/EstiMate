//
//  SheetStatus.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import Foundation
import SwiftUI
import SwiftUIX

enum SheetStatus: Equatable {
    case bottom
    case input
    case time
    case amount
    case invite
    case receive(betID: String)
    case side(bet: Bet)
    case vote(bet: Bet)
    case result(betR: BetResult)

    var needPadding: Bool {
        switch self {
        case .bottom, .input: false
        default: true
        }
    }
}
