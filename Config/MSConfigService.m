//
//  MSConfigService.m
//  Pods
//
//  Created by Mayank Sanganeria on 6/25/15.
//
//

#import "MSConfigService.h"
#import <AFNetworking.h>

@implementation MSConfigService

+ (void)fetchResourceAtPath:(NSString *)path
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure
{
  NSString *baseUrl;
  baseUrl = @"http://s3.amazonaws.com/static.e7mac.com/";
  NSString *fullUrl = [NSString stringWithFormat:@"%@%@", baseUrl, path];
  NSURL *url = [NSURL URLWithString:fullUrl];
  [self fetchJSONAtURL:url success:success failure:failure];
}

+ (void)fetchJSONAtURL:(NSURL *)url
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure
{
  NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
  operation.responseSerializer = [AFJSONResponseSerializer serializer];
  [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    if (success)
      success(responseObject);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    if (failure)
      failure(error);
  }];
  [operation start];
}

@end