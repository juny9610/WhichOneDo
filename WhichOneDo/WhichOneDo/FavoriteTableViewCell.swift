//
//  FavoriteTableViewCell.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/01.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet var cafeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
