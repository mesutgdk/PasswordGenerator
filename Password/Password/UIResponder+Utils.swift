//
//  UIResponder+Utils.swift
//  Password
//
//  Created by Mesut Gedik on 18.06.2023.
//

import UIKit
// it says who the current responder is in view
extension UIResponder {
    
    private struct Static {
        static weak var responder: UIResponder?
    }
    
    //Finds the current first responder
    // - Returns: the curren UIresponder if it exits
    static func currentFirst () -> UIResponder? {
        Static.responder = nil
        // it fires an event-sending an action to responder chain, and traping and setting itself
        UIApplication.shared.sendAction(#selector(UIResponder._trap), to: nil, from: nil, for: nil)
        return Static.responder
    }
    @objc private func _trap() {
        Static.responder = self
    }
}
