//
//  SheetInput.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI

struct SheetInput: View {
    let namespace: Namespace.ID
    @State var createBet = CreateBet.shared
    @Binding var status: SheetStatus

    @FocusState var focus: Bool

    var body: some View {
        VStack(spacing: 25) {
            HStack(spacing: 10) {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(.accent)
                    .font(.system(size: 24).weight(.bold))

                Text("New Bet")
                    .font(.system(size: 16).weight(.bold))
            }
            .matchedGeometryEffect(id: "indicator", in: namespace)
            .opacity(0.8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.top, 20)

            TextField("Your Bet", text: $createBet.title)
                .focused($focus)
                .padding(.horizontal, 30)
                .font(.system(size: 24).weight(.bold))
                .lineLimit(3)
                .submitLabel(.next)
                .onSubmit {
                    status = .time

                    Task.detached {
                        let emoji = try await WebAPI.generateEmoji(sentence: CreateBet.shared.title)
                        CreateBet.shared.emoji = emoji
                        print("Emoji: \(emoji)")
                    }
                }
                .onAppear {
                    focus = true
                }

            Spacer()
        }
    }
}
