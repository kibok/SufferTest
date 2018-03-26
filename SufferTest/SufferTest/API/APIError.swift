//
//  APIError.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/16.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import Foundation
import Firebase

protocol AuthErrorHandling: SimpleAlertPresenter {
}

extension AuthErrorHandling where Self: UIViewController {
    
    func handleAuthError(_ error: Error) {
        let title = "로그인 에러"
        print(error.localizedDescription)
        if let errorCode = AuthErrorCode(rawValue: (error as NSError).code) {
            switch errorCode {
            case .invalidCustomToken, .customTokenMismatch:
                self.showAlert(title: title, message: "토큰에러")
            case .userDisabled:
                self.showAlert(title: title, message: "userDisabled")
            case .operationNotAllowed:
                self.showAlert(title: title, message: "operationNotAllowed")
            case .emailAlreadyInUse:
                self.showAlert(title: title, message: "emailAlreadyInUse")
            case .invalidEmail:
                self.showAlert(title: title, message: "invalidEmail")
            case .wrongPassword:
                self.showAlert(title: title, message: "wrongPassword")
            case .tooManyRequests:
                self.showAlert(title: title, message: "tooManyRequests")
            case .userNotFound:
                self.showAlert(title: title, message: "userNotFound")
            case .accountExistsWithDifferentCredential:
                self.showAlert(title: title, message: "accountExistsWithDifferentCredential")
            case .requiresRecentLogin:
                self.showAlert(title: title, message: "requiresRecentLogin")
            case .networkError:
                self.showAlert(title: title, message: "networkError")
            case .userTokenExpired:
                self.showAlert(title: title, message: "userTokenExpired")
            case .userMismatch:
                self.showAlert(title: title, message: "userMismatch")
            case .weakPassword:
                self.showAlert(title: title, message: "weakPassword")
            case .missingEmail:
                self.showAlert(title: title, message: "missingEmail")
            default:
                self.showAlert(title: title, message:"로그인 실패")
            }
        } else {
            self.showAlert(title: title, message: "code error")
        }
    }
    
}

protocol FirestoreErrorHandling: SimpleAlertPresenter {
}

extension FirestoreErrorHandling where Self: UIViewController {
    
    func handleFirestoreError(_ error: Error) {
        let title = "파이어베이스 에러"
        print(error.localizedDescription)
        if let errorCode = FirestoreErrorCode(rawValue: (error as NSError).code) {
            switch errorCode {
            case .cancelled:
                self.showAlert(title: title, message: "cancelled")
            case .notFound:
                self.showAlert(title: title, message: "notFound")
            default:
                self.showAlert(title: title, message: "이러이러해서 실패")
            }
        } else {
            self.showAlert(title: title, message: "code error")
        }
    }
    
}
