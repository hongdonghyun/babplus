//
//  BranchsAddressMapViewController.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/03.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit
import MapKit

class BranchsAddressMapViewController: UIViewController {
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        let coordinate = CLLocationCoordinate2DMake(37.5469894, 127.0513373)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.setRegion(region, animated: true)
        return mapView
    }()
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    private var contents: BabMenu?
    private var pinNameList = [String]()
    private var pinAddressList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        checkAuthorizationStatus()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
    }

    private func checkAuthorizationStatus() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    private func startUpdatingLocation() {
        let status = CLLocationManager.authorizationStatus()
        guard status == .authorizedWhenInUse || status == .authorizedAlways else { return }
        guard CLLocationManager.locationServicesEnabled() else { return }
        locationManager.startUpdatingLocation()
    }
    
    // MARK: API에서 받아온 데이터들
    private func loadData() {
        Constants.APPDELEGATE.dummy?.contents.forEach {
            pinNameList.append($0.name)
            pinAddressList.append($0.address)
        }
    }
    
    // MARK: setupUI
    private func setupUI() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    
        Constants.APPDELEGATE.dummy?.contents.forEach {
            geocodeAddressString(address: $0.address, title: $0.name)
        }
    }
    
    // MARK: 주소 위경도 변환
    private func geocodeAddressString(address addressString: String, title titleString: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placeMark, error) in
            if error != nil {
                return print(error!.localizedDescription)
            }
            guard let place = placeMark?.first else { return }
            let coordinate = place.location?.coordinate
            self.setPin(title: titleString, coordinate: coordinate!)
        }
    }
    
    // MARK: Pin 셋팅
    private func setPin(title: String, coordinate: CLLocationCoordinate2D) {
        let setPoint = MKPointAnnotation()
        setPoint.title = title
        setPoint.coordinate = coordinate
        mapView.addAnnotation(setPoint)
    }
    
    
}

extension BranchsAddressMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let _title = view.annotation?.title, let title = _title, let index = pinNameList.firstIndex(of: title)  else { return }
        let DetailVC = BranchDetailViewController()
        DetailVC.receiveBranchName = title
        DetailVC.receiveAddress = pinAddressList[index]
        navigationController?.isNavigationBarHidden = false
        navigationController?.pushViewController(DetailVC, animated: true)
    }
    
}

extension BranchsAddressMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Authorized")
        default:
            print("Unauthorized")
        }
    }
}
