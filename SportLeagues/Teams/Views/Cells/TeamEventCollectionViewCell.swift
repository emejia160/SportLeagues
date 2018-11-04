//
//  TeamEventCollectionViewCell.swift
//  SportLeagues
//
//  Created by Edison Mejia Estrada on 3/11/18.
//  Copyright © 2018 Edison Mejia Estrada. All rights reserved.
//

import Foundation
import UIKit

class TeamEventCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var eventLeague: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTeams: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpData(teamEvent: TeamEvent){
        self.eventLeague.text = teamEvent.league
        self.eventDate.text = teamEvent.date
        self.eventTeams.text = teamEvent.event
    }
}
