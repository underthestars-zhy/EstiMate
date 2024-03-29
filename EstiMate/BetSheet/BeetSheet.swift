//
//  BeetSheet.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftUIX

struct BeetSheet: View {
    @Binding var status: SheetStatus

    @Namespace var namespace

    var body: some View {
        VStack {
            switch status {
            case .bottom:
                Button {
                    status = .input
                    CreateBet.shared.reset()
                } label: {
                    SheetBottom(namespace: namespace)
                        .width(Screen.width + 4.0)
                        .height(Screen.height * 0.7)
                }
            case .input:
                SheetInput(namespace: namespace, status: $status)
                    .width(Screen.width + 4.0)
                    .height(Screen.height * 0.6)
            case .time:
                SheetTime(namespace: namespace, status: $status)
            case .amount:
                SheetAmount(namespace: namespace, status: $status)
            case .invite:
                SheetInvite(namespace: namespace, status: $status)
            case .receive(let betID):
                SheetRecieve(namespace: namespace, status: $status, betID: betID)
            case .side(bet: let bet):
                SheetSide(namespace: namespace, status: $status, bet: bet)
            case .vote(bet: let bet):
                SheetVote(namespace: namespace, status: $status, bet: bet)
            case .result(betR: let bR):
                SheatResult(namespace: namespace, status: $status, betResult: bR)
            }
        }
        .background(Color(hexadecimal: "FAFAFA"))
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .inset(by: 1)
                .stroke(Color(hexadecimal: "D9D9D9"), lineWidth: 2)
        )
        .compositingGroup()
        .shadow(
            color: Color(red: 0, green: 0, blue: 0, opacity: 0.07), radius: 20, x: 0, y: -4
        )
        .animation(.easeInOut, value: status)
        .padding(.horizontal, status.needPadding ? 20 : 0)
        .padding(.bottom, status.needPadding ? 40 : 0)
    }
}

#Preview {
    BeetSheet(status: .constant(.bottom))
}
