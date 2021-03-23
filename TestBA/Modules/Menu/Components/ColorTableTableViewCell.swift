//
//  ColorTableTableViewCell.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 22/03/21.
//

import UIKit

class ColorTableTableViewCell: UITableViewCell {

    @IBOutlet weak var stColors: UIStackView!
    
    var colors = [UIColor.gray, .blue, .cyan, .green, .red, .purple]
    var handleSelectColor: ((_ color:UIColor?) -> Void)?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI(){
          
        DispatchQueue.main.async { [weak self] in
            for color in self?.colors ?? [] {
                let cardView = CardView()
                cardView.backgroundColor = color
                cardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self?.onSelectColor(_:))))
                self?.stColors.addArrangedSubview(cardView)
            }
        }
    }
    
    @objc
    func onSelectColor(_ sender: Any){
        if let sender = sender as? UIGestureRecognizer {
            if let card = sender.view as? CardView{
                handleSelectColor?(card.backgroundColor)
            }
        }
    }

    
    
}
