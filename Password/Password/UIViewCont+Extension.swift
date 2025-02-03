//
//  UIViewCont+Extension.swift
//  Password
//
//  Created by Mesut Gedik on 3.02.2025.
//

import UIKit

extension UIViewController {
//    @objc func keyboardWillShow(sender: NSNotification) { // keyboard bilgilerini burdan alıyoruz
//        //        view.frame.origin.y = view.frame.origin.y - 200 // it push all view 200 pxl up
//        guard let userInfo = sender.userInfo,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
//              let currentTextField = UIResponder.currentFirst() as? UITextField else {return}
//        
//        //        print("foo - userInfo \(userInfo)")
//        //        print("foo - keyboardFrame \(keyboardFrame)")
//        //        print("foo - currenttextField \(currentTextField)")
//        
//        // check if the top of the keyboard is above the bottom of the currently focused textbox
//        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//        // let textFieldBottomY = currentTextField.frame.origin.y + currentTextField.frame.size.height
//        
//        // textfield kendi koordinat sisteminde dönüyor, çalışmıyor, yukarıdaki yerine parent view koordinat sistemine çevireceğiz
//        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
//        
//        let textFieldBottomY = (convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height)
//        
//        // if textField bottom is below keyboard bottom - push the frame up
//        if textFieldBottomY > keyboardTopY {
//            //adjust view up
//            let textBoxY = convertedTextFieldFrame.origin.y
//            let newFrameY = (textBoxY - keyboardTopY/2) * -1
//            view.frame.origin.y = newFrameY
//        }
//        
//    }
}
