//
//  ViewController.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import UIKit

class TeamsViewController: BaseViewController {

    var teams : [Team] = []
    private var teamSelected : Team?
    @IBOutlet weak var teamsTableView: UITableView!
    var presenter: TeamsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        showProgress(message: NSLocalizedString("message.loadingteams", comment: ""), style: .light, presentationContext: .overCurrentContext)
        self.presenter = TeamsPresenter(delegate: self)
        self.presenter?.loadTeams()
    }
    
    func configureTableView() {
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        teamsTableView.register(UINib(nibName: Constants.Cells.TeamTableViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: Constants.Cells.TeamTableViewCell.identifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let vlc = segue.destination as! TeamDetailViewController
            vlc.team = teamSelected
        }
    }

}

extension TeamsViewController: TeamsView{
    func showError(error: String) {
        
    }
    
    func showTeams(teams: [Team]) {
        self.progress?.hide(animated: true)
        self.teams = teams
        self.teamsTableView.reloadData()
    }
    
}

extension TeamsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.TeamTableViewCell.identifier, for: indexPath) as? TeamTableViewCell else { return UITableViewCell() }
        cell.setUpData(team: teams[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.teamSelected = self.teams[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: nil)
    }
    
    
}
