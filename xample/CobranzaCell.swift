//
//  CobranzaCell.swift
//  xample
//
//  Created by usuario on 1/10/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit

class CobranzaCell: UITableViewCell {

    
    @IBOutlet weak var nombreCellLbl: UILabel!
    @IBOutlet weak var direccionCellLbl: UILabel!
    
    func configureCell(cellEmp: Empleado) {
        nombreCellLbl.text = cellEmp.nombre
        direccionCellLbl.text = cellEmp.direccion
    }
}
