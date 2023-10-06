//
//  Extension.swift
//  Netflix Clone
//
//  Created by Toan Tran on 10/5/23.
//

import Foundation

extension String {
    func capitalizedFirstLetter() ->String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
