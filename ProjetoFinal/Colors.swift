
//  Cores.swift
//  ProjetoFinal
//  Created by Elisa Kalil on 18/10/21.

import Foundation
import UIKit

enum Colors {
    case azulClaro
    case amareloClaro
    case vermelhoClaro
    case verdeClaro
    case roxoClaro
    case rosaClaro
    case laranjaClaro
    case marromClaro
    
    var uiColor: UIColor {
        switch self {
        case.azulClaro: return UIColor(red: 218.0/255, green: 243.0/255, blue: 255.0/255, alpha: 1.0)
        case.amareloClaro: return UIColor(red: 236.0/255, green: 204.0/255, blue: 151.0/255, alpha: 1.0)
        case.vermelhoClaro: return UIColor(red: 166.0/255, green: 97.0/255, blue: 92.0/255, alpha: 1.0)
        case.verdeClaro: return UIColor(red: 149.0/255, green: 187.0/255, blue: 143.0/255, alpha: 1.0)
        case.roxoClaro: return UIColor(red: 135.0/255, green: 130.0/255, blue: 166.0/255, alpha: 1.0)
        case.rosaClaro: return UIColor(red: 241.0/255, green: 208.0/255, blue: 212.0/255, alpha: 1.0)
        case.laranjaClaro: return UIColor(red: 225.0/255, green: 173.0/255, blue: 132.0/255, alpha: 1.0)
        case.marromClaro: return UIColor(red: 165.0/255, green: 130.0/255, blue: 91.0/255, alpha: 1.0)
        }
    }
    
    
}
