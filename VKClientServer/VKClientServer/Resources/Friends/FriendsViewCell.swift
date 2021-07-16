//
//  FriendsViewCell.swift
//  VKClientServer
//
//  Created by пользовтель on 12.07.2021.
//

import UIKit

class FriendsViewCell: UITableViewCell {

    @IBOutlet weak var avaraImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        fullNameLabel.text = ""
    }

}
