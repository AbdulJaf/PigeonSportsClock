//
//  LoftControllerPSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 13/04/22.
//
import Foundation
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Alamofire


class LoftControllerPSC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,getClubID {

    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var VwApproved: UIView!
    @IBOutlet weak var VwNotApproved: UIView!
    @IBOutlet weak var vwGoogleMap: GMSMapView!
    @IBOutlet weak var imgLoft: UIImageView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lblImageText: UILabel!
    @IBOutlet weak var btnRetake: UIButton!
    @IBOutlet weak var lblRetake: UILabel!

    var centerMapCoordinate:CLLocationCoordinate2D!
    var currentLocation: CLLocation!
    var locationManager = CLLocationManager()
    var imagePicker = UIImagePickerController()
    var SelectedMarker: String?
    var getclubIDValue : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewProperty()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    func viewProperty(){
        //   menuNavigation()
        //VwNotApproved.isHidden = true
        imgLoft.layer.masksToBounds = true
        imgLoft.layer.borderWidth = 2
        imgLoft.layer.borderColor = UIColor.black.cgColor
        imgLoft.layer.cornerRadius = 10
        btnSubmit.layer.cornerRadius = 20
        vwGoogleMap.layer.cornerRadius = 10
        vwGoogleMap.layer.borderColor = UIColor.black.cgColor
        vwGoogleMap.settings.compassButton = true

        vwGoogleMap.settings.myLocationButton = true
        btnRetake.isHidden = true
        lblRetake.isHidden = true
        imagePicker.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        //        mapView.isBuildingsEnabled = false
        //        mapView = GMSMapView(frame: self.view.bounds)
    }

    @IBAction func onClkCamera(_ sender: Any) {
        pickAnImage(sender: sender, imgPicker: imagePicker)
    }

    @IBAction func onClkRetake(_ sender: Any) {
        pickAnImage(sender: sender, imgPicker: imagePicker)

    }
    func getClubListID(clubId: String) {
        getclubIDValue = clubId
    }


    @IBAction func onClkSubmit(){
        self.loftApi()

    }

    func loftApi(){
        showLoading()
        let url = URL(string: "https://pigeonsportsclock.com/pigeon/lespoton_new_version.php")!
        let session = URLSession.shared
        let parameters =  [  "action":"loftupdate",
                             "latitude":lblLatitude.text,
                             "longitude":lblLongitude.text,
                             "apptype": getclubIDValue,
                             "files": imgLoft.image
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
                                //                                if msg == "registered successfully"{
                                //                                    let storyboard:UIStoryboard = UIStoryboard(name: "OnBoard", bundle: nil)
                                //                                    let vc = storyboard.instantiateViewController(withIdentifier:"HomeViewController") as! HomeViewController
                                //                                    vc.navigationController?.isNavigationBarHidden = false
                                //                                    self.navigationController?.pushViewController(vc, animated: true)

                                //  }
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
/* Location Common Method */
extension LoftControllerPSC: CLLocationManagerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)

        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        imgLoft.image = image
        vwGoogleMap.clear()
        locationManager.startUpdatingLocation()
        btnCamera.isHidden = true
        lblImageText.isHidden = true



    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let userLocation = locations.last {
            let camera = GMSCameraPosition.camera(withLatitude: userLocation.coordinate.latitude,
                                                  longitude: userLocation.coordinate.longitude, zoom: 15)

            vwGoogleMap.isMyLocationEnabled = true
            vwGoogleMap.settings.myLocationButton = true
            vwGoogleMap.camera = camera

            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let marker = GMSMarker(position: center)

            self.lblLatitude.text = "\(userLocation.coordinate.latitude)"
            self.lblLongitude.text = "\(userLocation.coordinate.longitude)"
            marker.map = vwGoogleMap
            locationManager.stopUpdatingLocation()
            btnRetake.isHidden = false
            lblRetake.isHidden = false
            btnSubmit.isHidden = false


        }
    }

}

