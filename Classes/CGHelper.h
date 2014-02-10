//
//  CGHelper.h
//
//  Created by Mayank Sanganeria on 7/17/12.
//  Copyright (c) 2012 Mayank Sanganeria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGHelper : NSObject

#pragma mark ConcentricArc

+(CGMutablePathRef)newConcentricArcPathAtPoint:(CGPoint)point withinnerRadius:(float)innerRadius outerRadius:(float)outerRadius startAngle:(float)startAngle endAngle:(float)endAngle CF_RETURNS_RETAINED;
+(void)fillConcentricArcAtPoint:(CGPoint)point withinnerRadius:(float)innerRadius outerRadius:(float)outerRadius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color;
+(void)strokeConcentricArcAtPoint:(CGPoint)point withinnerRadius:(float)innerRadius outerRadius:(float)outerRadius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color;
+(void)strokeConcentricArcAtPoint:(CGPoint)point withinnerRadius:(float)innerRadius outerRadius:(float)outerRadius startAngle:(float)startAngle endAngle:(float)endAngle width:(float)width color:(UIColor *)color;

#pragma mark Arc

+(CGMutablePathRef)newArcPathAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle CF_RETURNS_RETAINED;
+(void)fillArcAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color;
+(void)strokeArcAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color;
+(void)strokeArcAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle width:(float)width color:(UIColor *)color;

#pragma mark Slice

+(CGMutablePathRef)newSlicePathAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle CF_RETURNS_RETAINED;
+(void)fillSliceAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color;
+(void)strokeSliceAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color;
+(void)strokeSliceAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle width:(float)width color:(UIColor *)color;

#pragma mark Circle

+(CGMutablePathRef)newCirclePathAtPoint:(CGPoint)point withRadius:(float)radius CF_RETURNS_RETAINED;
+(void)fillCircleAtPoint:(CGPoint)point withRadius:(float)radius color:(UIColor *)color;
+(void)strokeCircleAtPoint:(CGPoint)point withRadius:(float)radius color:(UIColor *)color;
+(void)strokeCircleAtPoint:(CGPoint)point withRadius:(float)radius width:(float)width color:(UIColor *)color;

#pragma mark Text
+(void)drawText:(NSString *)text atPoint:(CGPoint)point font:(UIFont *)font color:(UIColor *)color;
@end
