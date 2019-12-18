//
//  ImagePicker.swift
//  FaceRecognition_v3.0
//
//  Created by Mark Baushenko on 11/12/2019.
//  Copyright © 2019 Mark Berg. All rights reserved.
//

import UIKit
import Vision

public protocol ImagePickerDelegate: class {
    func didSelect(image: UIImage?)
}

class ImagePicker: NSObject {
    
    private var pickerController: UIImagePickerController!
    private weak var presentationController: UIViewController?
    private weak var delegate: ImagePickerDelegate?
    
    init(presentationController: UIViewController, delegate: ImagePickerDelegate) {
        self.pickerController = UIImagePickerController()
        
        super.init()
        
        self.presentationController = presentationController
        self.delegate = delegate
        
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.pickerController.mediaTypes = ["public.image"]
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.presentationController?.present(self.pickerController, animated: true)
        }
    }
    
    public func present() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if let action = self.action(for: .camera, title: "Take photo") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .savedPhotosAlbum, title: "Camera roll") {
            alertController.addAction(action)
        }
        if let action = self.action(for: .photoLibrary, title: "Photo library") {
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.presentationController?.present(alertController, animated: true)
    }
    
    private func pickerController(_ controller: UIImagePickerController, didSelect image: UIImage?) {
        controller.dismiss(animated: true, completion: nil)
        
        let request = VNDetectFaceRectanglesRequest { (request, error) in
            if let error = error {
                print("Failed to detect:", error)
                return
            }
            request.results?.forEach({ (res) in
                DispatchQueue.main.async {
                    guard let faceObservation = res as? VNFaceObservation else { return }
                    
                    let cx = image!.size.width * faceObservation.boundingBox.origin.x
                    let ch = image!.size.height * faceObservation.boundingBox.height
                    let cy = image!.size.height * (1 - faceObservation.boundingBox.origin.y) - ch
                    let cw = image!.size.width * faceObservation.boundingBox.width
                    let crop = CGRect(x: cx, y: cy, width: cw, height: ch)
                    
                    self.delegate?.didSelect(image: self.cropImage(image: image!, rect: crop))
                }
            })
        }
        guard let cgImage = image!.cgImage else { return }
        
        DispatchQueue.global(qos: .background).async {
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try handler.perform([request])
            } catch let reqErr {
                print("Failed to perform request:", reqErr)
            }
        }
    }
    
    private func cropImage(image: UIImage, rect: CGRect) -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        defer { UIGraphicsEndImageContext() }
    
        image.draw(in: CGRect(origin: CGPoint(x: -rect.origin.x, y: -rect.origin.y), size: image.size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.pickerController(picker, didSelect: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return self.pickerController(picker, didSelect: nil)
        }
        self.pickerController(picker, didSelect: image)
    }
}
