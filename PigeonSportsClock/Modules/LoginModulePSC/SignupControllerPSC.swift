//
//  SignupControllerPSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 18/03/22.
//

import UIKit

class SignupControllerPSC: UIViewController, getClubName,UITextFieldDelegate {




    @IBOutlet weak var txtSlctClb: UITextField!
    @IBOutlet weak var btnSelectRace: UIButton!
    @IBOutlet weak var txtFanNme: UITextField!
    @IBOutlet weak var txtPhneNmbr: UITextField!
    @IBOutlet weak var txtPwd: PscTexfield!
    @IBOutlet weak var txtCfPwd: PscTexfield!
    @IBOutlet weak var btnSignUp: UIButton!

    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var lblLgn: UILabel!
    var getClubIdDet : getClubID?
    var navigationBarAppearace = UINavigationBar.appearance()
    var backgroundView : UIView = UIView()
    var regClubName : String?
    var regClubId : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSignUp.layer.cornerRadius = 20
        btnSignUp.layer.masksToBounds = true
        txtSlctClb.delegate = self
        
        //  self.setupDontHaveAnAccountTxt()


    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        super.viewWillAppear(animated)
        self.statusBarColorChange()
        // txtSlctClb.becomeFirstResponder()
        intialsetup()
        getClubIdDet?.getClubListID(clubId: regClubId!)


    }
    override func viewDidAppear(_ animated: Bool) {

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }
    func getClubInfo(clubdetails: String, clubId: String) {
        regClubName = clubdetails
        regClubId = clubId
    }
    //    func createBackgroundView()
    //    {
    //        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 335, height: 750))
    //            backgroundView.tag = 10
    //            backgroundView.isHidden = true
    //    }


    func validatetextfield() -> Bool{
        var isValideInput = false
        guard let  SelectClub = txtSlctClb.text, !SelectClub.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Select Your Club", comment: ""))
            isValideInput = false
            return isValideInput
        }
        guard let  name = txtFanNme.text, !name.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Enter Your Name", comment: ""))
            isValideInput = false
            return isValideInput
        }
        guard let  phoneNumber = txtPhneNmbr.text, !phoneNumber.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Enter Your Mobile Number", comment: ""))
            isValideInput = false
            return isValideInput
        }
        guard let  passWord = txtPwd.text, !passWord.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Enter Your Valid Password", comment: ""))
            isValideInput = false
            return isValideInput
        }
        guard let  confirmPassWord = txtCfPwd.text, !confirmPassWord.isEmpty else {
            self.showAlert(msg:  NSLocalizedString("Enter Your Valid  ConfirmPassword", comment: ""))
            isValideInput = false
            return isValideInput
        }

        if txtPwd.text == txtCfPwd.text {
            print("Password are correct")

        }else {
            self.showAlert(msg:  NSLocalizedString("Password and Confirm password are not match", comment: ""))
            isValideInput = false
            return isValideInput
        }

        return isValideInput
    }

    @IBAction func onClkSlctClub(_ sender: Any) {

    }
    func intialsetup(){
        if regClubName == nil {
            txtSlctClb.placeholder = "Select Club"
            txtSlctClb.tintColor = .lightGray
            //  btnSelectRace.isHidden = false
        }
        else {
            txtSlctClb.text = regClubName
            txtSlctClb.tintColor = .black
            //   btnSelectRace.isHidden = true
            // btnSlctClb.
            print("clubname..\(regClubName)")
        }
    }

    @IBAction func onclkSgnUp(_ sender: Any) {
        
        if  self.validatetextfield() == false {
            self.doSignup()
        }
    }

    @IBAction func onClkSignIn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignincontollerPSC") as! SignincontollerPSC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    func pushtosignin(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignincontollerPSC") as! SignincontollerPSC
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    private func doSignup(){
        showLoading()
        let url = URL(string: "https://pigeonsportsclock.com/pigeon/lespoton_new_version.php")!
        let session = URLSession.shared
        let parameters =  ["action":"pparegister",
                           "apptype": regClubId,
                           "deivce_id": "test",
                           "username": txtFanNme.text,
                           "phone_no": txtPhneNmbr.text,
                           "password": txtCfPwd.text,
                           "model":  "iphone13",
                           "ver": "1",
                           "code": "Test",
                           "country": "India",
                           "language": "en"
                           //"email_id":"anand1@yopmail.com"
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
                                if msg == "registered successfully"{
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





extension SignupControllerPSC {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if txtSlctClb.resignFirstResponder() {
            let storyBoard : UIStoryboard = UIStoryboard(name: "OnBoard", bundle:nil)
            let vC = storyBoard.instantiateViewController(withIdentifier: "RaceListControllerPSC") as! RaceListControllerPSC
            vC.clubName = self
            self.navigationController?.pushViewController(vC, animated: true)
        }

    }

}


