//
//  iAd.m
//  FLO
//
//  Created by Jason Hoang on 10/23/14.
//  Copyright (c) 2014 JasonHoang. All rights reserved.
//

#import "AD.h"

@interface AD ()

{
    BOOL _bannerIsVisible;
    ADBannerView *_adBanner;
}

@end

@implementation AD

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//This appears on the bottom of the screen for an iPhone 4

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    ADBannerView *adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 50,320,50)];
    [self.view addSubview:adView];
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
