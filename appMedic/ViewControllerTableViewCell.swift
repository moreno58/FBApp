//
//  ViewControllerTableViewCell.swift
//  appMedic
//
//  Created by Jeanette Moreno on 5/10/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelRfc: UILabel!
    @IBOutlet weak var labelParentezco: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
