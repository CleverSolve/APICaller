//
//  BitCoinTableViewCell.swift
//  API Caller
//
//  Created by Work on 9/10/18.
//  Copyright © 2018 CleverSolve. All rights reserved.
//

import UIKit

class BitCoinTableViewCell: UITableViewCell
{
    @IBOutlet weak var Symbol: UILabel!
    @IBOutlet weak var Volume: UILabel!
    @IBOutlet weak var Latest_Trade: UILabel!
    @IBOutlet weak var Weighted_Price: UILabel!
    @IBOutlet weak var Bid: UILabel!
    @IBOutlet weak var High: UILabel!
    @IBOutlet weak var Currency: UILabel!
    @IBOutlet weak var Low: UILabel!
    @IBOutlet weak var Ask: UILabel!
    @IBOutlet weak var Close: UILabel!
    @IBOutlet weak var Average: UILabel!
    @IBOutlet weak var Duration: UILabel!
    @IBOutlet weak var Currency_Volume: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
