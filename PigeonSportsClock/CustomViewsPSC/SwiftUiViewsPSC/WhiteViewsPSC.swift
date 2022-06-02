//
//  WhiteViewsPSC.swift
//  PigeonSportsClock
//
//  Created by Anand on 26/03/22.
//

import SwiftUI

struct WhiteViewsPSC: UIViewRepresentable {
    var style: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView  {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {

    }
}
