//
//  ViewController.h
//  NewTableView
//
//  Created by mario on 13-3-15.
//  Copyright (c) 2013年 mario. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray * cellArray;
    BOOL  isGrid;
    UIViewController *currentViewController;
    IBOutlet  UIView *contentView;
    BOOL transiting;
    UITableView *grid;
}

@property(nonatomic,retain)IBOutlet   UIView *contentView;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSMutableArray *gridDataArray;


@end
