//
//  PhotoTableViewCell.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var tfUrl: TextFieldCustom!
    @IBOutlet weak var btnLoad: ButtonView!
    @IBOutlet weak var imgImage: UIImageView!
    
    var handleError: ((_ title: String,_ message: String)-> Void)?
    
    var urlText = "https://http2.mlstatic.com/vegeta-tamano-rea-para-armar-en-papercraft-D_NQ_NP_892880-MLA26232224460_102017-F.jpg"
    
    @IBAction func onClickBtnLoad(_ sender: Any) {
        if let url = URL(string: tfUrl.text!) {
            imgImage.load(url: url)
        }else{
            handleError?("Alerta", "Url no válida")
        }
    }
    
    private func setupUI(){
        if let url = URL(string: urlText){
            imgImage.load(url: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    
    
}
