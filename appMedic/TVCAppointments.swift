//
//  TVCAppointments.swift
//  appMedic
//
//  Created by Jeanette Moreno on 5/11/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit

class TVCAppointments: UITableViewCell {
    
    @IBOutlet weak var lblPaciente: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblTelefono: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
