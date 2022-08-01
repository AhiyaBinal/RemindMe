//
//  DisplayDataListCell.swift
//  RemindMe
//
//  Created by Binal Manek on 2022-08-01.
//

import UIKit

class DisplayDataListCell: UITableViewCell {
    
    @IBOutlet weak var lblFriendName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
