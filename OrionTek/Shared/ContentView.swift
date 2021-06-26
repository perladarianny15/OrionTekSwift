//
//  ContentView.swift
//  Shared
//
//  Created by Perla Moreno de jesus on 23/6/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var newClient  = "";
    @State private var allClients: [ClientItems] = []
    
    private let clientKey = "ClientKey"
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack {
                    TextField("Add Client...", text: $newClient).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button (action: {
                        guard !self.newClient.isEmpty else {return}
                        
                        self.allClients.append(ClientItems(name: self.newClient))
                        
                        self.newClient = ""
                        
                        self.saveClients()
                        
                    }) {
                        Image(systemName: "plus")
                    }.padding()
                }
                
                List {
                    ForEach(allClients) { clientITem in
                        NavigationLink(
                            destination: AddressView(userId: clientITem.id, userName: clientITem.name),
                            label: {
                                Text(clientITem.name)
                            })
                        
                    
                    }.onDelete(perform: deleteClient)
                }
            }.navigationTitle("Clients")
        }.onAppear(perform: {
            readClients()
        })
    }
    
    private func deleteClient(at offsets: IndexSet)
    {
        self.allClients.remove(atOffsets: offsets)
        
        //Update
        
        saveClients()
    }
    
    private func saveClients()
    {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(self.allClients), forKey: clientKey)
    }
    
    private func readClients()
    {
        if let clientsData = UserDefaults.standard.value(forKey: clientKey) as? Data
        {
            if let clientList = try? PropertyListDecoder().decode(Array<ClientItems>.self, from: clientsData)
            {
                self.allClients = clientList
            }
        }
    }
    
}

struct ClientItems: Codable, Identifiable {
    var id = UUID()
    let name : String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
