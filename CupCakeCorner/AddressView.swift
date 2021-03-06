//
//  AddressView.swift
//  CupCakeCorner
//
//  Created by Apple on 10/02/21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order : Order
    var body: some View {
        Form{
            Section {
            TextField("Name : ", text : $order.name)
            TextField("Street Address : ", text : $order.streetAddress)
            TextField("City : ", text : $order.city)
            TextField("Zip : ", text : $order.zip)
            }
        
        Section {
            NavigationLink(
                destination: CheckoutView(order : order),
                label: {
                    Text("Check out")
                })
        }.disabled(!order.hasValidAddress)
        }.navigationBarTitle(Text("Delivery details"), displayMode:  .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
