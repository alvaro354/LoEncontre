//
//  Oferta.h
//  LoEncontre
//
//  Created by Alvaro Lancho on 25/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Oferta : NSObject



@property(nonatomic,retain) NSString * nombre;

@property(nonatomic,retain) NSString * ID;
@property(nonatomic,retain) NSString * datos;
@property(nonatomic,retain) NSString * grupo;
@property(nonatomic,retain) NSString * fechaFin;
@property(nonatomic) double latitude;
@property(nonatomic) double longitude;
@property(nonatomic,retain) NSString* usuario;
@property(nonatomic,retain) NSString* imagenURL;


@end
