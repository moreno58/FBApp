//
//  ViewController.swift
//  appMedic
//
//  Created by Jeanette Moreno on 5/10/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var refBeneficiarys: DatabaseReference!
    
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldRfc: UITextField!
    @IBOutlet weak var textFieldParentezco: UITextField!
   // @IBOutlet weak var labelMessage: UILabel!
    
    @IBOutlet weak var tblBeneficiary: UITableView!
    
    var beneficiarysList = [BeneficiaryModel]()
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let beneficiary = beneficiarysList[indexPath.row]
        let alertController = UIAlertController(title: beneficiary.name, message: "Si desea modificar ingrese los nuevos datos", preferredStyle:.alert)
        
        let  updateAction = UIAlertAction(title: "Modificar", style:.default){(_) in
            let id = beneficiary.id
            let name = alertController.textFields?[0].text
            let rfc = alertController.textFields?[1].text
            let parentezco = alertController.textFields?[2].text
            
            self.updateBeneficiary(id: id!,
                name: name!,
                rfc: rfc!,
                parentezco: parentezco! )
        
    }
        let  deleteAction = UIAlertAction(title: "Eliminar", style:.default){(_) in
            self.deleteBeneficiary(id: beneficiary.id!)
            
        }
        alertController.addTextField{(textField) in
            textField.text = beneficiary.name
        }
        alertController.addTextField{(textField) in
            textField.text = beneficiary.rfc
        }
        alertController.addTextField{(textField) in
            textField.text = beneficiary.parentezco
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        
        present(alertController, animated:true, completion: nil)
}
    func updateBeneficiary(id: String, name: String, rfc: String, parentezco: String){
        let beneficiary = [
            "id": id,
            "Name": name,
            "Rfc": rfc,
            "parentezco": parentezco
        ]
        refBeneficiarys.child(id).setValue(beneficiary)
        
        clean()
    }
    func deleteBeneficiary(id: String){
        refBeneficiarys.child(id).setValue(nil)
        //tblStocktaking.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beneficiarysList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celBene", for: indexPath) as! ViewControllerTableViewCell
        
        let beneficiary: BeneficiaryModel
        
        beneficiary = beneficiarysList[indexPath.row]
        
        cell.labelName.text = beneficiary.name
        cell.labelRfc.text = beneficiary.rfc
        cell.labelParentezco.text = beneficiary.parentezco
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        refBeneficiarys = Database.database().reference().child("beneficiary");
        
        refBeneficiarys.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.beneficiarysList.removeAll()
                
                for beneficiarys in snapshot.children.allObjects as![DataSnapshot]{
                    let beneficiaryObject = beneficiarys.value as? [String: AnyObject]
                    let beneficiaryName = beneficiaryObject?["Name"]
                    let beneficiaryRfc = beneficiaryObject?["Rfc"]
                    let beneficiaryParentezco = beneficiaryObject?["parentezco"]
                    let beneficiaryId = beneficiaryObject?["id"]
                  
                    
                    let beneficiary = BeneficiaryModel(id: beneficiaryId as! String?, name: beneficiaryName as! String?, rfc: beneficiaryRfc as! String?, parentezco: beneficiaryParentezco as! String?)
                    
                    self.beneficiarysList.append(beneficiary)
                }
                self.tblBeneficiary.reloadData()
            }
        })
    }
    
    func addBeneficiary() {
        let key = refBeneficiarys.childByAutoId().key
        let beneficiary = ["id":key,
                           "Name": textFieldName.text! as String,
                           "Rfc": textFieldRfc.text! as String,
                           "parentezco": textFieldParentezco.text! as String]
        refBeneficiarys.child(key!).setValue(beneficiary)
        
       clean()
    }
    
   func clean(){
      textFieldName.text! = ""
        textFieldRfc.text! = ""
      textFieldParentezco.text! = ""
        
   }
    
    @IBAction func buttonAddBeneficiary(_ sender: UIButton) {
        addBeneficiary()
        
    }


}

