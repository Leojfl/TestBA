//
//  CameraTableViewCell.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit

class CameraTableViewCell: UITableViewCell {

    @IBOutlet weak var imgShow: UIImageView!
    var handleOnClickImage: (()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        imgShow.isUserInteractionEnabled = true
        imgShow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickImage)))
    }
  
    func show(image: UIImage) {
        imgShow.image = image
        imgShow.contentMode = .scaleAspectFit
    }
    
    @objc
    private func onClickImage(){
        handleOnClickImage?()
    }
  
    
    
}
