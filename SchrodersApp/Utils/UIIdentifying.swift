//
//  UIIdentifying.swift
//  Schroders
//
//  Created by Jonathan Aguele on 03/02/2021.
//

import UIKit

protocol UIIdentifying {

    static var nib: UINib { get }
    static var identifier: String { get }
}

extension UIIdentifying where Self: AnyObject {

    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle.main)
    }

    static var identifier: String {
        String(describing: self)
    }
}

