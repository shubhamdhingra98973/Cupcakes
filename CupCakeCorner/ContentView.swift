//
//  ContentView.swift
//  CupCakeCorner
//
//  Created by Apple on 10/02/21.
//
//List(results,id: \.trackId) { item in
//    VStack(alignment : .leading) {
//        Text(item.trackId)
//            .font(.headline)
//        Text(item.collectionName)
//    }
//}.onAppear(perform: {
//    loadData()
//})
import SwiftUI
struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form{
                Section {
                    Picker("Select Cake Type", selection : $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value : $order.quantity, in : 3...20) {
                        Text("Number of Cakes : \(order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.specialRequestEnabled.animation(), label: {
                        Text("Any Special Requests?")
                    })
                    
                    if order.specialRequestEnabled {
                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add Extra Frosting")
                        }
                        
                        Toggle(isOn: $order.addSprinkles) {
                            Text("Add Sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order : self.order)) {
                        Text("Delivery Details")
                    }
                }
            }.navigationBarTitle(Text("CupCake Corner"))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//func loadData() {
//    guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
//        print("Invalid URL")
//        return
//    }
//
//    let request = URLRequest(url: url)
//    URLSession.shared.dataTask(with: request) { data, response, error in
//        if let data = data {
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                // we have good data – go back to the main thread
//                DispatchQueue.main.async {
//                    // update our UI
//                    self.results = decodedResponse.results
//                }
//
//                // everything is good, so we can exit
//                return
//            }
//        }
//        print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
//
//    }.resume()
