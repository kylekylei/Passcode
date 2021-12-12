//
//  Password.swift
//  Password
//
//  Created by Kyle Lei on 2021/11/27.
//

import Foundation
import UIKit

func checkPassword(username: String, password: String) -> Password {
    
    var checkResult = Password.createSuccessful
    
      
    guard password.count > 8 else {
        checkResult = .tooShort; return checkResult
    }
    guard password.contains(username) == false else {
        checkResult = .sameUsername; return checkResult
    }

    for mostCommonPassword in PasswordRule.mostCommonPasswords {
        guard password !=  mostCommonPassword  else {
            checkResult = .commonPasswords; return checkResult
        }
    }
    
    
    var isIncludeDigit = false
    var isIncludeLetter = false
    var isIncludeUppercaseLetter = false
    var isIncludeLowercaseLetter = false
    var isIncludePunctuation = false
    
    for character in password {
        if PasswordRule.digits.contains(character) {
            isIncludeDigit = true
        }
        if PasswordRule.punctuation.contains(character) {
            isIncludePunctuation = true
        }
        if PasswordRule.lowercaseLetters.contains(character) {
            isIncludeLowercaseLetter = true
            isIncludeLetter = true
        }
        if PasswordRule.uppercaseLetters.contains(character) {
            isIncludeUppercaseLetter = true
            isIncludeLetter = true
        }
    }
    guard isIncludeDigit else {
        checkResult = .needDigit; return checkResult
    }
    guard isIncludePunctuation else {
        checkResult = .needPunctuation; return checkResult
    }
    guard isIncludeLetter else {
        checkResult = .needLetter; return checkResult
    }
    guard isIncludeLowercaseLetter else {
        checkResult = .needLowercase; return checkResult
    }
    guard isIncludeUppercaseLetter else {
        checkResult = .needUppercase; return checkResult
    }
    
    return checkResult
}

enum InputStatus {
    case usernameEmpty, passwordEmpty, pass
       
    var message: (String, String) {
        switch self {
        case .usernameEmpty:
            return ("Sorry", "Please enter the username")
        case .passwordEmpty:
            return ("Sorry", "Please enter the password")
        case .pass:
            return ("Congratulation", " Your account build successful!")
        }
    }
}

enum Password {
    case rule
    case tooShort, needLetter, needLowercase, needUppercase, needDigit, needPunctuation, commonPasswords, sameUsername
    case createSuccessful
    
    var description: String {
        switch self {
        case .rule:
            return "Strong password include a mix of lower case letters,upper case letters, numbers, and special characters."
        case .tooShort:
            return "Passowords must include at least 8 characters"
        case .needLetter:
            return "Passowords must include at least one regular letter"
        case .needLowercase:
            return "Passowords must include at least one lowercase letter"
        case .needUppercase:
            return "Passowords must include at least one uppercase letter"
        case .needDigit:
            return "Passowords must include at least one digit"
        case .needPunctuation:
            return "Passowords must include one one punctuation character"
        case .commonPasswords:
            return "Passowords doesn't allow to contain the most common passwords"
        case .sameUsername:
            return "Passowords doesn't allow to contain the username"
        case .createSuccessful:
            return ""
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .rule: return .darkGray
        default: return .orange
        }
    }
}
