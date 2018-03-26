//
//  TopViewController.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/08.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol TopViewControllerDelegate{
    func didFinishLogout()
}

class TopViewController: UIViewController {
    
    @IBOutlet var resultAmountLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    var viewModel: TopViewModel!
    var delegate: TopViewControllerDelegate?
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateViews()
        
//        bannerView.adUnitID = "ca-app-pub-1881939689743902/1144068972"
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    func updateViews() {
        if let project = DataManager.shared.ongoingProject {
            self.viewModel = TopViewModel(project: project)
        } else {
            // 처음부터 시작하기 버튼 표시하기
        }
        
        if self.viewModel.isDday {
            // 결산 화면 표시하기
        } else {
            self.resultAmountLabel.text = "남은금액 " + self.viewModel.resultAmount.currencyFormat
            self.dateLabel.text = "\(self.viewModel.today) 일째 / \(self.viewModel.period)"
        }
    }
    
    // MARK: - Unwind segue

    @IBAction func backToTop(segue:UIStoryboardSegue) {
        self.updateViews()
    }
    
    // MARK: - Actions
    
    @IBAction func touchUpInsideLogoutButton(_ sender: Any) {
        AuthFetcher.logout(completion: {_ in
            DataManager.clear()
            self.delegate?.didFinishLogout()
        })
    }
    
    @IBAction func touchUpInsideHistoryButton(_ sender: Any) {
    
    }
    
}
