//
//  ViewController.swift
//  Surf
//
//  Created by Егор Зайнуллин on 01.08.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var placeLabel: UILabel!
    
    
    @IBOutlet weak var skillsHeight: NSLayoutConstraint!
    
    @IBOutlet weak var skillsView: UIView!
    
    @IBOutlet weak var aboutMeLabel: UILabel!
    
    @IBOutlet weak var heightOfAboutMe: NSLayoutConstraint!
    
    let offset = 20.0
    
    let offsetBetweenSkills = 5.0
    
    var maxWidth = 20.0
    
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setImage()
        setName()
        setStatus()
        setPlace()
        let bounds = UIScreen.main.bounds
        maxWidth = bounds.size.width - 2 * offset
        drawSkills()
    }
    
    private func drawSkills() {
        let skills = model.skills
        var i = 0
        var j = 0
        while i < skills.count {
            var sumOfWidthIsSmaller = true
            var sumOfWidth = 0.0
            while (sumOfWidthIsSmaller && i < skills.count) {
                let skill = skills[i]
                let view = SkillView(skill: skill)
                let width = view.frame.size.width
                print(j)
                if sumOfWidth + width + offsetBetweenSkills <= maxWidth {
                    view.frame = CGRectMake(sumOfWidth, CGFloat(j) * view.height, view.frame.size.width, view.frame.size.height)
                    skillsView.addSubview(view)
                    i += 1
                    sumOfWidth += width + offsetBetweenSkills
                } else {
                    sumOfWidthIsSmaller = false
                    j += 1
                }
                
            }
        }
        skillsHeight.constant = 30.0 * CGFloat(j + 1)
    }
    
    private func setImage() {
        profileImageView.image = model.getImage()
        profileImageView.makeRounded()
    }
    
    private func setName() {
        nameLabel.text = model.getName()
    }
    
    private func setStatus() {
        statusLabel.text = model.getStatus()
    }
    
    private func setPlace() {
        placeLabel.text = model.getPlace()
    }
}

extension UIImageView {
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
