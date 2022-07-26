//
//  DisplayDataList.swift
//  RemindMe
//
//  Created by Binal Manek on 2022-07-21.
//

import UIKit

class DisplayDataList: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tblFriendList: UITableView!
    var objDBFunctions: DBFunctions = DBFunctions()
    var objFriend: [Friend] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        objFriend = objDBFunctions.read()
        tblFriendList.reloadData()    }

    @IBAction func btnAddPressed(_ sender: Any) {
        guard let objInputDataForm = self.storyboard?.instantiateViewController(withIdentifier: "InputDataForm") as? InputDataForm else { return }
        self.navigationController?.pushViewController(objInputDataForm, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objFriend.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objcell: DisplayDataListCell = tblFriendList.dequeueReusableCell(withIdentifier: "DisplayDataListCell")! as! DisplayDataListCell
        objcell.lblFriendName.text = objFriend[indexPath.row].name
        return objcell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let flagStatus = objDBFunctions.deleteByEmailID(email: objFriend[indexPath.row].email)
            if flagStatus {
                objFriend = objDBFunctions.read()
                tblFriendList.reloadData()
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let objInputDataForm = self.storyboard?.instantiateViewController(withIdentifier: "InputDataForm") as? InputDataForm else { return }
        objInputDataForm.objFriend = objFriend
        objInputDataForm.indexRank = indexPath.row
        self.navigationController?.pushViewController(objInputDataForm, animated: true)
    }
}

