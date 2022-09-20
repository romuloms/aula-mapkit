//
//  ViewController.swift
//  AulaMapkitUFSManha
//
//  Created by Student on 20/09/22.
//  Copyright © 2022 Student. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var meuMapa: MKMapView!
    
    var locationManager = CLLocationManager()
    var userLocation = CLLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        meuMapa.showsUserLocation = true
        setupLocationManager()
        addGesture()

        meuMapa.setUserTrackingMode(.follow, animated: false)
        
    }
    
    // Função 01 - Definindo configurações do mapa
    func setupLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    // Função 02 - Definindo localizacao do usuario
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if locations.count > 0 {
            
            if let location = locations.last {
                
                userLocation = location
                print("A localizacao do usuario  é \(userLocation.coordinate)")
                
            }
            
        }
        
    }
    
    // Funcao 03 - Adicionando anotacoes no mapa
    @objc func addAnnotationToMap(gestureRecognizer: UIGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.location(in: meuMapa)
        
        let newCoordinate: CLLocationCoordinate2D = meuMapa.convert(touchPoint, toCoordinateFrom: meuMapa)
        
        let newAnnotation = MKPointAnnotation()
        
        newAnnotation.coordinate = newCoordinate
        newAnnotation.title = "Rômulo"
        newAnnotation.subtitle = String(describing: "Latitude: \(newCoordinate.latitude) \\ Longitude \(newCoordinate.longitude)")
        
        meuMapa.addAnnotation(newAnnotation)
        
    }
    
    // Funcao 04 - Configurar gesto no mapa
    func addGesture() {
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotationToMap(gestureRecognizer:)))
        
        longPress.minimumPressDuration = 0.8
        meuMapa.addGestureRecognizer(longPress)
        
    }
    

}

