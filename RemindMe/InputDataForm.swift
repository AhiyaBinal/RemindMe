//
//  InputDataForm.swift
//  RemindMe
//
//  Created by Binal Manek on 2022-07-21.
//

import UIKit

class InputDataForm: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtFDOAnniversary: UITextField!
    @IBOutlet weak var txtFDOB: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFPhone: UITextField!
    @IBOutlet weak var txtFRelation: UITextField!
    @IBOutlet weak var txtFLastName: UITextField!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var scrlVMain: UIScrollView!
    let dtPicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        self.showDatePicker()
    }
   
    @objc func keyboardWillHide(notification: NSNotification) {
        scrlVMain.contentInset = .zero
        scrlVMain.scrollIndicatorInsets = .zero
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    func showDatePicker(){
        dtPicker.datePickerMode = .date
        dtPicker.preferredDatePickerStyle = .inline
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let btnDone =  UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(donePressed))
        let btnSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([btnSpace,btnDone], animated: false)
        txtFDOB.inputAccessoryView = toolbar
        txtFDOB.inputView = dtPicker
       }
    @objc func donePressed(){
        let formatter = DateFormatter()
           formatter.dateFormat = "dd/MM/yyyy"
           txtFDOB.text = formatter.string(from: dtPicker.date)
           self.view.endEditing(true)
    }
}
