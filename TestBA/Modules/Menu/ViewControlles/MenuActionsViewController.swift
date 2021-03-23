//
//  MenuActionsViewController.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit
import RxCocoa
import RxSwift

class MenuActionsViewController: BaseViewController {
    
    @IBOutlet weak var tableActions: UITableView!
    
    public var viewModel: MenuActionsViewModel!
    private var bag = DisposeBag()
    
    
    var cameraImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        viewModel.loadData()
    }
    
    
    private func setupUI(){
        
        tableActions.rowHeight = UITableView.automaticDimension
        tableActions.register(UINib(nibName: "CameraTableViewCell", bundle: nil), forCellReuseIdentifier: "CameraTableViewCell")
        
        tableActions.register(UINib(nibName: "TextFieldTableViewCell", bundle: nil), forCellReuseIdentifier: "TextFieldTableViewCell")
        
        tableActions.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        
        tableActions.register(UINib(nibName: "BithdayTableViewCell", bundle: nil), forCellReuseIdentifier: "BithdayTableViewCell")
                
        tableActions.register(UINib(nibName: "GenderTableViewCell", bundle: nil), forCellReuseIdentifier: "GenderTableViewCell")
        
        tableActions.register(UINib(nibName: "ColorTableTableViewCell", bundle: nil), forCellReuseIdentifier: "ColorTableTableViewCell")
        
        
        
        
        viewModel.data.asObservable().bind(to: tableActions.rx.items) { tableview, row, model -> UITableViewCell in
            let indexPath = IndexPath(row: row, section: 0)
            
            
            switch model.type {
            case .camera:
                let cell = tableview.dequeueReusableCell(withIdentifier: "CameraTableViewCell", for: indexPath) as! CameraTableViewCell
                cell.selectionStyle = .none
                cell.handleOnClickImage = {
                    self.actionCameraCell()
                }
                if let image = self.cameraImage{
                    cell.show(image: image)
                }
                return cell
            case .photo:
                let cell = tableview.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
                cell.handleError = { title, message in
                    self.showAlert(message: title, title: message)
                }   
                cell.selectionStyle = .none
                return cell
            case .fullName:
                
                let cell = tableview.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
                cell.selectionStyle = .none
                cell.validateType = .fullname
                cell.lastText = self.viewModel.fullName
                cell.handleSave = { text in
                    self.viewModel.saveTextFullName(text: text)
                }
                return cell
            case .phone:
                let cell = tableview.dequeueReusableCell(withIdentifier: "TextFieldTableViewCell", for: indexPath) as! TextFieldTableViewCell
                    cell.selectionStyle = .none
                cell.validateType = .phone
                cell.lastText = self.viewModel.phone
                cell.handleSave = { text in
                    self.viewModel.saveTextPhone(text: text)
                }
                return cell
            case .birthday:
                
                let cell = tableview.dequeueReusableCell(withIdentifier: "BithdayTableViewCell", for: indexPath) as! BithdayTableViewCell
                cell.selectionStyle = .none
                
                cell.lastBirthdayString = self.viewModel.birthday
                cell.handleSave = { text in
                    self.viewModel.saveTextBirthday(text: text)
                }
                return cell
            case .gender:
                let cell = tableview.dequeueReusableCell(withIdentifier: "GenderTableViewCell", for: indexPath) as! GenderTableViewCell
                
                cell.selectionStyle = .none
                cell.lastGenderString = self.viewModel.gender
                cell.handleSave = { text in
                    self.viewModel.saveGender(text: text)
                }
                return cell
            case .favoriteColor:
                
                let cell = tableview.dequeueReusableCell(withIdentifier: "ColorTableTableViewCell", for: indexPath) as! ColorTableTableViewCell
                cell.selectionStyle = .none
                cell.handleSelectColor = { color in
                    if let color =  color {
                        self.setupStatusBar(color: color)
                        self.setupNavigarionBar(color: color)
                        self.viewModel.saveColor(color: color)
                    }
                }
                return cell
                
            }
            
        }.disposed(by: bag)
        
        
        
    }
    
    private func setupBindings(){
        
        viewModel.needsLoading.asObservable()
                .bind {  isLoading in
                    if isLoading {
                        self.start()
                    }else{
                        self.stop()
                    }
                }.disposed(by: bag)
        
        
    }
    
    
    


    
}

// MARK: CAMERA CELL
extension MenuActionsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                                        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        cameraImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if let index = viewModel.getIndex(type: .camera){
            tableActions.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        dismiss(animated: true, completion: nil)
    }
    
    private func actionCameraCell(){
        
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
}

