//
//  MapasVC.swift
//  xample
//
//  Created by usuario on 1/9/19.
//  Copyright © 2019 usuario. All rights reserved.
//

import UIKit
import MapKit

class MapasVC: UIViewController {
    
    @IBOutlet weak var myMapView: MKMapView!
    @IBOutlet weak var personaVisitaLbl: UILabel!
    @IBOutlet weak var codigoPostalLbl: UILabel!
    @IBOutlet weak var direccionLbl: UILabel!
    @IBOutlet weak var delegacionLbl: UILabel!
    @IBOutlet weak var tiempoestimadoLbl: UILabel!
    @IBOutlet weak var adeudoLbl: UILabel!
    @IBOutlet weak var notasLbl: UILabel!
    
    var personaqueVisita: String!
    var codigoPost: Int!
    var direccion: String!
    var delegacion: String!
    var adeudo: Double!
    var notas: String!
    var tiempoEstimado: String!
    var latitud: Double!
    var longitud: Double!
    
    var empleadoRuta: Empleado?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMapView.delegate = self
        
        if empleadoRuta != nil {
            loadEmpleadoData()
        }
    }
    
    func loadEmpleadoData() {
        if let emp = empleadoRuta {
            personaqueVisita = emp.personaVisitara
            codigoPost = Int(emp.postal)
            direccion = emp.direccion
            delegacion = emp.delegacion
            adeudo = emp.adeudo
            notas = emp.notas
            
            latitud = emp.latitud
            longitud = emp.longitud
            
            personaVisitaLbl.text = "Deudor: \(personaqueVisita!)"
            codigoPostalLbl.text = "C.P.: \(codigoPost!)"
            direccionLbl.text = "Direccion: \(direccion!)"
            delegacionLbl.text = "Del.: \(delegacion!)"
            adeudoLbl.text = "Adeuda: $ \(adeudo!)"
            notasLbl.text = "Nota: \(notas!)"
            
            mapOperations()
        }
    }
    
    func mapOperations() {
        // Dibujar el mapa
        let lat: CLLocationDegrees = 19.2967271 // Torres Esmeralda 19.2967271,-99.1881269
        let lon: CLLocationDegrees = -99.1881269
        let latDelta: CLLocationDegrees = 0.5
        let londelta: CLLocationDegrees = 0.5
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: londelta)
        let coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        myMapView.setRegion(region, animated: true)
        
        // anotaciones
        let annotation = MKPointAnnotation()
        annotation.title = "Ciudad de México"
        annotation.subtitle = "Me encuentro aqui."
        annotation.coordinate = coordinates
        myMapView.addAnnotation(annotation)
        myMapView.selectAnnotation(annotation, animated: true)
        
        // trazando la ruta
        // 19.3948,-99.1736
        let coordinates2 = CLLocationCoordinate2D(latitude:latitud, longitude:longitud)
        
        let sourcePlacemark = MKPlacemark.init(coordinate: coordinates)
        let sourceMapItem = MKMapItem.init(placemark: sourcePlacemark)
        
        let destinationPlacemark = MKPlacemark.init(coordinate: coordinates2)
        let destinationMapItem = MKMapItem.init(placemark: destinationPlacemark)
        
        
        // Obtener Direcciones
        let geocoder = CLGeocoder()
        //        Obtenerlo a traves de un string
        /*geocoder.geocodeAddressString("Napoles, Ciudad de Mexico") { (placemarks, error) in
         if error != nil {
         print(error)
         }
         if let placemarks = placemarks {
         print(placemarks[0].name)
         print(placemarks[0].administrativeArea)
         print(placemarks[0].postalCode)
         print(placemarks[0].areasOfInterest)
         }
         }*/
        
        //        Obtener a traves de un CLLocation
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinates2.latitude, longitude: coordinates2.longitude)) { (placemarks, error) in
            if error != nil {
                print("\(String(describing: error))")
            }
            if let placemarks = placemarks {
                print("\(String(describing: placemarks[0].name!))")
                print("\(String(describing: placemarks[0].administrativeArea!))")
                print("\(String(describing: placemarks[0].postalCode!))")
                print("\(String(describing: placemarks[0].timeZone!))")
            }
        }
        
        
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            print("Distancia: \(route.distance)")
            print("expectedTravelTime: \(route.expectedTravelTime)")
            print("instructions: \(route.steps[0].instructions)")
            
            self.tiempoestimadoLbl.text! = "Tiempo Est.:\(route.expectedTravelTime)"
            
            self.myMapView.addOverlay(route.polyline, level: .aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.myMapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
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

extension MapasVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.lineWidth = 4.0
        render.lineDashPattern = [2,4]
        render.strokeColor = UIColor.red
        render.alpha = 1
        return render
    }
}
