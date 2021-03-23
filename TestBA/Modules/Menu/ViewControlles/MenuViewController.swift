//
//  MenuViewController.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 20/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class MenuViewController: BaseViewController {

    @IBOutlet weak var tableMenu: UITableView!
    
    private var viewModel: MenuViewModel = MenuViewModel()
    private var bag = DisposeBag()
    private var itemSelect = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.loadData()
        setupUI()
    }
    
    @IBAction func onClickAction(_ sender: Any) {
        if itemSelect == -1 {
            self.showAlert(message:"Por favor selecciona una accion para poder continuar" , title: "Alerta")
            return
        }
        switch viewModel.data.value[itemSelect].type {
        case .camera:
            let vc: CameraViewController = UIStoryboard.storyboard(storyboard: .menu).instantiateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case .photo:
            let vc: PhotoViewController = UIStoryboard.storyboard(storyboard: .menu).instantiateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case .fullName:
            let vc: TextFieldViewController = UIStoryboard.storyboard(storyboard: .menu).instantiateViewController()
            vc.validateType = .fullname
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case .phone:
            let vc: TextFieldViewController = UIStoryboard.storyboard(storyboard: .menu).instantiateViewController()
            vc.validateType = .phone
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case .birthday:
            let vc: BirthdayViewController = UIStoryboard.storyboard(storyboard: .menu).instantiateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case .gender:
            let vc: GenderViewController = UIStoryboard.storyboard(storyboard: .menu).instantiateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        case .favoriteColor:
            let vc: FavoriteColorViewController = UIStoryboard.storyboard(storyboard: .menu).instantiateViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
            
        }
    
    }
    
    private func setupUI(){
        
        configBackButton(title: "Atras", color: .black, selColor: .clear)
        
        tableMenu.register(UINib(nibName: "MenuLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuLabelTableViewCell")
        
        viewModel.data.asObservable().bind(to: tableMenu.rx.items(cellIdentifier: "MenuLabelTableViewCell", cellType: MenuLabelTableViewCell.self)) { row, model, cell in
            cell.textString = model.type.getText()
            cell.isCheck = row == self.itemSelect
        }.disposed(by: bag)
        
        tableMenu.rx.itemSelected.bind { indexPath in
    
            
            let indexlast = self.itemSelect
            self.itemSelect = indexPath.row
            
            var reloadIndexPath = [ IndexPath(row: self.itemSelect, section: 0) ]
            
            
            if indexlast >= 0 {
                reloadIndexPath.append(IndexPath(row: indexlast, section: 0))
            }
            
            self.tableMenu.reloadRows(at: reloadIndexPath, with: .automatic)
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
        
        viewModel.color.asObservable()
                .bind {  color in
                    if let color = color {
                        self.setupStatusBar(color: color)
                        self.setupNavigarionBar(color: color)
                    }
                }.disposed(by: bag)
        
    }
}
