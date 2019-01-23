//
//  AddNewMatchViewController.swift
//  TennisApp
//
//  Created by Albert Gil Escura on 1/21/19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
  
  private let bag = DisposeBag()
  
  var delegate: AddNewMatchDelegate?
  let matchesCount = BehaviorSubject<Int>(value: 0)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let nameIsNotEmpty = nameTextfield.rx.text
      .map { ($0 ?? "").count > 0 }
    
    let surnameIsNotEmpty = surnameTextfield.rx.text
      .map { ($0 ?? "").count > 0 }
    
    Observable.combineLatest(nameIsNotEmpty, surnameIsNotEmpty)
      .map { $0 && $1 }
      .map { $0 ? "\(self.nameTextfield.text!) \(self.surnameTextfield.text!)" : "Rellene todos los campos" }
      .bind(to: completeNameLabel.rx.text)
      .disposed(by: bag)
    
    nivelSegmentedControl.rx.value.asObservable()
      .map { $0 == 0 ? "4 juegos máximo" : "8 juegos máximo" }
      .bind(to: nivelLabel.rx.text)
      .disposed(by: bag)
    
    nivelSegmentedControl.rx.value
      .map { $0 == 0 ? 4 : 8 }
      .bind(to: gameStepper.rx.maximumValue)
      .disposed(by: bag)
    
    gameStepper.rx.value
      .map { String(Int($0)) + " juegos" }
      .bind(to: gameLabel.rx.text)
      .disposed(by: bag)
    
    addNewMatchButton.rx.tap.asObservable()
      .subscribe({ [unowned self] _ in
        let match = Match(name: (self.completeNameLabel.text!), games: Int((self.gameStepper.value)))
        self.delegate?.didFinished(addNew: match)
      })
      .disposed(by: bag)
    
    let gameStepperIsNotEmpty = gameStepper.rx.value
      .map { $0 > 0 }
    
    Observable.combineLatest(nameIsNotEmpty, surnameIsNotEmpty, gameStepperIsNotEmpty)
      .map { $0 && $1 && $2 }
      .bind(to: addNewMatchButton.rx.isEnabled)
      .disposed(by: bag)
    
    matchesCount
      .filter { $0 > 0 }
      .map { "\($0) matches seleccionados" }
      .bind(to: navigationItem.rx.title)
      .disposed(by: bag)
  }
}

extension Reactive where Base: UIStepper {
  public var maximumValue: Binder<Double> {
    return Binder(self.base) { stepper, value in
      stepper.maximumValue = value
    }
  }
}

