//
//  ViewControllerTests.swift
//  PasswordTests
//
//  Created by Mesut Gedik on 19.06.2023.
//

import Foundation
import XCTest

@testable import Password

class ViewControllerTests_NewPassword_Validation: XCTestCase {

    var vc: ViewController!
    let validPassword = "9999999Aa!"
    let tooShort = "9876Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }

    /*
     Here we trigger those criteria blocks by entering text,
     clicking the reset password button, and then checking
     the error label text for the right message.
     */
    
    func testEmptyPassword() throws {
        vc.newPasswordText = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "Enter your Password")
    }
    func testInvalidPassword() throws {
        vc.newPasswordText = "🤬"
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "Enter valid special chars .,:;@!+-&/?#$₺() with no spaces")
    }

    func testCriteriaNotMet() throws {
        vc.newPasswordText = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "Your password must meet the requirement below")
    }

    func testValidPassword() throws {
        vc.newPasswordText = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "")
    }
}
