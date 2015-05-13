//
//  loginViewController.m
//  Banto
//
//  Created by NEIL on 2015/5/3.
//  Copyright (c) 2015年 NEIL. All rights reserved.
//

#import "loginViewController.h"
#import "CollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "bentoInformation.h"
#import "UIImageView+AFNetworking.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "InformationViewController.h"

@interface loginViewController ()<UICollectionViewDataSource,UICollectionViewDataSource>

{
    NSMutableArray *bentoAmount;
    NSUserDefaults *client;
    int bentoNumber,bentoNumberInfor,internetacont;
    UIActivityIndicatorView *indicator;
    UIImageView *firstViewImageView;
    NSString *parameter2;
}
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UIButton *bentoConform;
@property (nonatomic, strong) NSMutableArray *feeddata;
@property (strong,nonatomic)NSDictionary *todatBentoDictionary;
@property (weak, nonatomic) IBOutlet UICollectionView *colletionView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *avatarName;
@property (weak, nonatomic) IBOutlet UILabel *avatarInfor;
@property (weak, nonatomic) IBOutlet UILabel *totally;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (weak, nonatomic) IBOutlet UIButton *FBButton;

#define BaseURLString @"http://139.162.8.33"
@end

@implementation loginViewController


-(void)awakeFromNib{
    bentoNumberInfor = 0;

}



- (void)viewDidLoad {
    [super viewDidLoad];

    
    //Facebook Login

    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    CGPoint point =CGPointMake(225, 523);
//    loginButton.center = point;
//    [self.view addSubview:loginButton];
//    loginButton.readPermissions = @[@"user_about_me",@"email"];
//    parameter2= [[FBSDKAccessToken currentAccessToken] tokenString] ;
//    NSLog(@"Login %@ hihi",parameter2);
//    
//    if ([loginButton.titleLabel.text isEqualToString:@"Log out"]) {
//        NSLog(@"我有");
//    }
    
  
    firstViewImageView = [[UIImageView alloc]init];
    firstViewImageView.backgroundColor = [UIColor grayColor];
    firstViewImageView.alpha=0.6;
    firstViewImageView.frame = CGRectMake(0, 0, 1000, 1000);
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
       indicator.center = CGPointMake(160,200);
    
    [self.view addSubview:indicator];
    [self.view addSubview:firstViewImageView];
    self.view.userInteractionEnabled = NO;
    [indicator startAnimating];


    client = [NSUserDefaults standardUserDefaults];

    [self prepareforAPIcall];
    
    // Do any additional setup after loading the view.
}


-(void)prepareforAPIcall{
      AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: @"http://www.bentobanto.com"]];

    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:@"/api/v1/menus/lastest" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [indicator stopAnimating];


        self.todatBentoDictionary = responseObject;
  
        [client setObject:[self.todatBentoDictionary objectForKey:@"id"] forKey:@"id"];
        [client setObject:[self.todatBentoDictionary objectForKey:@"title"] forKey:@"bentoName"];
        [self avatar];
        [self bentoNumber];
        [self bentoInfor];
        [self total];
        self.view.userInteractionEnabled = YES;
        [firstViewImageView removeFromSuperview];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Get Section Error: %@", error);


    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)avatar{
    NSArray *avatarinfo = [self.todatBentoDictionary objectForKey:@"mominfo"];
    _avatarName.text = [avatarinfo objectAtIndex:1];
    [client setObject:[avatarinfo objectAtIndex:1] forKey:@"avatarName"];
    _avatarInfor.text =[avatarinfo objectAtIndex:0];
    NSString *avatarImage = [self.todatBentoDictionary objectForKey:@"img_url"];
    
    _avatarImage.layer.cornerRadius=65;
    _avatarImage.layer.masksToBounds=YES;
    [_avatarImage setImageWithURL:[NSURL URLWithString:avatarImage]];


}

// acount the total money and return the label
-(void)total{
    
    int temp = [[self.todatBentoDictionary objectForKey:@"price"]intValue];
    NSLog(@"temp = %d",temp);
    
    int x = [[client objectForKey:@"number"]intValue];
    [_bentoConform setTitle:([[NSString alloc] initWithFormat:@"%d",(x)]) forState:UIControlStateNormal];
    
    NSString *temp2 = [[NSString alloc] initWithFormat:@"%d",(x*temp)];
 
    [_totally setText:temp2];
    
}

