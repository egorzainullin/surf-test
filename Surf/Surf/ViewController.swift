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
    
    var plusButton: UIButton!
    
    var isEditingMode = false
    
    let offset = 20.0
    
    let offsetBetweenSkills = 5.0
    
    var maxWidth = 20.0
    
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setEditButton()
        setPlusButton()
        setImage()
        setName()
        setStatus()
        setPlace()
        setAbout()
        let bounds = UIScreen.main.bounds
        maxWidth = bounds.size.width - 2 * offset
        drawSkills()
        hideButtonsFromSkillView()
    }
    
    private func setPlusButton() {
        plusButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        plusButton.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.black, for: .normal)
        let action = UIAction {
            action in
            self.onPlusButtonTouchUp()
        }
        plusButton.addAction(action, for: .touchUpInside)
        skillsView.addSubview(plusButton)
    }
    
    @IBAction func onEditButtonTouchUpInside(_ sender: Any) {
        if !isEditingMode {
            isEditingMode = true
            editButton.setImage(UIImage(named: "tick"), for: .normal)
            showButtonsFromSkillView()
        }
        else {
            isEditingMode = false
            setEditButton()
            redrawSkills()
            hideButtonsFromSkillView()
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
    
    private func hideButtonsFromSkillView() {
        skillsView.subviews.compactMap {
            $0 as? SkillView
        }
        .forEach {
            $0.hideButton()
        }
        plusButton.isHidden = true
    }
    
    private func showButtonsFromSkillView() {
        skillsView.subviews.compactMap {
            $0 as? SkillView
        }
        .forEach {
            $0.showButton()
        }
        plusButton.isHidden = false
        skillsHeight.constant = skillsHeight.constant + 30
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
                    skillsView.addSubview(view)
                    i += 1
                    sumOfWidth += width + offsetBetweenSkills
                }
                else if width > maxWidth && sumOfWidth == 0 {
                    view.frame = CGRectMake(0, CGFloat(j) * view.height, maxWidth, view.frame.size.height)
                    skillsView.addSubview(view)
                    j += 1
                    i += 1
                    sumOfWidthIsSmaller = false
                }
                else if width > maxWidth && sumOfWidth > 0 {
                    j += 1
                    view.frame = CGRectMake(0, CGFloat(j) * view.height, maxWidth, view.frame.size.height)
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
        if isEditingMode {
            skillsHeight.constant = height + 30
        }
        else {
            skillsHeight.constant = height
        }
        plusButton.frame = CGRectMake(0, height, 30, 30)
    }
    
    public func alertWithTextField(title: String? = nil, message: String? = nil, placeholder: String? = nil, completion: @escaping ((String) -> Void) = { _ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = placeholder
        }
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel) { _ in completion("") })
        alert.addAction(UIAlertAction(title: "Добавить", style: .default) { action in
            if
                let textFields = alert.textFields,
                let tf = textFields.first,
                let result = tf.text
            { completion(result) }
            else
            { completion("") }
        })
        self.present(alert, animated: true)
    }
    
    private func onPlusButtonTouchUp() {
        alertWithTextField(title: "Ваш навык", message: "Введите название навыка, которым вы владеете", completion: {
            newSkill in
            if newSkill != "" {
                self.model.skills.append(Skill(newSkill))
                self.redrawSkills()
            }
        }
)
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
        model.skills.removeAll {
            $0.id == id
        }
        redrawSkills()
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
