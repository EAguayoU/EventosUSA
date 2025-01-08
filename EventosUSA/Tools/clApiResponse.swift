//
//  clApiResponse.swift
//  Nice
//
//  Created by Erik Aguayo on 01/04/24.
//

import Foundation
struct clApiResponse {
    
    var success : Bool = false
    var message : String = ""
    var messageDev : String = ""
    var data : String = ""
    var records : Int = -1
    var recordsError : Int = 0
    var executionTime : String = ""
}
