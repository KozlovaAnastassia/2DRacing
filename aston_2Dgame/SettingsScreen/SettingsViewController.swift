//
//  ViewController.swift
//  aston_2Dgame
//
//  Created by Анастасия on 21.11.2023.
//

import UIKit

private extension String {
    static let screenTitle = "Settings"
    static let textFieldPlaceholder = "Enter name of player"
    static let alertMessage = "Enter data otherwise your results will not be recorded in the results table"
    static let actionOk = "OK"
    static let actionStartGame = "Start the game anyway"
    static let alertAddImage = "Add image"
    static let actionPhoto = "Photos"
    static let actionCancel = "Cancel"
}

private extension CGFloat {
    static let textFieldPlaceholderFontSize = 16.0
}

private extension Int {
    static let numberOfTapsOnImage = 2
    static let numberOfComponents = 1
}

final class SettingsViewController: UIViewController {
    
     private var model = SettingModel()
     private let settingsView = SettingsView()
    
     override func loadView() {
         view = settingsView
     }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = String.screenTitle
        
        addTargets()
        setDelegates()
        setTapGesture()
        setNavigationItem()
        
        DispatchQueue.main.async {
            self.getDataFromUserData()
        }
    }
    
     @objc func pressButtonStartGame() {
         if model.image != nil && model.name != nil {
             var newId = Int.zero
             if let savedNumber = DataStorage(model: model).checkId() {
                  newId =  savedNumber + 1
             }
             DataStorage(model: model).saveData(id: newId, score: GeneralConstants.Defaults.score, image: (model.image ?? Data()))
             
             navigationController?.pushViewController(RaceViewController(gameLevel: model.currentLevel ?? "\(LevelsOfgame.easy)"), animated: true)
         } else {
             setAlertNoData()
             settingsView.textField.isUserInteractionEnabled = true
         }
     }
     
     @objc func resetSettings() {
         settingsView.textField.isUserInteractionEnabled = true
         settingsView.avatarImage.isUserInteractionEnabled = true
         settingsView.avatarImage.image = UIImage(named: GeneralConstants.ImageName.placeholder)
         settingsView.textField.attributedPlaceholder = getCustomPlaceholder(
                                                                placeholderName:  String.textFieldPlaceholder,
                                                                color: UIColor.systemGray,
                                                                fontSize: CGFloat.textFieldPlaceholderFontSize )
     }
     
     @objc func tapImageView() {
         let alert = UIAlertController(title: String.alertAddImage, message: nil, preferredStyle: .actionSheet)
         
         let actionPhoto = UIAlertAction(title: String.actionPhoto, style: .default) {  alert in
             self.settingsView.imagePicker.sourceType = .photoLibrary
             self.settingsView.imagePicker.allowsEditing = true
             self.present(self.settingsView.imagePicker, animated: true, completion: nil)
         }
         
         let actionCancel = UIAlertAction(title: String.actionCancel, style: .cancel)
         
         alert.addAction(actionPhoto)
         alert.addAction(actionCancel)
         
         present(alert, animated: true, completion: nil)
     }
     
     @objc func backToRootController() {
         navigationController?.popToRootViewController(animated: true )
     }
     
     private func addTargets() {
         settingsView.buttonReset.addTarget(self, action: #selector(resetSettings), for: .touchUpInside)
         settingsView.buttonStartGame.addTarget(self, action: #selector(pressButtonStartGame), for: .touchUpInside)
     }
     
     private func setNavigationItem() {
         let back = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(backToRootController))
         navigationItem.rightBarButtonItem = back
         navigationItem.hidesBackButton = true
     }
     
     private func getDataFromUserData() {
         if let id =  DataStorage(model: model).checkId() {
             if let storageModel = DataStorage(model: model).getData(currentCountOfPlayers: id) {
            settingsView.textField.isUserInteractionEnabled = false
            settingsView.avatarImage.isUserInteractionEnabled = false
            settingsView.avatarImage.image = UIImage(data: storageModel.image ?? Data())
            settingsView.textField.attributedPlaceholder = getCustomPlaceholder(placeholderName:  "\(storageModel.name ?? String())",
                                                                                color: UIColor.black,
                                                                                fontSize: CGFloat.textFieldPlaceholderFontSize)
             }
         } else {
             resetSettings()
        }
     }
     
     private func getCustomPlaceholder(placeholderName: String, color: UIColor, fontSize: CGFloat ) -> NSAttributedString {
         let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.systemFont(ofSize: fontSize)
         ]
         let attributedPlaceholder = NSAttributedString(string: placeholderName, attributes: attributes)
         return attributedPlaceholder
     }
     
     private func setDelegates() {
        settingsView.levelPicker.delegate = self
        settingsView.imagePicker.delegate = self
        settingsView.textField.delegate = self
    }
    
     private func setTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapImageView))
         tap.numberOfTapsRequired = Int.numberOfTapsOnImage
        settingsView.avatarImage.addGestureRecognizer(tap)
        settingsView.avatarImage.isUserInteractionEnabled = true
    }
    
     private func setAlertNoData() {
         let alert = UIAlertController(title: nil, message: String.alertMessage, preferredStyle: .alert)
         let actionOK = UIAlertAction(title: String.actionOk, style: .cancel)
         let actionStartGame = UIAlertAction(title: String.actionStartGame, style: .default) { _ in
             self.navigationController?.pushViewController(RaceViewController(gameLevel: self.model.currentLevel ?? String()), animated: false)
         }
         alert.addAction(actionOK)
         alert.addAction(actionStartGame)
         
         present(alert, animated: true)
     }
}

extension SettingsViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        model.levelsOfgame[row]
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        model.currentLevel = model.levelsOfgame[row]
        }
}

extension SettingsViewController: UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        model.levelsOfgame.count
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        Int.numberOfComponents
    }
}

extension SettingsViewController:  UIImagePickerControllerDelegate,
                                        UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
            
            settingsView.avatarImage.image = selectedImage
            model.image = selectedImage.pngData()
        }
        dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.hasText {
            model.name = textField.text ?? String()
            textField.isUserInteractionEnabled = false
            settingsView.avatarImage.isUserInteractionEnabled = false
          return true
        }
        return false
      }
}


