//
//  MyClass.m
//  Runtimer
//
//  Created by henyep on 15/7/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import "MyClass.h"
@interface MyClass(){
    NSInteger _instace1;
    NSString *_instace2;
}
@property(nonatomic,assign)NSUInteger integer;
-(void)method3WithArg1:(NSInteger)arg1 arg2:(NSString*)arg2;

@end

@implementation MyClass

+(void)classMethod1{

}

-(void)method1{
    NSLog(@"call method method1");
}

-(void)method2{

}

-(void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2{
    NSLog(@"arg1:%ld ,arg2:%@",arg1,arg2);
}




@end
