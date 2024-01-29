//
//  ViewController.swift
//  aston_2Dgame
//
//  Created by Анастасия on 21.11.2023.
//

import UIKit

private extension String {
    static let screenTitle = "Records"
}

private extension CGFloat {
    static let heightForRow = 80.0
}

final class RecordsViewController: UITableViewController {

    private var recordsData = [SettingModel]()
    private var model = SettingModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = String.screenTitle
        setNavigationItem()
        getDataFromUserDefault()
        tableView.register(RecordCell.self, forCellReuseIdentifier: RecordCell.identifier)
    }
    
    @objc func backToRootViewController(){
        navigationController?.popToRootViewController(animated: false)
    }
    
    private func setNavigationItem() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        let back = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backToRootViewController))
        navigationItem.rightBarButtonItem = back
        navigationItem.hidesBackButton = true
    }
    
    private func getDataFromUserDefault() {
        if let id = DataStorage(model: model).checkId() {
            for i in Int.zero...id {
                if let storageModel = DataStorage(model: model).getData(currentCountOfPlayers: i) {
                    recordsData.append(storageModel)
                }
            }
            recordsData.sort(by: {Double($0.score ?? Double()) > Double($1.score ?? Double()) })
       }
    }

}

extension RecordsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recordsData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat.heightForRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordCell.identifier, for: indexPath) as? RecordCell

        let model = recordsData[indexPath.row]
        cell?.configure(model)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

