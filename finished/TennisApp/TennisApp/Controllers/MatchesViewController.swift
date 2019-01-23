//
//  MatchesViewController.swift
//  TennisApp
//
//  Created by Albert Gil Escura on 1/22/19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class MatchesViewController: UIViewController {
  
  @IBOutlet private var tableView: UITableView! {
    didSet {
      tableView.tableFooterView = UIView()
    }
  }
  
  private let matches: BehaviorRelay<[Match]> = BehaviorRelay(value: [])
  private let bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    matches.bind(to: tableView.rx.items(cellIdentifier: "MatchTableViewCell", cellType: MatchTableViewCell.self)) {
      row, element, cell in
      cell.nameLabel.text = element.name
      cell.gamesLabel.text = "\(element.games)"
      }
      .disposed(by: bag)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let viewController = segue.destination as! AddNewMatchViewController
    viewController.delegate = self
    
    matches
      .map { $0.count }
      .bind(to: viewController.matchesCount)
      .disposed(by: bag)
  }
}

extension MatchesViewController: AddNewMatchDelegate {
  func didFinished(addNew item: Match) {
    var values = matches.value
    values.append(item)
  
    matches.accept(values)
  }
}
