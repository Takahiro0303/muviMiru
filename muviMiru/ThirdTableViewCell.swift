//
//  ThirdTableViewCell.swift
//  muviMiru
//
//  Created by takahiro tshuchida on 2017/10/09.
//  Copyright © 2017年 Takahiro Tshuchida. All rights reserved.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieLavel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
