//
//  DisplayDataList.swift
//  RemindMe
//
//  Created by Binal Manek on 2022-07-21.
//

import UIKit

class DisplayDataList: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tblFriendList: UITableView!
    var objDBFunctions: DBFunctions = DBFunctions()
    var objFriend: [Friend] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        objFriend = objDBFunctions.read()
        tblFriendList.reloadData()
    }

    @IBAction func btnAddPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "moveToInputDataForm", sender: self)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objFriend.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let objcell: DisplayDataListCell = tblFriendList.dequeueReusableCell(withIdentifier: "DisplayDataListCell")! as! DisplayDataListCell
        objcell.lblFriendName.text = objFriend[indexPath.row].name
        return objcell
    }
    func selectRow(at indexPath: IndexPath?, animated: Bool, scrollPosition: UITableView.ScrollPosition)
    {
        
    }
}

