//
//  OfertaCell.m
//  LoEncontre
//
//  Created by Alvaro Lancho on 25/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import "OfertaCell.h"

@interface OfertaCell ()

@end


@implementation OfertaCell
@synthesize imagen,nombre,datos,distancia;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      
        
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        
        
    }
    return self;
}

-(void)inicializar{

    // imagen.image= [UIImage imageNamed:@"Icono@2X.png"];
    imagen.backgroundColor= [UIColor grayColor];
    imagen.clipsToBounds = YES;
   // imagen.layer.cornerRadius = imagen.bounds.size.width / 2;
     imagen.layer.cornerRadius = 5.0;
    imagen.layer.borderWidth= 1.0f;
    imagen.layer.borderColor= [UIColor redColor].CGColor;

   
}

-(void)comprobarDistancia:(double)longitude latitude:(double)latitude  actual:(CLLocation*)actual{
    
    CLLocation* localizacion = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
     CLLocationDistance distance = [actual distanceFromLocation:localizacion];
    if (distance >1000) {
      
    distancia.text=[NSString stringWithFormat:@"%.1f Km",distance/1000];
        
    }else{
        distancia.text=[NSString stringWithFormat:@"%.0f m",distance];
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
