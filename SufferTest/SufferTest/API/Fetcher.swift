//
//  Fetcher.swift
//  SufferTest
//
//  Created by Kibok on 2018. 3. 15..
//  Copyright © 2018년 Fenrir Inc. All rights reserved.
//

import Foundation
import Firebase

typealias JSON = [String: Any]

class FirebaseManager {
    
    // Singleton
    static let shared = FirebaseManager()
    
    var db: Firestore!
    
    init() {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }
    
}

struct AuthFetcher {
    
    // 회원가입
    static func signup(email: String, password: String, completion:@escaping (_ error: Error?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            completion(error)
        }
    }
    
    // 로그인
    static func login(email: String, password: String, completion:@escaping (_ error: Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            completion(error)
        }
        
    }
    
    // 로그아웃
    static func logout(email: String, password: String, completion:@escaping (_ error: NSError?) -> ()) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            completion(error)
        }
    }
    
    // 확인메일보내기
    static func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("sendEmailVerificationOP")
        }
    }
    
    // 비번변경
    static func changePassword(to password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("update password")
        }
    }
    
    // 회원탈퇴
    static func deleteAccount() {
        Auth.auth().currentUser?.delete { error in
            if let error = error {
                // An error happened.
                print(error)
            } else {
                // Account deleted.
            }
        }
    }
    
}

struct HistoryFetcher {
    
    // 프로젝트 시작
    static func startProject(data: JSON) {
        FirebaseManager.shared.db.collection("users").document((Auth.auth().currentUser?.email)!).setData(data) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    // 프로젝트 읽어오기
    static func readProject(completion:@escaping (_ error: Error?) -> ()) {
        FirebaseManager.shared.db.collection("users").document((Auth.auth().currentUser?.email)!).getDocument { (document, error) in
            if let document = document,let data = document.data() , document.exists {
                DataManager.updateAll(response: UserHistory(data))
            } else {
                print("Document does not exist")
            }
            completion(error)
        }
        
    }
    
    // 오프라인 데이터 읽어오기
    static func readProjectFromSnapshot(completion:@escaping (_ error: Error?) -> ()) {
        FirebaseManager.shared.db.collection("users").document((Auth.auth().currentUser?.email)!).addSnapshotListener { (document, error) in
            if let document = document,let data = document.data() , document.exists {
                DataManager.updateAll(response: UserHistory(data))
            } else {
                print("Document does not exist")
            }
            completion(error)
        }
    }
    
    // 업데이트 프로젝트
    static func updateProject(data: JSON) {
        FirebaseManager.shared.db.collection("users").document((Auth.auth().currentUser?.email)!).updateData([
            "ongoingProject": data
        ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    // 프로젝트 삭제
    static func deleteProject() {
        FirebaseManager.shared.db.collection("users").document((Auth.auth().currentUser?.email)!).updateData([
            "ongoingProject": NSNull(),
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
        }
    }
    
    // 업데이트 히스토리
    static func updateHistory(data: [JSON]) {
        FirebaseManager.shared.db.collection("users").document((Auth.auth().currentUser?.email)!).updateData([
            "projectHistory": data
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    // 이력초기화
    static func deleteData() {
        FirebaseManager.shared.db.collection("users").document((Auth.auth().currentUser?.email)!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}

