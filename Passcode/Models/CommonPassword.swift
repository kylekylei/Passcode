//
//  CommonPassword.swift
//  Password
//
//  Created by Kyle Lei on 2021/12/11.
//

import Foundation

class PasswordRule {
    static let mostCommonPasswords = [
        "123456",
        "password",
        "12345678",
        "qwerty",
        "12345",
        "123456789",
        "letmein",
        "1234567",
        "football",
        "iloveyou"
    ]
    static let digits = "0123456789"
    static let punctuation = "!@#$%^&*(),.<>;'`~[]{}\\|/?_-+="
    static let lowercaseLetters = "abcdefghijklmnopqrstuvwxyz"
    static let uppercaseLetters = lowercaseLetters.uppercased()
}
