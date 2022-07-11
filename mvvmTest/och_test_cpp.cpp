//
//  och_test_cpp.cpp
//  mvvmTest
//
//  Created by hyunny on 2020/12/26.
//  Copyright © 2020 ochjjy. All rights reserved.
//

#include "och_test_cpp.h"

MyCppTest::MyCppTest()
{
    printf("Creator CppTest\n");
}

MyCppTest::~MyCppTest()
{
    printf("Destroy CppTest\n");
}


void MyCppTest::set_str1(std::string in_str1)
{
    printf("\n뭔가 굉장히 복잡하고\n");
    printf("c++스러운 작업을 처리하고, 결과를 리턴하는 로직이 여기에 구현되고...\n");
    printf("[cpp] set_str1 : in_str1=%s\n", in_str1.c_str());
    str1 = in_str1;
}

void MyCppTest::set_str2(std::string in_str2)
{
    printf("\n뭔가 굉장히 복잡하고\n");
    printf("c++스러운 작업을 처리하고, 결과를 리턴하는 로직이 여기에 구현되고...\n");
    printf("[cpp] set_str2 : in_str2=%s\n", in_str2.c_str());
    str2 = in_str2;
}

std::string MyCppTest::get_str1()
{
    return str1;
}

std::string MyCppTest::get_str2()
{
    return str2;
}

int MyCppTest::get_nNum1()
{
    return nNum1;
}

double MyCppTest::get_fNum1()
{
    return fNum1;
}

void MyCppTest::set_nNum1(int in_num)
{
    printf("set_nNum1 : %d", in_num);
    nNum1 = in_num;
}


void MyCppTest::set_fNum1(double in_fNum)
{
    printf("set_fNum1 : %f", in_fNum);
    fNum1 = in_fNum;
}
