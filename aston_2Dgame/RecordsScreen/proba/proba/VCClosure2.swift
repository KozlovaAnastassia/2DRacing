//
//  VCClosure2.swift
//  proba
//
//  Created by Анастасия on 16.12.2023.
//

import UIKit


protocol ViewController3Delegate: AnyObject {
   func  didReceiveData(data: String)
}


class VCClosure2: UIViewController {

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
    
   // var dataHandler: ((String) -> Void)?
    var vc11: VCClosure1?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                if let bViewController = viewController as? VCClosure1 {
                    
                    bViewController.dataHandler = { data in
                        print(3)
                        print(data)
                    }
                    vc11 = bViewController
                    break
                }
            }
        }

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
        
        navigationController?.popToViewController(vc11 ?? VCClosure1(), animated: true)

    }
}
