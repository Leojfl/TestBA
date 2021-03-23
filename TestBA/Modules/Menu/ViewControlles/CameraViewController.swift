//
//  CameraViewController.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit

class CameraViewController: UIViewController {
    
    @IBOutlet weak var imgCamera: UIImageView!
    
    private func setupUI() {
        imgCamera.isUserInteractionEnabled = true
        imgCamera.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSelectImage)))
    }
    
    @objc
    private func onSelectImage(){


        let alert = UIAlertController(title: "Selecciona una image",
                                       message: "Por favor selecciona una imagen para mostrar.",
                                       preferredStyle: .actionSheet)

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        let cameraAction = UIAlertAction(title: "Camara",
                                         style: .default,
                                         handler: {_ in
                                            imagePicker.sourceType = .camera
                                            self.present(imagePicker, animated: true)
                                         })

        let libraryAction = UIAlertAction(title: "Fotos",
                                          style: .default,
                                          handler: { _ in
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker, animated: true)
                                          })
        


        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .cancel,
                                         handler: nil)

        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)

        self.present(alert, animated: true, completion: nil)
        
    }
    
    func show( image: UIImage) {
        imgCamera.image = image
        imgCamera.contentMode = .scaleAspectFit
    }
  
    
    
}

extension CameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        let image: UIImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        show(image: image)
        dismiss(animated: true, completion: nil)
    }
}

