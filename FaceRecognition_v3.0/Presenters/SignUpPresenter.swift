//
//  SignUpPresenter.swift
//  FaceRecognition_v3.0
//
//  Created by Mark Baushenko on 14/12/2019.
//  Copyright © 2019 Mark Berg. All rights reserved.
//

import Foundation

protocol SignUpView: class {
    
}

class SignUpPresenter: NSObject {
    
    private weak var view: SignUpView?
    
    init(view: SignUpView) {
        self.view = view
    }
}
