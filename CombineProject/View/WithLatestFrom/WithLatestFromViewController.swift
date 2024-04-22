//
//  WithLatestFromViewController.swift
//  CombineProject
//
//  Created by Davidyoon on 4/22/24.
//

import UIKit
import SnapKit
import Combine

final class WithLatestFromViewController: UIViewController {
    
    private let viewDidLoadPublisher: PassthroughSubject<Void, Never> = .init()
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let viewModel: WithLatestFromViewModel
    
    init(viewModel: WithLatestFromViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bindViewModel()
        self.viewDidLoadPublisher.send()
    }
    
}

private extension WithLatestFromViewController {
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
    }
    
    func bindViewModel() {
        let outputs = self.viewModel.bind(.init(viewDidLoad: self.viewDidLoadPublisher.eraseToAnyPublisher()))
        
        [
            outputs.title.assign(to: \.title, on: self.navigationItem),
            outputs.events.sinkIgnored()
        ]
            .forEach {
                self.cancellables.insert($0)
            }
    }
    
}
