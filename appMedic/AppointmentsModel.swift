//
//  AppointmentsModel.swift
//  appMedic
//
//  Created by Jeanette Moreno on 5/11/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

class AppointmentsModel{
    
    var id: String?
    var consultorio: String?
    var direccion: String?
    var ciudad: String?
    var estado: String?
    
    init(id:String?, paciente:String?, fecha:String?, hora:String?, telefono:String?) {
        self.id = id;
        self.consultorio = paciente;
        self.direccion = fecha;
        self.ciudad = hora;
        self.estado = telefono;
        
    }
    
}
