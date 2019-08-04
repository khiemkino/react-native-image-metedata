//
//  ReactNativeImageMeteData.m
//  ReactNativeImageMeteData
//
//  Created by luckyxmobile on 2017/8/22.
//  Copyright © 2017年 luckyxmobile. All rights reserved.
//

#import "ReactNativeImageMeteData.h"
@interface ReactNativeImageMeteData()
@end
@implementation ReactNativeImageMeteData
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(readMeteData:(NSString *)imagePath resolve:(RCTPromiseResolveBlock)resolve
                  reject:(RCTPromiseRejectBlock)reject){
    CGImageSourceRef imageSource;
    @try{
        NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
        imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
        NSDictionary *dict =  (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(imageSource, 0, NULL));
        NSMutableDictionary *dictInfo = [dict mutableCopy];
        resolve(dict);
    }
    @catch(NSException *exception){
        NSString *exceptionStr = NSStringFromClass(exception);
        reject(exceptionStr,0,NULL);
    }
    @finally{
        if(imageSource){
            CFRelease(imageSource);
        }
    }
}
RCT_EXPORT_METHOD(editMeteDataPhotoForiOS:(NSString *)imagePath meteDataInfo:(NSDictionary *)meteDataInfo resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject){
        CGImageSourceRef imageSource;
        CFStringRef UTI;
        CGImageDestinationRef destination;
        @try{
            NSMutableDictionary *dictInfo = [meteDataInfo mutableCopy];
            NSMutableData *newImageData = [NSMutableData data];
            NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
            CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
            if(imageSource == NULL){
                NSLog(@"null了");
                reject(@"Image path not found,Please check your path and metedata",0,NULL);
            }
            UTI = CGImageSourceGetType(imageSource);
            destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)newImageData, UTI, 1,NULL);
            if(!destination){
                NSLog(@"null了");
                reject(@"Destination not found,Please check your path and metedata",0,NULL);
            }
            CGImageDestinationAddImageFromSource(destination, imageSource, 0, (__bridge CFDictionaryRef)dictInfo);
            CGImageDestinationFinalize(destination);
            [newImageData writeToFile: imagePath atomically:YES];
            resolve(dictInfo);
        }
        @catch(NSException *exception){
            NSString *exceptionStr = NSStringFromClass(exception);
            reject(exceptionStr,0,NULL);
        }
}
@end
