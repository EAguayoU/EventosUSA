//
//  mEventTicketInConsignments.swift
//  EventosUSA
//
//  Created by Erik Aguayo on 07/01/25.
//
import Foundation
import Combine
import SwiftUI

class clEventTicket : ObservableObject, Equatable {
    static func == (lhs: clEventTicket, rhs: clEventTicket) -> Bool {
        return lhs.WindowName == rhs.WindowName &&
                       lhs.EventTicketResult == rhs.EventTicketResult
    }
    
    private var WindowName : String = ""
    //CAMBIOS
    var didChange = PassthroughSubject<clEventTicket, Never>()
    @Published var EventTicketResult = stEventTicketApi(success: false, records: -1, message: "", messageDev: "", data: []){
        didSet {
            didChange.send(self)
        }
    }
  
    init(WindowName: String) {
        self.WindowName = WindowName
    }
    
    func getEventTicket(objEventTicket : stEventTicketRequest){
      
        
        //Variables de entorno
        let objConstants = clConstant()
        let sUrlBase = objConstants.sApiUrl
        let sEnvironment = objConstants.sEnvironment
        let sApiToken = objConstants.sToken
        let sUserID = 1
        
        // Asignamos valores a la clase
        guard let url = URL(string: "\(sUrlBase)Events/EventTicketInConsignments") else { return }
        let jsonData = try! JSONEncoder().encode(objEventTicket)
        guard let sParametros = String(data: jsonData, encoding: String.Encoding.utf8) else { return }
        //Creamos Request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(sParametros, forHTTPHeaderField:  "Parameters")
        request.setValue(sEnvironment, forHTTPHeaderField: "Environment")
        request.setValue(sApiToken, forHTTPHeaderField: "Authorization")
        request.setValue(String(sUserID), forHTTPHeaderField: "UserID")
        request.setValue(self.WindowName, forHTTPHeaderField: "WindowName")
        URLSession.shared.dataTask(with: request) { urldata, response, error in
            do{
                guard let datax = urldata else { return }
                let decodedData = try JSONDecoder().decode(stEventTicketApi.self, from: datax)	
                DispatchQueue.main.sync {
                    self.EventTicketResult = decodedData
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
                self.EventTicketResult.message = "Ticket Invalido"
            } catch let error as NSError {
                print("Error al ejecutar el api", error.localizedDescription)
            }
            
        }.resume()
    }
    
    func pResetData() {
            self.EventTicketResult = stEventTicketApi(success: false, records: 0, message: "", messageDev: "", data: [])
        }
}

struct stEventTicketRequest : Codable, Hashable {
    var TicketNumber : String?
}

struct stEventTicketApi : Decodable, Equatable {
    var success : Bool
    var records : Int
    var message : String
    var messageDev : String
    var data : [stEventTicket]
}

struct stEventTicket : Decodable, Hashable{
    var EventTicketInConsignmentID: Int?
    var EventTicketConsignmentID: Int?
    var EventTicketsID: Int?
    var EventName: String?
    var EventDate: String?
    var EventTicketZoneID: Int?
    var EventTicketZone: String?
    var CustomerFullName: String?
    var CustomerID: Int?
    var FullName: String?
    var Email: String?
    var Phone: String?
    var ItemID: Int?
    var ItemCode: String?
    var ItemSecondCode: String?
    var ItemDescription: String?
    var Quantity:Int?
    var OrderOpenID:Int?
    var OrderOpenPayURL: String?
    var OrderPayID:Int?
    var OrderPayNumber: String?
    var OrderPayDate: String?
    var IsSale: Bool?
    var IsPaid: Bool?
    var IsChecked: Bool?
    var CheckedDate: String?
    var IsActive: Bool?
    var TicketNumber: String?
    var GroupTicket: String?
    var PrintedNumber:Int?
    var OrderNumber: String?
    
    
}
