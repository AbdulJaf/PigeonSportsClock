//
//  SignincontollerPSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 18/03/22.
//

import UIKit
import CoreLocation

protocol getClubID {
    func getClubListID(clubId:String)
}

class SignincontollerPSC: UIViewController,getClubName,UITextFieldDelegate  {



    @IBOutlet weak var txtSlctClb: UITextField!
    @IBOutlet weak var btndropdown: UIButton!
    @IBOutlet weak var txtFancierName: UITextField!
    @IBOutlet weak var txtPasswrd: PscTexfield!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnFrgtpswd: UIButton!
    @IBOutlet weak var lblSignUp: UILabel!
    @IBOutlet weak var btnSignUp: UIButton!
    var currentLocation: CLLocation?
    var clubList : [Clublist] = []
    var clubName : String?
    var selectedClubId : String?
    var getClubIdDetails : getClubID?

    override func viewDidLoad() {

        super.viewDidLoad()
        self.btnLogin.layer.cornerRadius = 20
        self.btnLogin.layer.masksToBounds = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        txtSlctClb.delegate = self

    }
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        self.intialsetup()
        self.statusBarColorChange()
        getClubIdDetails?.getClubListID(clubId: selectedClubId!)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)

    }

    func getClubInfo(clubdetails: String, clubId: String) {
        print(clubdetails)
        clubName = clubdetails
        selectedClubId = clubId
    }
    func intialsetup(){
        if clubName == nil {
            txtSlctClb.placeholder = "Select Club"
            txtSlctClb.tintColor = .lightGray
       //     btndropdown.isHidden = false
        }
        else {
            txtSlctClb.text = clubName
            txtSlctClb.tintColor = .black
         //   btndropdown.isHidden = true
            // btnSlctClb.
            print("clubname..\(clubName)")
        }
    }
    @IBAction func onClkSelectClub(_ sender: Any) {

    }

    func validatetextfield() -> Bool{
        var isValideInput = false
        guard let  SelectClub = txtSlctClb.text, !SelectClub.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Select Your Club", comment: ""))
            isValideInput = false
            return isValideInput
        }
        guard let  name = txtFancierName.text, !name.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Enter Your Name or Mobile Number", comment: ""))
            isValideInput = false
            return isValideInput
        }
        guard let  password = txtPasswrd.text, !password.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Enter Your Valid Password", comment: ""))
            isValideInput = false
            return isValideInput
        }

        return isValideInput
    }
    
    @IBAction func onclklogn(_ sender: Any) {

        if  self.validatetextfield() == false {
            self.doSignIn()
        }
    }

    @IBAction func onClkSignUp(_ sender: Any) {

        let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignupControllerPSC") as! SignupControllerPSC
        nextViewController.navigationController?.isNavigationBarHidden = false
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }


    func pushtosignup(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignupControllerPSC") as! SignupControllerPSC
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }

    

    private func doSignIn(){

       showLoading()
        let url = URL(string: "https://pigeonsportsclock.com/pigeon/lespoton_new_version.php")!
        let session = URLSession.shared
        let parameters =  ["action":"ppalogin",
                           "apptype": selectedClubId,
                           "user_name": txtFancierName.text,
                           "password": txtPasswrd.text
        ] as [String : Any]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")


        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {

                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    DispatchQueue.main.async {
                        if let dataAPI = json["data"] as? [String:Any] {
//                            let storyboard:UIStoryboard = UIStoryboard(name: "OnBoard", bundle: nil)
//                            let vc = storyboard.instantiateViewController(withIdentifier:"HomeViewController") as! HomeViewController
//                            self.navigationController?.pushViewController(vc, animated: true)
                            let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
                                       let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                                       self.navigationController?.pushViewController(nextViewController, animated: true)

                        }else{
                            hideLoading()
                            if let msg = json["message"] as? String{
                                if msg == "Login Successfully"{
                                    let storyboard:UIStoryboard = UIStoryboard(name: "OnBoard", bundle: nil)
                                    let vc = storyboard.instantiateViewController(withIdentifier:"HomeViewController") as! HomeViewController
                                    vc.navigationController?.isNavigationBarHidden = false
                                    self.navigationController?.pushViewController(vc, animated: true)
                                  
                                }
                                self.showAlert(msg: msg)
                            }
                        }
                    }
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()

    }
}
extension SignincontollerPSC {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if txtSlctClb.resignFirstResponder() {
            let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
            let vC = storyBoard.instantiateViewController(withIdentifier: "RaceListControllerPSC") as! RaceListControllerPSC
            vC.clubName = self
            self.navigationController?.pushViewController(vC, animated: true)
        }

    }
}









