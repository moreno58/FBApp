//
//  TVCConsulting.swift
//  appMedic
//
//  Created by Jeanette Moreno on 5/11/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit

class TVCConsulting: UITableViewCell {
    
    @IBOutlet weak var lblConsultorio: UILabel!
    @IBOutlet weak var lblDireccion: UILabel!
    @IBOutlet weak var lblCiudad: UILabel!
    @IBOutlet weak var lblEstado: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
