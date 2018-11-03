//
//  TeamsPresenter.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation

protocol TeamsView {
    func showTeams(teams: [Team])
    func showError(error: String)
}

class TeamsPresenter {
    
    var teamsDelegate: TeamsView?
    private var repository: TeamsRepository
    
    init(delegate: TeamsView?) {
        self.teamsDelegate = delegate
        self.repository = TeamsRepository()
    }
    
    func loadTeams() {
        self.repository.loadTeams(responseHandler: teamsResponseHandler)
    }
    
}

extension TeamsPresenter {
    func teamsResponseHandler(result: Result<[Team]>) {
        switch result {
        case .Success(let teams):
            self.teamsDelegate?.showTeams(teams: teams)
        case .Failure(let error):
            self.teamsDelegate?.showError(error: error.userInfo["message"] as! String)
        }
    }
}
