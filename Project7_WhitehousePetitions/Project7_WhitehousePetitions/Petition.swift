//
//  Petition.swift
//  Project7_WhitehousePetitions
//
//  Created by Effrafax Bulwer on 8/4/21.
//  Copyright © 2021 Effrafax Bulwer. All rights reserved.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
