//
//  RegistroVC.swift
//  xample
//
//  Created by usuario on 1/7/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class {
    func userDidEnterData(_ nombre:String, paterno:String, materno:String, fechaNacimiento:String, numEmpleado:String, email:String, telefono:String, contra:String, confirmacontra:String)
}

class RegistroVC: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var nombreTxt: UITextField!
    @IBOutlet weak var paternoTxt: UITextField!
    @IBOutlet weak var maternoTxt: UITextField!
    @IBOutlet weak var fechaNacimientoPicker: UIDatePicker!
    @IBOutlet weak var numEmpleadoTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var telefonoTxt: UITextField!
    @IBOutlet weak var contrasenaTxt: UITextField!
    @IBOutlet weak var confirmarContratxt: UITextField!
    var fechaDeNacimiento: String = ""
    
    weak var delegate: DataEnteredDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fechaNacimientoPicker.addTarget(self, action: #selector(valueChanged(_:)), for: UIControl.Event.valueChanged)
    }
    
    @IBAction func btnGuardar(_ sender: Any) {
        delegate?.userDidEnterData(nombreTxt.text!, paterno: paternoTxt.text!, materno: maternoTxt.text!, fechaNacimiento: fechaDeNacimiento, numEmpleado: numEmpleadoTxt.text!, email: emailTxt.text!, telefono: telefonoTxt.text!, contra: contrasenaTxt.text!, confirmacontra: confirmarContratxt.text!)
        
        // regresar al ViewContorller anterior
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
    
    @IBAction func btnCancelarPulsado(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
    
    @objc func valueChanged(_ datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        fechaDeNacimiento = dateFormatter.string(from: datePicker.date)
        print("Fecha Nacimiento: \(fechaDeNacimiento)")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
