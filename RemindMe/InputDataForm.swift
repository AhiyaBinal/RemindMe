//
//  InputDataForm.swift
//  RemindMe
//
//  Created by Binal Manek on 2022-07-21.
//

import UIKit

class InputDataForm: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var lblNameRequired: UILabel!
    @IBOutlet weak var lblRelationRequired: UILabel!
    @IBOutlet weak var lblPhoneRequired: UILabel!
    @IBOutlet weak var lblDOBRequired: UILabel!
    @IBOutlet weak var lblEmailRequired: UILabel!
    @IBOutlet weak var txtFDOAnniversary: UITextField!
    @IBOutlet weak var txtFDOB: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFPhone: UITextField!
    @IBOutlet weak var txtFRelation: UITextField!
    @IBOutlet weak var txtFLastName: UITextField!
    @IBOutlet weak var txtFName: UITextField!
    @IBOutlet weak var scrlVMain: UIScrollView!
    let dtPicker = UIDatePicker()
    var objCommonFunction: CommonFunctions = CommonFunctions()
    var objDBFunctions: DBFunctions = DBFunctions()
    var objFriend: [Friend] = []
    var strTry: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        if (objFriend.count > 0) {
            txtFName.text = objFriend[0].name
            txtFLastName.text = objFriend[0].surname
            txtFRelation.text = objFriend[0].relation
            txtFDOB.text = objFriend[0].DOB
            txtFDOAnniversary.text = objFriend[0].DOA
            txtFEmail.text = objFriend[0].email
            txtFPhone.text = objFriend[0].phone
        }
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardDidShow(notification:)),
            name: UIResponder.keyboardDidShowNotification, object: nil)
            NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardDidHide(notification:)),
            name: UIResponder.keyboardDidHideNotification, object: nil)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        self.showDatePicker()
    }
    //MARK: Methods to manage keybaord
    @objc func keyboardDidShow(notification: NSNotification) {
        let info = notification.userInfo
        let keyBoardSize = info![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        scrlVMain.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
        scrlVMain.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
    }
    @objc func keyboardDidHide(notification: NSNotification) {
        
        scrlVMain.contentInset = UIEdgeInsets.zero
        scrlVMain.scrollIndicatorInsets = UIEdgeInsets.zero
    }
    //MARK: TextField Delegate Method
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           self.view.endEditing(true)
           return false
       }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    //MARK: Methods to manage DatePicker
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
   
    @IBAction func btnSubmitPressed(_ sender: Any) {
        lblNameRequired.isHidden = true
        lblPhoneRequired.isHidden = true
        lblDOBRequired.isHidden = true
        lblEmailRequired.isHidden = true
        lblRelationRequired.isHidden = true
        
        if txtFName.text != "" && txtFEmail.text != "" && txtFDOB.text != "" && txtFPhone.text != "" && txtFRelation.text != ""{
            //DB call
            let emailString = txtFEmail.text!
            let phoneString = txtFPhone.text!
            if objCommonFunction.isValidEmail(email: emailString) && objCommonFunction.isValidPhone(phone: phoneString) {
                //DB Call
                lblEmailRequired.isHidden = true
                lblPhoneRequired.isHidden = true
                lblEmailRequired.text = "*Email-id is required"
                lblPhoneRequired.text = "*Phone is required"
                print("All Good....")
                objDBFunctions.insert(name: txtFName.text!, surname: txtFLastName.text!, relation: txtFRelation.text!, DOB: txtFDOB.text!, DOA: txtFDOAnniversary.text!, phone: txtFPhone.text!, email: txtFEmail.text!)
                objFriend = objDBFunctions.read()
                print("Yes Finally\(objFriend[0].name)")
            }
            if !objCommonFunction.isValidEmail(email: emailString){
                lblEmailRequired.isHidden = false
                lblEmailRequired.text = "Please Enter Valid Email-id"
            }
            if !objCommonFunction.isValidPhone(phone: phoneString){
                lblPhoneRequired.isHidden = false
                lblPhoneRequired.text = "Please Enter Valid Phone Number"
            }
        }
        if txtFName.text == ""{
            lblNameRequired.isHidden = false
        }
        if txtFEmail.text == ""{
            lblEmailRequired.isHidden = false
        }
        if txtFDOB.text == ""{
            lblDOBRequired.isHidden = false
        }
        if txtFPhone.text == ""{
            lblPhoneRequired.isHidden = false
        }
        if txtFRelation.text == ""{
            lblRelationRequired.isHidden = false
        }
    }
}
