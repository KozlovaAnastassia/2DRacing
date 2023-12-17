//
//  ViewController.swift
//  proba
//
//  Created by Анастасия on 01.12.2023.
//

import UIKit

/// Данные через делегат передаются назад!!

class ViewController1: UIViewController {
    
    private var buttonConfirm: UIButton = {
       let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true

        button.backgroundColor = .gray
        button.setTitleColor(.blue, for: .highlighted)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        setButtom()
        
        buttonConfirm.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
 
    
    func setButtom() {
        view.addSubview(buttonConfirm)
        buttonConfirm.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonConfirm.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc func pressButton() {
       
        let vc2 = ViewController2()
        vc2.delegate = self
        
        navigationController?.pushViewController(vc2, animated: false)
        
    }
}
extension ViewController1: ViewController2Delegate {
    func didReceiveData(data: String) {
       print(data)
    }


}

