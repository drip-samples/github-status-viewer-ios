//
//  ViewController.swift
//  GithubStatusViewer
//
//  Created by ogawa_mitsunori on 2019/08/15.
//  Copyright © 2019 ogawa_mitsunori. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private let viewModel = ViewModel()
    private let disposeBag = DisposeBag()

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var lastUpdated: UILabel!
    
    @IBOutlet weak var buttonUpdate: UIButton! {
        didSet {
            buttonUpdate.rx.tap
                .asDriver()
                .drive(onNext: { [weak self] _ in
                    self?.viewModel.updateStatus()
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.isUpdating
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] isUpdating in
                self?.buttonUpdate.isEnabled = !isUpdating
                self?.buttonUpdate.setTitle(isUpdating ? "Updateing..." : "Update", for: .normal)
                self?.buttonUpdate.backgroundColor = isUpdating ? UIColor.darkGray : UIColor.blue
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.status
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] status in
                self?.status.text = status
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.color
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] color in
                self?.status.backgroundColor = color
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.lastUpdated
            .observeOn(MainScheduler.instance)
            .bind(onNext: { [weak self] updated in
                self?.lastUpdated.text = updated
            })
            .disposed(by: self.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.updateStatus()
    }

}

