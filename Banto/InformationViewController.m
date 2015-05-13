//
//  InformationViewController.m
//  Banto
//
//  Created by NEIL on 2015/4/30.
//  Copyright (c) 2015年 NEIL. All rights reserved.
//

#import "InformationViewController.h"


@interface InformationViewController (){
    
    NSUserDefaults *client;
}


@end

@implementation InformationViewController




- (IBAction)orderConfirm:(id)sender {
    
    NSLog(@"%@",_nameField.text);
    NSLog(@"%@",_cellphoneField.text);
    NSLog(@"%@",_adressField.text);
    [client setObject:(_nameField) forKey:@"name"];
    [client setObject:(_cellphoneField) forKey:@"cellphone"];
    [client setObject:(_adressField) forKey:@"adress"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)hideKeyboard
{
    [self.view endEditing:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    client = [NSUserDefaults standardUserDefaults];
    

    
    UITapGestureRecognizer *gestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(hideKeyboard)];
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];
   
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
