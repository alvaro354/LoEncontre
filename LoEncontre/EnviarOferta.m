//
//  EnviarOferta.m
//  LoEncontre
//
//  Created by Alvaro Lancho on 24/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import "EnviarOferta.h"

@interface EnviarOferta ()

@end

@implementation EnviarOferta
@synthesize BotonEnviar,imagen,campoDatos,campoNombre,botonGrupo,labelGrupo,SwitchLocalizacion,labelFechaFin,campoActivo, scrollView,vistaFondo;

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
    self.view.tintColor= [UIColor colorWithRed:0.90 green:0.0 blue:0.0 alpha:1];
    
    vistaFondo.layer.borderWidth=1.0f;
    vistaFondo.layer.borderColor=[UIColor colorWithRed:0.90 green:0.0 blue:0.0 alpha:1].CGColor;
    vistaFondo.clipsToBounds=YES;
    vistaFondo.layer.cornerRadius = 5.0;
    
    
    

    [SwitchLocalizacion setOnTintColor:[UIColor colorWithRed:0.90 green:0.0 blue:0.0 alpha:1]];
    imagen.layer.borderWidth=1.0f;
    imagen.layer.borderColor=[UIColor colorWithRed:0.90 green:0.0 blue:0.0 alpha:1].CGColor;
    imagen.clipsToBounds=YES;
    imagen.layer.cornerRadius = 5.0;
    
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
    
    
    [campoDatos setDelegate:self];
    [campoNombre setDelegate:self];
    
    arrayGrupos=[[NSArray alloc]initWithObjects:@"Comida",@"Tecnología",@"Ropa", nil];
    

    //Iniciamos la localizacion (Luego el usuario aceptara si enviarla o no)
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    grupo=@"Comida";
    
    
    
    
	// Do any additional setup after loading the view.
}



-(IBAction)cambiarFecha:(id)sender{
    fecha=YES;
    vistaFondo.alpha=0;
    pickerD =[[UIDatePicker alloc]init];
    pickerD.backgroundColor= [UIColor grayColor];
    pickerD.frame=CGRectMake(0,180, 320, 200);
    pickerD.datePickerMode= UIDatePickerModeDate;
    [self.view addSubview:pickerD];
    
    
    
    toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,160,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"  style:UIBarButtonItemStyleBordered target:self action:@selector(terminar:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    barButtonDone.tintColor=[UIColor redColor];
    [self.view addSubview:toolBar];
    
    
}


