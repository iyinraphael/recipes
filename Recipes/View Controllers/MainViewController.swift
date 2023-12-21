//
//  MainViewController.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .systemRed
        
        Task {
            await play()
        }
    }

    func play() async {
        let model = MainViewModel(networkService: NetworkService())
        await model.getAll()
    }
    
}
