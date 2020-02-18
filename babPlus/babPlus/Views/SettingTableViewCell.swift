//
//  SettingTableViewCell.swift
//  babPlus
//
//  Created by Hongdonghyun on 2020/02/14.
//  Copyright © 2020 YoujinMac. All rights reserved.
//

import UIKit

class CellDivider {
    private let tableView: UITableView
    init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    func create(setting: SettingOptions) -> UITableViewCell {
        self.register(cellType: setting.cellType)
        guard let cell = dequeue(cellType: setting.cellType) as? SettingViewCustomCell else { return UITableViewCell() }
        
        switch setting.cellType {
        case .indicatorCell:
            guard cell is IndicatorCell else { return UITableViewCell() }
        case .switchCell:
            guard cell is SwitchCell else { return UITableViewCell() }
        case .defaultCell:
            return UITableViewCell()
        }
        cell.configure(settingOption: setting)
        return cell
    }
    
    func register(cellType: CellType) {
        switch cellType {
        case .indicatorCell:
            self.tableView.register(IndicatorCell.self, forCellReuseIdentifier: IndicatorCell.identifier)
        case .switchCell:
            self.tableView.register(SwitchCell.self, forCellReuseIdentifier: SwitchCell.identifier)
        case .defaultCell:
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        }
        
    }
    
    func dequeue(cellType: CellType) -> UITableViewCell {
        switch cellType {
        case .indicatorCell:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: IndicatorCell.identifier) else { return UITableViewCell() }
            return cell
        case .switchCell:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier) else { return UITableViewCell() }
            return cell
        case .defaultCell:
            return UITableViewCell()
        }
        
    }
}

class SettingViewCustomCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AssetsColor.babplusTextColor.getColor()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = AssetsColor.babplusCellBackground.getColor()
        setupUI()
    }
    
    private func setupUI() {
        let safeArea = contentView.safeAreaLayoutGuide
        
        [titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30)
        ])
    }
    
    func configure(settingOption setting: SettingOptions) {
        guard (setting.indicator ^ setting.toggleBtn) else { return }
        titleLabel.text = setting.settingName
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


