//
//  TweetsTableViewCell.swift
//  TwitterClient
//
//  Created by Douglas on 2/14/16.
//  Copyright © 2016 Dougli. All rights reserved.
//

import UIKit

class TweetsTableViewCell: UITableViewCell {

    @IBOutlet var tweetView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
