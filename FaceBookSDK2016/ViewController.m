//
//  ViewController.m
//  FaceBookSDK2016
//
//  Created by Vivid6 on 11/02/16.
//  Copyright © 2016 Vivid6. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)ClickLogin:(id)sender {
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
 
  NSArray *permissions =    @[@"email",@"public_profile",@"user_hometown",@"user_birthday",@"user_about_me",@"user_friends",@"user_photos"];
    [loginManager logInWithReadPermissions:permissions
                        fromViewController:self
                                   handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
                                       if (error) {
   
    NSLog(@"Process error");
    } else if (result.isCancelled) {
                                           NSLog(@"Cancelled");
                                       } else {
                                           [self fetchUserInfo];
                                       }
                                   }];
}
-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"birthday"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"results:%@",result);
                 
                 NSString *email = [result objectForKey:@"email"];
                 //NSString *userId = [result objectForKey:@"id"];
                 
                 if (email.length >0 )
                 {
                     //Start you app Todo
                 }
                 else
                 {
                     NSLog(@"Facebook email is not verified");
                    }
            }
    else
      {
           NSLog(@"Error %@",error);
      }}];}}
@end
