//
//  Model.swift
//  Surf
//
//  Created by Егор Зайнуллин on 01.08.2023.
//

import Foundation
import UIKit

class Model {
    var skills: [Skill] = []
    
    func getImage() -> UIImage {
        if let image = UIImage(named: "myimage") {
            return image
        }
        fatalError("Image is not found")
    }
    
    func getName() -> String {
        "Иванов Иван Иванович"
    }
    
    func getStatus() -> String {
        "middle iOS разработчик, опыт более двух лет"
    }
    
    func getPlace() -> String {
        "Воронеж"
    }
    
    init() {
        let stringSkills = ["Kotlin", "Swift", "iOS", "Android", "Git", "Communication", "Design"]
        skills = stringSkills.map {
            Skill($0)
        }
    }
}

struct Skill: Identifiable {
    let id: String = UUID().uuidString
    
    let skillName: String
    
    init(_ name: String) {
        skillName = name
    }
}

