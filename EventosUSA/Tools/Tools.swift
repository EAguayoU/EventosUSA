//
//  Tools.swift
//
//
//  Created by Guillermo Alvarez on 08/02/24.
//

import Foundation
import SwiftUI
import WebKit

extension Color {
    init(hex: String){
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
        
    }
}

extension URLSession {
    
    func syncRequest(request: URLRequest) -> (data: Data?, response: URLResponse?, error: Error?){
        
        let semaphore = DispatchSemaphore(value: 0)
        var data: Data?
        var response : URLResponse?
        var error : Error?
        
        let task = self.dataTask(with: request){
            data = $0
            response = $1
            error = $2
            semaphore.signal()
        }
        
        task.resume()
        semaphore.wait()
        
        return (data,response,error)
    }
}



struct HourGlass: UIViewRepresentable{
    private let name: String
    init(_ name: String) {
        self.name = name
    }
    func makeUIView(context: Context) -> WKWebView{
        let webView = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        
        webView.load(
            data,
            mimeType: "image/gif",
            characterEncodingName: "UTF-8",
            baseURL: url.deletingLastPathComponent())
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct CheckboxToggleStyle: ToggleStyle {
 
    func makeBody(configuration: Self.Configuration) -> some View {
 
        return HStack {
 
            configuration.label
 
            Spacer()
 
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(configuration.isOn ? Color(hex: "#002D57") : .gray)
                .font(.system(size: 18, weight: .bold, design: .serif))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
 
    }
}
struct SymbolToggleStyle: ToggleStyle {
 
    var systemImage: String = "checkmark"
    var activeColor: Color = .green
 
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
 
            Spacer()
 
            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? activeColor : Color(.systemGray5))
                .overlay {
                    Circle()
                        .fill(.white)
                        .padding(3)
                        .overlay {
                            Image(systemName: systemImage)
                                .foregroundColor(configuration.isOn ? activeColor : Color(.systemGray5))
                        }
                        .offset(x: configuration.isOn ? 10 : -10)
 
                }
                .frame(width: 50, height: 32)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
struct MiniToggleStyle: ToggleStyle {
 
    
    var activeColor: Color = Color(hex: "#002D57")
 
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
 
            Spacer()
 
            RoundedRectangle(cornerRadius: 30)
                .fill(configuration.isOn ? activeColor : Color(.systemGray5))
                .overlay {
                    Circle()
                        .fill(.white)
                        .padding(3)
                        .offset(x: configuration.isOn ? 10 : -10)
 
                }
                .frame(width: 50, height: 25)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}



