//
//  och_test_cpp.h
//  mvvmTest
//
//  Created by hyunny on 2020/12/26.
//  Copyright © 2020 ochjjy. All rights reserved.
//

#ifndef och_test_cpp_h
#define och_test_cpp_h

#if defined __cplusplus
#include <stdio.h>
#include <string>

class MyCppTest
{
public:
    MyCppTest();
    ~MyCppTest();
    
    std::string str1;
    std::string str2;
    int nNum1;
    double fNum1;
    
    void set_str1(std::string in_str1);
    void set_str2(std::string in_str2);
    std::string get_str1();
    std::string get_str2();
    int get_nNum1();
    double get_fNum1();
    void set_nNum1(int in_num);
    void set_fNum1(double in_fNum);
    
};
#endif

#endif /* och_test_cpp_h */
