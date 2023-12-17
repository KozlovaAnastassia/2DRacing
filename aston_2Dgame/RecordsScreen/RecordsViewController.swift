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

    private var recordsData = [RecordModel]()

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
        if let currentCountOfPlayers = UserDefaults.standard.object(forKey: GeneralConstants.UDKeys.id) as? Int {
            for i in 0...currentCountOfPlayers {
                if let data = UserDefaults.standard.data(forKey: "\(i)") {
                    do {
                        let decodedStruct = try JSONDecoder().decode(RecordModel.self, from: data)
                        recordsData.append(decodedStruct)
                    } catch {
                        print("\(error.localizedDescription)")
                    }
                }
            }
            recordsData.sort(by: {Double($0.score) ?? Double() > Double($1.score) ?? Double()})
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

extension RecordsViewController: SettingsViewControllerDelegate {
    func didReceiveData(name: String, image: Data, id: Int) {
        do {
            try StorageManager().saveImage(UIImage(data: image) ?? UIImage(), name: name)
        }
        catch {
            print("\(error.localizedDescription)")
        }
        
        UserDefaults.standard.set(name, forKey: GeneralConstants.UDKeys.name)
        if let currentCountOfPlayers = UserDefaults.standard.object(forKey: GeneralConstants.UDKeys.id) as? Int {
            let newNum = currentCountOfPlayers + 1
            UserDefaults.standard.set(newNum, forKey: GeneralConstants.UDKeys.id)
        } else {
            UserDefaults.standard.set(0, forKey: GeneralConstants.UDKeys.id)
        }
    }
}
    
extension RecordsViewController: RaceViewControllerDelegate {
    func senData(data: Double) {
        
        if let savedNumber = UserDefaults.standard.object(forKey: GeneralConstants.UDKeys.id) as? Int {
            if let lastSavedPlayer = UserDefaults.standard.string(forKey: GeneralConstants.UDKeys.name) {
                let player = RecordModel(id: savedNumber, name: lastSavedPlayer, score: String(data))
                    if let encoded = try? JSONEncoder().encode(player) {
                        UserDefaults.standard.set(encoded, forKey: "\(savedNumber)")
                    }
            }
        }
    }
}
