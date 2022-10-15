
#import "och_test_cpp.h"
#import "och_test_cpp_wrapper.hpp"
#import <Foundation/Foundation.h>

@implementation MyCppTestWrapper

-(MyCppTestWrapper*) init
{
    NSLog(@"MyCppTestWrapper init");
    //Create C++ Class instance
    MyCppTestClass = (void*)new MyCppTest;
    return self;
}

-(void) set_str1 : (NSString*) in_str1
{
    NSLog(@"[Wrapper mm] set_str1 : in_str1=%@\n", in_str1);
    MyCppTest* pCpp = (MyCppTest*) MyCppTestClass;
    pCpp->set_str1(in_str1.UTF8String);
}

-(void) set_str2 : (NSString*) in_str2
{
    NSLog(@"[Wrapper mm] set_str2 : in_str2=%@\n", in_str2);
    MyCppTest* pCpp = (MyCppTest*) MyCppTestClass;
    pCpp->set_str2(in_str2.UTF8String);
}

-(NSString*) get_str1
{
    MyCppTest* pCpp = (MyCppTest*) MyCppTestClass;
    std::string str = pCpp->get_str1();
    return [NSString stringWithUTF8String:str.c_str()];
}

-(NSString*) get_str2
{
    MyCppTest* pCpp = (MyCppTest*) MyCppTestClass;
    std::string str = pCpp->get_str2();
    return [NSString stringWithUTF8String:str.c_str()];
}

@end
