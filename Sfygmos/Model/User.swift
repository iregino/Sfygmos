//
//  User.swift
//  Sfygmos
//
//  Created by Ian Regino on 4/19/19.
//  Copyright © 2019 iregino. All rights reserved.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var gender: String
    var bloodType: String?
    var email: String?
    
    // Formats date to a custom format
    static var userDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    // Create directory/archive instance to store user data
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bpuser").appendingPathExtension("plist")
    
    // Decode saved user data from archive
    static func loadUser() -> User? {
        guard let codedUser = try? Data(contentsOf: ArchiveURL) else { return nil }
        let properListDecoder = PropertyListDecoder()
        return try? properListDecoder.decode(User.self, from: codedUser)
    } //end loadUser()
    
    // Encode user data and save them to archive
    static func saveUser(_ user: User) {
        let propertyListEncoder = PropertyListEncoder()
        let codedUser = try? propertyListEncoder.encode(user)
        try? codedUser?.write(to: ArchiveURL, options: .noFileProtection)
    } //end saveUser()
    
}

