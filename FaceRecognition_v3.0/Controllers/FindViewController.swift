//
//  FindViewController.swift
//  FaceRecognition_v3.0
//
//  Created by Mark Baushenko on 06/12/2019.
//  Copyright © 2019 Mark Berg. All rights reserved.
//

import UIKit

class FindViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var presenter: SignUpPresenter!
    private var imagePicker: ImagePicker!
    
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var faceImage: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = SignUpPresenter(view: self)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.faceImageTapped))
        faceImage.addGestureRecognizer(tap)
        
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        findButton.translatesAutoresizingMaskIntoConstraints = false
        topText.translatesAutoresizingMaskIntoConstraints = false
        faceImage.translatesAutoresizingMaskIntoConstraints = false
        
        faceImage.backgroundColor = .lightGray
        faceImage.isUserInteractionEnabled = true
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            topText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            topText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            findButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            findButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            faceImage.heightAnchor.constraint(equalToConstant: 150.0),
            faceImage.widthAnchor.constraint(equalToConstant: 150.0),
            faceImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            faceImage.bottomAnchor.constraint(equalTo: findButton.topAnchor, constant: -20.0)
        ])
        
        faceImage.layer.cornerRadius = 75
        faceImage.clipsToBounds = true
    }
    
    @objc func faceImageTapped(_ sender: Any) {
        imagePicker.present()
    }
}

extension FindViewController: SignUpView {
    
}

extension FindViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        faceImage.contentMode = .scaleToFill
        faceImage.image = image
    }
}
