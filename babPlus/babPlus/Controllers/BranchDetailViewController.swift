//
//  BranchDetailViewController.swift
//  babPlus
//
//  Created by YoujinMac on 2020/02/03.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit
import MapKit

class BranchDetailViewController: UIViewController {
    private let backButtonItem = UINavigationItem()
    private let mapContainerView = UIView()
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2DMake(Constants.mapCenterlat, Constants.mapCenterlon),
            span: Constants.span
        )
        mapView.setRegion(region, animated: true)
        return mapView
    }()
    private let menuTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = 45
        tableView.sectionHeaderHeight = 65
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.APPDELEGATE.dummy?.date
        label.textAlignment = .right
        label.textColor = .darkGray
        return label
    }()
    private lazy var menuArray = Constants.APPDELEGATE.dummy?.contents.filter({ $0.name == self.receiveBranchName }).first
    
    public var receiveAddress = ""
    public var receiveBranchName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = receiveBranchName
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lessthan"), style: .plain, target: self, action: #selector(didTapBackButtonItem(_:)))
        setupUI()
    }
    
    @objc private func didTapBackButtonItem(_ sender : Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupPin()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        receiveBranchName = ""
        receiveAddress = ""
    }
}

extension BranchDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let height = tableView.sectionHeaderHeight
        let width = tableView.frame.width
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let blurView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let titleLabel = UILabel(frame: CGRect(x: imageView.center.x - 50, y: imageView.center.y - 15, width: 100, height: 30))
        
        if section == 0 {
            titleLabel.text = "Lunch"
            imageView.image = UIImage(named: "lunch_image")
            blurView.alpha = 0.5
        } else {
            titleLabel.text = "Dinner"
            imageView.image = UIImage(named: "dinner_image")
            blurView.alpha = 0.6
        }
        
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 23, weight: .bold)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        blurView.backgroundColor = .darkGray
        
        imageView.addSubview(blurView)
        imageView.addSubview(titleLabel)
        headerView.addSubview(imageView)
        
        return headerView
    }
    
}

//MARK: - TableViewDelegate
extension BranchDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionCount = section == 0 ? menuArray?.menus.lunch.count : menuArray?.menus.dinner.count else { return 0 }
        return sectionCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sectionCount = 0
        if !menuArray!.menus.lunch.isEmpty { sectionCount += 1 }
        if !menuArray!.menus.dinner.isEmpty { sectionCount += 1 }
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = menuArray!.menus.lunch[indexPath.row]
        } else {
            cell.textLabel?.text = menuArray!.menus.dinner[indexPath.row]
        }
        cell.textLabel?.font = .systemFont(ofSize: 15)
        cell.backgroundColor = .appColor(.babplusCellBackground)
        return cell
    }
}


// MARK: - mapViewPin
extension BranchDetailViewController {
    private func setupPin() {
        let geocoder = CLGeocoder()
        let pinPoint = MKPointAnnotation()
        
        geocoder.geocodeAddressString(receiveAddress) { (placeMark, error) in
            if error != nil {
                return print(error!.localizedDescription)
            }
            guard let place = placeMark?.first,
            let location = place.location else { return }

            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            pinPoint.title = self.receiveBranchName
            pinPoint.coordinate = place.location!.coordinate
            
            self.mapView.addAnnotation(pinPoint)
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(latitude, longitude), span: Constants.span)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
}

// MARK: - Setup UI
extension BranchDetailViewController {
    private func setupMapView() {
        let safeArea = view.safeAreaLayoutGuide
        let mapSize = self.view.frame.height * 0.3
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapContainerView.translatesAutoresizingMaskIntoConstraints = false
        mapView.addSubview(dateLabel)
        mapContainerView.addSubview(mapView)
        view.addSubview(mapContainerView)
        
        
        NSLayoutConstraint.activate([
            mapContainerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            mapContainerView.heightAnchor.constraint(equalToConstant: mapSize),
            
            dateLabel.topAnchor.constraint(equalTo: mapView.topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            
            mapView.bottomAnchor.constraint(equalTo: mapContainerView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapContainerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapContainerView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: mapSize * 1),
            
        ])
    }
    
    private func setupTableView() {
        let safeArea = view.safeAreaLayoutGuide
        [menuTableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: mapContainerView.bottomAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
    }
    
    private func setupUI() {
        setupMapView()
        setupTableView()
        menuTableView.dataSource = self
        menuTableView.delegate = self
    }
}
