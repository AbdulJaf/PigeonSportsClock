//
//  HomeViewController.swift
//  PigeonSportsClock
//
//  Created by Anand on 25/03/22.
//

import UIKit
import SwiftUI
import SideMenu
import CoreLocation

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var BtnSideMenu: UIBarButtonItem!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var tblRaceList: UITableView!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnRaceName: UIButton!
    @IBOutlet weak var btnLcn: UIButton!
    var menu:SideMenuNavigationController?
    var imageviewcontroller = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialsetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.dateandtime()

    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }

    func tableview(){
        let nib = UINib.init(nibName: "HomeTableViewCell", bundle: nil)
        self.tblRaceList.register(nib, forCellReuseIdentifier: "HomeTableViewCell")
    }

    func intialsetup(){
        tblRaceList.delegate = self
        tblRaceList.dataSource = self
        self.tableview()
        self.tblRaceList.separatorStyle = UITableViewCell.SeparatorStyle.none
        statusBarColorChange()
        navigationItem.backButtonTitle = ""
        navigationItem.title = "Race"
        imageviewcontroller.delegate = self
        tblRaceList.isHidden = true
        // btnRaceName.isHidden = true

    }

    @IBAction func onSideMenuClk(_ sender: Any) {
        self.showSideMenu()
    }

    func showSideMenu() {
        let sideMenuVC = UIStoryboard(name: "Storyboard", bundle: nil).instantiateViewController(withIdentifier: "SideMenuControllerPSC") as! SideMenuControllerPSC
        let rightMenuNavigationController = SideMenuNavigationController(rootViewController: sideMenuVC)
        rightMenuNavigationController.presentationStyle = .viewSlideOutMenuIn
        rightMenuNavigationController.statusBarEndAlpha = 0
        rightMenuNavigationController.presentationStyle.presentingEndAlpha = 1
        rightMenuNavigationController.settings.menuWidth = UIScreen.main.bounds.width
        SideMenuManager.default.leftMenuNavigationController?.blurEffectStyle = .light
        SideMenuManager.default.leftMenuNavigationController = rightMenuNavigationController
        rightMenuNavigationController.settings.menuWidth = UIScreen.main.bounds.width-100
        rightMenuNavigationController.statusBarEndAlpha = 0
        if let sideMenu = SideMenuManager.default.leftMenuNavigationController {
            self.navigationController?.present(sideMenu, animated: true, completion: nil)
        }
    }

    func hideSideMenu() {
        DispatchQueue.main.async {
            if let sideMenu = SideMenuManager.default.leftMenuNavigationController {
                sideMenu.dismiss(animated: false, completion: nil)
            }
        }
    }

    // Date and Timer
    func dateandtime(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
            let dateformat = DateFormatter();
            let timeformat = DateFormatter();
            dateformat.dateFormat = "dd:MM:yyyy"
            timeformat.dateFormat = "hh:mm:ss a"
            let date = dateformat.string(from: Date())
            let time = timeformat.string(from: Date())
            self.lblDate.text = date
            self.lbltime.text = time
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblRaceList.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell else {return UITableViewCell()}

        //        let Dict =  imageviewcontroller[indexPath.row]
        //        cell.imageView?.image =
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    @IBAction func onclkRaceBtn(_ sender: Any) {
        print("Race List")
        self.race()
    }
    func race(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
        let vC = storyBoard.instantiateViewController(withIdentifier: "RaceListControllerPSC") as! RaceListControllerPSC
        //transitionVc(vc: vC, duration: 0.5, type: .fromTop)
    }
    
    @IBAction func onClkLocation(_ sender: Any) {
        print("Location Tapped")
        
    }
}

