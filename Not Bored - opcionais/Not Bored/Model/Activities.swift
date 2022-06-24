//
//  Activities.swift
//  Not Bored
//
//  Created by Douglas Eiki Yonemura on 21/06/22.
//

enum Activities: CaseIterable {
    
    case Education
    case Recreational
    case Social
    case Diy
    case Charity
    case Cooking
    case Relaxation
    case Music
    case Busywork
    
    var name: String {
        switch self {
        case .Education:
            return "Education"
        case .Recreational:
            return "Recreational"
        case .Social:
            return "Social"
        case .Diy:
            return "Diy"
        case .Charity:
            return "Charity"
        case .Cooking:
            return "Cooking"
        case .Relaxation:
            return "Relaxation"
        case .Music:
            return "Music"
        case .Busywork:
            return "Busywork"
        }
    }
    
}
