//
//  ZipViewController.swift
//  CombineProject
//
//  Created by Davidyoon on 4/23/24.
//

import UIKit
import Combine
import SnapKit

final class ZipViewController: UIViewController {
    
    private let viewDidLoadPublisher: PassthroughSubject<Void, Never> = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    // UI
    private lazy var displayLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        
        label.layer.borderColor = UIColor.gray.cgColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 4
        
        return label
    }()
    
    private lazy var numberButton: UIButton = {
        var configure = UIButton.Configuration.plain()
        configure.title = "Number"
        
        let button = UIButton(configuration: configure)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    private lazy var stringButton: UIButton = {
        var configure = UIButton.Configuration.plain()
        configure.title = "String"
        
        let button = UIButton(configuration: configure)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        
        [
            self.numberButton,
            self.stringButton
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        return stackView
    }()
    
    private lazy var resetButton: UIButton = {
        var configure = UIButton.Configuration.plain()
        configure.title = "RESET"
        
        let button = UIButton(configuration: configure)
        button.backgroundColor = .red
        button.tintColor = .white
        button.layer.cornerRadius = 4
        
        return button
    }()
    
    private let viewModel: ZipViewModel
    
    init(viewModel: ZipViewModel) {
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
    
    deinit {
        print("DEINIT \(type(of: self))")
    }
    
}

private extension ZipViewController {
    
    func setupViews() {
        self.view.backgroundColor = .systemBackground
        [
            self.displayLabel,
            self.buttonHStackView,
            self.resetButton
        ]
            .forEach {
                self.view.addSubview($0)
            }
        
        self.displayLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(300.0)
        }
        
        self.buttonHStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(50.0)
        }
        
        self.resetButton.snp.makeConstraints {
            $0.top.equalTo(self.displayLabel.snp.bottom).offset(8)
            $0.trailing.equalTo(self.displayLabel)
            $0.height.equalTo(30)
        }
    }
    
    func bindViewModel() {
        var number = 0
        var string = ""
        
        let numberPublisher = self.numberButton.tapPublisher
            .flatMap {  _ -> AnyPublisher<Int, Never> in
                number += 1
                return Just(number)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        let stringPublisher = self.stringButton.tapPublisher
            .flatMap { _ -> AnyPublisher<String, Never> in
                string += "a"
                return Just(string)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        let outputs = self.viewModel.bind(inputs: .init(
            viewDidLoad: self.viewDidLoadPublisher.eraseToAnyPublisher(),
            numberButton: numberPublisher,
            stringButton: stringPublisher,
            resetButton: self.resetButton.tapPublisher
        ))
        
        [
            outputs.title.assign(to: \.title, on: self.navigationItem),
            outputs.displayValue
                .print("DisplayValue")
                .assign(to: \.text, on: self.displayLabel),
            outputs.events.sinkIgnored(),
            outputs.reset.sink(receiveValue: { [weak self] _ in
                number = 0
                string = ""
                self?.reset()
            })
        ]
            .forEach {
                self.cancellables.insert($0)
            }
    }
    
    func reset() {
        self.displayLabel.text = nil
        self.cancellables = []
        self.bindViewModel()
    }
    
}

#Preview {
    ZipViewController(viewModel: ZipViewModel(navigator: ZipNavigator(navigationController: nil)))
}
