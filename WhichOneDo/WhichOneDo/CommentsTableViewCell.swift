//
//  CommentsTableViewCell.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/23.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    @IBOutlet var comment: UILabel!
    @IBOutlet var time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
