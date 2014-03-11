//
//  CGHelper.m
//
//  Created by Mayank Sanganeria on 7/17/12.
//  Copyright (c) 2012 Mayank Sanganeria. All rights reserved.
//

#import "CGHelper.h"
#ifndef PI
#define PI 3.14159
#endif

@implementation CGHelper


+(CGMutablePathRef)newConcentricArcPathAtPoint:(CGPoint)point withinnerRadius:(float)innerRadius outerRadius:(float)outerRadius startAngle:(float)startAngle endAngle:(float)endAngle
{
    float emptyMiddleRadius = 1;
    float midAngle = (startAngle + endAngle) / 2;
    point.x += emptyMiddleRadius*cosf(midAngle);
    point.y += emptyMiddleRadius*sinf(midAngle);
    bool _clockwise = 0;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, point.x + innerRadius*cosf(startAngle), point.y + innerRadius*sinf(startAngle));
    CGPathAddLineToPoint(path, NULL, point.x + outerRadius*cosf(startAngle), point.y + outerRadius*sinf(startAngle));
    CGPathAddArc(path, NULL, point.x, point.y, outerRadius, startAngle, endAngle, _clockwise);
    CGPathAddLineToPoint(path, NULL, point.x + innerRadius*cosf(endAngle), point.y + innerRadius*sinf(endAngle));
    CGPathAddArc(path, NULL, point.x, point.y, innerRadius, endAngle, startAngle, !_clockwise);
    return path;
}

+(void)fillConcentricArcAtPoint:(CGPoint)point withinnerRadius:(float)innerRadius outerRadius:(float)outerRadius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color
{
    CGMutablePathRef path = [self newConcentricArcPathAtPoint:point withinnerRadius:innerRadius outerRadius:outerRadius startAngle:startAngle endAngle:endAngle];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path);
    [color setFill];
    CGContextFillPath(context);
    CGPathRelease(path);
}


+(void)strokeConcentricArcAtPoint:(CGPoint)point withinnerRadius:(float)innerRadius outerRadius:(float)outerRadius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color
{
    CGMutablePathRef path = [self newConcentricArcPathAtPoint:point withinnerRadius:innerRadius outerRadius:outerRadius startAngle:startAngle endAngle:endAngle];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, path);
    [color setStroke];
    CGContextStrokePath(context);
    CGPathRelease(path);
}

+(void)strokeConcentricArcAtPoint:(CGPoint)point withinnerRadius:(float)innerRadius outerRadius:(float)outerRadius startAngle:(float)startAngle endAngle:(float)endAngle width:(float)width color:(UIColor *)color
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, width);
    [self strokeConcentricArcAtPoint:point withinnerRadius:innerRadius outerRadius:outerRadius startAngle:startAngle endAngle:endAngle color:color];
}


#pragma mark Arc

+(CGMutablePathRef)newArcPathAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, point.x, point.y, radius, startAngle, endAngle, 0);
    return path;
}

+(void)fillArcAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = [self newArcPathAtPoint:point withRadius:radius startAngle:startAngle endAngle:endAngle];
    [color setFill];
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGPathRelease(path);
}


+(void)strokeArcAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = [self newArcPathAtPoint:point withRadius:radius startAngle:startAngle endAngle:endAngle];
    [color setStroke];
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGPathRelease(path);
}

+(void)strokeArcAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle width:(float)width color:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, width);
    [self strokeArcAtPoint:point withRadius:radius startAngle:startAngle endAngle:endAngle color:color];
}

#pragma mark Arc

+(CGMutablePathRef)newSlicePathAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, point.x, point.y, radius, startAngle, endAngle, 0);    
    CGPathMoveToPoint(path, NULL, point.x + radius*cosf(startAngle), point.y + radius*sinf(startAngle));
    CGPathAddLineToPoint(path, NULL, point.x, point.y);
    CGPathAddLineToPoint(path, NULL, point.x + radius*cosf(endAngle), point.y + radius*sinf(endAngle));
    return path;
}

+(void)fillSliceAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = [self newSlicePathAtPoint:point withRadius:radius startAngle:startAngle endAngle:endAngle];
    [color setFill];
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGPathRelease(path);
}


+(void)strokeSliceAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle color:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = [self newSlicePathAtPoint:point withRadius:radius startAngle:startAngle endAngle:endAngle];
    [color setStroke];
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGPathRelease(path);
}


+(void)strokeSliceAtPoint:(CGPoint)point withRadius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle width:(float)width color:(UIColor *)color
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, width);
    [self strokeSliceAtPoint:point withRadius:radius startAngle:startAngle endAngle:endAngle color:color];
}

#pragma mark Circle


+(CGMutablePathRef)newCirclePathAtPoint:(CGPoint)point withRadius:(float)radius
{
    return [self newArcPathAtPoint:point withRadius:radius startAngle:0 endAngle:2*PI];
}

+(void)fillCircleAtPoint:(CGPoint)point withRadius:(float)radius color:(UIColor *)color
{
    [self fillArcAtPoint:point withRadius:radius startAngle:0 endAngle:2*PI color:color];
}


+(void)strokeCircleAtPoint:(CGPoint)point withRadius:(float)radius color:(UIColor *)color
{
    [self strokeArcAtPoint:point withRadius:radius startAngle:0 endAngle:2*PI color:color];
}

+(void)strokeCircleAtPoint:(CGPoint)point withRadius:(float)radius width:(float)width color:(UIColor *)color
{
    [self strokeArcAtPoint:point withRadius:radius startAngle:0 endAngle:2*PI width:width color:color];
}

#pragma mark Text
+(void)drawText:(NSString *)text atPoint:(CGPoint)point font:(UIFont *)font color:(UIColor *)color
{
    [color setFill];
    [text drawAtPoint:point withFont:font];
}

@end
