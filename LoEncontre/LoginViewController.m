//
//  LoginViewController.m
//  LoEncontre
//
//  Created by Alvaro Lancho on 22/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize vistaFondo,scrollView,usuarioText,correoText,contrasenaText,campoActivo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    vistaFondo.layer.borderWidth=1.0f;
    vistaFondo.layer.borderColor=[UIColor colorWithRed:0.90 green:0.0 blue:0.0 alpha:1].CGColor;
    vistaFondo.clipsToBounds=YES;
    vistaFondo.layer.cornerRadius = 5.0;
    
    [scrollView setContentSize:[[self view] frame].size];
    
    //Notificaciones del teclado
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(apareceElTeclado:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(desapareceElTeclado:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //Detección de toques en el scroll view
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewPulsado)];
    [tapRecognizer setCancelsTouchesInView:NO];
    
    
    [usuarioText setDelegate:self];
    [contrasenaText setDelegate:self];
    [correoText setDelegate:self];
    
    usuarioText.clipsToBounds=YES;
    usuarioText.layer.cornerRadius = 8.0;
    contrasenaText.clipsToBounds=YES;
    contrasenaText.layer.cornerRadius = 8.0;
    correoText.clipsToBounds=YES;
    correoText.layer.cornerRadius = 8.0;
    
    //vistaFondo.backgroundColor=[UIColor redColor];
    
	// Do any additional setup after loading the view.
}


-(IBAction)cancelar:(id)sender{
    
    CABasicAnimation *animY = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animY.duration = 0.6;
    animY.repeatCount = 0;
    animY.delegate=self;
    animY.removedOnCompletion = NO;
    animY.fillMode = kCAFillModeForwards;
    animY.toValue=[NSNumber numberWithFloat:550];
    [scrollView.layer addAnimation:animY forKey:nil];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    scrollView.alpha=0;
    
    [UIView commitAnimations];
    
    
    
}
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    NSLog(@"Llamado");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Colocar" object:nil];
    [scrollView removeFromSuperview];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
  /*  if (alerta ==1 ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Volver" object:nil];
    }*/

}


