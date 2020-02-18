//
//  SettingViewController.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/14.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class SettingViewController: UITableViewController {
    private var settings = [Settings]()
    private lazy var cellDivider = CellDivider(tableView: self.tableView)
    private lazy var sections = SettingType.caseList.map { $0.rawValue }

    override func viewDidLoad() {
        super.viewDidLoad()
        settings = SettingType.caseList.map {
            Settings(key: $0.rawValue, settingOptions: $0.getInfo())
        }
        view.backgroundColor = AssetsColor.babplusBackground.getColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.title = "설정"
    }
    
}

extension SettingViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section]
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = AssetsColor.babplusBackground.getColor()
            headerView.textLabel?.textColor = AssetsColor.babplusTableCellTextColor.getColor()
            headerView.textLabel?.textAlignment = .left
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = settings[indexPath.section].settingOptions[indexPath.row]
        
        return self.cellDivider.create(setting: setting)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath)
        guard let identifier = currentCell?.reuseIdentifier, identifier == IndicatorCell.identifier else { return }
        if let cell = currentCell as? IndicatorCell {
            guard let nextVC = cell.nextVC else { return }
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        
    }
}
