//
//  SheetContainer.swift
//  EstiMate
//
//  Created by 朱浩宇 on 2024/2/17.
//

import SwiftUI
import SwiftUIX

struct SheetContainer: View {
    @State var statusPublisher = SheetStatusPublisher.shared

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            BeetSheet(status: $statusPublisher.status)
                .offset(y: statusPublisher.status == .bottom ? Screen.height * 0.7 - 147 : 0)
        }
        .maxWidth(.infinity)
        .background(Color.black.opacity(statusPublisher.status == .bottom ? 0 : 0.2)
            .onTapGesture {
                if statusPublisher.status == .input {
                    statusPublisher.status = .bottom
                }

                if case .receive(_) = statusPublisher.status {
                    statusPublisher.status = .bottom
                }

                if case .vote(_) = statusPublisher.status {
                    statusPublisher.status = .bottom
                }
            })
        .animation(.easeInOut, value: statusPublisher.status)
        .ignoresSafeArea(.keyboard)
        .onOpenURL { url in
            switch url.host {
            case "bet":
                let betID = url.pathComponents[1]
                statusPublisher.status = .receive(betID: betID)
            default: print(url.host ?? "Wrong")
            }
        }
    }
}

#Preview {
    SheetContainer()
        .ignoresSafeArea(.all)
}

@Observable
class SheetStatusPublisher {
    static let shared = SheetStatusPublisher()

    var status = SheetStatus.bottom
}
