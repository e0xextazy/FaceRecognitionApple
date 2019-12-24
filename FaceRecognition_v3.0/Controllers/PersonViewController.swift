//
//  PersonViewController.swift
//  FaceRecognition_v3.0
//
//  Created by Mark Baushenko on 06/12/2019.
//  Copyright © 2019 Mark Berg. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        surnameLabel.translatesAutoresizingMaskIntoConstraints = false
        personImage.translatesAutoresizingMaskIntoConstraints = false
        
        personImage.backgroundColor = .lightGray
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
            surnameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20.0),
            surnameLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            surnameLabel.rightAnchor.constraint(equalTo: nameLabel.rightAnchor),
            personImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            personImage.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -20.0),
            personImage.widthAnchor.constraint(equalToConstant: 300.0),
            personImage.heightAnchor.constraint(equalToConstant: 300.0)
        ])
        
        personImage.layer.cornerRadius = 150
        personImage.clipsToBounds = true
    }
}