// bento array to update

-(void)bentoInfor{
    NSArray *temp = [[NSArray alloc]init];
    temp =[self.todatBentoDictionary objectForKey:@"contents"];
    self.feeddata = [[NSMutableArray alloc]init];
    self.feeddata = [temp copy];
    [_colletionView reloadData];
    
}
-(void)bentoNumber{
    
    bentoNumber = [[self.todatBentoDictionary objectForKey:@"in_stock_qty"] intValue];
    bentoAmount = [[NSMutableArray alloc]init];
    
    for (int x = 1 ; x <= bentoNumber; x++) {
        NSString *temp = [[NSString alloc] initWithFormat:@"%d",x];
        [bentoAmount addObject: temp];
    }
    
    if ([bentoAmount count]>0) {
        
        [_pickerView reloadAllComponents];}
    if ([bentoAmount count]== 0) {
//        self.bentoConform.userInteractionEnabled=NO;
//        self.bentoConform.titleLabel.text=@"0";
//        self.buyButton.userInteractionEnabled = NO;
//        self.buyButton.titleLabel.text=@"今日售完";
        
    }
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

        return [bentoAmount count];

}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

        return [bentoAmount objectAtIndex:row];
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    

        NSLog(@"%@",[bentoAmount objectAtIndex:row]);
        
       [client setObject:[bentoAmount objectAtIndex:row] forKey:@"number"];
    
    [self total];

    
}

- (IBAction)bantoPrice:(id)sender {
    [UIView beginAnimations:nil context:NULL];

            [UIView setAnimationDuration:0.3];
            CGRect frame = _pickerView.frame;
            frame.origin.y -= 292;
            _pickerView.frame = frame;
            [UIView commitAnimations];
 
}


- (IBAction)tapGesture:(id)sender {
    [UIView beginAnimations:nil context:nil];
    

    [UIView setAnimationDuration:0.2];
    CGRect frame = _pickerView.frame;
    frame.origin.y += 292;
    _pickerView.frame = frame;
    
    [UIView commitAnimations];
    
    
  
    
}

#pragma collectionView




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    int temp2 = 0;
    if (_feeddata != nil) {
    for (int temp = 0; temp < _feeddata.count ; temp++) {
        if ([[self.feeddata objectAtIndex:temp] isEqualToString:@""]) {

        }
        else{
            temp2++;
        }
        
    }}
    return temp2;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LabelTitleCell" forIndexPath:indexPath];
    
    cell.collectionCell.text= [self.feeddata objectAtIndex:indexPath.row];
    cell.collectionCell.layer.cornerRadius = 15;
    cell.collectionCell.clipsToBounds = YES;
    
    if (bentoNumberInfor == 0) {
        UIImageView *star2 = [[UIImageView alloc]init];
        UIImage *star = [UIImage imageNamed:@"star"];
        star2.image = star;
        star2.frame = CGRectMake(0, 0, 20, 20);
        [cell addSubview:star2];
    }
        bentoNumberInfor ++;
        return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma FacebookFunction

- (IBAction)FacebookLogin:(id)sender {
    
    if ([FBSDKAccessToken currentAccessToken]== nil) {
        
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            NSLog(@"error %@",error);
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"Cancelled");
        } else {
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
                [self fetchUserInfo];
                
                
            }
        }
    }];
        }
    else{
        [self fetchUserInfo];
    }
}

-(void)fetchUserInfo {
    
    if ([FBSDKAccessToken currentAccessToken]) {
        
        parameter2= [[FBSDKAccessToken currentAccessToken] tokenString] ;
        NSLog(@"%@",parameter2);
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *parameters = @{@"access_token":parameter2};
        [manager POST:@"http://www.bentobanto.com/api/v1/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"JSON: %@", responseObject);
            
            if (([responseObject objectForKey:@"user_email"] == [NSNull null] ) || ([responseObject objectForKey:@"user_email"] == [NSNull null] )||([responseObject objectForKey:@"user_email"] == [NSNull null] )) {
                //轉移頁面 or 更改顯示方式
                
            }
          
            [client setObject:[responseObject objectForKey:@"user_email"]forKey:@"user_email"];
//            [client setObject:[responseObject objectForKey:@"user_name"]forKey:@"user_name"];
//            [client setObject:[responseObject objectForKey:@"user_phone"]forKey:@"user_phone"];
            
         
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
        
        
    }
}



@end
