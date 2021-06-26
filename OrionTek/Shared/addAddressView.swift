//
//  addAddress.swift
//  OrionTek
//
//  Created by Perla Moreno de jesus on 24/6/21.
//

import Foundation
import SwiftUI

struct addAddressView: View {
    
    @State var userId: UUID
    @State var userName: String = ""

    @State var country: String = ""
    @State var city: String = ""
    @State var zipcode: String = ""
    @State var street: String = ""
    @State var streetNumber: String = ""

    var body: some View {
        Form {
            TextField("Country", text: $country)
            TextField("City", text: $city)
            TextField("Zip Code", text: $zipcode)
            TextField("Street", text: $street)
            TextField("Street Number", text: $streetNumber)
            
            Button(action: {
                DbConnection().insertDemo(userName: userName, userId: userId.uuidString, country: self.country, city: self.city, zipcode: self.zipcode, street: self.street, streetNumber: self.streetNumber)
            }) {
                HStack {
                    Spacer()
                    Text("Save")
                        .font(.headline)
                    Spacer()
                }
            }
            
            .padding(.vertical, 10.0)
            .background(Color.purple)
            .padding(.horizontal, 50)
            
        }
        .navigationBarTitle("Add Address")
        
    }
}
