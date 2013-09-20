//
//  ViewController.m
//  NewTableView
//
//  Created by mario on 13-3-15.
//  Copyright (c) 2013年 mario. All rights reserved.
//

#import "ViewController.h"

#define TableViewGridStyle 2001

#define pageControlY 135
#define pageControlHeight 25
#define GridCount 3

@implementation ViewController
@synthesize contentView;
@synthesize gridDataArray;

-(void)initData{
    cellArray = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    self.gridDataArray = [NSMutableArray array];
}

-(void)handleData{
    
    NSArray *arr = @[@"3",@"7",@"4",@"1",@"3",@"3",@"3",@"3"];
    [self.dataArray  addObjectsFromArray:arr];
    int dataCount =[self.dataArray count];
    if (dataCount ==0) {
        return;
    }
    [gridDataArray removeAllObjects];
    NSMutableArray *readArray =[NSMutableArray arrayWithArray:self.dataArray ] ;
    
    if (dataCount>GridCount) {
        
        int cellTotal =dataCount/GridCount;
        
        int mo =dataCount%GridCount;
        
        if (mo>0) {
            for (int i=0; i<cellTotal+1; i++) {
                
                if (i==cellTotal) {
                    NSMutableArray *tempArray =[[NSMutableArray alloc] init];
                    for (int y=0; y<mo; y++) {
                        [tempArray addObject:[readArray objectAtIndex:y]];
                    }
                    [gridDataArray addObject:tempArray ];
                }
                else{
                    NSMutableArray *tempArray =[[NSMutableArray alloc] init];
                    [tempArray addObject:[readArray objectAtIndex:0]];
                    [tempArray addObject:[readArray objectAtIndex:1]];
                    [tempArray addObject:[readArray objectAtIndex:2]];

                    [gridDataArray addObject:tempArray];
                    
                    for (int y=0; y<GridCount; y++) {
                        [readArray removeObjectAtIndex:0];
                    }
                }
            }
        }
        else{
            //能被整除
            for (int i=0; i<cellTotal; i++) {
                NSMutableArray *tempArray =[[NSMutableArray alloc] init];
                [tempArray addObject:[readArray objectAtIndex:0]];
                [tempArray addObject:[readArray objectAtIndex:1]];
                [tempArray addObject:[readArray objectAtIndex:2]];
                
                [gridDataArray addObject:tempArray];                
                for (int y=0; y<GridCount; y++) {
                    [readArray removeObjectAtIndex:0];
                }
            }
        }
        
    }else{
        NSMutableArray *tempArrayG =[[NSMutableArray alloc] init];
        for (int x=0; x<[readArray count]; x++) {
            [tempArrayG addObject:[readArray objectAtIndex:x]];
        }
        [gridDataArray addObject:tempArrayG];
    }
    [grid reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    grid =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    grid.dataSource = self;
    grid.delegate = self;
    [self handleData];
    [grid reloadData];
    [self.view addSubview:grid];
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [gridDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
    }
    [self creatGridViewWithCell:cell IndexPath:indexPath];
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)creatGridViewWithCell:(UITableViewCell*)cell IndexPath:(NSIndexPath*)indexPath{

    NSArray *readyArray =[gridDataArray objectAtIndex:indexPath.row];
    for (int i=0; i<[readyArray count]; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.frame=CGRectMake(0+106*i+1, 0, 105.5, 50);
        [button setAccessibilityValue:readyArray[i]];

        [button addTarget:self action:@selector(cllickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor grayColor];
        
        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(0, 10, 106, 20)];
        label.font=[UIFont systemFontOfSize:13];
        label.text = readyArray[i];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
        [cell.contentView addSubview:button];
    }
}

- (void)cllickButton:(UIButton *)button
{
    NSLog(@"button..tag : %@",button.accessibilityValue);
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}




@end
