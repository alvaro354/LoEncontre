//
//  EnviarOferta.h
//  LoEncontre
//
//  Created by Alvaro Lancho on 24/11/13.
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
#import <CoreLocation/CoreLocation.h>
#import "Descargar.h"

@interface EnviarOferta : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UIAlertViewDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate, UIPickerViewDataSource>{
    UIImagePickerController *imagePicker;
    NSString*  grupo;
    NSString*  fechaFin;
    
    UIImage* imagenOferta;
    NSArray * arrayGrupos;
     MBProgressHUD* hud;
    IBOutlet UIPickerView * pickerG;
    IBOutlet UIDatePicker * pickerD;
    UIToolbar* toolBar;
    BOOL fecha;
    
    CLLocationManager * locationManager;
}
@property (weak, nonatomic) IBOutlet UILabel *labelFechaFin;

@property (weak, nonatomic) IBOutlet UIButton *BotonEnviar;
@property (retain, nonatomic) IBOutlet UIImageView *imagen;
@property (weak, nonatomic) IBOutlet UITextField *campoNombre;
@property (weak, nonatomic) IBOutlet UITextField *campoDatos;
@property (weak, nonatomic) IBOutlet UIButton *botonGrupo;
@property (weak, nonatomic) IBOutlet UILabel *labelGrupo;

@property (weak, nonatomic) IBOutlet UISwitch *SwitchLocalizacion;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *vistaFondo;

@property (strong, nonatomic) UITextField *campoActivo;

-(IBAction)foto:(id)sender;
-(IBAction)cambiarGrupo:(id)sender;
-(IBAction)enviar:(id)sender;
-(IBAction)cancelar:(id)sender;
-(void)terminar:(id)sender;
-(IBAction)cambiarFecha:(id)sender;
-(void)subirFoto:(NSString*)objectID;

@end
