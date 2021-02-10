//
//  SceneView.swift
//  CupCakeCorner
//
//  Created by Apple on 10/02/21.
//

import SwiftUI

struct SceneView: View {
    @State var email = ""
    @State var username = ""
    var body: some View {
        Form {
            Section{
                TextField("Username :", text : $username)
                TextField("Email :", text: $email)
            }
            Section {
                Button("Create Account") {
                    print("Please wait .... work in progress")
                }
            }.disabled(username.count < 5 || email.count < 5)
        }
    }
}

struct SceneView_Previews: PreviewProvider {
    static var previews: some View {
        SceneView()
    }
}
