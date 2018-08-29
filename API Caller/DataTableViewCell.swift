//
//  DataTableViewCell.swift
//  API Caller
//
//  Created by Work on 8/29/18.
//  Copyright © 2018 CleverSolve. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var Name: UILabel!
    
    @IBOutlet weak var Price: UILabel!
    
    @IBOutlet weak var stat1: UILabel!
    
    @IBOutlet weak var stat4: UILabel!
    
    @IBOutlet weak var stat2: UILabel!
    
    @IBOutlet weak var stat5: UILabel!
    
    @IBOutlet weak var stat3: UILabel!
    
    @IBOutlet weak var stat6: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
