//
//  CoformViewController.m
//  Banto
//
//  Created by NEIL on 2015/5/6.
//  Copyright (c) 2015年 NEIL. All rights reserved.
//

#import "CoformViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface CoformViewController (){
    NSUserDefaults *client;
}
@property (weak, nonatomic) IBOutlet UILabel *avatarName;
@property (weak, nonatomic) IBOutlet UILabel *clientName;
@property (weak, nonatomic) IBOutlet UILabel *clientCellPhone;
@property (weak, nonatomic) IBOutlet UILabel *clientAdress;
@property (weak, nonatomic) IBOutlet UILabel *bentoNumber;

@end

@implementation CoformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    client = [NSUserDefaults standardUserDefaults];
    self.bentoNumber.text = [client objectForKey:@"number"];
    self.clientName.text = [client objectForKey:@"name"];
    self.clientCellPhone.text = [client objectForKey:@"phone"];
    self.clientAdress.text = [client objectForKey:@"adress"];
    self.avatarName.text =[client objectForKey:@"avatarName"];


    
    NSString *hihi = [client objectForKey:@"phone"];
    NSLog(@"%@",hihi);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)conformButton:(id)sender {
    
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"name":[client objectForKey:@"name"],@"phone": [client objectForKey:@"phone"],@"address": [client objectForKey:@"adress"],@"menu_id":[client objectForKey:@"id"],@"menu_count":[client objectForKey:@"number"],@"auth_token":@"Kywpc2x-7gLMkd4X8qEC"};
    [manager POST:@"http://www.bentobanto.com/api/v1/orders" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
- (IBAction)cancelButton:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
