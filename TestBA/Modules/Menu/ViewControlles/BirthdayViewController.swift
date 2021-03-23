//
//  BirthdayViewController.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class BirthdayViewController: BaseViewController {

    @IBOutlet weak var dpDate: UIDatePicker!
    @IBOutlet weak var lastBirthday: UILabel!
    let viewModel = BirthdayViewModel()
    private var bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupBinding()
    }
    

    @IBAction func onClickSelect(_ sender: Any) {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        let date = df.string(from: dpDate.date)
        viewModel.saveText(text: date)
        lastBirthday.text = date
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
        
        viewModel.lastBirthday.asObservable()
                .bind {  text in
                    self.lastBirthday.text = "Ultima fecha: \(text)"
                }.disposed(by: bag)
        
        
    }
}
