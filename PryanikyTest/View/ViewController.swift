//
//  ViewController.swift
//  PryanikyTest
//
//  Created by Denis Larin on 31.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var networkService = NetworkService()
    
    lazy var button1: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 0
        button.backgroundColor = .systemGray
        return button
    }()
    
    lazy var button2: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 1
        button.backgroundColor = .systemGray
        return button
    }()
    
    lazy var button3: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 2
        button.backgroundColor = .systemGray
        button.layer.shadowColor   = UIColor.black.cgColor
        return button
    }()
    
    lazy var button4: UIButton = {
        let button = UIButton(type: .system)
        button.tag = 0
        button.backgroundColor = .systemGray
        return button
    }()
    
    lazy var buttonArray = [button1, button2, button3, button4]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension ViewController {
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        networkService.fetchData { (pryaniky) in
            DispatchQueue.main.sync {
                switch sender.tag {
                case 0:
                    guard let title = pryaniky.data[0].data.text else {return}
                    let alert = UIAlertController(title: title, message: "id / имя инициировал событие", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                case 1:
                    self.performSegue(withIdentifier: "goToSelectorVC", sender: self.button2)
                default:
                    self.performSegue(withIdentifier: "goToPictureVC", sender: self.button3)
                }
            }
        }
    }
    
    func btnUISettings() {
        
        networkService.fetchData { [weak self] (pryaniky) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.title = "PryanikyTest"
                let viewArr = pryaniky.view
                for (name, button) in zip(viewArr, self.buttonArray) {
                    button.setTitle(name, for: .normal)
                    button.setTitleColor(.white, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 50)
                    button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
                }
            }
        }
    }
    
    
    func setupUI() {
        
        btnUISettings()
        let stackView = UIStackView(arrangedSubviews: buttonArray)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 50
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 100),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -100),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
            
        ])
        
    }
}
