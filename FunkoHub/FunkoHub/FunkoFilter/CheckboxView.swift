//
//  CheckboxView.swift
//  FunkoHub
//
//  Created by Juan José Perálvarez Ortiz on 16/9/24.
//

import UIKit

class CheckboxView: UIView {
    
    var isSelected: Bool = false
    var typeText: String = .empty

    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        let nib: UINib = UINib(nibName: Constants.Storyboard.checkboxView, bundle: nil)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return}
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }

    @IBAction func buttonAction(_ sender: Any) {
        isSelected.toggle()
        changeImageButton()
    }
    
    func changeImageButton () {
        checkbox.setImage(UIImage(systemName: isSelected ? Constants.Image.selectedCheckbox : Constants.Image.unselectedCheckbox), for: .normal)
    }
}

