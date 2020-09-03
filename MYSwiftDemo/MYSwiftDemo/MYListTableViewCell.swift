//
//  MYListTableViewCell.swift
//  MYSwiftDemo
//
//  Created by Meikeo on 2020/9/3.
//  Copyright © 2020 Meikeo. All rights reserved.
//

import UIKit
import SnapKit
import AlamofireImage

enum listCellType {
    case homeCellType
    case groupCellType
    case memberCellType
}

class MYListTableViewCell: UITableViewCell {
    var header: String!
    var name: String!
    var cellType: listCellType!
    
    typealias selectBtnTapBlock = (Bool) -> ()
    var tapBlock: selectBtnTapBlock?
    
    
    let headerImage: UIImageView = UIImageView()
    let nameLabel: UILabel = UILabel()
    let selectButton: UIButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configSubView() {
        headerImage.layer.masksToBounds = true
        headerImage.layer.cornerRadius = 20
        self.contentView.addSubview(headerImage)
        
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 14)
        self.contentView.addSubview(nameLabel)
        
        selectButton.setImage(UIImage(named: "select_un"), for: .normal)
        selectButton.setImage(UIImage(named: "select"), for: .selected)
        selectButton.addTarget(self, action: #selector(selectBtnAction), for: .touchUpInside)
        self.contentView.addSubview(selectButton)
        
        headerImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(40)
            $0.width.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(headerImage.snp_trailingMargin).offset(15)
            $0.trailing.equalTo(selectButton.snp_leadingMargin).offset(-20)
        }
        
        selectButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
            $0.width.equalTo(40)
            $0.trailing.equalToSuperview().offset((-15))
        }
    }
    
    func fillViewWithValue(header:String , nameString:String, isBeenSelect:Bool) {
        nameLabel.text = nameString
        
        switch cellType {
            case .groupCellType:
                self.selectButton.isSelected = isBeenSelect
                headerImage.image = UIImage(named: header)
                break
                
            case .memberCellType:
                self.selectButton.isSelected = isBeenSelect
                headerImage.af.setImage(withURL: URL(string: header)!)
                break
                
            case .homeCellType:
                self.selectButton.isHidden = true
                headerImage.af.setImage(withURL: URL(string: header)!)
                break
                
            default:
                break
            }
    }
    
    @objc func selectBtnAction(button: UIButton) -> Void {
        if self.cellType == .groupCellType {
            if button.isSelected {
                button.isSelected = false
                if self.tapBlock != nil {
                    self.tapBlock!(button.isSelected)
                }
            }
        }else if self.cellType == .memberCellType {
            button.isSelected = !button.isSelected
            if self.tapBlock != nil {
                self.tapBlock!(button.isSelected)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
