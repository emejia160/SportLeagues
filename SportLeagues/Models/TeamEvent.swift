//
//  TeamEvent.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation

class TeamEvent: Codable {
    
    var name: String?
    var stadium: String?
    var badge: String?
    var descriptionEN: String?
    var descriptionES: String?
    var formedYear: String?
    var jersey: String?
    var webSite: String?
    var facebookLink: String?
    var twitterLink: String?
    var instagramLink: String?
    var youtubeLink: String?
    
    private enum CodingKeys: String, CodingKey {
        case name = "strTeam"
        case stadium = "strStadium"
        case badge = "strTeamBadge"
        case descriptionEN = "strDescriptionEN"
        case descriptionES = "strDescriptionES"
        case formedYear = "intFormedYear"
        case jersey = "strTeamJersey"
        case webSite = "strWebsite"
        case facebookLink = "strFacebook"
        case twitterLink = "strTwitter"
        case instagramLink = "strInstagram"
        case youtubeLink = "strYoutube"
    }
}
