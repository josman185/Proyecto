//
//  PersonaCobranza.swift
//  xample
//
//  Created by usuario on 1/9/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import Foundation

class PersonaCobranza: NSObject {
    
    var nombre: String!
    var direccion: String!
    var codigoPostal: Int = 0
    var personaVisitara: String
    var adeudo: Double
    var notas: String
    var delegacion: String
    var latitud: Double
    var longitud: Double
    var esjefe: Bool
    
    init(nombre:String, direccion:String, postal:Int, personaVisitara:String, adeudo:Double, notas:String, delegacion: String, lat: Double, lon: Double, esjefe:Bool) {
        self.nombre = nombre
        self.direccion = direccion
        self.codigoPostal = postal
        self.personaVisitara = personaVisitara
        self.adeudo = adeudo
        self.notas = notas
        self.delegacion = delegacion
        self.latitud = lat
        self.longitud = lon
        self.esjefe = esjefe
    }
}
