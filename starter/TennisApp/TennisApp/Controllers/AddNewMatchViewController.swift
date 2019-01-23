//
//  AddNewMatchViewController.swift
//  TennisApp
//
//  Created by Albert Gil Escura on 1/21/19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit

protocol AddNewMatchDelegate: class {
  func didFinished(addNew item: Match)
}

final class AddNewMatchViewController: UIViewController {
  
  @IBOutlet private weak var nameTextfield: UITextField!
  @IBOutlet private weak var surnameTextfield: UITextField!
  
  @IBOutlet private weak var completeNameLabel: UILabel!
  @IBOutlet private var nivelSegmentedControl: UISegmentedControl!
  @IBOutlet private var nivelLabel: UILabel!
  
  @IBOutlet private var gameStepper: UIStepper!
  @IBOutlet private var gameLabel: UILabel!
  
  @IBOutlet private var addNewMatchButton: UIButton!
  
  var delegate: AddNewMatchDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
