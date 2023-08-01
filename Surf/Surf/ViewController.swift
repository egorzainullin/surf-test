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
    
    @IBOutlet weak var heightOfAboutMe: NSLayoutConstraint!
    
    @IBOutlet weak var skillsView: UIView!
    
    @IBOutlet weak var aboutMeLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    var isEditingMode = false
    
    let offset = 20.0
    
    let offsetBetweenSkills = 5.0
    
    var maxWidth = 20.0
    
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setEditButton()
        setImage()
        setName()
        setStatus()
        setPlace()
        setAbout()
        let bounds = UIScreen.main.bounds
        maxWidth = bounds.size.width - 2 * offset
        drawSkills()
    }
    
    @IBAction func onEditButtonTouchUpInside(_ sender: Any) {
        if !isEditingMode {
            isEditingMode = true
            editButton.setImage(UIImage(named: "tick"), for: .normal)
            let views = skillsView.subviews.compactMap {
                $0 as? SkillView
            }
            views.forEach {
                $0.showButton()
            }
        }
        else {
            isEditingMode = false
            setEditButton()
            redrawSkills()
        }
    }
    
    private func redrawSkills() {
        skillsView.subviews.compactMap {
            $0 as? SkillView
        }
        .forEach {
            $0.removeFromSuperview()
        }
        drawSkills()
    }
    
    private func setEditButton() {
        editButton.setImage(UIImage(named: "editpencil"), for: .normal)
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
                let view = SkillView(skill: skill, callbackOnDelete: onDelete)
                let width = view.frame.size.width
                
                if sumOfWidth + width + offsetBetweenSkills <= maxWidth {
                    view.frame = CGRectMake(sumOfWidth, CGFloat(j) * view.height, view.frame.size.width, view.frame.size.height)
                    view.hideButton()
                    skillsView.addSubview(view)
                    i += 1
                    sumOfWidth += width + offsetBetweenSkills
                }
                else if width > maxWidth && sumOfWidth == 0 {
                    view.frame = CGRectMake(0, CGFloat(j) * view.height, maxWidth, view.frame.size.height)
                    view.hideButton()
                    skillsView.addSubview(view)
                    j += 1
                    i += 1
                    sumOfWidthIsSmaller = false
                }
                else if width > maxWidth && sumOfWidth > 0 {
                    j += 1
                    view.frame = CGRectMake(0, CGFloat(j) * view.height, maxWidth, view.frame.size.height)
                    view.hideButton()
                    skillsView.addSubview(view)
                    j += 1
                    i += 1
                    sumOfWidthIsSmaller = false
                }
                else {
                    j += 1
                    sumOfWidthIsSmaller = false
                }
                
            }
        }
        let height = 30.0 * CGFloat(j + 1)
        skillsHeight.constant = height + 30
        var button = UIButton(frame: CGRect(x: 0, y: height, width: 30, height: 30))
        button.setTitle("+", for: .normal)
        button.isHidden = true

    }
    
    func onDelete(id: String) {
        let view = skillsView.subviews
            .compactMap {
                $0 as? SkillView
            }
            .filter {
                $0.skill.id == id
            }.first
        guard let view = view
        else {
            fatalError("Id is not correct")
        }
        view.isHidden = true
        model.skills.removeAll {
            $0.id == id
        }
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
    
    private func setAbout() {
        aboutMeLabel.text = model.getAbout()
        let height = aboutMeLabel.requiredHeight
        heightOfAboutMe.constant = height + 30
    }
}

extension UIImageView {
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}

extension UILabel {
    public var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
}
