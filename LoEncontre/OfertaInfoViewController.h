//
//  OfertaInfoViewController.h
//  LoEncontre
//
//  Created by Alvaro Lancho on 26/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface OfertaInfoViewController : UIViewController <MKMapViewDelegate>



@property (strong, nonatomic) IBOutlet UILabel *nombre;
@property(nonatomic,retain)IBOutlet UIImageView * imagen;
@property (strong, nonatomic) IBOutlet MKMapView *map;

//@property(nonatomic,retain)IBOutlet MKMapView* map;
@property (nonatomic)double longitude;
@property (nonatomic)double latitude;
@property (nonatomic)NSString* nombreT;
@property (nonatomic)NSString* datosT;
@property (nonatomic)UIImage* imagenT;
@property (strong, nonatomic) IBOutlet UILabel *distanciaLabel;

@property (strong, nonatomic) IBOutlet UILabel *datos;

@end
