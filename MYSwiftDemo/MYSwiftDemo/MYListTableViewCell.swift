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
    var isBeenSelect: Bool = false
    
    var headerImage: UIImageView = UIImageView()
    var nameLabel: UILabel = UILabel()
    var selectButton: UIButton = UIButton()
    
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
        
        if cellType == listCellType.homeCellType {
            self.selectButton.isHidden = true
        }
    }
    
    func fillViewWithValue(header:String , nameString:String, isBeenSelect:Bool) {
        nameLabel.text = nameString
        
        if (cellType == listCellType.groupCellType){
            self.selectButton.isSelected = isBeenSelect
            headerImage.image = UIImage(named: header)

        }else if (cellType == listCellType.memberCellType)  {
            self.selectButton.isSelected = isBeenSelect
            headerImage.af.setImage(withURL: URL(string: header)!)
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
