//
//  TeamTableViewCell.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import UIKit
import AlamofireImage

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamViewContainer: UIView!
    @IBOutlet weak var teamBadge: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamStadiumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teamViewContainer.layer.masksToBounds = false
    }
    
    func setUpData(team: Team){
        self.teamNameLabel.text = team.name
        self.teamStadiumLabel.text = team.stadium
        
        if let urlString = team.badge, let url = URL(string: urlString) {
           self.teamBadge.af_setImage(withURL: url)
        }
       
    }
}

