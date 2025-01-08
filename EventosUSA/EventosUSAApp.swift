//
//  EventosUSAApp.swift
//  EventosUSA
//
//  Created by Erik Aguayo on 08/01/25.
//

import SwiftUI

@main
struct EventosUSAApp: App {
    var body: some Scene {
        WindowGroup {
            vw_dbo_Start(path: .init())
                .preferredColorScheme(.light)
        }
    }
}
