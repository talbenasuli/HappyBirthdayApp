//
//  SnapKitBuilder.swift
//  GifBoard
//
//  Created by Tal Ben Asuli MAC  on 14/03/2021.
//

import SnapKit

extension ConstraintMakerEditable {
    
    @discardableResult
    func multipliedBy(_ amount: Padding) -> ConstraintMakerEditable {
        self.multipliedBy(amount.rawValue)
        return self
    }
    
    @discardableResult
    func dividedBy(_ amount: Padding) -> ConstraintMakerEditable {
        return self.multipliedBy(1.0 / amount.rawValue.constraintMultiplierTargetValue)
    }
    
    @discardableResult
    func offset(_ amount: Padding) -> ConstraintMakerEditable {
        return self.offset(amount.rawValue)
    }
    
    @discardableResult
    func inset(_ amount: Padding) -> ConstraintMakerEditable {
        return self.inset(amount.rawValue)
    }
}
