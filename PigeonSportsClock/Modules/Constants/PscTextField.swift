//
//  PscTextField.swift
//  PigeonSportsClock
//
//  Created by Anand on 30/03/22.
//

import Foundation
import UIKit


open class PscTexfield : UITextField{

    let rightButton  = UIButton(type: .custom)

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    required public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    func commonInit() {
        rightButton.setImage(UIImage(named: "eyeopen") , for: .normal)
        rightButton.addTarget(self, action: #selector(toggleShowHide), for: .touchUpInside)
        rightButton.frame = CGRect(x: CGFloat(self.frame.size.width), y: CGFloat(5), width: CGFloat(50), height: CGFloat(self.frame.size.height))
        rightButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        rightViewMode = .always
        rightView = rightButton
        isSecureTextEntry = true
    }

    @objc func toggleShowHide(button: UIButton) {
        toggle()
    }

    func toggle() {
        isSecureTextEntry = !isSecureTextEntry
        if isSecureTextEntry {
            rightButton.setImage(UIImage(named: "eyeopen") , for: .normal)
        } else {
            rightButton.setImage(UIImage(named: "eyeclose") , for: .normal)
        }
    }


}
