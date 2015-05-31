//
//  ViewController.h
//  RSS Raider Denemesi Sefa Ayçiçek
//
//  Created by Eyüp Çimen on 7.03.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Haber.h"

@interface ViewController : UIViewController  <NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate>
{
    
    NSXMLParser *parser;
    NSMutableArray *haberlistesi;
    Haber *haber;
    
    NSString *currentElement;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableViewMy;

- (IBAction)butonPressed:(UIButton *)sender;


@end

