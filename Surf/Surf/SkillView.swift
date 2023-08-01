//
//  SkillView.swift
//  Surf
//
//  Created by Егор Зайнуллин on 01.08.2023.
//

import UIKit

class SkillView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    var skill: Skill = Skill("")
    
    let height = CGFloat(30.0)
    
    let widthOfImage = 60
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        skill = Skill("")
        initSubviews()
    }
    
    init(skill: Skill) {
        super.init(frame: CGRect())
        self.skill = skill
        initSubviews()
    }
    
    func initSubviews() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: height))
        label.text = skill.skillName
        let widthOfLabel = label.intrinsicContentSize.width
        label.frame = CGRectMake(0, 0, widthOfLabel, height)
        addSubview(label)
        
        let imageButton = UIButton(frame: CGRect(x: widthOfLabel, y: 0, width: 30, height: 30))
        imageButton.setImage(UIImage(named: "cross"), for: .normal)
        imageButton.setTitle("Button", for: .normal)
        addSubview(imageButton)
        
        backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        layer.cornerRadius = 10
        frame = CGRect(x: 0, y: 0, width: widthOfLabel + 30, height: height)
    }
}
