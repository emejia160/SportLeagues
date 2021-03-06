//
//  TeamDetailViewController.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation

import UIKit

class TeamDetailViewController: BaseViewController {
    
    @IBOutlet weak var teamEventsCollectionView: UICollectionView!
    @IBOutlet weak var btnWeb: UIButton!
    @IBOutlet weak var btnInstagram: UIButton!
    @IBOutlet weak var btnYoutube: UIButton!
    @IBOutlet weak var btnTwitter: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var teamDescription: UILabel!
    @IBOutlet weak var teamFoundation: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamJersey: UIImageView!
    @IBOutlet weak var teamBadge: UIImageView!
    var team : Team?
    var presenter: TeamsPresenter?
    var teamEvents: [TeamEvent] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = TeamsPresenter(delegate: self)
        configureCollectionView()
        setupUI()
        presenter?.loadTeamEvents(teamId: (team?.teamId)!)
    }
    
    @IBAction func btnWebPagePressed(_ sender: Any) {
        openBrowser(urlString: (team?.webSite)!)
    }
    @IBAction func btnInstagramPressed(_ sender: Any) {
        openBrowser(urlString: (team?.instagramLink)!)
    }
    @IBAction func btnYoutubePressed(_ sender: Any) {
        openBrowser(urlString: (team?.youtubeLink)!)
    }
    @IBAction func btnFacebookPressed(_ sender: Any) {
        openBrowser(urlString: (team?.facebookLink)!)
    }
    @IBAction func btnTwitterPressed(_ sender: Any) {
        openBrowser(urlString: (team?.twitterLink)!)
    }
    
    func openBrowser(urlString: String) {
        
        if let url = URL(string: urlString.hasPrefix("http") ? urlString : "http://" + urlString), UIApplication.shared.canOpenURL(url), urlString != "" {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func configureCollectionView() {
        teamEventsCollectionView.delegate = self
        teamEventsCollectionView.dataSource = self
        teamEventsCollectionView.register(UINib(nibName: Constants.Cells.TeamEventCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: Constants.Cells.TeamEventCollectionViewCell.identifier)
    }
    
    func setupUI() {
        
        teamName.text = team?.name
        teamFoundation.text = String(format: NSLocalizedString("label.foundation.year", comment: ""), (team?.formedYear)!)
        teamDescription.text = team?.descriptionEN
        if let urlString = team?.badge, let url = URL(string: urlString) {
            self.teamBadge.af_setImage(withURL: url)
        }
        
        if let urlString = team?.jersey, let url = URL(string: urlString) {
            self.teamJersey.af_setImage(withURL: url)
        }
        btnWeb.alpha = team?.webSite != "" ? 1 :  0.5
        btnFacebook.alpha = team?.facebookLink != "" ? 1 :  0.5
        btnTwitter.alpha = team?.twitterLink != "" ? 1 :  0.5
        btnInstagram.alpha = team?.instagramLink != "" ? 1 :  0.5
        btnYoutube.alpha = team?.youtubeLink != "" ? 1 :  0.5
        
    }
    
}

extension TeamDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.teamEvents.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.TeamEventCollectionViewCell.identifier, for: indexPath) as! TeamEventCollectionViewCell
      cell.setUpData(teamEvent: self.teamEvents[indexPath.row])
        
        return cell
    }
}

extension TeamDetailViewController: TeamDetailView {
    func showTeamEvents(teamEvents: [TeamEvent]) {
        self.teamEvents = teamEvents
        self.teamEventsCollectionView.reloadData()
    }
}
