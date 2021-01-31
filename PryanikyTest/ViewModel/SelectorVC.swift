//
//  SelectorVC.swift
//  PryanikyTest
//
//  Created by Denis Larin on 31.01.2021.
//

import Foundation

import UIKit

class SelectorVC: UIViewController {
    
    let networkService = NetworkService()
    
    lazy var label1: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    lazy var label2: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    lazy var label3: UILabel = {
        let lab = UILabel()
        return lab
    }()
    
    lazy var labelArr = [label1,label2,label3]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }

}




extension SelectorVC {
    
    func setupUI() {
        networkService.fetchData { [weak self] (pryaniky) in
            guard let self = self else { return }
            guard let variantsArr = pryaniky.data[2].data.variants else {return}
            DispatchQueue.main.sync {
                for (name, label) in zip(variantsArr, self.labelArr) {
                    label.font = UIFont.systemFont(ofSize: 30)
                    label.backgroundColor = .systemGray
                    label.text = name.text
                    label.textAlignment = .center
                   
                    guard let title = pryaniky.data[1].data.text else {return}
                    let alert = UIAlertController(title: title, message: "id / имя инициировал событие", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
       
        let stackView = UIStackView(arrangedSubviews: labelArr)
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
