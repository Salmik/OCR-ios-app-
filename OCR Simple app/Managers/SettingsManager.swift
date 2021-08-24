//
//  SettingsManager.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

struct SettingsManager {
    
    var models: [Section] = []
    
    static var shared = SettingsManager()
    
    private init() {}
    
    mutating func configure(completion: @escaping ([Section]) -> Void) {
        
        self.models.append(
            Section(title: "Photo", option: [
                        .switchCell(model: SettingsSwitchOption(
                                        title: "Save photo",
                                        icon: UIImage(systemName: "camera"),
                                        iconBackgorundColor: .systemGreen,
                                        handler: {
                                            
                                        },
                                        isOn: true))]))
        
        self.models.append(
            
            Section(title: "General", option: [
                
                .staticCell(model:SettingsOption(title: "FAQ", icon: UIImage(systemName: "questionmark.circle"), iconBackgorundColor: .systemGreen, handler: {
                    
                })),
                
                .staticCell(model:SettingsOption(title: "Recommend to a friend", icon: UIImage(systemName: "hand.thumbsup"), iconBackgorundColor: .systemBlue, handler: {
                    
                })),
                .staticCell(model:SettingsOption(title: "Feedback", icon: UIImage(systemName: "square.and.pencil"), iconBackgorundColor: .systemOrange, handler: {
                    
                })),
                
                .staticCell(model:SettingsOption(title: "Rate us", icon: UIImage(systemName: "star"), iconBackgorundColor: .systemOrange, handler: {
                    
                })),
                
                .staticCell(model:SettingsOption(title: "Follow us", icon: UIImage(systemName: "network"), iconBackgorundColor: .systemBlue, handler: {
                    
                })),
                .staticCell(model:SettingsOption(title: "About app", icon: UIImage(systemName: "exclamationmark.circle"), iconBackgorundColor: .systemGreen, handler: {
                    
                })),
                
                .staticCell(model:SettingsOption(title: "Familiarity with fucntions", icon: UIImage(systemName: "play"), iconBackgorundColor: .systemBlue, handler: {
                    
                })),
            ]
          )
            
      )
        completion(models)
        
    }
}
