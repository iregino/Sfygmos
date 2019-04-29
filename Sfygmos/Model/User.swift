//
//  User.swift
//  Sfygmos
//
//  Created by Ian Regino on 4/19/19.
//  Copyright © 2019 iregino. All rights reserved.
//

import Foundation

struct User {
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var gender: String?
    var email: String?
    var bloodPressures: [BloodPressure]?
}
