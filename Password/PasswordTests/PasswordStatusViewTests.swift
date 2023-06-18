//
//  PasswordStatusViewTests.swift
//  PasswordTests
//
//  Created by Mesut Gedik on 19.06.2023.
//

import Foundation
import XCTest

@testable import Password

class PasswordStatusViewTests_ShowCheckmarkOrReset_When_Validation_Is_Inline: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true // inline
    }

    /*
     if shouldResetCriteria {
         // Inline validation (✅ or ⚪️)
     } else {
         ...
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthStatusView.isCriteriaOK)
        XCTAssertTrue(statusView.lengthStatusView.isCheckMarkImage) // ✅
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthStatusView.isCriteriaOK)
        XCTAssertTrue(statusView.lengthStatusView.isResetImage) // ⚪️
    }
}

class PasswordStatusViewTests_ShowCheckmarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {

    var statusView: PasswordStatusView!
    let validPassword = "12345678Aa!"
    let tooShort = "123Aa!"

    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false // loss of focus
    }

    /*
     if shouldResetCriteria {
         ...
     } else {
         // Focus lost (✅ or ❌)
     }
     */

    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthStatusView.isCriteriaOK)
        XCTAssertTrue(statusView.lengthStatusView.isCheckMarkImage) // ✅ vermeli
    }

    func testTooShort() throws {
        statusView.updateDisplay(tooShort)
        XCTAssertFalse(statusView.lengthStatusView.isCriteriaOK)
        XCTAssertTrue(statusView.lengthStatusView.isXmarkImage) // ❌ vermeli
    }
}

class PasswordStatusViewTests_Validate_Three_of_Four: XCTestCase {

    var statusView: PasswordStatusView!
    let twoOfFour = "32456123Z"
    let threeOfFour = "32456123Ze"
    let fourOfFour = "132456123Ze!"

    // Verify is valid if three of four criteria met
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }

    func testTwoOfFour() throws {
        XCTAssertFalse(statusView.validate(twoOfFour))
    }
    
    func testThreeOfFour() throws {
        XCTAssertTrue(statusView.validate(threeOfFour))
    }

    func testFourOfFour() throws {
        XCTAssertTrue(statusView.validate(fourOfFour))
    }
}
