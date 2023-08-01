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
    
    func getAbout() -> String {
        "Программирую программироавние, программист из программистов, программирую, блаблатомцвмтцщкоимцщмукшмишгмуцкомлкицтмлокцимтолкцимолцкимолкцмицколмикцолмиолкцумицолтывтсьямт олим ыолвми оцдлмтлдвымтлдцмтоцлктмлцдмьцлдукмт cds.m,dcs.............d,s.csd,v d,s.v ds,.v  dsv,.dv ,d.sv sd ,vd,sv ds.v, ds.,v dsv,.ds vd,.s ,.v ds s,.v ds,v dsvd.sv ds.v ds., v.,ds vsdv.,ds v,.ds v,.ds v,.sdv ds.,v ds.,v sv,.ds ,.sdv d., vds,. ds v,.ds v.,sd v,.ds vd.,s vds, vd,s. vds. vds.,v ds. vd,s.v ds,v ds.,vds v.ds, vds.,v dsvs,. v.,ds vsd vds,.v dsds,.dv,.v. sdv,. sdv.,sd vdsv sdv .ds.,v,ds.,vds., vd,s..,v.,dv ds v.,.ds,.vv sd.,v sdv.,vds.,v .,dv ,.ds .,v.,dsv ds., vv ,.sd. ,v,.dsv , ds ,.v.,ds,vsd.,vds..d vs.dv .d,"
    }
    
    init() {
        let stringSkills = ["Kotlin", "Swift", "iOS,", "Android", "Git", "Communication", "Design"]
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

