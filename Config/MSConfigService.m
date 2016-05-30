//
//  MSConfigService.m
//  Pods
//
//  Created by Mayank Sanganeria on 6/25/15.
//
//

#import "MSConfigService.h"

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
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    if (!data) {
      NSLog(@"%s: sendAynchronousRequest error: %@", __FUNCTION__, connectionError);
      if (failure) failure(connectionError);
    } else if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
      NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
      if (statusCode != 200) {
        NSLog(@"%s: sendAsynchronousRequest status code != 200: response = %@", __FUNCTION__, response);
        if (failure) failure(connectionError);
      }
    }
    
    NSError *parseError = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
    if (!dictionary) {
      NSLog(@"%s: JSONObjectWithData error: %@; data = %@", __FUNCTION__, parseError, [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
      if (failure) failure(parseError);
    }
    // now you can use your `dictionary` object
    if (success) success(dictionary);
  }];
  

}

@end