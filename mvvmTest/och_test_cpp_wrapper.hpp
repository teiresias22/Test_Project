
#import <Foundation/Foundation.h>

@interface MyCppTestWrapper : NSObject
//{
//    NSString* str1;
//    NSString* str2;
//}
{
    @private void* MyCppTestClass;
}
-(MyCppTestWrapper*)init;
-(void) set_str1 : (NSString*) in_str1;
-(void) set_str2 : (NSString*) in_str2;
-(NSString*) get_str1;
-(NSString*) get_str2;
@end
