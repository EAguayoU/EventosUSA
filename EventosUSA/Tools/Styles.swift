//
//  Styles.swift
//  Nice
//
//  Created by Erik Aguayo on 01/04/24.
//

import Foundation
import SwiftUI


struct btnCancelar : ViewModifier {
    func body(content: Content) -> some View {
        content
           
            .background(.red)
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}

struct btnAzulOscuro : ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .background(Color(hex: "#234174"))
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}
struct btnAzulClaro : ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .background(Color(hex: "#94C1E8"))
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}
struct btnGrisOscuro : ViewModifier {
    func body(content: Content) -> some View {
        content
            
            .background(Color(hex: "#272727"))
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}

struct btnColor : ViewModifier {
     var cColor : Color
    func body(content: Content) -> some View {
        content
           
            .background(cColor)
            .foregroundColor(Color.white)
            .cornerRadius(20)
    }
}
