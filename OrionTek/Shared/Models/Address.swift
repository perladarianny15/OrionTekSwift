//
//  Client.swift
//  OrionTek (iOS)
//
//  Created by Perla Moreno de jesus on 23/6/21.
//

import Foundation


class Address: Identifiable, Codable
{
    public var id: Int = 0
    public var userId: String?
    public var country: String?
    public var city: String?
    public var zipcode: String?
    public var street: String?
    public var streetNumber: String?
}

//class DbAddress: Codable
//{
//    var id: Int
//    var country: String?
//    var city: String?
//    var zipcode: String?
//    var street: String?
//    var streetNumber: String?
//
//    var list : [Address]?
//}
//
//class dbClient: Codable {
//    var id: Int = 1
//    var name: String?
//    var lastname: String?
//    var email: String?
//    var number : String?
//
//    var Address : [Address]?
//}


struct Contact {
  let id: Int32
  let name: NSString
}
