//
//  TabBarControlador.h
//  LoEncontre
//
//  Created by Alvaro Lancho on 22/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import "BaseViewController.h"

@interface TabBarControlador : BaseViewController{
    IBOutlet UIView* notificationView;
    
    IBOutlet UILabel* commentCountLabel;
    IBOutlet UILabel* likeCountLabel;
    IBOutlet UILabel* followerCountLabel;
    
    UIButton* showButton;
    UIButton* hideButton;
}

@property (nonatomic, retain) IBOutlet UIView* notificationView;
@property(nonatomic, retain) NSString *usuarioID;
@property (nonatomic, retain) IBOutlet UILabel* commentCountLabel;
@property (nonatomic, retain) IBOutlet UILabel* likeCountLabel;
@property (nonatomic, retain) IBOutlet UILabel* followerCountLabel;
@property (nonatomic, retain) UIButton* showButton;
@property (nonatomic, retain) UIButton* hideButton;
@end

