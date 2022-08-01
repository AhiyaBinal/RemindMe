//
//  CommonFunctions.swift
//  RemindMe
//
//  Created by Binal Manek on 2022-07-29.
//

import UIKit

class CommonFunctions: NSObject {
    func isValidEmail(email: String) -> Bool {
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailPattern)
        return emailPred.evaluate(with: email)
    }
    func isValidPhone(phone: String) -> Bool {
        let phonePattern = #"^\(?\d{3}\)?[ -]?\d{3}[ -]?\d{4}$"#
        let phonePred = NSPredicate(format: "SELF MATCHES %@", phonePattern)
        return phonePred.evaluate(with: phone)
    }
}
