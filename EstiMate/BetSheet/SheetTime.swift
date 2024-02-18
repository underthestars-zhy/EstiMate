//
//  SheetTime.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI

struct SheetTime: View {
    @State var createBet = CreateBet.shared
    @Binding var status: SheetStatus

    var body: some View {
        VStack(spacing: 30) {
            HStack(spacing: 10) {
                Image(systemName: "calendar.badge.clock")
                    .foregroundStyle(.accent)
                    .font(.system(size: 24).weight(.bold))

                Text("End Date")
                    .font(.system(size: 16).weight(.bold))
            }
            .opacity(0.8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.top, 20)

            DatePicker(
                "End Date",
                selection: $createBet.end,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding(.horizontal, 30)

            Button {
                status = .amount
            } label: {
                Text("Next")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, design: .rounded).weight(.bold))
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.accent)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
    }
}