-(IBAction)cambiarGrupo:(id)sender{
    fecha=NO;
    
     vistaFondo.alpha=0;
     pickerG =[[UIPickerView alloc]init];
    pickerG.backgroundColor= [UIColor grayColor];
    pickerG.frame=CGRectMake(0,180, 320, 200);
    pickerG.delegate=self;
    [self.view addSubview:pickerG];
    
    
    
   toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,160,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"  style:UIBarButtonItemStyleBordered target:self action:@selector(terminar:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    barButtonDone.tintColor=[UIColor redColor];
    [self.view addSubview:toolBar];
    
}
-(void)terminar:(id)sender{
    if(fecha){
        NSDate * seleccionado = [pickerD date];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
      
        fechaFin = [dateFormatter stringFromDate:seleccionado];
        labelFechaFin.text=fechaFin;
        
        [toolBar removeFromSuperview];
        NSLog(@"Terminado: %@",fechaFin);
        [pickerD removeFromSuperview];
        vistaFondo.alpha=1;
    }
    else{
    [toolBar removeFromSuperview];
    NSLog(@"Terminado");
    [pickerG removeFromSuperview];
    vistaFondo.alpha=1;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    return [arrayGrupos count];
    
}

-(IBAction)foto:(id)sender{
   
    imagePicker= [[UIImagePickerController alloc]init];
    imagePicker.delegate=self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing=YES;
   [self presentViewController:imagePicker animated:YES completion:nil];
 
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [picker dismissViewControllerAnimated:YES completion:nil];
    imagenOferta=[[UIImage alloc]initWithCGImage:image.CGImage];
    imagen.image= imagenOferta;
    [imagen reloadInputViews];
    //[self.vistaFondo addSubview:imagen];
    [vistaFondo reloadInputViews];
    [self reloadInputViews];
    
    
}
-(IBAction)cancelar:(id)sender{
    
    CABasicAnimation *animY = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animY.duration = 0.6;
    animY.repeatCount = 0;
    animY.delegate=self;
    animY.removedOnCompletion = NO;
    animY.fillMode = kCAFillModeForwards;
    animY.toValue=[NSNumber numberWithFloat:550];
    [vistaFondo.layer addAnimation:animY forKey:nil];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    vistaFondo.alpha=0;
    
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [campoNombre resignFirstResponder];
        [campoDatos resignFirstResponder];
   ;
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
    campoNombre.layer.borderWidth=0;
    
    
    campoDatos.layer.borderWidth=0;
    

    
    
    
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row   inComponent:(NSInteger)component{
    
    NSLog(@"Selected Row %d", row);
    switch(row)
    {
            
        case 0:
            grupo = @"Comida";
            labelGrupo.text=grupo;
            break;
        case 1:
            grupo = @"Tecnologia";
            labelGrupo.text=grupo;
            break;
            
        case 2:
            grupo = @"Ropa";
            labelGrupo.text=grupo;
            break;
     
    }
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [arrayGrupos objectAtIndex:row];
    
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
-(IBAction)enviar:(id)sender{
    if ([campoNombre.text isEqualToString:@""] || [campoNombre.text isEqualToString:@" "] ) {
        NSLog(@"Blanco");
        UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Nombre en Blanco"
                                                              delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alertsuccess show];
        
        
    }
    else{
        
        // Show an activity spinner that blocks the whole screen
        
      
        
        //NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",userText.text, ContraText.text];
        
        NSString *hostStr = @"http://lanchosoftware.es/loencontre/enviarOferta.php";
        // hostStr = [hostStr stringByAppendingString:post];
        
        NSLog(@"%@",hostStr);
        
        
        
        NSDate *myDate = [NSDate date];
        NSDateFormatter *df = [NSDateFormatter new];
        [df setDateFormat:@"dd-MM-yyyy"];
        
        
        
        NSString *tokenPush = [[NSUserDefaults standardUserDefaults] stringForKey:@"PushToken"];
        if ([tokenPush isEqualToString:@""]) {
            sleep(2);
            tokenPush = [[NSUserDefaults standardUserDefaults] stringForKey:@"PushToken"];
        }

        
        /*NSData *decryptedData = [crypto decrypt:encryptedData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
         
         NSLog(@"decrypted data in dex: %@", decryptedData);
         NSString *str = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
         
         NSLog(@"decrypted data string for export: %@",str);
         */
 
        //  NSLog(@"encrypted data string for export: %@",[encryptedDataCon base64EncodingWithLineLength:0]);
        NSString * userID = [[NSUserDefaults standardUserDefaults]objectForKey:@"ID_usuario"];
        NSString * user = [[NSUserDefaults standardUserDefaults]objectForKey:@"usuario"];
         NSString * tokenS = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
        
        NSString * datosS = campoDatos.text;
        datosS=[datosS stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSString * nombreS = campoNombre.text;
        nombreS =[nombreS stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        double longitudeURL;
        double latitudeURL;
        
        
        if(SwitchLocalizacion.on){
            longitudeURL=locationManager.location.coordinate.longitude;
            latitudeURL=locationManager.location.coordinate.latitude;
        }
        else{
            longitudeURL=0;
            latitudeURL=0;
        }
        
        
        NSString * usuarioID = [NSString stringWithFormat:@"?userID=%@",userID];
        NSString * usuario = [NSString stringWithFormat:@"&user=%@",user];
        NSString * token = [NSString stringWithFormat:@"&token=%@",tokenS];
        NSString * grupoURL = [NSString stringWithFormat:@"&grupo=%@",grupo];
         NSString * nombreURL = [NSString stringWithFormat:@"&nombre=%@",nombreS];
        NSString * datos = [NSString stringWithFormat:@"&datos=%@",datosS];
        NSString * longitude = [NSString stringWithFormat:@"&longitude=%f",longitudeURL];
        NSString * latitude = [NSString stringWithFormat:@"&latitude=%f",latitudeURL];
        NSString * fechaURL = [NSString stringWithFormat:@"&fecha=%@", [df stringFromDate:myDate]];
         NSString * fechaFinURL = [NSString stringWithFormat:@"&fechaFin=%@", fechaFin];
        
     
        [locationManager stopUpdatingLocation];
        
        hostStr= [hostStr stringByAppendingString:usuarioID];
        hostStr=[hostStr stringByAppendingString:usuario];
        hostStr=[hostStr stringByAppendingString:token];
        hostStr=[hostStr stringByAppendingString:grupoURL];
        hostStr=[hostStr stringByAppendingString:nombreURL];
        hostStr=[hostStr stringByAppendingString:datos];
        hostStr=[hostStr stringByAppendingString:longitude];
        hostStr=[hostStr stringByAppendingString:latitude];
        hostStr=[hostStr stringByAppendingString:fechaURL];
        hostStr=[hostStr stringByAppendingString:fechaFinURL];
       hostStr = [hostStr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSLog(@"URL: %@",hostStr);
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:hostStr]];
        
        NSOperationQueue *cola = [NSOperationQueue new];
        // now lets make the connection to the web
        
        [NSURLConnection sendAsynchronousRequest:request queue:cola completionHandler:^(NSURLResponse *response, NSData *datas, NSError *error)
         {
             
                NSString *  serverOutput = [[NSString alloc] initWithData:datas encoding: NSASCIIStringEncoding];

                 NSLog(@" %@ ObjectID",serverOutput);
             if (serverOutput!= Nil || [serverOutput isEqualToString:@""]) {
                 
                 [self subirFoto:serverOutput];
             }
             
         }];
        
        
        
    }
}
-(void)subirFoto:(NSString*)objectID{
    
    NSLog(@"Enviando");
    NSString *_key = @"alvarol2611995";
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    NSDateFormatter *dma = [NSDateFormatter new];
    NSDateFormatter *hms = [NSDateFormatter new];
    [df setDateFormat:@"dd"];
    [dma setDateFormat:@"dd-MM-yyyy"];
    [hms setDateFormat:@"hh:mm:ss"];
    
    
    
    
    _key= [_key stringByAppendingString:[df stringFromDate:myDate]];
    NSLog(@" %@ date",[hms stringFromDate:myDate]);
    StringEncryption *crypto = [[StringEncryption alloc] init] ;
    
    NSString * usuario= [[NSUserDefaults standardUserDefaults] objectForKey:@"usuario"];
    NSString * token= [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    NSData *imageData = UIImageJPEGRepresentation(imagenOferta, 0.5);
    
    
	CCOptions padding = kCCOptionECBMode;
	NSData *encryptedData = [crypto encrypt:imageData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
    
   
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    hud.labelText = NSLocalizedString(@"Cargando", @"");
    
	
	/*NSData *decryptedData = [crypto decrypt:encryptedData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
     
     NSLog(@"decrypted data in dex: %@", decryptedData);
     NSString *str = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
     
     NSLog(@"decrypted data string for export: %@",str);
     */
    
    
    
    NSData* imagenD=[[encryptedData base64EncodingWithLineLength:0] dataUsingEncoding:[NSString defaultCStringEncoding] ] ;
    
    
    NSString *userName =[NSString stringWithFormat:@"user=%@",usuario];
    NSString *tokenURL=[NSString stringWithFormat:@"&token=%@",token];
      NSString *grupoURL=[NSString stringWithFormat:@"&grupo=%@",grupo];
    NSString *ID=[NSString stringWithFormat:@"&obID=%@",objectID];
    NSString *date=[NSString stringWithFormat:@"&date=%@",[df stringFromDate:myDate]];
    
    
    NSString *urlString= @"http://lanchosoftware.es/loencontre/Imagenes/imageupload.php?";
    
    urlString = [urlString stringByAppendingString:userName];
    urlString = [urlString stringByAppendingString:tokenURL];
        urlString = [urlString stringByAppendingString:grupoURL];
     urlString = [urlString stringByAppendingString:ID];
urlString = [urlString stringByAppendingString:date];
     NSLog(@"URL: %@",urlString);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"imagename.jpg\"\r\n",index] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imagenD]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    NSString *postLength = [NSString stringWithFormat:@"%d", [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    NSOperationQueue *cola = [NSOperationQueue new];
    // now lets make the connection to the web
    
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:cola completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [MBProgressHUD hideHUDForView:self.view animated:YES];
             NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"%@ Respuesta",returnString);
             if ( [returnString isEqualToString:@"Yes"]) {
                 UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"OK" message:@"Foto Subida"
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alertsuccess show];
             }
             else{
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 UIAlertView *alertsuccess = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error"
                                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
                 [alertsuccess show];
             }
             
   
             
         }); }];
   
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
