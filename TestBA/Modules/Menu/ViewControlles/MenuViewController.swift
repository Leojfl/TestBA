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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.loadData()
        setupUI()
    }
    
    @IBAction func onClickAction(_ sender: Any) {
        if viewModel.itemsSelected.isEmpty {
            self.showAlert(message:"Por favor selecciona una accion para poder continuar" , title: "Alerta")
            return
        }
        
        let vc: MenuActionsViewController = UIStoryboard.storyboard(storyboard: .menu).instantiateViewController()
        vc.viewModel = MenuActionsViewModel(itemsSelected: viewModel.itemsSelected)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI(){
        
        configBackButton(title: "Atras", color: .black, selColor: .clear)
        
        tableMenu.register(UINib(nibName: "MenuLabelTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuLabelTableViewCell")
        
        viewModel.data.asObservable().bind(to: tableMenu.rx.items(cellIdentifier: "MenuLabelTableViewCell", cellType: MenuLabelTableViewCell.self)) { row, model, cell in
            cell.textString = model.type.getText()
            cell.isCheck = self.viewModel.isSelected(itemSelect: model)
        }.disposed(by: bag)
        
        tableMenu.rx.itemSelected.bind { indexPath in
            self.viewModel.changeStatusItem( row: indexPath.row)
            self.tableMenu.reloadRows(at: [indexPath], with: .automatic)
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
