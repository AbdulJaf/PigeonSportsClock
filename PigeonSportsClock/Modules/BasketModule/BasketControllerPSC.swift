//
//  BasketControllerPSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 12/04/22.
//

import UIKit
import Pods_PigeonSportsClock

class BasketControllerPSC: UIViewController {

    @IBOutlet weak var tblBasketList: UITableView!

    @IBOutlet weak var btnSelectRace: UIButton!
    
    @IBOutlet weak var btnCategory: UIButton!
    
    @IBOutlet weak var btnGetBasket: UIButton!
    
    @IBOutlet weak var btnAddBird: UIButton!
    
    @IBOutlet weak var btnPreview: UIButton!
    
    @IBOutlet weak var lblBAsketCount: UILabel!
    
    @IBOutlet weak var btnSideMenu: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        register()
        curves()
//        self.btnSideMenu.target = revealViewController()
//        self.btnSideMenu.action = #selector(self.revealViewController()?.popUpSideMenu)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
    }
        func register(){
        let nib = UINib.init(nibName: "BasketTableViewCellPSC", bundle: nil)
        self.tblBasketList.register(nib, forCellReuseIdentifier: "BasketTableViewCellPSC")

    }
    func curves(){
        btnPreview.layer.masksToBounds = true
        btnAddBird.layer.masksToBounds = true
        btnGetBasket.layer.masksToBounds = true
        btnAddBird.layer.cornerRadius = 20
        btnGetBasket.layer.cornerRadius = 20
        btnPreview.layer.cornerRadius = 20
    }


}
