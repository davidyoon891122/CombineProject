//
//  MenuViewController.swift
//  CombineProject
//
//  Created by Davidyoon on 4/19/24.
//

import UIKit
import Combine
import SnapKit

final class MenuViewController: UIViewController {
    
    private let viewDidLoadPublisher: PassthroughSubject<Void, Never> = .init()
    private let didSelectedPublisher: PassthroughSubject<IndexPath, Never> = .init()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createLayout()
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(MenuCollectionViewCell.self)
        
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, MenuModel> = {
        .init(collectionView: self.collectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(MenuCollectionViewCell.self, for: indexPath)
            cell.setupCell(title: item.title)
            
            return cell
        })
    }()
    
    private let viewModel: MenuViewModel
    
    init(viewModel: MenuViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bindViewModel()
        self.viewDidLoadPublisher.send()
    }
    
}

// CollectionView Delegate
extension MenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectedPublisher.send(indexPath)
    }
    
}


private extension MenuViewController {
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        [
            self.collectionView
        ]
            .forEach {
                self.view.addSubview($0)
            }
        
        self.collectionView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func bindViewModel() {
        let outputs = self.viewModel.bind(.init(
            viewDidLoad: self.viewDidLoadPublisher.eraseToAnyPublisher(),
            didSelected: self.didSelectedPublisher.eraseToAnyPublisher())
        )
        
        [
            outputs.events.sinkIgnored(),
            outputs.title.assign(to: \.title, on: self.navigationItem),
            outputs.menus
                .sink(receiveValue: { [weak self] menus in
                self?.applySnapshot(items: menus)
            })
        ]
            .forEach {
                self.cancellables.insert($0)
            }
        
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { sectionIndex, layoutEnvironment in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(30)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        })
    }
    
    func applySnapshot(items: [MenuModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, MenuModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
}

#Preview {
    MenuViewController(viewModel: MenuViewModel(navigator: MenuNavigator(navigationController: UINavigationController())))
}
