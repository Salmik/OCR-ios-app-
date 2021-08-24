//
//  Localize + Extension.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizible",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
