//
//  ViewController2.swift
//  proba
//
//  Created by Анастасия on 01.12.2023.
//

import UIKit


protocol ViewController2Delegate: AnyObject {
   func  didReceiveData(data: String)
}


class ViewController2: UIViewController {

    weak var delegate: ViewController2Delegate?
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
    

        // Объявляем замыкание в качестве свойства
        var dataHandler: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
        
        
        
        setButtom()
        buttonConfirm.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
    }
    
    
    func setButtom() {
        view.addSubview(buttonConfirm)
        buttonConfirm.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonConfirm.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    @objc func pressButton() {
        let data = "Привет, получатель!"
        delegate?.didReceiveData(data: data)
        navigationController?.popViewController(animated: true)
        
    }
    

}

