//
//  vw_dbo_LoadingView.swift
//  NESGoIOS
//
//  Created by Erik Aguayo on 13/03/24.
//

import SwiftUI

struct vw_tls_LoadingView: View {
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.75)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ProgressView()
                Text("Cargando...")
            }
            .background {
                RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: 200, height: 200)
            }
            .offset(y: -70)
        }
    }
}

#Preview {
    vw_tls_LoadingView()
}
