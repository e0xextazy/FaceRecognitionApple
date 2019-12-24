//
//  ViewController.swift
//  FaceRecognition_v3.0
//
//  Created by Mark Baushenko on 03/12/2019.
//  Copyright © 2019 Mark Berg. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureConstraints()
    }

    private func configureViews() {
        findButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            findButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            findButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: findButton.topAnchor, constant: -10.0),
            signUpButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
}

