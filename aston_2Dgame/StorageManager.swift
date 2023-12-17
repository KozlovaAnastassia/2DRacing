//
//  StorageManager.swift
//  aston_2Dgame
//
//  Created by Анастасия on 12.12.2023.
//

import UIKit

final class StorageManager {

    func saveImage(_ image: UIImage, name: String) throws {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileURL = directory.appendingPathComponent(name)

        guard let data = image.jpegData(compressionQuality: 1.0) else {return}
        try data.write(to: fileURL)
    }

    
    func getImage(_ name: String) -> UIImage? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let fileURL = directory.appendingPathComponent(name)
        
        let imageData = try? Data(contentsOf: fileURL)
        guard let image = UIImage(data: imageData ?? Data()) else { return nil }
        return image
    }
}
