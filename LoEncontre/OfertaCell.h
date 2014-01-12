//
//  OfertaCell.h
//  LoEncontre
//
//  Created by Alvaro Lancho on 25/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>

@interface OfertaCell : UITableViewCell

@property(nonatomic,retain)IBOutlet UILabel *nombre;
@property(nonatomic,retain)IBOutlet UILabel *distancia;
@property(nonatomic,retain)IBOutlet UILabel *datos;
@property (nonatomic)double longitude;
@property (nonatomic)double latitude;
@property(nonatomic,retain)IBOutlet UIImageView *imagen;


-(void)inicializar;
-(void)comprobarDistancia:(double)longitude latitude:(double)latitude actual:(CLLocation*)actual;

@end
