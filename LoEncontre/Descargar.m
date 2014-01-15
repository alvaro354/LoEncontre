//
//  Descargar.m
//  LoEncontre
//
//  Created by Alvaro Lancho on 25/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import "Descargar.h"

@implementation Descargar

-(void) descargarImagenes:(NSMutableArray*)array grupo:(NSString*)grupo{
    
    
   imagenesCargadas = [[NSMutableArray alloc]init];
    AFHTTPClient *httpClient  = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    [httpClient.operationQueue setMaxConcurrentOperationCount:1] ;
    NSMutableArray *operationsArray = [NSMutableArray array];
    
  
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd"];
    
    for (Oferta *oferta in array) {
        
        //   NSLog(@"URL: %@", us.URLimagen);
        
        
        NSString *hostStr = @"http://lanchosoftware.es/loencontre/Imagenes/descargarImagenes.php";
        // hostStr = [hostStr stringByAppendingString:post];
        
      
        
        /*NSData *decryptedData = [crypto decrypt:encryptedData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
         
         NSLog(@"decrypted data in dex: %@", decryptedData);
         NSString *str = [[NSString alloc] initWithData:decryptedData encoding:NSUTF8StringEncoding];
         
         NSLog(@"decrypted data string for export: %@",str);
         */
        
        //  NSLog(@"encrypted data string for export: %@",[encryptedDataCon base64EncodingWithLineLength:0]);
        
        NSString * user = [[NSUserDefaults standardUserDefaults]objectForKey:@"usuario"];
        NSString * tokenS = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
        
       
        
        
        
        NSString * usuario = [NSString stringWithFormat:@"?user=%@",user];
        NSString * token = [NSString stringWithFormat:@"&token=%@",tokenS];
        NSString * grupoURL = [NSString stringWithFormat:@"&grupo=%@",oferta.grupo];
        NSString * IDURL = [NSString stringWithFormat:@"&ID=%@",oferta.ID];
        NSString * perfil = [NSString stringWithFormat:@"&perfil=0"];
        NSString * date = [NSString stringWithFormat:@"&date=%@",[df stringFromDate:myDate]];
       
        
        
        
        
        
        hostStr=[hostStr stringByAppendingString:usuario];
        hostStr=[hostStr stringByAppendingString:token];
        hostStr=[hostStr stringByAppendingString:grupoURL];
        hostStr=[hostStr stringByAppendingString:IDURL];
         hostStr=[hostStr stringByAppendingString:perfil];
        hostStr=[hostStr stringByAppendingString:date];
        
        hostStr = [hostStr stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL * URL = [[NSURL alloc]initWithString:hostStr];
        NSLog(@"URL: %@",URL);
        
        AFImageRequestOperation *getImageOperation =
        [AFImageRequestOperation imageRequestOperationWithRequest:[NSURLRequest requestWithURL:URL]
                                             imageProcessingBlock:nil
                                                          success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                                              //
                                                              // Save image
                                                              //
                                                              if(image != nil){
                                                                  [imagenesCargadas addObject:image];
                                                              }
                                                              else{
                                                                  Error=YES;
                                                                  NSLog(@"Image request CACHE error!");
                                                              }
                                                          }
                                                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                              if((error.domain == NSURLErrorDomain) && (error.code == NSURLErrorCancelled))
                                                                  NSLog(@"Image request cancelled!");
                                                              else
                                                                  NSLog(@"Image request error!");
                                                          }];
        
        [operationsArray addObject:getImageOperation];
        
        
        //
        // Lock user interface by pop-up dialog with process indicator and "Cancel download" button
        //
        
        
        
        
    }
    
    [httpClient enqueueBatchOfHTTPRequestOperations:operationsArray
                                      progressBlock:^(NSUInteger numberOfFinishedOperations, NSUInteger totalNumberOfOperations) {
                                          //
                                          // Handle process indicator
                                          //
                                          //   NSLog(@"Imagenes: %@", imagenesCargadas);
                                          //  NSLog(@"Completado");
                                      } completionBlock:^(NSArray *operations) {
                                          //
                                          // Remove blocking dialog, do next tasks
                                          //+
                                          if(Error){
                                              //[self changeSorting];
                                          }
                                          else{
                                              NSLog(@"Imagenes: %lu", (unsigned long)[imagenesCargadas count]);
                                              
                                              NSArray* arrayObjects= [[NSArray alloc]initWithObjects:grupo,imagenesCargadas, nil];
                                              NSArray* arrayClaves= [[NSArray alloc]initWithObjects:@"grupo",@"Imagenes", nil];
                                              
                                              NSDictionary *diccionarioPasarDatos =[[NSDictionary alloc]initWithObjects:arrayObjects forKeys:arrayClaves];
                                              
                                              [[NSNotificationCenter defaultCenter] postNotificationName:@"ImagenesCargadas"
                                                                                object:nil
                                                                              userInfo:diccionarioPasarDatos];
                                          
                                          }
                                          
                                       //     dispatch_group_leave(group);
                                      }];
    
    
    //dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    

}
-(NSMutableArray*)ObtenerArray{
    return imagenesCargadas;
}

