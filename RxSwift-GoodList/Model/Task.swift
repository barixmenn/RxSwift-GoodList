//
//  Task.swift
//  RxSwift-GoodList
//
//  Created by Baris on 5.05.2023.
//

import Foundation

 enum Priority: Int {
   case high
   case medium
   case low
 }

 struct Task {
     let title: String
     let priority: Priority
 }
