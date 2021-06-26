//
//  AddressView.swift
//  OrionTek
//
//  Created by Perla Moreno de jesus on 24/6/21.
//

import Foundation
import SwiftUI

struct AddressView: View {
    @State private var addMode = false
    
    @State private var allAddress: [Address] = []
    
    @State var userId: UUID
    @State var userName: String

    var body: some View {
                    
            VStack {
                List {
                    ForEach(allAddress) { clientITem in
                        GroupBox(
                           label: Label("Address: ", systemImage: "location")
                               .foregroundColor(.purple)
                       ) {
                            Text("Country: \(clientITem.country!)")
                            Text("City: \(clientITem.city!)")
                            Text("Zip Code: \(clientITem.zipcode!)")
                            Text("Street: \(clientITem.street!)")
                            Text("Street Number: \(clientITem.streetNumber!)")

                       }.padding()
                    }
                }
                .navigationBarTitle(Text("Address List of \(userName)"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {

                    self.addMode = true
                    } ) {
                    Image(systemName: "plus")
                        .resizable()
                        .padding(6)
                        .frame(width: 24, height: 24)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .foregroundColor(.white)
                } )
                
                // invisible link inside NavigationView for add mode
                NavigationLink(destination: addAddressView(userId: userId, userName: userName),
                isActive: $addMode) { EmptyView() }
            }.onAppear(perform: {
                readAddress()
            })
        }
    
    private func readAddress()
    {
        
//        let db = DbConnection().DeleteTable()
        
        self.allAddress = DbConnection().getAddress(userId: self.userId)
    }
}
