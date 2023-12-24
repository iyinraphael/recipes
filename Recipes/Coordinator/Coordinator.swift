//
//  Coordinator.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/23/23.
//

import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
