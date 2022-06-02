//
//  SideMenuView.swift
//  PigeonSportsClock
//
//  Created by Anand on 26/03/22.
//

import SwiftUI
import UIKit

//@Binding var animatePath: Bool = true
//@Binding var animatedBG: Bool?

struct SideMenuView: View {

    @Environment(\.presentationMode) private var presentationMode
    var dismissAction : (() -> Void)
    @State var animatePath: Bool = false
    @State var animatedBG: Bool = false
    @State private var showdetails = false
    var body: some View {

        ZStack{

            WhiteViewsPSC(style: .systemUltraThinMaterialDark)

            LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)



//            Content...
            VStack(alignment: .leading, spacing: 5){
                Button(action: {
                    print("Button Tapped")
//                    self.presentationMode.wrappedValue.dismiss()






                }, label: {
                    Image(systemName: "xmark.circle")
                    .font(.title)
                })



                .foregroundColor(Color.white)
                // Menu Buttons....
                    Group {
                MenuButton(title: "My Profile", image: "profile-img", offset: 10)
                MenuButton(title: "Home", image: "Home-1", offset: 10)
                MenuButton(title: "Loft", image: "loft", offset: 10)
                MenuButton(title: "Basketing", image: "basketing", offset: 10)
                MenuButton(title: "Results", image: "result", offset: 10)
                MenuButton(title: "Gallery", image: "gallery", offset: 10)
                MenuButton(title: "All Fanciers", image: "all-fancier", offset: 10)
                MenuButton(title: "Notification", image: "notification", offset: 10)
                MenuButton(title: "Subscription", image: "subscription", offset: 10)
                        Group {
                MenuButton(title: "App Info", image: "app-info", offset: 10)
                           //Spacer(minLength: 60)
                MenuButton(title: "LOGOUT", image: "logout", offset: 10)
                        }
                }
            }
            .padding(.trailing,170)
            .padding()
            .padding(.top,getsafeArea().top)
            .padding(.bottom,getsafeArea().bottom)
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)


        }.navigationBarBackButtonHidden(true)
            .clipShape(Menushape())
        .background(
            Menushape()
                .stroke(
                    .linearGradient(.init(colors: [

                        Color.blue,
                        Color.blue
                          .opacity(0.7),
                        Color.red
                          .opacity(0.7),
                        Color.red,
                        Color.clear,


                    ]), startPoint: .top, endPoint: .bottom),
                    lineWidth: 7
                )
                .padding(.leading, -50)

        )
        .ignoresSafeArea()
    }
    @ViewBuilder
    func MenuButton(title: String,image: String,offset: CGFloat)-> some View{
        Button{

        }label: {
            HStack(spacing: 5){
                if image == "profile-img"{
                    //Asset Image
                    Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 25, height: 25)
                    .clipShape(Circle())


                }
                else{
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.white)
                }
                Text(title)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundColor(Color.white)
            }
            .padding(.vertical)
        }
        .offset(x: offset)
    }


}
//
struct SideMenuView_Preview: PreviewProvider {
    static var previews: some View {
        SideMenuView {

        }
    }

}

struct Menushape: Shape{
//    var value: CGFloat
//    var animatableData: CGFloat{
//        get{return value}
//        set{value = newValue}
//
//    }
    func path(in rect: CGRect) -> Path {
        return Path{path in

            let width = rect.width - 100
            let height = rect.height

            path.move(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
            // curve...
            path.move(to: CGPoint(x: width, y: 0))
            path.addCurve(to: CGPoint(x: width, y: height + 100), control1: CGPoint(x: width + 150, y: height / 3), control2: CGPoint(x: width - 150, y: height / 2))

        }
    }


}




extension View{
    func getsafeArea()->UIEdgeInsets{

        guard let screen = UIApplication.shared.connectedScenes.first as?
                UIWindowScene else{
                    return.zero
                }
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return.zero

        }
        return safeArea
                }
    func getRect()->CGRect{
        return UIScreen.main.bounds
    }


}