-(IBAction)sendData:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        
        
        if (networkStatus == NotReachable) {
            NSLog(@"There IS NO internet connection");
            
            [[LoEncontreAppDelegate alloc]internet];
            return;
            
        }
        
        
        
        
        if (registrar==YES) {
            
            if ([usuarioText.text isEqualToString:@""] || [usuarioText.text isEqualToString:@" "] ) {
                NSLog(@"Blanco");
                UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Usuario en Blanco"
                                                                      delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [alertsuccess show];
                
                
            }
            if ([contrasenaText.text isEqualToString:@""] || [contrasenaText.text isEqualToString:@" "] ) {
                NSLog(@"Blanco");
                UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Contraseña en Blanco"
                                                                      delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [alertsuccess show];
                
                
            }
            if ([correoText.text isEqualToString:@""] || [correoText.text isEqualToString:@" "] ) {
                NSLog(@"Blanco");
                UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Correo en Blanco"
                                                                      delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [alertsuccess show];
                
                
            }
            else{
                hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                hud.labelText = NSLocalizedString(@"Connecting", @"");
                
                //NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",userText.text, ContraText.text];
                
                NSString *hostStr = @"http://lanchosoftware.es/app/registrar.php";
                // hostStr = [hostStr stringByAppendingString:post];
                
                NSLog(@"%@",hostStr);
                
                
                
                NSString *_key = @"alvarol2611995";
                
                NSDate *myDate = [NSDate date];
                NSDateFormatter *df = [NSDateFormatter new];
                [df setDateFormat:@"dd"];
                
                _key= [_key stringByAppendingString:[df stringFromDate:myDate]];
                NSLog(@" %@ key",_key);
                StringEncryption *crypto = [[StringEncryption alloc] init] ;
                
                
                
                
                NSData *_secretData = [usuarioText.text dataUsingEncoding:NSUTF8StringEncoding];
                NSData *_secretDataCon = [contrasenaText.text dataUsingEncoding:NSUTF8StringEncoding];
                NSData *_secretDataCorreo = [correoText.text dataUsingEncoding:NSUTF8StringEncoding];
                
                CCOptions padding = kCCOptionPKCS7Padding;
                NSData *encryptedData = [crypto encrypt:_secretData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
                NSData *encryptedDataCon = [crypto encrypt:_secretDataCon key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
                NSData *encryptedDataCorreo = [crypto encrypt:_secretDataCorreo key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
                NSLog(@"encrypted data in hex: %@", encryptedData);
                
                /*NSData *decryptedData = [crypto decrypt:encryptedData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
                 
                 NSLog(@"decrypted data in dex: %@", decryptedData);
                 NSString *str = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
                 
                 NSLog(@"decrypted data string for export: %@",str);
                 */
                NSString * encodedStringUsu = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                                    NULL,
                                                                                                                    (CFStringRef)[encryptedData base64EncodingWithLineLength:0],
                                                                                                                    NULL,
                                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                                    kCFStringEncodingUTF8 ));
                NSString * encodedStringCon = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                                    NULL,
                                                                                                                    (CFStringRef)[encryptedDataCon base64EncodingWithLineLength:0],
                                                                                                                    NULL,
                                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                                    kCFStringEncodingUTF8 ));
                NSString * encodedStringCorreo = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                                       NULL,
                                                                                                                       (CFStringRef)[encryptedDataCorreo base64EncodingWithLineLength:0],
                                                                                                                       NULL,
                                                                                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                                       kCFStringEncodingUTF8 ));
                
                NSLog(@"encrypted data string for export: %@",[encryptedDataCon base64EncodingWithLineLength:0]);
                NSString * usuario = [NSString stringWithFormat:@"?username=%@",encodedStringUsu];
                NSString * contrasena = [NSString stringWithFormat:@"&password=%@",encodedStringCon ];
                NSString * correo = [NSString stringWithFormat:@"&email=%@",encodedStringCorreo ];
                NSString * date = [NSString stringWithFormat:@"&date=%@",[df stringFromDate:myDate]];
                NSLog(@"Usuario: %@",usuario);
                NSLog(@"Contrasena: %@",contrasena);
                
                hostStr= [hostStr stringByAppendingString:usuario];
                hostStr=[hostStr stringByAppendingString:contrasena];
                hostStr=[hostStr stringByAppendingString:correo];
                hostStr=[hostStr stringByAppendingString:date];
                
                NSLog(@"URL: %@",hostStr);
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:[NSURL URLWithString:hostStr]];
                
                NSOperationQueue *cola = [NSOperationQueue new];
                // now lets make the connection to the web
                
                [NSURLConnection sendAsynchronousRequest:request queue:cola completionHandler:^(NSURLResponse *response, NSData *datas, NSError *error)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         serverOutput = [[NSString alloc] initWithData:datas encoding: NSASCIIStringEncoding];
                         NSString *trimmedString = [serverOutput stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                         NSLog(@"%@ String",serverOutput);
                         
                         if([trimmedString isEqualToString:@"1"]){
                             
                             NSLog(@"Registro Exitoso");
                             
                             usuarioText.layer.borderWidth=2;
                             usuarioText.layer.borderColor= [UIColor colorWithRed:0 green:1 blue:0 alpha:1].CGColor;
                             
                             contrasenaText.layer.borderWidth=2;
                             contrasenaText.layer.borderColor= [UIColor colorWithRed:0 green:1 blue:0 alpha:1].CGColor;
                             
                             correoText.layer.borderWidth=2;
                             correoText.layer.borderColor= [UIColor colorWithRed:0 green:1 blue:0 alpha:1].CGColor;
                             exito=YES;
                             
                             UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Registrado" message:@"Registro con exito"
                                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                             [alertsuccess show];
                             
                             
                             
                         }
                         if([trimmedString isEqualToString:@"2"]){
                             NSLog(@"Usuario Existe");
                             usuarioText.layer.borderWidth=2;
                             usuarioText.layer.borderColor= [UIColor colorWithRed:1 green:0 blue:0 alpha:1].CGColor;
                             
                             UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Usuario" message:@"Ya existe este usuario"
                                                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                             [alertsuccess show];
                             
                             
                             
                         }
                         if([trimmedString isEqualToString:@"3"]){
                             correoText.layer.borderWidth=2;
                             correoText.layer.borderColor= [UIColor colorWithRed:1 green:0 blue:0 alpha:1].CGColor;
                             
                             NSLog(@"Correo Existe");
                             
                             UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Ya esta siendo usado este email"
                                                                                   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                             [alertsuccess show];
                             
                             
                             
                         }
                         
                         
                     });}];
                
                
                
            }
            
        }
        if (registrar==NO) {
            if (registrando==YES) {
                registrando=NO;
            }
            // CUIDADO CON EL USUARIO EN BLANCO DEJA PASAR
            if ([usuarioText.text isEqualToString:@""] || [usuarioText.text isEqualToString:@" "] ) {
                NSLog(@"Blanco");
                UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Usuario en Blanco"
                                                                      delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [alertsuccess show];
                
                
            }
            if ([contrasenaText.text isEqualToString:@""] || [contrasenaText.text isEqualToString:@" "] ) {
                NSLog(@"Blanco");
                UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Contraseña en Blanco"
                                                                      delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                [alertsuccess show];
                
                
            }
            else{
                
                // Show an activity spinner that blocks the whole screen
                
                hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
                hud.labelText = NSLocalizedString(@"Connecting", @"");
                
                //NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",userText.text, ContraText.text];
                
                NSString *hostStr = @"http://lanchosoftware.es/loencontre/login.php";
                // hostStr = [hostStr stringByAppendingString:post];
                
                NSLog(@"%@",hostStr);
                
                
                
                NSString *_key = @"alvarol2611995";
                
                NSDate *myDate = [NSDate date];
                NSDateFormatter *df = [NSDateFormatter new];
                [df setDateFormat:@"dd"];
                
                _key= [_key stringByAppendingString:[df stringFromDate:myDate]];
                NSLog(@" %@ key",_key);
                StringEncryption *crypto = [[StringEncryption alloc] init] ;
                
                
                NSString *tokenPush = [[NSUserDefaults standardUserDefaults] stringForKey:@"PushToken"];
                if ([tokenPush isEqualToString:@""]) {
                    sleep(2);
                    tokenPush = [[NSUserDefaults standardUserDefaults] stringForKey:@"PushToken"];
                }
                
                NSData *_secretData = [usuarioText.text dataUsingEncoding:NSUTF8StringEncoding];
                NSData *_secretDataCon = [contrasenaText.text dataUsingEncoding:NSUTF8StringEncoding];
                
                CCOptions padding = kCCOptionPKCS7Padding;
                NSData *encryptedData = [crypto encrypt:_secretData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
                NSData *encryptedDataCon = [crypto encrypt:_secretDataCon key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
                NSLog(@"encrypted data in hex: %@", encryptedData);
                
                /*NSData *decryptedData = [crypto decrypt:encryptedData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
                 
                 NSLog(@"decrypted data in dex: %@", decryptedData);
                 NSString *str = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
                 
                 NSLog(@"decrypted data string for export: %@",str);
                 */
                NSString * encodedStringUsu = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                                    NULL,
                                                                                                                    (CFStringRef)[encryptedData base64EncodingWithLineLength:0],
                                                                                                                    NULL,
                                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                                    kCFStringEncodingUTF8 ));
                NSString * encodedStringCon = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                                    NULL,
                                                                                                                    (CFStringRef)[encryptedDataCon base64EncodingWithLineLength:0],
                                                                                                                    NULL,
                                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                                    kCFStringEncodingUTF8 ));
                
              //  NSLog(@"encrypted data string for export: %@",[encryptedDataCon base64EncodingWithLineLength:0]);
                NSString * usuario = [NSString stringWithFormat:@"?username=%@",encodedStringUsu];
                NSString * contrasena = [NSString stringWithFormat:@"&password=%@",encodedStringCon ];
                NSString * date = [NSString stringWithFormat:@"&date=%@",[df stringFromDate:myDate]];
                NSString * pushToken = [NSString stringWithFormat:@"&Ptoken=%@",tokenPush];
                NSLog(@"Usuario: %@",usuario);
                NSLog(@"Contrasena: %@",contrasena);
                
                hostStr= [hostStr stringByAppendingString:usuario];
                hostStr=[hostStr stringByAppendingString:contrasena];
                hostStr=[hostStr stringByAppendingString:date];
                hostStr=[hostStr stringByAppendingString:pushToken];
                
                NSLog(@"URL: %@",hostStr);
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                [request setURL:[NSURL URLWithString:hostStr]];
                
                NSOperationQueue *cola = [NSOperationQueue new];
                // now lets make the connection to the web
                
                [NSURLConnection sendAsynchronousRequest:request queue:cola completionHandler:^(NSURLResponse *response, NSData *datas, NSError *error)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         
                         serverOutput = [[NSString alloc] initWithData:datas encoding: NSASCIIStringEncoding];
                         NSString *trimmedString = [serverOutput stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                         NSLog(@"%@ String",serverOutput);
                         
                         if([trimmedString isEqualToString:@"0"]){
                             
                             [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Longueado"];
                             
                             usuarioText.layer.borderWidth=2;
                             usuarioText.layer.borderColor= [UIColor colorWithRed:1 green:0 blue:0 alpha:1].CGColor;
                             
                             contrasenaText.layer.borderWidth=2;
                             contrasenaText.layer.borderColor= [UIColor colorWithRed:1 green:0 blue:0 alpha:1].CGColor;
                             [MBProgressHUD hideHUDForView:self.view animated:YES];
                             UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Invalid Access"
                                                                                   delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
                             [alertsuccess show];
                             
                             
                         }
                         else {
                             
                             SBJsonParser *parser = [[SBJsonParser alloc] init];
                             CCOptions padding = kCCOptionECBMode;
                             NSString *_key = @"alvarol2611995";
                             
                             NSDate *myDate = [NSDate date];
                             NSDateFormatter *df = [NSDateFormatter new];
                             [df setDateFormat:@"dd"];
                             
                             _key= [_key stringByAppendingString:[df stringFromDate:myDate]];
                             NSData *_secretData = [NSData dataWithBase64EncodedString:serverOutput];
                             
                             NSData *encryptedData = [crypto decrypt:_secretData  key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
                             NSString* newStr = [[NSString alloc]initWithData:encryptedData encoding:NSASCIIStringEncoding];
                             const char *convert = [newStr UTF8String];
                             NSString *responseString = [NSString stringWithUTF8String:convert];
                             
                             NSError *error =nil;
                             NSArray *returned = [parser objectWithString:responseString error:&error];
                            // NSLog(@"%@",error);
                             
                             
                             
                            // NSLog(@"%@ Data",encryptedData );
                            // NSLog(@"%@ Array",newStr );
                             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                             
                             for (NSDictionary *dict in returned){
                                 
                                 [defaults setObject:[dict objectForKey:@"id_Usuario"] forKey:@"ID_usuario"];
                                 
                                 [defaults setObject:usuarioText.text forKey:@"usuario"];
                                 [defaults setObject:[dict objectForKey:@"token"] forKey:@"token"];
                                 [defaults setBool:YES forKey:@"Longeado"];
                                 [defaults synchronize];
                                 
                                 
                                 
                             }
                             
                             
                             [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Longueado"];
                             [[NSNotificationCenter defaultCenter] postNotificationName:@"Longueado"
                                                                                 object:nil
                                                                               userInfo:nil];
                             
                             [self cancelar:nil];
                             /*  UIViewController* secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Principal"];
                              [self presentViewController:secondViewController animated:YES completion:nil];
                              [self.view removeFromSuperview];
                              */
                           //  [self Cambiar];
                             
                         }
                         
                     });
                 }];
                
                
                
            }
            NSLog(@"%@",serverOutput);
        }
    });
}

