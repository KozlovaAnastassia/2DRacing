//
//  DataStorage.swift
//  aston_2Dgame
//
//  Created by Анастасия on 29.12.2023.
//

import UIKit


private enum Keys {
    static let level = GeneralConstants.UDKeys.currentLevel
    static let id = GeneralConstants.UDKeys.id
    static let playerName = GeneralConstants.UDKeys.name
}

final class DataStorage {
    
    private var model: SettingModel
    
    init(model: SettingModel){
        self.model = model
    }
    
    func checkId() -> Int? {
        if let savedNumber = UserDefaults.standard.object(forKey: Keys.id) as? Int {
            return savedNumber
        } else {
            return nil
        }
    }
    
    func saveData(id: Int, score: Double, image: Data) {
        UserDefaults.standard.set(id, forKey: Keys.id)
        let player = SettingModel(currentLevel: model.currentLevel, name: model.name, id: id, score: score)
        if let encoded = try? JSONEncoder().encode(player) {
            UserDefaults.standard.set(encoded, forKey: "\(id)")
        }
        try? saveImage(image, name: "\(id)")
    }
    
    func getData(currentCountOfPlayers: Int) -> SettingModel? {
        if let data = UserDefaults.standard.data(forKey: "\(currentCountOfPlayers)") {
           let image = getImage("\(currentCountOfPlayers)")
            do {
                var decodedStruct = try JSONDecoder().decode(SettingModel.self, from: data)
                decodedStruct.image = image
                return decodedStruct
            } catch {
                return nil
            }
        }
        return nil
    }
    
    private func saveImage(_ image: Data, name: String) throws {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = directory.appendingPathComponent(name)
        try image.write(to: fileURL)
    }

    
    private func getImage(_ name: String) -> Data? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = directory.appendingPathComponent(name)
        let imageData = try? Data(contentsOf: fileURL)
        return imageData
    }
       
    
}
