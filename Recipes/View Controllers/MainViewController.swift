//
//  MainViewController.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Outlets
    var segmentControl: UISegmentedControl?
    var collectionView: UICollectionView?
    // MARK: - Private
    private var selectedSegmentIndex = 2
    private var dataSource: UICollectionViewDiffableDataSource<CategoryType, Meal>?
    
    var mainViewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor =  .systemBackground
        setUpViews()
        configureDataSource()
        setUpSnapshot()
    }
    private func setUpViews() {
        let control = UISegmentedControl(items: CategoryType.allValues())
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = selectedSegmentIndex
        control.addTarget(self, action: #selector(setUpSnapshot), for: .valueChanged)
        segmentControl = control
    
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: makeCollectionView())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        self.collectionView = collectionView
        
        view.addSubview(control)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            control.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            control.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            control.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: control.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func makeCollectionView() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 12, trailing: 8)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1/3))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
    }
    private func configureDataSource() {
         guard let collectionView else { return }
         let mealCellRegistration = UICollectionView.CellRegistration<MainViewCell, Meal>{ cell, indexPath, meal in
             Task {
                 await cell.updateView(meal)
             }
         }
         dataSource = UICollectionViewDiffableDataSource<CategoryType, Meal>(collectionView: collectionView) {(collectionView, indexPath, item) -> UICollectionViewCell? in
             return collectionView.dequeueConfiguredReusableCell(using: mealCellRegistration, for: indexPath, item: item)
         }
     }
    @objc private func setUpSnapshot() {
        selectedSegmentIndex = segmentControl?.selectedSegmentIndex ?? 2
    
        Task
        {
            switch selectedSegmentIndex {
            case 0:
                await applySnapshot(from: .starter)
            case 1:
                await applySnapshot(from: .pasta)
            case 2:
                await applySnapshot(from: .dessert)
            default:
                print("default")
            }
        }
    }
    private func applySnapshot(from category: CategoryType) async {
        if let mainViewModel = mainViewModel {
            var snapshot = NSDiffableDataSourceSnapshot<CategoryType, Meal>()
            await mainViewModel.getAllMeals(category: category)
            snapshot.appendSections([category])
            snapshot.appendItems(mainViewModel.meals)
            await dataSource?.apply(snapshot)
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meal = mainViewModel?.meals[indexPath.row]
        mainViewModel?.appCoordinator?.gotoDetailView()
        
       }
}
