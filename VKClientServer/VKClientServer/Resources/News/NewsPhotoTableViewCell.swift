//
//  NewsPhotoTableViewCell.swift
//  VKClientServer
//
//  Created by пользовтель on 27.08.2021.
//

import UIKit

class NewsPhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var attachmentPhotoImage: UIImageView!
    @IBOutlet weak var nameOfGroupOrUserLabel: UILabel!
    @IBOutlet weak var postAvatarImage: UIImageView!
    @IBOutlet weak var NewsTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
