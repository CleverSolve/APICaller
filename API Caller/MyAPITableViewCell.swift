//
//  MyAPITableViewCell.swift
//  API Caller
//
//  Created by Work on 9/4/18.
//  Copyright © 2018 CleverSolve. All rights reserved.
//

import UIKit

class MyAPITableViewCell: UITableViewCell
{
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Link: UILabel!
    @IBOutlet weak var ImgUrl: UILabel!
    @IBOutlet weak var NumOfLessons: UILabel!
    @IBOutlet weak var CImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
