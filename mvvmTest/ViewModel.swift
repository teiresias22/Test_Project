//
//  ViewModel.swift
//  mvvmTest
//
//  Created by hyunny on 2020/12/15.
//  Copyright © 2020 ochjjy. All rights reserved.
//

import Foundation
import UIKit

class ViewModel : NSObject {
    static let view_model = ViewModel()
    
    private var src_items : [String] = ["사과","바나나","포도","망고","오렌지","딸기"]
 
    
    func add_model_data(strData : String) {
        src_items.append(strData)
    }
    
    func get_model_data() -> [String] {
        return src_items
    }
    
}

class tableViewCell : UITableViewCell {
    var fruit = UILabel()
}
