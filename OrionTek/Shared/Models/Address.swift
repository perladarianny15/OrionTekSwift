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
