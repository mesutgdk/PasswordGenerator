//
//  PasswordStatsCriteriaTests.swift
//  PasswordTests
//
//  Created by Mesut Gedik on 18.06.2023.
//

import Foundation
import XCTest
// dont forget cmd+U to run

@testable import Password

class PasswordLengthStatTests: XCTestCase {

    // Boundary conditions 8-32
    
    func testShort() throws { // 7 karakter
        XCTAssertFalse(PasswordStatsCriteria.lenghtStatMet("1234567"))
    }

    func testLong() throws { // 40 karakter
        XCTAssertFalse(PasswordStatsCriteria.lenghtStatMet("1234567891234567890012345678901234567890"))
    }
    
    func testValidShort() throws { // 8 karakter
        XCTAssertTrue(PasswordStatsCriteria.lenghtStatMet("12345678"))
    }

    func testValidLong() throws { // 32 karakter
        XCTAssertTrue(PasswordStatsCriteria.lenghtStatMet("12345678901234567890123456789012"))
    }
}

class PasswordOtherStatsTests: XCTestCase {
    func testSpaceMet() throws {
        XCTAssertTrue(PasswordStatsCriteria.noSpaceStatMet("foranewlifejusttryit"))    }
    
    func testSpaceNotMet () throws {
        XCTAssertFalse(PasswordStatsCriteria.noSpaceStatMet("geco 14"))
    }
    
    func testlenghtAndNoSpaceNotMet() throws {
        XCTAssertFalse(PasswordStatsCriteria.lenghtAndNoSpaceMet("thebigbossisswatchingus ok"))
    }
    
    func testlenghtAndNoSpaceMet() throws {
        XCTAssertTrue(PasswordStatsCriteria.lenghtAndNoSpaceMet("foranewlifejusttryit"))
    }
    
    func testUpperCaseNotMet() throws {
        XCTAssertFalse(PasswordStatsCriteria.upperCaseMet("levelupdeveloper"))
    }
    
    func testUpperCaseMet() throws {
        XCTAssertTrue(PasswordStatsCriteria.upperCaseMet("levelupDeveloper"))
    }
    
    func testLowercaseNotMet() throws {
        XCTAssertFalse(PasswordStatsCriteria.lowercaseMet("RIDE NOW, RIDE TO GONDOR"))
    }
    
    func testLowercaseMet() throws {
        XCTAssertTrue(PasswordStatsCriteria.upperCaseMet("Arise, arise, Riders of Théoden!"))
    }
    
    func testdigitNotMet() throws {
        XCTAssertFalse(PasswordStatsCriteria.digitMet("RIDE NOW, RIDE TO GONDOR"))
    }
    
    func testdigitMet() throws {
        XCTAssertTrue(PasswordStatsCriteria.digitMet("Arise, arise, 14000 Riders of Théoden!"))
    }
    
    func testSpecialCharNotMet() throws {
        XCTAssertFalse(PasswordStatsCriteria.specialCharacterMet("uShallNotPass12390455"))
    }
    
    func testSpecialCharMet() throws {
        XCTAssertTrue(PasswordStatsCriteria.specialCharacterMet("Arise, arise, Riders of Théoden!"))
    }
    
}

