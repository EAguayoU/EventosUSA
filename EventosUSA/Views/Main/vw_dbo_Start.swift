//
//
//  
//
//
//

import SwiftUI

struct vw_dbo_Start: View {
    
    //Controles
    @State var path : NavigationPath
    @State var bShowLoading : Bool = false
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                GeometryReader{_ in
                    Image("BarraSuperior")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        HStack{
                            Spacer()
                            Image("NiceBella")
                                .resizable()
                                .frame(width: 300, height: 70)
                                .padding(.top, 50)
                            Spacer()
                        }
                       
                        Text("Elevate 2025")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.top,15)
                            .foregroundStyle(Color.black)
                            .font(.system(size: 25))
                        Spacer()
                    }
    
                    VStack(){
                        
                        Spacer()
                        //Aceptar botón
                        HStack(alignment: .center, content: {
                            Button(action: {
                                path.append("vw_dbo_Validation")
                             
                            }, label: {
                                HStack(alignment: .center,content: {
                                    Spacer()
                                    Text("Start")
                                        .font(.system(size: 40))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        //.foregroundStyle(Color(hex: "#234174"))
                                    Spacer()
                                }).padding(.vertical,170)
                            })
                            .modifier(btnColor(cColor: Color(hex: "#94C1E8")))
                        })
                        .padding(.leading,10)
                        .padding(.trailing,10)
                        .padding(.top,250)
                        Spacer()
                    }
                    .foregroundStyle(Color(hex: "#002D57"))
                    .navigationBarBackButtonHidden(true)
                    //Agregamos las ventanas para la navegacion
                    .navigationDestination(for: String.self){ viewName in
                        switch viewName {
                        case "vw_dbo_Validation":
                            vw_dbo_Validation(path: $path)
                                .navigationBarBackButtonHidden(true)
                                .preferredColorScheme(.light)
                        default:
                            Text("La ventana seleccionada no se encuentra disponible")
                        }
                    }
                   
                }
                .background(Color(hex: "#94C1E8"))
                .ignoresSafeArea(.keyboard)
                if bShowLoading { vw_tls_LoadingView () }
            }
            .animation(.default, value: bShowLoading)
        }
    }
    
}


#Preview {
    vw_dbo_Start(path: .init())
}
