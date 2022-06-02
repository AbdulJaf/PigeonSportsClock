//
//  HomeTableViewCell.swift
//  PigeonSportsClock
//
//  Created by Anand on 30/03/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {


    @IBOutlet weak var btnVwCamera: UIButton!
    @IBOutlet weak var VwTable: UIView!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.VwTable.layer.cornerRadius = 15.0
        self.VwTable.layer.masksToBounds = true


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
