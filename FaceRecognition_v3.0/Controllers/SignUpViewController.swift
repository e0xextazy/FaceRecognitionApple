//
//  SignUpViewController.swift
//  FaceRecognition_v3.0
//
//  Created by Mark Baushenko on 06/12/2019.
//  Copyright © 2019 Mark Berg. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private var presenter: SignUpPresenter!
    private var imagePicker: ImagePicker!
    
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var faceImage: UIImageView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = SignUpPresenter(view: self)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.faceImageTapped))
        faceImage.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        nameTextField.delegate = self
        surnameTextField.delegate = self
        
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        topText.translatesAutoresizingMaskIntoConstraints = false
        faceImage.translatesAutoresizingMaskIntoConstraints = false
        
        faceImage.backgroundColor = .lightGray
        faceImage.isUserInteractionEnabled = true
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            topText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            topText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            surnameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            surnameTextField.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            nameTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: surnameTextField.topAnchor, constant: -20.0),
            signUpButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20.0),
            surnameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50.0),
            surnameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50.0),
            nameTextField.leftAnchor.constraint(equalTo: surnameTextField.leftAnchor),
            nameTextField.rightAnchor.constraint(equalTo: surnameTextField.rightAnchor),
            faceImage.heightAnchor.constraint(equalToConstant: 150.0),
            faceImage.widthAnchor.constraint(equalToConstant: 150.0),
            faceImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            faceImage.bottomAnchor.constraint(equalTo: nameTextField.topAnchor, constant: -20.0)
        ])
        
        faceImage.layer.cornerRadius = 75
        faceImage.clipsToBounds = true
    }
    
    @IBAction func onSignUpTapped(_ sender:Any) {
        guard let name = nameTextField.text, let surname = surnameTextField.text, let image = faceImage else {
            return
        }
    }
    
    @objc func faceImageTapped(_ sender: Any) {
        imagePicker.present()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension SignUpViewController: SignUpView {
    
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        faceImage.contentMode = .scaleToFill
        faceImage.image = image
    }
}