-(void)Comprobar{
    NSLog(@"Comprobar");
    if([serverOutput isEqualToString:@"Yes"]){
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        usuarioText.layer.borderWidth=2;
        usuarioText.layer.borderColor= [UIColor colorWithRed:0 green:1 blue:0 alpha:1].CGColor;
        
        contrasenaText.layer.borderWidth=2;
        contrasenaText.layer.borderColor= [UIColor colorWithRed:0 green:1 blue:0 alpha:1].CGColor;
        NSLog(@"Longeado");
      //  [self Cambiar];
    }
    if([serverOutput isEqualToString:@"No"]){
        usuarioText.layer.borderWidth=2;
        usuarioText.layer.borderColor= [UIColor colorWithRed:1 green:0 blue:0 alpha:1].CGColor;
        
        contrasenaText.layer.borderWidth=2;
        contrasenaText.layer.borderColor= [UIColor colorWithRed:1 green:0 blue:0 alpha:1].CGColor;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Invalid Access"
                                                              delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alertsuccess show];
        
        
    }}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [usuarioText resignFirstResponder];
        [contrasenaText resignFirstResponder];
        [correoText setDelegate:self];
    }
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"TEXT");
    textField.layer.borderWidth=2;
    textField.layer.borderColor= [UIColor colorWithRed:0.5 green:0 blue:0 alpha:1].CGColor;
    [self setCampoActivo:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField

{
    usuarioText.layer.borderWidth=0;
    
    
    contrasenaText.layer.borderWidth=0;
    
    
    correoText.layer.borderWidth=0;
    
    
    
    [self setCampoActivo:nil];
}


- (void) apareceElTeclado:(NSNotification *)laNotificacion
{
    NSLog(@"Aparece");
    NSDictionary *infoNotificacion = [laNotificacion userInfo];
    CGSize tamanioTeclado = [[infoNotificacion objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, tamanioTeclado.height+30, 0);
    [scrollView setContentInset:edgeInsets];
    [scrollView setScrollIndicatorInsets:edgeInsets];
    
    [scrollView scrollRectToVisible:[self campoActivo].frame animated:YES];
}

- (void) desapareceElTeclado:(NSNotification *)laNotificacion
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.15];
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    [scrollView setContentInset:edgeInsets];
    [scrollView setScrollIndicatorInsets:edgeInsets];
    [UIView commitAnimations];
}

#pragma mark - Métodos de acción adicionales
- (void) scrollViewPulsado
{
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
