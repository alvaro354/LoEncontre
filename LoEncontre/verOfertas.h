//
//  verOfertas.h
//  LoEncontre
//
//  Created by Alvaro Lancho on 22/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Descargar.h"
#import "OfertaInfoViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "OfertaCell.h"

@interface verOfertas : UITableViewController{
    
    
    UIRefreshControl *refreshControl ;
    
    NSMutableArray * comida;
    NSMutableArray * tecnologia;
    NSMutableArray * ropa;
    
     NSMutableArray* imagenesComida;
     NSMutableArray* imagenesTecnologia;
     NSMutableArray* imagenesRopa;
    OfertaCell*cellP;
    CLLocationManager* locationManager ;
    
    
}

@end
