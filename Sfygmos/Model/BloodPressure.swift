//
//  BloodPressure.swift
//  Sfygmos
//
//  Created by Ian Regino on 4/19/19.
//  Copyright © 2019 iregino. All rights reserved.
//

import Foundation

struct BloodPressure: Codable {
    var bpDate: Date
    var systolic: Int
    var diastolic: Int
    var pulse: Int
    var weight: Double?
    var weightUnit: String?
    var measurementSite: String
    var notes: String?
    
    // Formats date to a custom format
    static var bpDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        formatter.dateFormat = "MMM d, yyyy  '@' h:mm a"
        return formatter
    }
    
    // Create directory/archive instance to store blood pressure data
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bloodPressures").appendingPathExtension("plist")
    
    // Decode saved blood pressure data from archive
    static func loadBloodPressures() -> [BloodPressure]? {
        guard let codedBPs = try? Data(contentsOf: ArchiveURL) else { return nil }
        let properListDecoder = PropertyListDecoder()
        return try? properListDecoder.decode(Array<BloodPressure>.self, from: codedBPs)
    } //end loadBloodPressures()
    
    // Encode blood pressure data and save them to archive
    static func saveBloodPressures(_ BPs: [BloodPressure]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedBPs = try? propertyListEncoder.encode(BPs)
        try? codedBPs?.write(to: ArchiveURL, options: .noFileProtection)
    } //end saveBloodPressures()
}
