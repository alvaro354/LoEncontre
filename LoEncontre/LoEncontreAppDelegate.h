//
//  LoEncontreAppDelegate.h
//  LoEncontre
//
//  Created by Alvaro Lancho on 22/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
#import "Reachability.h"
#import <CoreLocation/CoreLocation.h>
#import "Localizacion.h"

@interface LoEncontreAppDelegate : NSObject <UIApplicationDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>
{
    UIWindow *window;
    UINavigationController *navigationController;
    BOOL internet;
    NSTimer *timer;
    NSTimer *timer2;
    UIAlertView *alert;
    CLLocationManager* locationManager ;
    BOOL anadir;
}
-(void)internet;
-(void)alert;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end