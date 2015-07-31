//
//  MyClass.h
//  Runtimer
//
//  Created by henyep on 15/7/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject<NSCopying,NSCoding>

@property(nonatomic,strong)NSArray *array;
@property(nonatomic,copy)NSString *string;
-(void)method1;
-(void)method2;
+(void)classMethod1;

@end
