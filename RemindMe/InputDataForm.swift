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
    var flagDOB: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFName, lblField: lblNameRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFPhone, lblField: lblPhoneRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFDOB, lblField: lblDOBRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFEmail, lblField: lblEmailRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFRelation, lblField: lblNameRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFLastName, lblField: lblNameRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFDOAnniversary, lblField: lblNameRequired)

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
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        flagDOB = false
        if textField == txtFDOB {
            flagDOB = true
        }
        if textField == txtFEmail {
            self.setLabelTextFieldUI(flagStatus: false, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "*Email-id can not be changed after added", txtField: txtFEmail, lblField: lblEmailRequired)
        }
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
        txtFDOAnniversary.inputAccessoryView = toolbar
        txtFDOB.inputView = dtPicker
        txtFDOAnniversary.inputView = dtPicker
       }
    @objc func donePressed(){
        let formatter = DateFormatter()
           formatter.dateFormat = "dd/MM/yyyy"
        if flagDOB {
            txtFDOB.text = formatter.string(from: dtPicker.date)
        }
        else{
            txtFDOAnniversary.text = formatter.string(from: dtPicker.date)
        }
           self.view.endEditing(true)
    }
    @IBAction func btnSubmitPressed(_ sender: Any) {

        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFName, lblField: lblNameRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFPhone, lblField: lblPhoneRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFDOB, lblField: lblDOBRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFEmail, lblField: lblEmailRequired)
        self.setLabelTextFieldUI(flagStatus: true, borderWidth: 1.0, borderColor: UIColor.systemGray.cgColor, strAlertMsg: "", txtField: txtFRelation, lblField: lblNameRequired)
        if txtFName.text != "" && txtFEmail.text != "" && txtFDOB.text != "" && txtFPhone.text != "" && txtFRelation.text != ""{
            //DB call
            let emailString = txtFEmail.text!
            let phoneString = txtFPhone.text!
            if objCommonFunction.isValidEmail(email: emailString) && objCommonFunction.isValidPhone(phone: phoneString) {
                //DB Call
                lblEmailRequired.isHidden = true
                lblPhoneRequired.isHidden = true
                if (objFriend.count > 0) {
                    let strQuery = "UPDATE friend SET Name = '\(txtFName.text!)',Surname = '\(txtFLastName.text!)',Relation = '\(txtFRelation.text!)',DOB = '\(txtFDOB.text!)',DOA = '\(txtFDOAnniversary.text!)',Phone = '\(txtFPhone.text!)' WHERE Email = '\(txtFEmail.text!)';"
                    objDBFunctions.update(query: strQuery)
                }
                else {
                objDBFunctions.insert(name: txtFName.text!, surname: txtFLastName.text!, relation: txtFRelation.text!, DOB: txtFDOB.text!, DOA: txtFDOAnniversary.text!, phone: txtFPhone.text!, email: txtFEmail.text!)
                }
                self.navigationController?.popViewController(animated: true)
            }
            if !objCommonFunction.isValidEmail(email: emailString){
                self.setLabelTextFieldUI(flagStatus: false, borderWidth: 1.0, borderColor: UIColor.red.cgColor, strAlertMsg: "*Please Enter Valid Email-id", txtField: txtFName, lblField: lblNameRequired)
            }
            if !objCommonFunction.isValidPhone(phone: phoneString){
                self.setLabelTextFieldUI(flagStatus: false, borderWidth: 1.0, borderColor: UIColor.red.cgColor, strAlertMsg: "*Please Enter Valid Phone No.", txtField: txtFPhone, lblField: lblPhoneRequired)
            }
        }
        if txtFName.text == ""{
            self.setLabelTextFieldUI(flagStatus: false, borderWidth: 1.0, borderColor: UIColor.red.cgColor, strAlertMsg: "*Name is required", txtField: txtFName, lblField: lblNameRequired)
        }
        if txtFEmail.text == ""{
            self.setLabelTextFieldUI(flagStatus: false, borderWidth: 1.0, borderColor: UIColor.red.cgColor, strAlertMsg: "*Email-id is required", txtField: txtFEmail, lblField: lblEmailRequired)
        }
        if txtFDOB.text == ""{
            self.setLabelTextFieldUI(flagStatus: false, borderWidth: 1.0, borderColor: UIColor.red.cgColor, strAlertMsg: "*Date of Birth is required", txtField: txtFDOB, lblField: lblDOBRequired)
        }
        if txtFPhone.text == ""{
            self.setLabelTextFieldUI(flagStatus: false, borderWidth: 1.0, borderColor: UIColor.red.cgColor, strAlertMsg: "*Phone is required", txtField: txtFPhone, lblField: lblPhoneRequired)
        }
        if txtFRelation.text == ""{
            self.setLabelTextFieldUI(flagStatus: false, borderWidth: 1.0, borderColor: UIColor.red.cgColor, strAlertMsg: "*Relation is required", txtField: txtFRelation, lblField: lblRelationRequired)
        }
    }
    func setLabelTextFieldUI(flagStatus: Bool, borderWidth: CGFloat, borderColor: CGColor, strAlertMsg:String, txtField: UITextField,lblField: UILabel) {
            lblField.isHidden = flagStatus
            txtField.layer.borderWidth = borderWidth
            txtField.layer.borderColor = borderColor
            lblField.text = strAlertMsg
    }
}
