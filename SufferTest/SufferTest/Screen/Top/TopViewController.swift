//
//  TopViewController.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/08.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit
import GoogleMobileAds
import ExpandingMenu

protocol TopViewControllerDelegate{
    func didFinishLogout()
}

class TopViewController: UIViewController, AuthErrorHandling {
    
    @IBOutlet var resultAmountLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    var viewModel: TopViewModel!
    var delegate: TopViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bannerView.adUnitID = "ca-app-pub-1881939689743902/1144068972"
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        self.updateViews()
        self.view.backgroundColor = UIColor(patternImage: self.viewModel.resultState.backgroundImage)
        self.addMenuButton()
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
    
    func setAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
                self.view.backgroundColor = UIColor(patternImage: self.viewModel.resultState.backgroundImage)
            })
        }
        
        UIView.transition(with: (self.navigationController?.navigationBar)!, duration: 1, options: .transitionCrossDissolve, animations: {
            self.navigationController?.navigationBar.setBackgroundImage(self.viewModel.resultState.backgroundImage, for: .default)
        })
    }
    
    // MARK: - Unwind segue

    @IBAction func backToTop(segue:UIStoryboardSegue) {
        self.updateViews()
        self.setAnimation()
    }
    
    // MARK: - Actions
    
    @IBAction func touchUpInsideHistoryButton(_ sender: Any) {
    }
    
    // MARK: - Private methods
    
    private func requestLogout() {
        AuthFetcher.logout(completion: { error in
            if let error = error {
                self.handleAuthError(error)
            } else {
                DataManager.clear()
                self.delegate?.didFinishLogout()
            }
        })
    }
    
    private func pushToHistory() {
        self.performSegue(withIdentifier: "toHistory", sender: nil)
    }
    
    private func pushToSetting() {
        self.performSegue(withIdentifier: "toSetting", sender: nil)
    }
    
}

// MARK: - Side menu

extension TopViewController {
    
    private func addMenuButton() {
        let menuButtonSize: CGSize = CGSize(width: 64.0, height: 64.0)
        let menuButton = ExpandingMenuButton(frame: CGRect(origin: CGPoint.zero, size: menuButtonSize), centerImage: UIImage(named: "sample")!, centerHighlightedImage: UIImage(named: "sample")!)
        menuButton.center = CGPoint(x: 20.0, y: 100.0)
        menuButton.expandingDirection = .bottom
        menuButton.menuTitleDirection = .right
        menuButton.bottomViewAlpha = 0.7
        menuButton.enabledExpandingAnimations = [AnimationOptions.MenuItemBound, AnimationOptions.MenuItemMoving, AnimationOptions.MenuItemFade]
        menuButton.enabledFoldingAnimations = [AnimationOptions.MenuItemBound, AnimationOptions.MenuItemMoving, AnimationOptions.MenuItemFade]
        self.view.addSubview(menuButton)
        
        func showAlert(_ title: String) {
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let item1 = ExpandingMenuItem(size: menuButtonSize, title: "Logout", image: UIImage(named: "sample")!, highlightedImage: UIImage(named: "sample")!, backgroundImage: UIImage(named: "sample"), backgroundHighlightedImage: UIImage(named: "sample")) { () -> Void in
            print("tap Logout")
            self.requestLogout()
        }
        let item2 = ExpandingMenuItem(size: menuButtonSize, title: "History", image: UIImage(named: "sample")!, highlightedImage: UIImage(named: "sample")!, backgroundImage: UIImage(named: "sample"), backgroundHighlightedImage: UIImage(named: "sample")) { () -> Void in
            print("tap History")
            self.pushToHistory()
        }
        let item3 = ExpandingMenuItem(size: menuButtonSize, title: "Setting", image: UIImage(named: "sample")!, highlightedImage: UIImage(named: "sample")!, backgroundImage: UIImage(named: "sample"), backgroundHighlightedImage: UIImage(named: "sample")) { () -> Void in
            print("tap Setting")
            self.pushToSetting()
        }
        let item4 = ExpandingMenuItem(size: menuButtonSize, title: "Reset", image: UIImage(named: "sample")!, highlightedImage: UIImage(named: "sample")!, backgroundImage: UIImage(named: "sample"), backgroundHighlightedImage: UIImage(named: "sample")) { () -> Void in
            print("tap Reset")
        }
        menuButton.addMenuItems([item1, item2, item3, item4])
    }
    
}
