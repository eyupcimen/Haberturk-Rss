//
//  Haber.m
//  RSS Raider Denemesi Sefa Ayçiçek
//
//  Created by Eyüp Çimen on 8.03.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import "Haber.h"

@implementation Haber

@synthesize resim,baslik,tanim ;


- (id)init
{
    self = [super init];
    if (self) {
        baslik = [[NSMutableString alloc]init];
        tanim = [[NSMutableString alloc]init];
        resim = [[NSMutableString alloc]init];
    }
    return self;
}







@end
