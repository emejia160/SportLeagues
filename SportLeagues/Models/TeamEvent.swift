//
//  TeamEvent.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation

class TeamEvent: Codable {
    
    var event: String?
    var league: String?
    var date: String?
    
    private enum CodingKeys: String, CodingKey {
        case event = "strEvent"
        case league = "strLeague"
        case date = "dateEvent"
    }
}
