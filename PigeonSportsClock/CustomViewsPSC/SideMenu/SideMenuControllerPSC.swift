//
//  SideMenuControllerPSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 31/03/22.
//
import SideMenu
import UIKit

class SideMenuControllerPSC: UIViewController {

    @IBOutlet weak var tblMenuList: UITableView!
    @IBOutlet weak var btnLogout: UIButton!
    static let NibName = "SideMenuControllerPSC"
    var defaultHighlightedCell: Int = 0

    let ImageMenu =  ["home","loft-1","basketing-1","result-1","gallery-1","all-fancier-1","notification-1","subscription-1","app-info-1"]
    let MenuList = ["Home","Loft","Basketing","Results","Gallery","All Fanciers","Notification","Subscription","App Info"]

    override func viewDidLoad() {
        super.viewDidLoad()

        tblMenuList?.delegate = self
        tblMenuList?.dataSource = self
        tblMenuList?.separatorStyle = .none
        tblMenuList?.register(UINib(nibName: "SideMenuPSCTableViewCell", bundle: nil), forCellReuseIdentifier: "SideMenuPSCTableViewCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.statusBarColorChange()
        self.navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func onclkProfile(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileControllerPSC") as! ProfileControllerPSC
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }

    @IBAction func onClkLogout(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignincontollerPSC") as! SignincontollerPSC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }


}

extension SideMenuControllerPSC: UITableViewDelegate,UITableViewDataSource  {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sideMenuCell = (tblMenuList?.dequeueReusableCell(withIdentifier: "SideMenuPSCTableViewCell", for: indexPath) as? SideMenuPSCTableViewCell) else {return UITableViewCell()}
        let dict = MenuList[indexPath.row]
        sideMenuCell.lblMenu.text = dict
        let image = self.ImageMenu[indexPath.row]
        sideMenuCell.imgMenu.image = UIImage(named: image)
        sideMenuCell.selectionStyle = UITableViewCell.SelectionStyle.none
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = UIColor.red
        sideMenuCell.selectedBackgroundView = myCustomSelectionColorView
        return sideMenuCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0{
            self.navigationController?.pushViewController(ViewController.HomeViewController.value, animated: true)
        }
        else if indexPath.row == 1{
            self.navigationController?.pushViewController(ViewController.LoftControllerPSC.value, animated: true)
        }
        else if indexPath.row == 2{
            self.navigationController?.pushViewController(ViewController.BasketControllerPSC.value, animated: true)
        }
        else  if indexPath.row == 3{
            self.navigationController?.pushViewController(ViewController.ResultControllerPSC.value, animated: true)
        }
        else if indexPath.row == 4{
            self.navigationController?.pushViewController(ViewController.AllFanciersControllerPSC.value, animated: true)
        }
        else if indexPath.row == 5{
            self.navigationController?.pushViewController(ViewController.AllFanciersControllerPSC.value, animated: true)
        }
        else if indexPath.row == 6{
            self.navigationController?.pushViewController(ViewController.NotificationControllerPSC.value, animated: true)
        }
        else if indexPath.row == 7{
            self.navigationController?.pushViewController(ViewController.SubscriptionControllerPSC.value, animated: true)
        }
        else if indexPath.row == 8{
            self.navigationController?.pushViewController(ViewController.SubscriptionControllerPSC.value, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

}
extension SideMenuControllerPSC : SideMenuNavigationControllerDelegate {
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        print("SideMenu")
    }
}


