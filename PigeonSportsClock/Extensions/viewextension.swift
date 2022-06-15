//
//  viewextension.swift
//  PigeonSportsClock
//
//  Created by Anand on 25/03/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
extension UIViewController {
    
    func showAlert(msg: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("PigeonSportsClock", comment: ""), message: msg, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            // alert.view.tintColor = UIColor.NavigationBackColor
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIViewController {
    func transitionVc(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
        let customVcTransition = vc
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.push
        transition.subtype = type
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(customVcTransition, animated: false)
    }
    
}

//func setNavigationAppearance(){
//       //Transperent NavigationBar
//
//       UINavigationBar.appearance().setBackgroundImage(UIImage(named: "signin-bg"), for: .default)
//       UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//       UINavigationBar.appearance().shadowImage = UIImage()
//       UINavigationBar.appearance().isTranslucent = true
//    UINavigationBar.appearance().barTintColor = UIColor.init(red: 191, green: 57, blue: 64, alpha: 1)
//       UINavigationBar.appearance().tintColor = UIColor.init(red: 191, green: 57, blue: 64, alpha: 1)
//
//
//       //Set Navigation Title Font
//       UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor:UIColor.white]
//
//       UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)
//       , NSAttributedString.Key.foregroundColor:UIColor.white], for: .normal)
//
//       UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000, vertical: 0), for:UIBarMetrics.default)
//
//       UIToolbar.appearance().tintColor = UIColor.init(red: 191, green: 57, blue: 64, alpha: 1)
//   }

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension UIViewController{
    
    func pickAnImage(sender:Any,imgPicker:UIImagePickerController){
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera(imgPicker: imgPicker)
        }))
        
        //        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
        //            self.openGallery(imgPicker: imgPicker)
        //        }))

        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func openCamera(imgPicker:UIImagePickerController){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imgPicker.sourceType = UIImagePickerController.SourceType.camera
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: nil)
        }else{
            
            showAlert(msg: "You don't have camera")
        }
    }
    func openGallery(imgPicker:UIImagePickerController){
        imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imgPicker.allowsEditing = true
        self.present(imgPicker, animated: true, completion: nil)
    }
}



extension UIViewController {


        func profileImage(sender:Any,imgPicker:UIImagePickerController){
            let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera(imgPicker: imgPicker)
            }))

                    alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                        self.openGallery(imgPicker: imgPicker)
                    }))

            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

            switch UIDevice.current.userInterfaceIdiom {
            case .pad:
                alert.popoverPresentationController?.sourceView = sender as? UIView
                alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
                alert.popoverPresentationController?.permittedArrowDirections = .up
            default:
                break
            }
            self.present(alert, animated: true, completion: nil)
        }



        func cameraOpen(imgPicker:UIImagePickerController){
            if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
                imgPicker.sourceType = UIImagePickerController.SourceType.camera
                imgPicker.allowsEditing = true
                self.present(imgPicker, animated: true, completion: nil)
            }else{

                showAlert(msg: "You don't have camera")
            }
        }
        func GalleryOpen(imgPicker:UIImagePickerController){
            imgPicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imgPicker.allowsEditing = true
            self.present(imgPicker, animated: true, completion: nil)
        }
    }


extension UIViewController {
    
    func statusBarColorChange() {

        if #available(iOS 13.0, *) {

            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = hexStringToUIColor(hex: "#DC3940")
            statusBar.tag = 100
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)

        } else {

            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = hexStringToUIColor(hex: "#DC3940")
        }
    }

}
public enum Storyboard: String {
    case OnBoard = "OnBoard"
    case Storyboard = "Storyboard"

    public var value : UIStoryboard{
        return UIStoryboard(name: self.rawValue, bundle: nil)
    }
}


public enum ViewController: String {

    case HomeViewController = "HomeViewController"
    case LoftControllerPSC = "LoftControllerPSC"
    case BasketControllerPSC = "BasketControllerPSC"
    case ResultControllerPSC = "ResultControllerPSC"
    case AllFanciersControllerPSC = "AllFanciersControllerPSC"
    case NotificationControllerPSC = "NotificationControllerPSC"
    case SubscriptionControllerPSC = "SubscriptionControllerPSC"



    var value : UIViewController{

        switch self{
        case .HomeViewController, .LoftControllerPSC, .BasketControllerPSC, .ResultControllerPSC, .AllFanciersControllerPSC, .NotificationControllerPSC, .SubscriptionControllerPSC:
            return Storyboard.OnBoard.value.instantiateViewController(withIdentifier: self.rawValue)

        }
    }
}

func showLoading(){
    let activityData = ActivityData(size: CGSize(width: 50, height: 50), message: "", messageFont: .systemFont(ofSize: 20), messageSpacing: nil, type: .ballRotateChase, color: UIColor.red, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: UIColor.black.withAlphaComponent(0.5), textColor: .white)
    NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
}

func hideLoading(){
    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
}
