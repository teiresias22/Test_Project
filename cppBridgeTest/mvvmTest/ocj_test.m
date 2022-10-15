//
//  ocj_test.m
//  mvvmTest
//
//  Created by hyunny on 2020/12/26.
//  Copyright © 2020 ochjjy. All rights reserved.
//

// -fno-objc-arc : auto release mode off

#import <Foundation/Foundation.h>

#include "och_test.h"

@implementation testObj

-(void)setStr1:(NSString *)in_str1
{
    [str1 autorelease];
    NSLog(@"setStr1 : %@", in_str1);
    str1 = [in_str1 retain];
}

-(void)setStr2:(NSString *)in_str2
{
    [str2 autorelease];
    NSLog(@"setStr2 : %@", in_str2);
    str2 = [in_str2 retain];
}

-(void)setInt1:(int)in_nInt1
{
    NSLog(@"setInt1 : %d", in_nInt1);
    nInt1 = in_nInt1;
}

-(void)setDoubleNum1:(double)in_fNum1
{
    NSLog(@"setDoubleNum1 : %f", in_fNum1);
    fNum1 = in_fNum1;
}

-(NSString*) get_str1 {
    return str1;
}

-(NSString*) get_str2 {
    return str2;
}

-(int) get_nInt1 {
    return nInt1;
}

-(double) get_fNum1 {
    return fNum1;
}

@end

