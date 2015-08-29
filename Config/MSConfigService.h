//
//  MSConfigService.h
//  Pods
//
//  Created by Mayank Sanganeria on 6/25/15.
//
//

#import <Foundation/Foundation.h>

@interface MSConfigService : NSObject

+ (void)fetchResourceAtPath:(NSString *)path
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure;

@end