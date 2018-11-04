//
//  TeamsRepository.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation
import Alamofire

final class TeamsRepository: BaseRepository {
    func loadTeams<T>(leagueId: String, responseHandler: @escaping ((_ result: Result<T>) -> Void)) where T: Decodable {
        let url =  String(format: Constants.Request.listTeamsPerLeaguePath, leagueId)
        
        let headers: HTTPHeaders = [
            "X-Api-Key": "1",
        ]
        BaseRepository.callService(url: url, method: .get, parameters: [:], encoding: URLEncoding.httpBody, headers: headers, responseHandler: responseHandler)
    }
    
    func loadTeamEvents<T>(teamId: String, responseHandler: @escaping ((_ result: Result<T>) -> Void)) where T: Decodable {
        let url =  String(format: Constants.Request.teamEventPath, teamId)
        
        let headers: HTTPHeaders = [
            "X-Api-Key": "1",
            ]
        BaseRepository.callService(url: url, method: .get, parameters: [:], encoding: URLEncoding.httpBody, headers: headers, responseHandler: responseHandler)
    }
}
