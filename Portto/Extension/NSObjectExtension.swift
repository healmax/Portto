//
//  NSObjectExtension.swift
//  Portto
//
//  Created by Vincent on 2022/5/6.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }

    var className: String {
        return type(of: self).className
    }
}
