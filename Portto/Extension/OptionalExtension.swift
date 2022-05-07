//
//  OptionalExtension.swift
//  Portto
//
//  Created by Vincent on 2022/5/6.
//

import Foundation

extension Optional {
    func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        return self ?? defaultValue
    }
}
