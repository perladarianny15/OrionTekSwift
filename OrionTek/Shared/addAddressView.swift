//
//  addAddress.swift
//  OrionTek
//
//  Created by Perla Moreno de jesus on 24/6/21.
//

import Foundation
import SwiftUI

struct addAddressView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var userId: UUID
    @State var userName: String = ""

    @State var country: String = ""
    @State var city: String = ""
    @State var zipcode: String = ""
    @State var street: String = ""
    @State var streetNumber: String = ""
    @State var result: Bool = false

    var body: some View {
        
        Form {
            TextField("Country", text: $country)
            Text("Country is required")
            TextField("City", text: $city)
            TextField("Zip Code", text: $zipcode)
            TextField("Street", text: $street)
            TextField("Street Number", text: $streetNumber)
            
            Button(action: {
                result = DbConnection().insertDemo(userName: userName, userId: userId.uuidString, country: self.country, city: self.city, zipcode: self.zipcode, street: self.street, streetNumber: self.streetNumber)
                
                if result == true
                {
                    presentationMode.wrappedValue.dismiss()
                }
                
            }) {
                HStack {
                    Spacer()
                    Text("Save")
                        .font(.headline)
                        .cornerRadius(10)
                        .foregroundColor(Color.white)

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
