//
//  vw_dbo_Validation.swift
//  EventosUSA
//
//  Created by Erik Aguayo on 06/01/25.
//
import CodeScanner
import Foundation
import SwiftUI

struct vw_dbo_Validation: View {
    @Binding var path: NavigationPath
    @State var bShowLoading: Bool = false
    @State private var bShowScanner: Bool = false
    @State private var cColorScan: Color = Color.black
    @State private var cColorOrder: Color = Color.black
    @State private var sScannedCode: String = ""
    private let pasteboard = UIPasteboard.general
    var scannerSheet: some View {
        CodeScannerView(codeTypes:[.qr],
                        completion: {result in
            if case let .success(code) = result {
                self.sScannedCode = code.string
                self.bShowScanner = false
                bShowLoading = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    objTicketValidation.getEventTicket(objEventTicket: stEventTicketRequest(TicketNumber: self.sScannedCode))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        if(objTicketValidation.EventTicketResult.success){
                            if(!(objTicketValidation.EventTicketResult.data.first?.IsChecked)!){
                                objTicketChecked.getEventTicketChecked(objEventTicketChecked: stEventTicketCheckedRequest(EventTicketInConsignmentID: (objTicketValidation.EventTicketResult.data.first?.EventTicketInConsignmentID)!))
                            }
                        }
                        bShowLoading = false
                    }
                }
            }
        }
        )
    }
    @ObservedObject var objTicketValidation = clEventTicket(WindowName: "vw_dbo_Validation")
    @ObservedObject var objTicketChecked = clEventTicketChecked(WindowName: "vw_dbo_Validation")
    var body: some View {
        ZStack{
            VStack(alignment: .center, spacing: 17){
                if(objTicketValidation.EventTicketResult.success){
                    if(!(objTicketValidation.EventTicketResult.data.first?.IsChecked)!){
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .foregroundStyle(Color.green)
                     }
                    else{
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150)
                            .foregroundStyle(Color.red)
                     }
                    Text(sScannedCode)
                        .font(.callout)
                        .padding(.vertical,20)
                        .foregroundStyle(cColorScan)
                        .onTapGesture {
                            cColorScan = Color(hex: "#234174")
                            pasteboard.string = self.sScannedCode
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                cColorScan = Color.black
                            }
                        }
                    Text("Order Number")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top,30)
                    Text((objTicketValidation.EventTicketResult.data.first?.OrderNumber)!)
                        .padding(.bottom,10)
                        .foregroundStyle(cColorOrder)
                        .onTapGesture {
                            cColorOrder = Color(hex: "#234174")
                            pasteboard.string = (objTicketValidation.EventTicketResult.data.first?.OrderNumber)!
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                cColorOrder = Color.black
                            }
                        }
                    HStack{
                        Text("V.Date")
                            .frame(width: 100,alignment: .leading)
                        Text(objTicketValidation.EventTicketResult.data.first?.CheckedDate ?? "Sin Fecha")
                            .frame(width: 220,alignment: .leading)
                        
                    }
                    HStack{
                        Text("EIN")
                            .frame(width: 100,alignment: .leading)
                        
                        Text(("\(objTicketValidation.EventTicketResult.data.first?.CustomerID ?? 0)"))
                            .frame(width: 220,alignment: .leading)
                        
                    }
                    HStack{
                        Text("Name")
                            .frame(width: 100,alignment: .leading)
                        
                        Text((objTicketValidation.EventTicketResult.data.first?.CustomerFullName)!)
                            .frame(width: 220,alignment: .leading)
                        
                    }
                    HStack{
                        Text("Email")
                            .frame(width: 100,alignment: .leading)
                        
                        Text((objTicketValidation.EventTicketResult.data.first?.Email)!)
                            .frame(width: 220,alignment: .leading)
                        
                    }
                    
                    HStack{
                        Text("Mobile")
                            .frame(width: 100,alignment: .leading)
                        
                        Text((objTicketValidation.EventTicketResult.data.first?.Phone)!)
                            .frame(width: 220,alignment: .leading)
                        
                    }
                    
                }
                else if (!objTicketValidation.EventTicketResult.success && objTicketValidation.EventTicketResult.message == ""){
                }
                else{
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .foregroundStyle(Color.red)
                    Text(sScannedCode)
                        .padding(.vertical,20)
                        .foregroundStyle(cColorScan)
                        .onTapGesture {
                            cColorScan = Color(hex: "#234174")
                            pasteboard.string = self.sScannedCode
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                cColorScan = Color.black
                            }
                        }
                    
                    Text("Invalid Ticket")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.top,30)
                }
                
                
                
                Spacer()
                Button(action: {
                    self.bShowScanner = true
                    objTicketValidation.pResetData()
                }, label: {
                    HStack(alignment: .center,content: {
                        Spacer()
                        Text("Verify")
                            .font(.system(size: 20))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                    }).padding(.vertical,20)
                })
                .modifier(btnAzulOscuro())
                .sheet(isPresented: $bShowScanner){
                    self.scannerSheet
                }
                
                Button(action: {
                    objTicketValidation.pResetData()
                }, label: {
                    HStack(alignment: .center,content: {
                        Spacer()
                        Text("Clear")
                            .font(.system(size: 20))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        
                        Spacer()
                    }).padding(.vertical,20)
                })
                .modifier(btnColor(cColor: Color(hex: "#94C1E8")))
                
            }
            .navigationBarBackButtonHidden(true)
            .padding(.all,15)
            Spacer()
            
            if bShowLoading{
                vw_tls_LoadingView()
            }
        }
    }
    
}

#Preview {
    vw_dbo_Validation(path: .constant(.init()))
}
