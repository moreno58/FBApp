//
//  VCConsulting.swift
//  appMedic
//
//  Created by Jeanette Moreno on 5/11/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VCConsulting: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    
    var refConsulting: DatabaseReference!

    @IBOutlet weak var txtConsultorio: UITextField!
    @IBOutlet weak var txtDireccion: UITextField!
    @IBOutlet weak var txtCiudad: UITextField!
    @IBOutlet weak var txtEstado: UITextField!
    
    @IBOutlet weak var tblConsulting: UITableView!
    
    
    var consultingList = [ConsultingModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let consultings = consultingList[indexPath.row]
        let alertController = UIAlertController(title: consultings.consultorio, message: "Si desea modificar ingrese los nuevos datos", preferredStyle: .alert)
        
    let updateAction = UIAlertAction(title: "Modificar", style: .default){ _ in
            
            
           let id = consultings.id
            let consultorio = alertController.textFields?[0].text
            let direccion = alertController.textFields?[1].text
            let ciudad = alertController.textFields?[2].text
            let estado = alertController.textFields?[3].text
            
            self.updateConsulting(id: id!,
                                    consultorio: consultorio!,
                                    direccion: direccion!,
                                    ciudad: ciudad!,
                                    estado: estado!)
        }
        
        let deleteAction = UIAlertAction(title: "Eliminar", style: .default){(_) in
           self.deleteConsulting(id: consultings.id!)
            
        }
        
        alertController.addTextField{(textField) in
            textField.text = consultings.consultorio
        }
        alertController.addTextField{(textField) in
            textField.text = consultings.direccion
        }
        alertController.addTextField{(textField) in
            textField.text = consultings.ciudad
        }
        alertController.addTextField{(textField) in
            textField.text = consultings.estado
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    func updateConsulting(id: String, consultorio: String, direccion: String, ciudad: String, estado: String){
        let consultings = [
            "id": id,
            "Consultorio": consultorio,
            "Direccion": direccion,
            "Ciudad": ciudad,
            "Estado": estado
        ]
        refConsulting.child(id).setValue(consultings)
        
        clean()
    }
    
    func deleteConsulting(id: String){
        refConsulting.child(id).setValue(nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consultingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellConsult", for: indexPath) as! TVCConsulting
        
        let consultings: ConsultingModel
        
        consultings = consultingList[indexPath.row]
        
        cell.lblConsultorio.text = consultings.consultorio
        cell.lblDireccion.text = consultings.direccion
        cell.lblCiudad.text = consultings.ciudad
        cell.lblEstado.text = consultings.estado
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        refConsulting = Database.database().reference().child("consultings")
        
        refConsulting.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.consultingList.removeAll()
                for consultings in snapshot.children.allObjects as![DataSnapshot]{
                    let consultingsObject = consultings.value as? [String: AnyObject]
                    let consultingsConsultorio = consultingsObject?["Consultorio"]
                    let consultingsDireccion = consultingsObject?["Direccion"]
                    let consultingsCiudad = consultingsObject?["Ciudad"]
                    let consultingsEstado = consultingsObject?["Estado"]
                    let consultingsId = consultingsObject?["id"]
                    
                    let consultings = ConsultingModel(id: consultingsId as! String?, consultorio: consultingsConsultorio as! String?, direccion: consultingsDireccion as! String?, ciudad: consultingsCiudad as! String?, estado: consultingsEstado as! String?)
                    
                    self.consultingList.append(consultings)
                }
                self.tblConsulting.reloadData()
            }
        })
    }
    
    func addConsultings() {
        let key = refConsulting.childByAutoId().key
        let consultings = ["id":key,
                            "Consultorio":txtConsultorio.text! as String,
                            "Direccion":txtDireccion.text! as String,
                            "Ciudad":txtCiudad.text! as String,
                            "Estado":txtEstado.text! as String]
        refConsulting.child(key!).setValue(consultings)
        
        clean()
    }
    
    func clean(){
        txtConsultorio.text! = ""
        txtDireccion.text! = ""
        txtCiudad.text! = ""
        txtEstado.text! = ""
    }
    
    @IBAction func addConsulting(_ sender: UIButton) {
        addConsultings()
    }
    

    
    
}
