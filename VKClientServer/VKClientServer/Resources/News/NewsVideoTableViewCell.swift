//
//  NewsVideoTableViewCell.swift
//  VKClientServer
//
//  Created by пользовтель on 27.08.2021.
//

import UIKit

class NewsVideoTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarNewsImage: UIImageView!
    @IBOutlet weak var videoNewsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
