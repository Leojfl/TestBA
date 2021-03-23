//
//  FavoriteColorViewController.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteColorViewController: BaseViewController {
    
    @IBOutlet weak var tableColor: UITableView!
    var viewModel = ColorViewModel()
    private var bag = DisposeBag()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        setupUI()
    }
    
    private func setupUI() {
        setupTable()
        viewModel.loadData()
    }
    
    private func setupBinding(){
        viewModel.needsLoading.asObservable()
                .bind {  isLoading in
                    if isLoading {
                        self.start()
                    }else{
                        self.stop()
                    }
                }.disposed(by: bag)
        
    }
    
    private func setupTable(){
        
        tableColor.register(UINib(nibName: "ColorTableViewCell", bundle: nil), forCellReuseIdentifier: "ColorTableViewCell")
        
        viewModel.colors.asObservable().bind(to: tableColor.rx.items(cellIdentifier: "ColorTableViewCell", cellType: ColorTableViewCell.self)) { row, model, cell in
            cell.color = model
        }.disposed(by: bag)
        
        tableColor.rx.itemSelected.bind { indexPath in
            let color = self.viewModel.colors.value[indexPath.row]
            self.viewModel.saveColor(color: color)
            self.setupStatusBar(color: color)
            self.setupNavigarionBar(color: color)
        }.disposed(by: bag)
        
    }

    
}
