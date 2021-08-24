//
//  SettingsModel.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import Foundation
import UIKit

struct Section {
    let title: String
    let option: [SettingsOptionType]
}

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgorundColor: UIColor
    let handler: (() -> Void)
    let isOn: Bool
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgorundColor: UIColor
    let handler: (() -> Void)
}
