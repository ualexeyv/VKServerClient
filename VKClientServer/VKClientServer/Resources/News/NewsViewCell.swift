//
//  NewsViewCell.swift
//  VKClientServer
//
//  Created by пользовтель on 21.07.2021.
//

import UIKit

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var attachmentPhotoImage: UIImageView!
    @IBOutlet weak var nameOfGroupOrUserLabel: UILabel!
    @IBOutlet weak var postAvatarImage: UIImageView!
    @IBOutlet weak var NewsTextLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
