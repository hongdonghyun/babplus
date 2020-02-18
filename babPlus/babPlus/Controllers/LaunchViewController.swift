//
//  LaunchViewController.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/06.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    private let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    private let forkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "fork")
        return imageView
    }()
    private let spoonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "spoon")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        RequestHelper().reqTask(path: "menu", method: "GET") { [weak self] (result) in
        guard let _ = self else { return }

            let imageData: [ContentImage] = result.contents.map {
                if let url = URL(string: $0.image ?? ""), let data = try? Data(contentsOf: url) {
                    return ContentImage(name: $0.name, imageData: data)
                }
                return ContentImage(name: $0.name, imageData: nil)
            }
            UserDefaultHelper().addData(contentImg: imageData)

            DispatchQueue.main.async {
                Constants.APPDELEGATE.dummy = result
                Constants.APPDELEGATE.changeRootViewController()
            }
        }
//        Constants.APPDELEGATE.changeRootViewController()
        UIView.animateKeyframes(withDuration: 1.0, delay: 0.0, options: [.repeat], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.spoonImage.transform = .init(rotationAngle: .pi / -27)
                self.forkImage.transform = .init(rotationAngle: .pi / 27)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.5) {
                self.spoonImage.transform = .init(rotationAngle: .pi / -18)
                self.forkImage.transform = .init(rotationAngle: .pi / 18)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.75) {
                self.spoonImage.transform = .init(rotationAngle: .pi / -27)
                self.forkImage.transform = .init(rotationAngle: .pi / 27)
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 1) {
                self.spoonImage.transform = .init(rotationAngle: .pi / -18)
                self.forkImage.transform = .init(rotationAngle: .pi / 18)
            }
        })
        
    }
    
    private func setupUI() {
        let logoSize:CGFloat = view.frame.width / 2
        let margin:CGFloat = 50
        let dishiesWidht:CGFloat = 120
        
        [logoImage, forkImage, spoonImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: logoSize),
            logoImage.heightAnchor.constraint(equalToConstant: logoSize),
            
            forkImage.centerYAnchor.constraint(equalTo: logoImage.bottomAnchor),
            forkImage.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: -margin),
            forkImage.widthAnchor.constraint(equalToConstant: dishiesWidht),
            
            spoonImage.centerYAnchor.constraint(equalTo: logoImage.bottomAnchor),
            spoonImage.trailingAnchor.constraint(equalTo: logoImage.leadingAnchor, constant: margin),
            spoonImage.widthAnchor.constraint(equalToConstant: dishiesWidht),
            
        ])
    }
    
}
