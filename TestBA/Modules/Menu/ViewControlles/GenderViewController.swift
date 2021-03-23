//
//  GenderViewController.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class GenderViewController: BaseViewController {

    @IBOutlet weak var scGender: UISegmentedControl!
    @IBOutlet weak var lastGender: UILabel!
    
    let viewModel = GenderViewModel()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinding()
    }
    
    @IBAction func onSelectGender(_ sender: Any) {
        
        let index = scGender.selectedSegmentIndex
        var gender  = "Mujer"
        if index == 0{
            viewModel.saveText(text: gender)
            lastGender.text = gender
        }
        
        if index == 1{
            gender = "Hombre"
            viewModel.saveText(text: gender)
            lastGender.text = gender
        }
    }
    
    private func setup() {
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
        
        viewModel.lastGender.asObservable()
                .bind {  text in
                    self.lastGender.text = text
                }.disposed(by: bag)
    }

}
