//
//  ProfileControllerPSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 14/06/22.
//

import UIKit

class ProfileControllerPSC: UIViewController {


    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var btnProfile: UIButton!
    @IBOutlet weak var fancierNme: UITextField!
    @IBOutlet weak var phNmbr: UITextField!
    @IBOutlet weak var clubName: UITextField!
    @IBOutlet weak var btnUpdate: UIButton!


    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnUpdate.layer.masksToBounds = true
        btnUpdate.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
    }

    @IBAction func onClkProfile(_ sender: Any) {
    profileImage(sender: sender, imgPicker: imagePicker)
    }




    func validatetextfield() -> Bool{
        var isValideInput = false
        guard let  FancierName = fancierNme.text, !FancierName.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Fancier name should not be empty", comment: ""))
            isValideInput = false
            return isValideInput
        }
        guard let  PhoneNumer = phNmbr.text, !PhoneNumer.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Phonenumber should not be empty", comment: ""))
            isValideInput = false
            return isValideInput
        }
        guard let  ClubName = clubName.text, !ClubName.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Clubname should not be empty", comment: ""))
            isValideInput = false
            return isValideInput
        }

        return isValideInput
    }
    

    @IBAction func onClkUpdate(_ sender: Any) {

        if  validatetextfield() == false {

           // showAlert(msg: "Profile updated successfully")

//            let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
//            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//            self.navigationController?.pushViewController(nextViewController, animated: true)

        }
    }

}
