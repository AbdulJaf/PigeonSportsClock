//
//  BasketTableViewCellPSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 12/04/22.
//

import UIKit

class BasketTableViewCellPSC: UITableViewCell {

    @IBOutlet weak var lblRingNbr: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblOuterRing: UILabel!
    @IBOutlet weak var lblColor: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var imgStatusView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
