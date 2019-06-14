//
//  ConsultingModel.swift
//  appMedic
//
//  Created by Jeanette Moreno on 5/11/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

class ConsultingModel{
    
    var id: String?
    var consultorio: String?
    var direccion: String?
    var ciudad: String?
    var estado: String?
    
    
    init(id:String?, consultorio:String?, direccion:String?, ciudad:String?, estado:String?) {
        self.id = id;
        self.consultorio = consultorio;
        self.direccion = direccion;
        self.ciudad = ciudad;
        self.estado = estado;
        
    }
}

