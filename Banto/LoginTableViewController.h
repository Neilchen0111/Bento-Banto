//
//  LoginTableViewController.h
//  Banto
//
//  Created by NEIL on 2015/4/29.
//  Copyright (c) 2015年 NEIL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTableViewController : UITableViewController <UIPickerViewDataSource,UIPickerViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
{

    NSMutableArray *price, *number;
    int realBentoNumber;

}
@end
