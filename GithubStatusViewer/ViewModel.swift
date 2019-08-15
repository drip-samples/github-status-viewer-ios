//
//  ViewModel.swift
//  GithubStatusViewer
//
//  Created by ogawa_mitsunori on 2019/08/15.
//  Copyright © 2019 ogawa_mitsunori. All rights reserved.
//

import Foundation
import APIKit
import RxSwift
import RxCocoa

final class ViewModel {
    let isUpdating = BehaviorSubject<Bool>(value: false)
    let status = BehaviorSubject<String>(value: "initialized")
    let color = BehaviorSubject<UIColor>(value: UIColor.darkGray)
    let lastUpdated = BehaviorSubject<String>(value: " ")
    let dateFormatter = DateFormatter()
    
    init() {
        self.dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    }
    
    func updateStatus() {
        self.isUpdating.onNext(true)
        let request = GithubStatusRequest()
        Session.send(request) { [weak self] result in
            switch result {
            case .success(let response):
                self?.status.onNext(response.status.description)
                if let color = self?.getColorByIndicator(indicator: response.status.indicator) {
                    self?.color.onNext(color)
                }
            case .failure(let error):
                self?.status.onNext(error.localizedDescription)
                self?.color.onNext(UIColor.red)
            }
            if let updated = self?.dateFormatter.string(from: Date()) {
                self?.lastUpdated.onNext(updated)
            }
            self?.isUpdating.onNext(false)
        }
    }
    
    func getColorByIndicator(indicator: String) -> UIColor {
        switch indicator {
        case "none":
            return UIColor.green
        case "minor":
            return UIColor.orange
        case "major":
            return UIColor.red
        case "critical":
            return UIColor.red
        default:
            return UIColor.darkGray
        }
    }
}
