//
//  VCAppointments.swift
//  appMedic
//
//  Created by Jeanette Moreno on 5/11/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VCAppointments: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refAppointments: DatabaseReference!
    
    
    @IBOutlet weak var txtPaciente: UITextField!
    @IBOutlet weak var txtFecha: UITextField!
    @IBOutlet weak var txtHora: UITextField!
    @IBOutlet weak var txtTelefono: UITextField!
    
    @IBOutlet weak var tblAppointments: UITableView!
    
    var appointmentsList = [AppointmentsModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appointments = appointmentsList[indexPath.row]
        let alertController = UIAlertController(title: appointments.consultorio, message: "Si desea modificar ingrese los nuevos datos", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Modificar", style: .default){(_) in
            let id = appointments.id
            let paciente = alertController.textFields?[0].text
            let fecha = alertController.textFields?[1].text
            let hora = alertController.textFields?[2].text
            let telefono = alertController.textFields?[3].text
            
            self.updateAppointments(id: id!,
                                   paciente: paciente!,
                                   fecha: fecha!,
                                   hora: hora!,
                                   telefono: telefono!)
        }
        
        let deleteAction = UIAlertAction(title: "Eliminar", style: .default){(_) in
            self.deleteAppointments(id: appointments.id!)
        
    }
        
        alertController.addTextField{(textField) in
            textField.text = appointments.consultorio
        }
        alertController.addTextField{(textField) in
            textField.text = appointments.direccion
        }
        alertController.addTextField{(textField) in
            textField.text = appointments.ciudad
        }
        alertController.addTextField{(textField) in
            textField.text = appointments.estado
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func updateAppointments(id: String, paciente: String, fecha: String, hora: String, telefono: String){
        let appointments = [
            "id": id,
            "Paciente": paciente,
            "Fecha": fecha,
            "Hora": hora,
            "Telefono": telefono
        ]
        refAppointments.child(id).setValue(appointments)
        
        clean()
    }
    
    func deleteAppointments(id: String){
        refAppointments.child(id).setValue(nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appointmentsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCitas", for: indexPath) as! TVCAppointments
        
        let appointments: AppointmentsModel
        
        appointments = appointmentsList[indexPath.row]
        
        cell.lblPaciente.text = appointments.consultorio
        cell.lblFecha.text = appointments.direccion
        cell.lblHora.text = appointments.ciudad
        cell.lblTelefono.text = appointments.estado
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        refAppointments = Database.database().reference().child("appointments")
        
        refAppointments.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.appointmentsList.removeAll()
                for appointments in snapshot.children.allObjects as![DataSnapshot]{
                    let appointmentsObject = appointments.value as? [String: AnyObject]
                    let appointmentsPaciente = appointmentsObject?["Paciente"]
                    let appointmentsFecha = appointmentsObject?["Fecha"]
                    let appointmentsHora = appointmentsObject?["Hora"]
                    let appointmentsTelefono = appointmentsObject?["Telefono"]
                    let appointmentsId = appointmentsObject?["id"]
                    
                    let appointments = AppointmentsModel(id: appointmentsId as! String?, paciente: appointmentsPaciente as! String?, fecha: appointmentsFecha as! String?, hora: appointmentsHora as! String?, telefono: appointmentsTelefono as! String?)
                    
                    self.appointmentsList.append(appointments)
                }
                self.tblAppointments.reloadData()
            }
        })
    }
    
    func addAppointments() {
        let key = refAppointments.childByAutoId().key
        let appointments = ["id":key,
                            "Paciente":txtPaciente.text! as String,
                            "Fecha":txtFecha.text! as String,
                            "Hora":txtHora.text! as String,
                            "Telefono":txtTelefono.text! as String]
        refAppointments.child(key!).setValue(appointments)
        
        clean()
    }
    
    func clean(){
        txtPaciente.text! = ""
        txtFecha.text! = ""
        txtHora.text! = ""
        txtTelefono.text! = ""
    }
    
    
    @IBAction func addCita(_ sender: UIButton) {
        addAppointments()
    }
    
 
}
