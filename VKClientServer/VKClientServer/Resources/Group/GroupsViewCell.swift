//
//  GroupsViewCell.swift
//  VKClientServer
//
//  Created by пользовтель on 14.07.2021.
//

import UIKit

class GroupsViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var groupAvatarImage: UIImageView!
    @IBOutlet weak var GroupNameLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
