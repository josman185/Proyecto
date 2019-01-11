//
//  TablaCobranzaVC.swift
//  xample
//
//  Created by usuario on 1/9/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit
import CoreData

class TablaCobranzaVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var tablaCobranza: UITableView!
    var personasCobranza = [PersonaCobranza]()
    
    // persistencia
    var controller: NSFetchedResultsController<Empleado>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tablaCobranza.delegate = self
        tablaCobranza.dataSource = self
        
        
        /* // Sin persistencia
        let personaCobranza = PersonaCobranza(nombre: "jose", direccion: "Llanura 237", postal: 04500, personaVisitara: "Pedro Picapiedra", adeudo: 5000.00, notas: "No ha pagado su TV", delegacion: "Coyoacan", lat: 19.3095893, lon: -99.1940031, esjefe: true)
        
        let personaCobranza2 = PersonaCobranza(nombre: "salvador", direccion: "WTC", postal: 04500, personaVisitara: "Pablo Marmol", adeudo: 1000.00, notas: "No ha pagado su Refri", delegacion: "Coyoacan", lat: 19.393669, lon: -99.1767865, esjefe: false)
        
        let personaCobranza3 = PersonaCobranza(nombre: "Otro", direccion: "WTC", postal: 04500, personaVisitara: "Pablo Marmol", adeudo: 1000.00, notas: "No ha pagado su Refri", delegacion: "Coyoacan", lat: 19.393669, lon: -99.1767865, esjefe: true)
        
        personasCobranza.append(personaCobranza)
        personasCobranza.append(personaCobranza2)
        personasCobranza.append(personaCobranza3)
        */
        
        // Con persistencia
        //generaDatosPrueba()
        attempFetch()
    }
    
    // MARK: - TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Con Persistencia
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
        
        // Sin persistencia de Datos
        //return personasCobranza.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* // Sin Persistencia
        let cell = tableView.dequeueReusableCell(withIdentifier: "celltablacobranza", for: indexPath)
        cell.textLabel?.text = personasCobranza[(indexPath as NSIndexPath).row].nombre
        return cell
        */
        
        // Con persistencia
        let cell = tableView.dequeueReusableCell(withIdentifier: "celltablacobranza", for: indexPath) as! CobranzaCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: CobranzaCell, indexPath: NSIndexPath) {
        let emp = controller.object(at: indexPath as IndexPath)
        cell.configureCell(cellEmp: emp)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Con persistencia
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let esjefe = objs[indexPath.row].jefe
            if esjefe {
                cell.backgroundColor = UIColor.green
                cell.accessoryType = .detailDisclosureButton
            } else {
                cell.backgroundColor = UIColor.white
            }
        }
        
        /* // Sin persistencia
        let esjefe = personasCobranza[indexPath.row].esjefe
        if esjefe {
            cell.backgroundColor = UIColor.green
            cell.accessoryType = .detailDisclosureButton
        } else {
            cell.backgroundColor = UIColor.white
        }*/
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* // Sin persistencia
        let esjefe = personasCobranza[indexPath.row].esjefe
        if esjefe {
            performSegue(withIdentifier: "seguetoDetalleMapa", sender: self)
        } */
        
        // Con Persistencia
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let emp = objs[indexPath.row]
            let esjefe = objs[indexPath.row].jefe
            if esjefe {
                performSegue(withIdentifier: "seguetoDetalleMapa", sender: emp)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        Con Persistencia
        if segue.identifier == "seguetoDetalleMapa"{
            if let destination = segue.destination as? MapasVC {
                if let empleado = sender as? Empleado {
                    //destination.empleadoRuta = empleado
                    destination.empleadoRuta = empleado
                }
            }
        }
        
//        Sin Persistencia
        /*if segue.identifier == "seguetoDetalleMapa" {
            let row = (self.tablaCobranza.indexPathForSelectedRow! as NSIndexPath).row
                    let detalle = segue.destination as! MapasVC
                    detalle.personaqueVisita = personasCobranza[row].personaVisitara
                    detalle.codigoPost = personasCobranza[row].codigoPostal
                    detalle.direccion = personasCobranza[row].direccion
                    detalle.delegacion = personasCobranza[row].delegacion
                    detalle.adeudo = personasCobranza[row].adeudo
                    detalle.notas = personasCobranza[row].notas
                    detalle.latitud = personasCobranza[row].latitud
                    detalle.longitud = personasCobranza[row].longitud
        }*/
    }
    
    func attempFetch() {
        let fetchRequest: NSFetchRequest<Empleado> = Empleado.fetchRequest()
        let nameSort = NSSortDescriptor(key: "nombre", ascending: false)
        fetchRequest.sortDescriptors = [nameSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tablaCobranza.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tablaCobranza.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tablaCobranza.insertRows(at:[indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tablaCobranza.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .move:
            if let indexPath = indexPath {
                tablaCobranza.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tablaCobranza.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = tablaCobranza.cellForRow(at: indexPath) as! CobranzaCell
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        }
    }
    
    func generaDatosPrueba() {
        let emp = Empleado(context: context)
        emp.nombre = "Jose Manuel"
        emp.direccion = "Llanura 237"
        emp.postal = 04500
        emp.personaVisitara = "Pedro Picapiedra"
        emp.adeudo = 5000.00
        emp.notas = "No ha pagado su TV"
        emp.delegacion = "Coyoacan"
        emp.latitud = 19.3095893
        emp.longitud = -99.1940031
        emp.jefe = true
        
       ad.saveContext()
    }

}
