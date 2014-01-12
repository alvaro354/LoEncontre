//
//  OfertaInfoViewController.m
//  LoEncontre
//
//  Created by Alvaro Lancho on 26/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import "OfertaInfoViewController.h"

@interface OfertaInfoViewController ()

@end

@implementation OfertaInfoViewController
@synthesize imagen,imagenT,latitude,longitude,nombre,datos,nombreT,datosT,map,distanciaLabel;

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
    
    
        CLLocationManager* locationManager = [[CLLocationManager alloc] init];
    
    [locationManager startUpdatingLocation];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    imagen.backgroundColor= [UIColor grayColor];
    imagen.clipsToBounds = YES;
    // imagen.layer.cornerRadius = imagen.bounds.size.width / 2;
    imagen.layer.cornerRadius = 5.0;
    imagen.layer.borderWidth= 1.0f;
    imagen.layer.borderColor= [UIColor redColor].CGColor;
    imagen.image=imagenT;
    nombre.text=nombreT;
    datos.text=datosT;
    
    map.delegate=self;
    map.showsUserLocation = YES;
    map.clipsToBounds = YES;
    // imagen.layer.cornerRadius = imagen.bounds.size.width / 2;
    map.layer.cornerRadius = 5.0;
    map.layer.borderWidth= 1.0f;
    map.layer.borderColor= [UIColor redColor].CGColor;
    
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = latitude;
    location.longitude = longitude;
    region.span = span;
    region.center = location;
    [map setRegion:region animated:YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:location];
    [annotation setTitle:nombreT ];
    [map addAnnotation:annotation];
    
    
    CLLocation* localizacion = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    CLLocation *actual = locationManager.location;
    
    CLLocationDistance distance = [actual distanceFromLocation:localizacion];
    if (distance >1000) {
        
        distanciaLabel.text=[NSString stringWithFormat:@"%.1f Km",distance/1000];
        
    }else{
        distanciaLabel.text=[NSString stringWithFormat:@"%.0f m",distance];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
