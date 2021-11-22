//
//  SettingsVC.swift
//  OCR Simple app
//
//  Created by Zhanibek Lukpanov on 22.08.2021.
//

import UIKit

final class SettingsVC: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
          tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseID)
          tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: SwitchTableViewCell.reuseID)
          tableView.tableFooterView = UIView(frame: CGRect.zero)
          return tableView
      }()
      
    var models: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Settings"
        
        SettingsManager.shared.configure {[weak self] model in
            guard let self = self else { return }
            self.models = model
        }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
      
      override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          tableView.frame = view.bounds
      }
      
  }

  // MARK:- UITableViewDelegate, UITableViewDataSource
  extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
      
      func numberOfSections(in tableView: UITableView) -> Int {
          return models.count
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return models[section].option.count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
          let model = models[indexPath.section].option[indexPath.row]
          
          switch model {
          
          case .staticCell(let model):
              
          guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseID, for: indexPath) as? SettingsTableViewCell else {
                  return UITableViewCell()
              }
              cell.configure(model: model)
              return cell
              
          case .switchCell(let model):
              guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.reuseID, for: indexPath) as? SwitchTableViewCell else {
                  return UITableViewCell()
              }
              cell.configure(model: model)
              return cell
          }
          
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let model = models[indexPath.section].option[indexPath.row]
          tableView.deselectRow(at: indexPath, animated: true)
          
          switch model {
          case .staticCell(let model):
              model.handler()
          case .switchCell(let model):
              model.handler()
          }
      }
      
      func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
          let section = models[section]
          return section.title
      }
      
  }
