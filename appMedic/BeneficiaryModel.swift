//
//  BeneficiaryModel.swift
//  appMedic
//
//  Created by Jeanette Moreno on 5/10/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

class BeneficiaryModel{
    
    var id: String?
    var name: String?
    var rfc: String?
    var parentezco: String?
    
    init(id:String?, name:String?, rfc:String?, parentezco:String?) {
        self.id = id;
        self.name = name;
        self.rfc = rfc;
        self.parentezco = parentezco;
        
    }
}

