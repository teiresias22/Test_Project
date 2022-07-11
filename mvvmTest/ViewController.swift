//
//  ViewController.swift
//  mvvmTest
//
//  Created by hyunny on 2020/12/15.
//  Copyright © 2020 ochjjy. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    //object-c class
    var test_obj = testObj()
    
    //c++ wrapper class
    var test_cpp_wrapper = MyCppTestWrapper()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Main View"
        
        /*
        let clothes : [[String]] = [["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"]]
        let n = solution_best(clothes)
        print("n=\(n)")
        
        let clo2 : [[String]] = [["crow_mask", "face"], ["blue_sunglasses", "face"], ["smoky_makeup", "face"]]
        let n2 = solution_best(clo2)
        print("n=\(n2)")
        
        solution([12,11,10,9,8,1])
        
        test_obj.setStr1("testObj str1")
        test_obj.setStr2("testObj str2")
        
        let testObj_str1 = test_obj.get_str1() as String
        let testObj_str2 = test_obj.get_str2() as String
        
        print("testObj_str1 = \(testObj_str1), testObj_str2=\(testObj_str2)")
        */
        
        //Call C++ functions by wrapper
        test_cpp_wrapper?.set_str1("Call cpp func : set_str1")
        test_cpp_wrapper?.set_str2("Call cpp func : set_str2")
        
        let cpp_wrapper_str1 = (test_cpp_wrapper?.get_str1() ?? "") as String
        print("Check cpp func : get_str1 = \(cpp_wrapper_str1)")
        let cpp_wrapper_str2 = (test_cpp_wrapper?.get_str2() ?? "") as String
        print("Check cpp func : get_str2 = \(cpp_wrapper_str2)")
    }

    
    func solution(_ numbers:[Int]) -> Int {
        //let test : [Int] = [3,0,6,1,5]
        let sorted_arr = numbers.sorted {$0 > $1}
        let total = numbers.count
        var comp_arr : [(Int,Int)] = []
        
        sorted_arr.forEach{ i in
            var cnt : Int = 0
            
            
            //인용횟수보다 같거나 큰 경우
            for x in 0..<numbers.count {
                //print("i=\(i), sorted_arr[x]=\(sorted_arr[x]), cnt=\(cnt)")
                if(i <= numbers[x]) && (i > numbers.count){
                    cnt += 1
                }
            }
            
            
            if(cnt > 0) {
                comp_arr.append((i,cnt))
            }
            
            print("i=\(i) cnt=\(cnt), comp_arr=\(comp_arr)")
            
            
            
        }
        
        
        
        
        var rlt : Int = 0
        
        
        print("sorted_arr=\(sorted_arr), comp_arr=\(comp_arr)")
        
        
        return 0
    }
    
    func solution_best(_ clothes:[[String]]) -> Int {
        let dict: [String: Int] = clothes.reduce(into: [:]) {
            //한가지만 입을경우가 있으므로 디폴트가 1
            $0[$1[1], default: 1] += 1;
        }
        print("dict=\(dict)")
        
        //reduce가 어떻게 동작하는지 알아보는 코드
        let n1 = dict.reduce(0) { $0+$1.1}
        let n2 = dict.reduce(2) { $0+$1.1}

        print("n1=\(n1), n2=\(n2)")

        let array = [1, 1, 2, 3,4]
        let newArray = array.reduce(1) { $0 * $1 }
        print("newArray=\(newArray)") //6

        let charArray = ["a", "b", "c", "d"]
        let charNewArray = charArray.reduce("result is ") { $0 + $1 }
        print("charNewArray=\(charNewArray)") //result is abcd
        //reduce가 어떻게 동작하는지 알아보는 코드
        
        return dict.reduce(1) { $0 * $1.1 } - 1
    }
    
    //N : Total stage stages[] = current state
    func solution(_ clothes:[[String]]) -> Int {
        //let clothes : [[String]] = [["yellow_hat", "headgear"], ["blue_sunglasses", "eyewear"], ["green_turban", "headgear"]]
        var first_arr : [String] = []
        var sec_arr : [String] = []
        
        for x in clothes {
            if(first_arr.contains(x[0])) {
                first_arr.append(x[0])
            }
            if(sec_arr.contains(x[1]) == false) {
                sec_arr.append(x[1])
            }
        }
        
        return (first_arr.count * sec_arr.count - 1)
        
    }

    @IBAction func next_btn_clicked(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

