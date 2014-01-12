//
//  Oferta.m
//  LoEncontre
//
//  Created by Alvaro Lancho on 25/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import "Oferta.h"

@implementation Oferta
@synthesize  nombre,datos,grupo,fechaFin,latitude,longitude,usuario,imagenURL,ID;

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:ID forKey:@"ID"];
    [encoder encodeObject:nombre forKey:@"nombre"];
    [encoder encodeObject:datos forKey:@"datos"];
    [encoder encodeObject:grupo forKey:@"grupo"];
    [encoder encodeObject:fechaFin forKey:@"fechaFin"];
    [encoder encodeDouble:latitude forKey:@"latitude"];
    [encoder encodeDouble:longitude forKey:@"longitude"];
    [encoder encodeObject:usuario forKey:@"usuario"];
    [encoder encodeObject:imagenURL forKey:@"imagenURL"];
  
}

-(id)initWithCoder:(NSCoder *)decoder
{
    ID = [decoder decodeObjectForKey:@"ID"];
    nombre = [decoder decodeObjectForKey:@"nombre"];
    datos = [decoder decodeObjectForKey:@"datos"];
    grupo = [decoder decodeObjectForKey:@"grupo"];
    fechaFin = [decoder decodeObjectForKey:@"fechaFin"];
    latitude = [decoder decodeDoubleForKey:@"latitude"];
   longitude = [decoder decodeDoubleForKey:@"longitude"];
    usuario=[decoder decodeObjectForKey:@"usuario"];
    imagenURL= [decoder decodeObjectForKey:@"imagenURL"];
    
    return self;
}


@end
