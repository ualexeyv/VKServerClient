//
//  NewsViewCell.swift
//  VKClientServer
//
//  Created by пользовтель on 21.07.2021.
//

import UIKit

class NewsViewCell: UITableViewCell {

    @IBOutlet weak var NewsTextLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
