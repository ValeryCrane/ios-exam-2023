//
//  ViewController.swift
//  iosExam
//
//  Created by valeriy.zhuravlev on 26.05.2023.
//

import UIKit

extension ViewController {
    /// Константы.
    private enum Constants {
        static let rowHeight: CGFloat = 128
        static let horizontalSpacing: CGFloat = 12
        static let initialRowCount: Int = 100000
        static let reloadTriggerDifference: Int = 10000
        static let rowCountStep: Int = 20000
    }
}

/// Основной контроллер приложения.
class ViewController: UIViewController {
    
    var rowCount = Constants.initialRowCount
    
    // MARK: Subviews.
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CarouselTableViewCell.self, forCellReuseIdentifier: CarouselTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: ViewController's life cycle.

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addTableView()
    }
    
    // MARK: Private methods.
    
    /// Добавляет tableView на экран.
    private func addTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: CarouselTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CarouselTableViewCell
        
        // Обновляем максимальную строку.
        if indexPath.row + Constants.reloadTriggerDifference > rowCount {
            rowCount += Constants.rowCountStep
        }
        
        cell?.setup(with: .init(
            numberOfColumns: 9,
            multiplier: indexPath.row + 1,
            horizontalSpacing: Constants.horizontalSpacing,
            rowHeight: Constants.rowHeight
        ))
        return cell ?? UITableViewCell()
    }
}

// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.rowHeight
    }
}

