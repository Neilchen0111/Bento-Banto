//
//  InforTableViewController.m
//  Banto
//
//  Created by NEIL on 2015/5/7.
//  Copyright (c) 2015年 NEIL. All rights reserved.
//

#import "InforTableViewController.h"

@interface InforTableViewController
(){
    NSUserDefaults *client;
    
    
}

@end

@implementation InforTableViewController

-(void)awakeFromNib{
    client = [NSUserDefaults standardUserDefaults];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([client objectForKey:@"user_name"] != NULL) {
        _nameField.text = [client objectForKey:@"user_name"];}
    if ([client objectForKey:@"user_phone"] != NULL) {
        _nameField.text = [client objectForKey:@"user_phone"];}
    if ([client objectForKey:@"user_address"] != NULL) {
        _nameField.text = [client objectForKey:@"user_address"];}


    UITapGestureRecognizer *gestureRecognizer =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(hideKeyboard)];
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)conFormButton:(id)sender {
    
    
    if (_nameField.text.length * _phoneField.text.length *_adressField.text.length == 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"資訊有誤" message:@"請填寫完整資料" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"返回檢查資料" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self viewDidLoad];
        }];
        [alertController addAction:cancelButton];
        [self presentViewController:alertController animated:YES completion:nil];
    }

    else{[client setObject:_nameField.text forKey:@"name"];
    [client setObject:_adressField.text forKey:@"adress"];
    [client setObject:_phoneField.text forKey:@"phone"];

    
        [self dismissViewControllerAnimated:YES completion:nil];}

}


- (void)hideKeyboard
{
    [self.view endEditing:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
