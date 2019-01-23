//
//  MatchesViewController.swift
//  TennisApp
//
//  Created by Albert Gil Escura on 1/22/19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit

final class MatchesViewController: UIViewController {
  
  @IBOutlet private var tableView: UITableView! {
    didSet {
      tableView.tableFooterView = UIView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let viewController = segue.destination as! AddNewMatchViewController
    viewController.delegate = self
  }
}

extension MatchesViewController: AddNewMatchDelegate {
  func didFinished(addNew item: Match) {
  }
}
