//
//  AppCoordinator.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/23/23.
//

import UIKit
import SwiftUI

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    let network = NetworkService()
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    func start() {
        goToMainView()
    }
    private func goToMainView() {
        let mainVC = MainViewController()
        let mainViewModel = MainViewModel(networkService: network)
        mainViewModel.appCoordinator = self
        mainVC.mainViewModel = mainViewModel
        navigationController.pushViewController(mainVC, animated: true)
    }
    func gotoDetailView() {
        let detailView = DetailView()
        let detailViewModel = DetailViewModel(network: network)
        detailViewModel.appCoordinator = self
        detailView.viewModel = detailViewModel
        let hostController = UIHostingController(rootView: detailView)
        navigationController.pushViewController(hostController, animated: true)
    }
}
