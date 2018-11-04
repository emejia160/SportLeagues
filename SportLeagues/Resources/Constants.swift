//
//  Constants.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation

struct Constants {
    
    static var baseUrl: String {
        get {
            return Bundle.main.object(forInfoDictionaryKey: "apiBaseUrl") as! String
        }
    }
    
    struct Request {
        
        static let listTeamsPerLeaguePath = baseUrl + "/lookup_all_teams.php?id=%@"
        static let listAllLeaguesPath = baseUrl + "/all_leagues.php"
        static let teamEventPath = baseUrl + "/eventsnext.php?id=%@"
        
    }
    
    struct Cells {
        struct TeamTableViewCell {
            static let nibName = "TeamTableViewCell"
            static let identifier = "TeamCell"
        }
        
        struct TeamEventCollectionViewCell {
            static let nibName = "TeamEventCollectionViewCell"
            static let identifier = "TeamEventCell"
        }
    
    }
    
}
