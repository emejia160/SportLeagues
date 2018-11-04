//
//  ViewController.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import UIKit

struct League {
    var leagueId : String
    var leagueName : String
}

class TeamsViewController: BaseViewController {

    @IBOutlet weak var leagueTextField: UITextField!
    var leaguesPickerView = UIPickerView()
    var teams : [Team] = []
    var teamSelected : Team?
    @IBOutlet weak var teamsTableView: UITableView!
    var presenter: TeamsPresenter?
    private var leaguesArray : [League] = []
    var leagueSelected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLeagues()
        configurePickerView()
        self.presenter = TeamsPresenter(delegate: self)
      
        
        loadTeams(leagueId: leaguesArray[2].leagueId)
        
    }
    
    private func configurePickerView() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TeamsViewController.donePicker))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
        self.leaguesPickerView.delegate = self
        self.leaguesPickerView.dataSource = self
        self.leagueTextField.inputView = self.leaguesPickerView
         leagueTextField.inputAccessoryView = toolBar
    }
    
    @objc private func donePicker() {
        leagueTextField.resignFirstResponder()
        loadTeams(leagueId: self.leagueSelected)
    }
    
    private func loadTeams(leagueId: String) {
         showProgress(message: NSLocalizedString("message.loadingteams", comment: ""), style: .light, presentationContext: .overCurrentContext)
        self.presenter?.loadTeams(leagueId: leagueId)
    }
    
    private func configureLeagues() {
        
        leaguesArray.append(League(leagueId: "4335", leagueName: "Spanish La Liga"))
        leaguesArray.append(League(leagueId: "4328", leagueName: "English Premier League"))
        leaguesArray.append(League(leagueId: "4332", leagueName: "Italian Serie A"))
    }
    
    private func configureTableView() {
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
          self.progress?.hide(animated: true)
        showAlert(title: "Ups!", message: error)
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

extension TeamsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.leaguesArray.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return leaguesArray[row].leagueName
        
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.leagueSelected = leaguesArray[row].leagueId
        self.leagueTextField.text = leaguesArray[row].leagueName
        
    }
       
        
}
