//
//  AnadirEmpCobranza.swift
//  xample
//
//  Created by usuario on 1/10/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class AnadirEmpCobranza: UIViewController {
    
    
    @IBOutlet weak var nombreTxf: UITextField!
    @IBOutlet weak var direccionTxf: UITextField!
    @IBOutlet weak var codigoPostalTxf: UITextField!
    @IBOutlet weak var personaVisitaTxf: UITextField!
    @IBOutlet weak var adeudoTxf: UITextField!
    @IBOutlet weak var notasTxf: UITextField!
    @IBOutlet weak var delegacionTxf: UITextField!
    @IBOutlet weak var latitudTxf: UITextField!
    @IBOutlet weak var longitudTxf: UITextField!
    @IBOutlet weak var esjefeSwitch: UISwitch!
    var esJefe: Bool = false
    
  override  func viewDidLoad() {
        super.viewDidLoad()
    print(esJefe.description)
    esjefeSwitch.addTarget(self, action: #selector(switchIsChanged(mySwitch:)), for: UIControl.Event.valueChanged)
    }
    
    
    @IBAction func btnGuardar(_ sender: Any) {
        let empleado = Empleado(context: context)
        //lat: 19.3095893, lon: -99.1940031
        /*empleado.nombre = "jose"
        empleado.direccion = "llanura 237"
        empleado.postal = 04500
        empleado.personaVisitara = "pedro"
        empleado.adeudo = 123.00
        empleado.notas = "notas de prueba"
        empleado.delegacion = "Coyoacan"
        empleado.latitud = 19.3095893
        empleado.longitud = -99.1940031*/
        if let nombre = nombreTxf.text {
            empleado.nombre = nombre
        }
        if let direccion = direccionTxf.text {
            empleado.direccion = direccion
        }
        if let codigo = codigoPostalTxf.text {
            empleado.postal = Int32(codigo)!
        }
        if let personavisitara = personaVisitaTxf.text {
            empleado.personaVisitara = personavisitara
        }
        if let adeudo = adeudoTxf.text {
            empleado.adeudo = Double(adeudo)!
        }
        if let notas = notasTxf.text {
            empleado.notas = notas
        }
        if let delegacion = delegacionTxf.text {
            empleado.delegacion = delegacion
        }
        if let lat = latitudTxf.text {
            empleado.latitud = Double(lat)!
        }
        if let lon = longitudTxf.text {
            empleado.longitud = Double(lon)!
        }
        
        empleado.jefe = esJefe
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func switchIsChanged(mySwitch: UISwitch) {
        if mySwitch.isOn {
            esJefe = true
            print(esJefe.description)
        } else {
            esJefe = false
            print(esJefe.description)
            
        }
    }
    
}
