//
//  mEventTicketInConsignmentsChecked.swift
//  EventosUSA
//
//  Created by Erik Aguayo on 07/01/25.
//

import Foundation
import Combine
import SwiftUI

class clEventTicketChecked : ObservableObject {
    private var WindowName : String = ""
    //CAMBIOS
    var didChange = PassthroughSubject<clEventTicketChecked, Never>()
    @Published var EventTicketCheckedResult = stEventTicketCheckedApi(success: false, records: -1, message: "", messageDev: "", data: []){
        didSet {
            didChange.send(self)
        }
    }
  
    init(WindowName: String) {
        self.WindowName = WindowName
    }
    
    func getEventTicketChecked(objEventTicketChecked : stEventTicketCheckedRequest){

        let objConstants = clConstant()
        let sUrlBase = objConstants.sApiUrl
        let sEnvironment = objConstants.sEnvironment
        let sApiToken = objConstants.sToken
       
        // Asignamos valores a la clase
        guard let url = URL(string: "\(sUrlBase)Events/EventTicketInConsignmentsChecked") else { return }
        let jsonData = try! JSONEncoder().encode(objEventTicketChecked)

        //Creamos Request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField:  "Content-Type")
        request.setValue(sEnvironment, forHTTPHeaderField: "Environment")
        request.setValue(sApiToken, forHTTPHeaderField: "Authorization")
        request.setValue("1", forHTTPHeaderField: "UserID")
        request.setValue(self.WindowName, forHTTPHeaderField: "WindowName")
        let (data, response, _) = Foundation.URLSession.shared.syncRequest(request: request)
        do{
            if let httpResponse = response as? HTTPURLResponse {
                if(httpResponse.statusCode == 200)
                {
                    guard let datax = data else { return }
                    let decodedData = try JSONDecoder().decode(stEventTicketCheckedApi.self, from: datax)
                    self.EventTicketCheckedResult = decodedData
                                        
                    if(!self.EventTicketCheckedResult.success!){
                        self.EventTicketCheckedResult.message = ""
                    }
                }
                else
                {
                    EventTicketCheckedResult.message = "No se pudo obtener respuesta del servidor, inténtelo de nuevo mas tarde (error \(httpResponse.statusCode))"
                }
            }
            else
            {
                EventTicketCheckedResult.message = "No se pudo obtener respuesta del servidor, inténtelo de nuevo mas tarde (unknow)"
            }
        } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let error as NSError {
                print("Error al ejecutar el api", error.localizedDescription)
            }
            
    }
}
struct stEventTicketCheckedRequest : Codable, Hashable {
    var EventTicketInConsignmentID : Int?
}

struct stEventTicketCheckedApi : Decodable {
    var success : Bool?
    var records : Int?
    var message : String?
    var messageDev : String?
    var data : [stEventTicketChecked]?
}

struct stEventTicketChecked : Decodable, Hashable {
    var EventTicketInConsignmentID : Int?
}
