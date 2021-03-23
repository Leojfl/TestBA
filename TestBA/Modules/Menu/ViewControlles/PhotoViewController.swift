//
//  PhotoViewController.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var tfUrl: TextFieldCustom!
    
    @IBOutlet weak var btnLoad: ButtonView!
    
    @IBOutlet weak var imgImage: UIImageView!
    var urlText = "https://http2.mlstatic.com/vegeta-tamano-rea-para-armar-en-papercraft-D_NQ_NP_892880-MLA26232224460_102017-F.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func onClickBtnLoad(_ sender: Any) {
        if let url = URL(string: tfUrl.text!) {
            imgImage.load(url: url)
        }else{
            self.showAlert(message: "Url no válida", title: "Alerta")
        }
    }
    
    private func setupUI(){
        if let url = URL(string: urlText){
            imgImage.load(url: url)
        }
    }
    
}
