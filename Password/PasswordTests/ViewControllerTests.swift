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
        vc.passwordText1 = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "Enter your Password")
    }
    func testInvalidPassword() throws {
        vc.passwordText1 = "🤬"
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "Enter valid special chars .,:;@!+-&/?#$₺() with no spaces")
    }

    func testCriteriaNotMet() throws {
        vc.passwordText1 = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "Your password must meet the requirement below")
    }

    func testValidPassword() throws {
        vc.passwordText1 = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "")
    }
}

class ViewControllerTests_Second_Password_Validation: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.passwordText2 = ""
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField2.errorLabel.text!, "Enter your Password.")
    }
    func testInvalidPassword() throws {
        vc.passwordText1 = validPassword
        vc.passwordText2 = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField2.errorLabel.text!, "Passwords do not match.")
    }


    func testValidPassword() throws {
        vc.passwordText1 = validPassword
        vc.passwordText2 = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())
        
        XCTAssertEqual(vc.passwordTextField.errorLabel.text!, "")
    }
}

class ViewControllerTests_Show_Alert: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testShowSuccess() throws {
        vc.passwordText1 = validPassword
        vc.passwordText2 = validPassword
        vc.resetPasswordButtonTapped(sender: UIButton())

        XCTAssertNotNil(vc.alert)
        XCTAssertEqual(vc.alert!.title, "Success") // Optional
    }

    func testShowError() throws {
        vc.passwordText1 = validPassword
        vc.passwordText2 = tooShort
        vc.resetPasswordButtonTapped(sender: UIButton())

        XCTAssertNil(vc.alert)
    }
}
