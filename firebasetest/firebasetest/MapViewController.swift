//
//  MapViewController.swift
//  firebasetest
//
//  Created by markcloud on 2022/11/02.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    
    var coordinates = [
        CLLocation(latitude: 37.51235719303268, longitude: 127.05875237509075),
        CLLocation(latitude: 37.52235719303269, longitude: 127.07875237509076),
        CLLocation(latitude: 37.53335719303278, longitude: 127.06875237509085),
        CLLocation(latitude: 37.51235719303268, longitude: 127.05875237509075),
        CLLocation(latitude: 37.54236719303368, longitude: 127.08875237509175)
    ]
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        checkUserLocationServicesAithorization()
        setAnnotations(cordinates: coordinates)
    }
}

// MARK: - Func
extension MapViewController {
    private func checkUserLocationServicesAithorization() {
        let authorizationStatus: CLAuthorizationStatus
        authorizationStatus = locationManager.authorizationStatus
        
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스를 켜주세요")
            if let url = URL(string: UIApplication.openSettingsURLString) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    private func setupLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //권한 허용 확인
    private func checkLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            startTrakingUserLocation()
        case .notDetermined:
            print("권한 설정 안됨")
            setupLocationManager()
        default :
            print("권한 설정 거부")
            if let url = URL(string: UIApplication.openSettingsURLString) {
                DispatchQueue.main.async {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    //사용자 위치 추적
    private func startTrakingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    //현재 위치 반영
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 100000, longitudinalMeters: 100000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    //사용자 위치 가져오기
    private func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    private func setAnnotations(cordinates: [CLLocation]) {
        for location in cordinates {
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let long = view.annotation?.coordinate.longitude else { return }
        guard let lat = view.annotation?.coordinate.latitude else { return }
        
        for i in self.coordinates {
            if Double(i.coordinate.longitude) == long && Double(i.coordinate.latitude) == lat {
                print(i)
            }
        }
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        
        mapView.setRegion(region, animated: true)
    }
    
    // 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    //앱이 위치 관리자를 생성하고, 승인 상태가 변경이 될 때 대리자에게 승인 상채를 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
    }
}
