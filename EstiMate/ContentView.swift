//
//  ContentView.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftDate
import SwiftUIPullToRefresh

struct ContentView: View {
    @State var allBets = AllBets.shared

    var body: some View {
        RefreshableScrollView { done in
            Task {
                try await allBets.refresh()
                done()
            }
        } progress: { state in
            ProgressView().progressViewStyle(.circular)
                .controlSize(.large)
                .padding(.top, 148)
        } content: {
            VStack(spacing: 40) {
                ForEach(allBets.bets) { bet in
                    BetItem(bet: bet)
                        .padding(.horizontal, 30)
                }
            }
            .padding(.top, 168)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            VStack {
                NavBar()

                Spacer()
            }
        }
        .overlay {
            SheetContainer()
        }
        .task {
            do {
                try await allBets.refresh()
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    ContentView()
        .ignoresSafeArea()
}
