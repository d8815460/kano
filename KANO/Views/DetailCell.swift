//
//  DetailCell.swift
//  KANO
//
//  Created by 陳駿逸 on 2018/8/14.
//  Copyright © 2018年 陳駿逸. All rights reserved.
//

import UIKit

enum DETAIL: Int {
    case TITLE              = 0
    case RELEASEDATE        = 1
    case DURATION           = 2
    case GENRES             = 3
    case SYNOPSIS           = 4
    case HOMEPAGE           = 5
    case ORIGINALLANGUAGE   = 6
    case SPOKENLANGUAGE     = 7
    case POPULARITY         = 8
}

class DetailCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
