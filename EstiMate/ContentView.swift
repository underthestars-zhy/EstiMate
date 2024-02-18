//
//  ContentView.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftDate

struct ContentView: View {
    @State var allBets = AllBets.shared

    var body: some View {
        ScrollView {
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
        .onOpenURL { url in
            
        }
    }
}

#Preview {
    ContentView()
        .ignoresSafeArea()
}
