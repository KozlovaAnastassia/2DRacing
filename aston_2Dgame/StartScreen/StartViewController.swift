//
//  ViewController.swift
//  aston_2Dgame
//
//  Created by Анастасия on 12.11.2023.
//

import UIKit

final class StartViewController: UIViewController {

    private let startView = StartView()
    
    override func loadView() {
        view = startView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    @objc func tapOnButton(_ sender: UIButton) {
        switch sender.tag {
        case 1: navigationController?.pushViewController(RaceViewController(gameLevel: "\(LevelsOfgame.easy)"), animated: false)
        case 2: navigationController?.pushViewController(SettingsViewController(), animated: false)
        case 3: navigationController?.pushViewController(RecordsViewController(), animated: false)
        default: break
        }
    }
    
    private func addTargets() {
        startView.buttonStart.addTarget(self, action: #selector(tapOnButton(_:)), for: .touchUpInside)
        startView.buttonSettings.addTarget(self, action: #selector(tapOnButton(_:)), for: .touchUpInside)
        startView.buttonRecords.addTarget(self, action: #selector(tapOnButton(_:)), for: .touchUpInside)
    }
}

