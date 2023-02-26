//
//  TableViewCell.swift
//  SportsApp
//
//  Created by Sohila on 18/02/2023.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var legLabel: UILabel!
    
    @IBOutlet weak var legImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
    }

}
