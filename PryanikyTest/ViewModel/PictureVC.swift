//
//  PictureVC.swift
//  PryanikyTest
//
//  Created by Denis Larin on 31.01.2021.
//

import Foundation

import UIKit

class PictureVC: UIViewController {
    
    var networkService = NetworkService()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
}

extension PictureVC {
    
    func setupView() {
        
        networkService.fetchData { pryaniky in
            guard let pictureURL = pryaniky.data[1].data.url else { return }
            let queue = DispatchQueue.global(qos: .utility)
            queue.async {
                DispatchQueue.main.async {
                    guard let url = URL(string: pictureURL), let data = try? Data(contentsOf: url) else {return}
                    self.imageView.image = UIImage(data: data)
                    
                    guard let title = pryaniky.data[1].data.text else {return}
                    let alert = UIAlertController(title: title, message: "id / имя инициировал событие", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
        }
       
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
         
        
        ])
    }
}
