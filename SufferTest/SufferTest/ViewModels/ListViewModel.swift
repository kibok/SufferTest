//
//  ListViewModel.swift
//  SufferTest
//
//  Created by 朴 基馥 on 2018/03/08.
//  Copyright © 2018年 Fenrir Inc. All rights reserved.
//

import UIKit

struct ListViewModel {
 
    let projects: [Project]
    
    init(projects: [Project]) {
        self.projects = projects
    }
    
}

struct DetailsViewModel {
    
    let details: [Detail]
    
    init(details: [Detail]) {
        self.details = details
    }
    
}
