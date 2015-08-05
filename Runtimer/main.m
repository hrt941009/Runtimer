//
//  main.m
//  Runtimer
//
//  Created by henyep on 15/7/31.
//  Copyright (c) 2015年 com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyClass.h"
#import <objc/runtime.h>

#import "SomeClass.h"

NSString *nameGetter(id self, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([SomeClass class], "_privateName");
    return object_getIvar(self, ivar);
}

void nameSetter(id self, SEL _cmd, NSString *newName) {
    Ivar ivar = class_getInstanceVariable([SomeClass class], "_privateName");
    id oldName = object_getIvar(self, ivar);
    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
}
void Set(){
    MyClass *myClass=[[MyClass alloc]init];
    unsigned int outcount=0;
    
    Class cls=myClass.class;
    
    //类名
    NSLog(@"class name:%s",class_getName(cls));
    NSLog(@"===========================");
    
    
    //父类
    NSLog(@"super class name:%s",class_getName(class_getSuperclass(cls)));
    NSLog(@"================================");
    
    //是否是元类
    NSLog(@"MyClass is %@ a meta-class",class_isMetaClass(cls)?@"":@"not");
    NSLog(@"================================");
    
    
    Class meta_class=objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s",class_getName(cls),class_getName(meta_class));
    NSLog(@"====================================");
    
    
    //变量实例大小
    NSLog(@"instance size:%zu",class_getInstanceSize(cls));
    NSLog(@"====================================");
    
    //成员变量
    Ivar *ivars=class_copyIvarList(cls, &outcount);
    for (int i=0; i<outcount; i++) {
        Ivar ivar=ivars[i];
        NSLog(@"instace variable's name:%s at index:%d",ivar_getName(ivar),i);
    }
    free(ivars);
    
    Ivar string=class_getInstanceVariable(cls, "_string");
    if (string!=NULL) {
        NSLog(@"instace variable %s",ivar_getName(string));
    }
    NSLog(@"====================================");
    
    //属性操作
    objc_property_t *properties=class_copyPropertyList(cls, &outcount);
    for (int i=0; i<outcount; i++) {
        objc_property_t property=properties[i];
        NSLog(@"property's name :%s",property_getName(property));
    }
    free(properties);
    
    objc_property_t array=class_getProperty(cls, "array");
    if (array!=NULL) {
        NSLog(@"property %s",property_getName(array));
    }
    NSLog(@"====================================");
    
    
    //方法操作
    Method *methods=class_copyMethodList(cls, &outcount);
    for (int i=0; i<outcount; i++) {
        Method method=methods[i];
        NSLog(@"method's signature:%s",method_getName(method));
    }
    free(methods);
    
    Method method1=class_getInstanceMethod(cls, @selector(method1));
    if (method1!=NULL) {
        NSLog(@"method %s",method_getName(method1));
    }
    
    Method classMethod=class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod!=NULL) {
        NSLog(@"class method:%s",method_getName(classMethod));
    }
    NSLog(@"MyClass is%@ responed to selector:method3WithArg1:arg2:",class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    
    IMP imp=class_getMethodImplementation(cls, @selector(method1));
    imp();
    NSLog(@"====================================");
    
    //协议
    Protocol * __unsafe_unretained *protocols=class_copyProtocolList(cls, &outcount);
    Protocol *protocol;
    for (int i=0; i<outcount; i++) {
        protocol=protocols[i];
        NSLog(@"protocol name:%s",protocol_getName(protocol));
        
    }
    NSLog(@"MYClass is %@ responsed to protocol %s",class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    NSLog(@"====================================");
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        Set();
//       学习网址 http://www.jianshu.com/p/6b905584f536
        unsigned int outcount=0;
        objc_property_attribute_t type = { "T", "@\"NSString\"" };
        objc_property_attribute_t ownership = { "C", "" }; // C = copy
        objc_property_attribute_t backingivar  = { "V", "_privateName" };
        objc_property_attribute_t attrs[] = { type, ownership, backingivar };
        class_addProperty([SomeClass class], "name", attrs,3);
        class_addMethod([SomeClass class], @selector(name), (IMP)nameGetter, "@@:");
        class_addMethod([SomeClass class], @selector(setName:), (IMP)nameSetter, "v@:@");
        
        objc_property_t *properties1=class_copyPropertyList([SomeClass class], &outcount);
        for (int i=0; i<outcount; i++) {
            objc_property_t property=properties1[i];
            NSLog(@"property's name :%s",property_getName(property));
        }
        free(properties1);

        id o = [SomeClass new];
        NSLog(@"%@", [o name]);
        [o setName:@"Jobs"];
        NSLog(@"%@", [o name]);
    }
    return 0;
}
