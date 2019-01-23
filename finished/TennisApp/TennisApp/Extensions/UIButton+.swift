//
//  UIButton.swift
//  TennisApp
//
//  Created by Albert Gil Escura on 1/22/19.
//  Copyright © 2019 Albert Gil Escura. All rights reserved.
//

import UIKit

extension UIButton {
  open override var isEnabled: Bool{
    didSet { alpha = isEnabled ? 1.0 : 0.5 }
  }
}
