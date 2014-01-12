//
//  LoginViewController.h
//  LoEncontre
//
//  Created by Alvaro Lancho on 22/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "LoEncontreAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+AESCrypt.h"
#import <Security/Security.h>
#import "MBProgressHUD.h"
#import "StringEncryption.h"
#import "NSData+Base64.h"
#import "SBJson.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate>{
    BOOL registrar;
     MBProgressHUD* hud;
    NSString *serverOutput;
     BOOL exito;
     BOOL registrando;
}
@property (strong, nonatomic) IBOutlet UITextField *usuarioText;
@property (strong, nonatomic) IBOutlet UITextField *contrasenaText;
@property (strong, nonatomic) IBOutlet UITextField *correoText;

@property (retain, nonatomic) IBOutlet UIView *vistaFondo;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UITextField *campoActivo;


-(IBAction)cancelar:(id)sender;
-(IBAction)sendData:(id)sender;
@end
