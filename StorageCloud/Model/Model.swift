//
//  Model.swift
//  StorageCloud
//
//  Created by Naved  on 13/02/24.
//

import Foundation
import FirebaseFirestoreInternal

struct UserData : Codable {
    let userName : String
    let date : Timestamp
    let imageUrl : [String]
    let description : String
}
