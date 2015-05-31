//
//  ViewController.m
//  RSS Raider Denemesi Sefa Ayçiçek
//
//  Created by Eyüp Çimen on 7.03.2015.
//  Copyright (c) 2015 Eyüp Çimen. All rights reserved.
//

#import "ViewController.h"

#import "CellVCTableViewCell.h"


@interface ViewController ()

@end

@implementation ViewController        // http://www.samanyoluhaber.com/rss.htm&id=son-dakika
                                      // http://www.haberturk.com/rss


-(void)getRssData
{
    NSString *strUrl = @"http://www.haberturk.com/rss";
    NSURL *url = [NSURL URLWithString:strUrl];
    
    NSData *data = [NSData dataWithContentsOfURL:url];
     NSLog([[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
    haberlistesi = [[NSMutableArray alloc]init];
    
    parser = [[NSXMLParser alloc]initWithData:data];
    parser.delegate = self;
    [parser parse];
    
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    // bir element başladığı zaman yapılacaklar
    // ilk başta size bir elementName verecektir
    // item tagı başladığında haber nesnesini oluşturuoruz
    
    currentElement = elementName;
    
    if ([elementName isEqualToString:@"item"])
    {
        haber = [[Haber alloc]init];
    }
    
    
}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // foundCharacters metodu String bir parametre alıyor.
    
    if ([currentElement isEqualToString:@"title"])
    {
        [haber.baslik appendString:string];
    }
    
    if ([currentElement isEqualToString:@"description"])
    {
        [haber.tanim appendString:string];
    }
    
    if ([currentElement isEqualToString:@"image"])
    {
        [haber.resim appendString:string];
    }
    
}



-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // item tag'ı kapandığında ne yapacağını belirliyoruruz
    // yani item tagı kapandığında haber nesnesini haberlistesi'ne ekle
    
    if ([elementName isEqualToString:@"item"])
    {
        [haberlistesi addObject:haber];
    }
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.tableViewMy reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelectorInBackground:@selector(getRssData) withObject:nil];
    
    self.tableViewMy.delegate = self;
    self.tableViewMy.dataSource = self;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return haberlistesi.count ;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CellVCTableViewCell *cell = (CellVCTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Haber *temp = [haberlistesi objectAtIndex:indexPath.row];
    
    cell.labelCell.numberOfLines = 0;
    cell.labelCell.text = temp.baslik ;
    
    
    NSData *data = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[temp.resim stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    if (data != nil) {
        cell.imageViewCell.image = [UIImage imageWithData:data];
    }
    
    
    
    return cell;
}



- (IBAction)butonPressed:(UIButton *)sender
{
    
}








@end
