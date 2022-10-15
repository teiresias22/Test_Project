//
//  och_test.h
//  mvvmTest
//
//  Created by hyunny on 2020/12/26.
//  Copyright © 2020 ochjjy. All rights reserved.
//

#ifndef och_test_h
#define och_test_h

#import <Foundation/Foundation.h>

@interface testObj : NSObject
{
    NSString* str1;
    NSString* str2;
    int nInt1;
    double fNum1;
}

-(void) setStr1: (NSString* )in_str1;
-(void) setStr2: (NSString* )in_str2;
-(void) setInt1: (int)in_nInt1;
-(void) setDoubleNum1 : (double)in_fNum1;
-(NSString*) get_str1;
-(NSString*) get_str2;
-(int) get_nInt1;
-(double) get_fNum1;
@end



#endif /* och_test_h */
