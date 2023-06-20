//
//  PasswordStatsCriteria.swift
//  Password
//
//  Created by Mesut Gedik on 16.06.2023.
//

import Foundation

struct PasswordStatsCriteria {
    // 8-32 arası karakter içersin
    static func lenghtStatMet(_ text: String) -> Bool {
        text.count >= 8 && text.count <= 32
    }
    // No space criteria
    static func noSpaceStatMet(_ text: String) -> Bool {
        text.rangeOfCharacter(from: NSCharacterSet.whitespaces) == nil
    }
    // both 8-32 chars and noSpace criterias
    static func lenghtAndNoSpaceMet(_ text: String) -> Bool {
        lenghtStatMet(text) && noSpaceStatMet(text)
    }
    // büyük harf var mı ?
    static func upperCaseMet(_ text: String) -> Bool {
        text.range(of: "[A-Z]+", options: .regularExpression) != nil
    }
    // küçük harf var mı ?
    static func lowercaseMet(_ text: String) -> Bool {
        text.range(of: "[a-z]+", options: .regularExpression) != nil
    }
    // rakam var mı ?
    static func digitMet(_ text: String) -> Bool {
        text.range(of: "[0-9]+", options: .regularExpression) != nil
    }
    // özel karakter var mı ?
    static func specialCharacterMet(_ text: String) -> Bool {
        // regex escaped @:?!()$#,.\/
        text.range(of: "[.*[^A-Za-z0-9].*]+", options: .regularExpression) != nil
    }
    // ardışık ve tekrarlanan var mı?
    static func hasNoConsecutiveOrRepeatedCharacters(_ text: String) -> Bool {
        text.range(of:"(.)\\1", options: .regularExpression) == nil
    }
    static func hasNoSequentialCharacters(_ text: String) -> Bool {
        let passwordLength = text.count
        
        if passwordLength >= 3 {
            for i in 0..<(passwordLength - 2) {
                let firstChar = text[text.index(text.startIndex, offsetBy: i)]
                let secondChar = text[text.index(text.startIndex, offsetBy: i + 1)]
                let thirdChar = text[text.index(text.startIndex, offsetBy: i + 2)]
                
                if let firstCharASCII = firstChar.asciiValue,
                   let secondCharASCII = secondChar.asciiValue,
                   let thirdCharASCII = thirdChar.asciiValue {
                    if secondCharASCII == firstCharASCII + 1 && thirdCharASCII == secondCharASCII + 1 {
                        return false
                    }
                }
            }
        }
       
        return true
    }
    static func hasNoSequentialAndNoRepeatedCharMet(_ text: String) -> Bool {
        hasNoConsecutiveOrRepeatedCharacters(text) && hasNoSequentialAndNoRepeatedCharMet(text)
    }
    
}

