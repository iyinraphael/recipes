//
//  AppCoordinator.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/23/23.
//

import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    func start() {
        goToMainView()
    }
    private func goToMainView() {
        let mainVC = MainViewController()
        let network = NetworkService()
        let mainViewModel = MainViewModel(networkService: network)
        mainViewModel.appCoordinator = self
        mainVC.mainViewModel = mainViewModel
        navigationController.pushViewController(mainVC, animated: true)
    }
}
