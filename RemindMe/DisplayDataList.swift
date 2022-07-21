//
//  DisplayDataList.swift
//  RemindMe
//
//  Created by Binal Manek on 2022-07-21.
//

import UIKit

class DisplayDataList: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnAddPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "pushToFormViewController", sender: self)
    }
}

