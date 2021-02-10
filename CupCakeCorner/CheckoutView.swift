//
//  CheckoutView.swift
//  CupCakeCorner
//
//  Created by Apple on 10/02/21.
//

import SwiftUI
import SystemConfiguration
import Foundation
import UIKit
import SystemConfiguration.CaptiveNetwork

struct CheckoutView: View {
    
    @ObservedObject var order : Order
    @State private var confirmationMessage = ""
    @State private var confirmationTitle = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaleEffect()
                        .frame(width : geo.size.width)
                    
                    Text("Your total cost is \(order.cost , specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }.navigationBarTitle(Text("Check out") , displayMode:  .inline)
        .alert(isPresented: $showingConfirmation, content: {
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        })
    }
    
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode..")
            return
        }
        
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        if !Reachability.isConnectedToNetwork() {
            self.confirmationTitle = "Attention"
            self.confirmationMessage = "There is no internet connection"
            self.showingConfirmation = true
        }
        
        URLSession.shared.dataTask(with: request) { data , response , error in
            
            if error != nil {
                print("Error :\(error?.localizedDescription ?? "Unknown Error")")
                return
            }
            if let data = data {
                if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                    self.confirmationTitle = "Thank you !!"
                    self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes on its way !! "
                    self.showingConfirmation = true
                }
            }
            else {
                print("No data in response !")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