-(NSMutableArray*) descargarDeGrupo:(NSString*)grupo{
    NSMutableArray * arrayFinal = [[NSMutableArray alloc]init];
    
    NSString *hostStr = @"http://lanchosoftware.es/loencontre/ofertas.php";
    
    NSString *_key = @"alvarol2611995";
    
    NSDate *myDate = [NSDate date];
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"dd"];
    
    _key= [_key stringByAppendingString:[df stringFromDate:myDate]];
   // NSLog(@" %@ key",_key);
    StringEncryption *crypto = [[StringEncryption alloc] init] ;
    // hostStr = [hostStr stringByAppendingString:post];
    
    NSString * user = [[NSUserDefaults standardUserDefaults]objectForKey:@"usuario"];
    NSString * tokenS = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];

    
    //  NSLog(@"encrypted data string for export: %@",[encryptedDataCon base64EncodingWithLineLength:0]);
    NSString * usuario = [NSString stringWithFormat:@"?username=%@",user];
    NSString * token = [NSString stringWithFormat:@"&token=%@",tokenS ];
    NSString * grupoU = [NSString stringWithFormat:@"&grupo=%@",grupo];
    NSString * date = [NSString stringWithFormat:@"&date=%@",[df stringFromDate:myDate]];
    
    hostStr= [hostStr stringByAppendingString:usuario];
    hostStr=[hostStr stringByAppendingString:token];
    hostStr=[hostStr stringByAppendingString:grupoU];
    hostStr=[hostStr stringByAppendingString:date];
    
    //NSLog(@"URL: %@",hostStr);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:hostStr]];
    
    NSOperationQueue *cola = [NSOperationQueue new];
    // now lets make the connection to the web
   __block NSString * serverOutput;
    
    //Para que espere hasta que termine el bloque 
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    [NSURLConnection sendAsynchronousRequest:request queue:cola completionHandler:^(NSURLResponse *response, NSData *datas, NSError *error)
     {
        
             
             serverOutput = [[NSString alloc] initWithData:datas encoding: NSASCIIStringEncoding];
             NSString *trimmedString = [serverOutput stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
         
             
             if([trimmedString isEqualToString:@"0"]){
                
                 
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
              //    NSLog(@"%@ Array",responseString );
                 
                 
                 for (NSDictionary *dict in returned){
                     Oferta * oferta= [[Oferta alloc]init];
                     
                     oferta.nombre=[dict objectForKey:@"Nombre"];
                     oferta.datos=[dict objectForKey:@"Datos"];
                     oferta.grupo=[dict objectForKey:@"Grupo"];
                     oferta.fechaFin=[dict objectForKey:@"FechaFin"];
                     oferta.latitude=[[dict objectForKey:@"Latitude"] doubleValue];
                      oferta.longitude=[[dict objectForKey:@"Longitude"] doubleValue];
                     oferta.usuario=[dict objectForKey:@"Usuario"];
                     
                   //  NSString * datosS = [dict objectForKey:@"_id"];
                     
                    // datosS=[datosS stringByReplacingOccurrencesOfString:@"{\"_id\":" withString:@""];
                  //    datosS=[datosS stringByReplacingOccurrencesOfString:@"}" withString:@""];
 
                     NSDictionary* dict2=[dict objectForKey:@"_id"];
                     oferta.ID= [dict2 objectForKey:@"$id"];
                    // NSArray *returned2 = [parser objectWithString:oferta.ID error:&error];
                     /*
                     [defaults setObject:[dict objectForKey:@"id_Usuario"] forKey:@"ID_usuario"];
                     
                     //[defaults setObject:usuarioText.text forKey:@"usuario"];
                     [defaults setObject:[dict objectForKey:@"token"] forKey:@"token"];
                     [defaults setBool:YES forKey:@"Longeado"];
                     [defaults synchronize];
                     */
                     
                     [arrayFinal addObject:oferta];
                 }
             //    NSLog(@"Final");
               
                 /*  UIViewController* secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Principal"];
                  [self presentViewController:secondViewController animated:YES completion:nil];
                  [self.view removeFromSuperview];
                  */
                 //  [self Cambiar];
                 
             }
         
         
         
         //Avisas que ya ha acabado
         dispatch_group_leave(group);
   
     }];
    //Espera hasta que acabe
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    [self guardarDatos:arrayFinal grupo:grupo];
    return arrayFinal;
    
}

-(void) guardarDatos:(NSMutableArray*)arrayP grupo:(NSString*)grupoP{
    
    //Prueba Git
    
    NSData *datos = [NSKeyedArchiver archivedDataWithRootObject:arrayP];
    [[NSUserDefaults standardUserDefaults] setObject:datos forKey:grupoP];
    
}

@end
