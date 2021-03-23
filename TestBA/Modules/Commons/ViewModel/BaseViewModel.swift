//
//  BaseViewModel.swift
//  TestBA
//
//  Created by Leonardo Flores Lopez on 21/03/21.
//

import Foundation
import RxCocoa
typealias ErrorMessage = (title: String, message: String)

class BaseViewModel {
    let errorMessage = BehaviorRelay<ErrorMessage>(value: ("", ""))
    let needsLoading = BehaviorRelay<Bool>(value: false)
}
