//
//  verOfertas.m
//  LoEncontre
//
//  Created by Alvaro Lancho on 22/11/13.
//  Copyright (c) 2013 Lancho Software. All rights reserved.
//

#import "verOfertas.h"


@interface verOfertas ()

@end

@implementation verOfertas

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
   
    self.navigationController.navigationBar.topItem.title=@"Ofertas";

}
- (void)viewDidLoad
{
  [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager startUpdatingLocation];
    
    
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:0.90 green:0.0 blue:0.0 alpha:1];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor colorWithRed:0.9 green:0.0 blue:0.0 alpha:1];
    [refreshControl addTarget:self action:@selector(iniciar) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    
    //[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(Login) userInfo:nil repeats:NO];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self iniciar];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Longueado"]) {
        [self Login];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(iniciar)
                                                     name:@"Longueado"
                                                   object:nil];
    }
    
    
  //   [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(imagenes) userInfo:nil repeats:NO];
    NSLog(@"Cargado");
}

-(void)iniciar{
    
    
    comida =[[NSMutableArray alloc]init];
    tecnologia =[[NSMutableArray alloc]init];
    ropa =[[NSMutableArray alloc]init];
    
  
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(obtenerImagenes:)
                                                 name:@"ImagenesCargadas"
                                               object:nil];
    comida= [[Descargar alloc] descargarDeGrupo:@"Comida"];
    tecnologia= [[Descargar alloc] descargarDeGrupo:@"Tecnologia"];
    ropa= [[Descargar alloc] descargarDeGrupo:@"Ropa"];
    
    dispatch_queue_t myQueue = dispatch_queue_create("My Queue",NULL);
    dispatch_async(myQueue, ^{
       
        
        
        [[Descargar alloc] descargarImagenes:comida grupo:@"Comida"];
        [[Descargar alloc] descargarImagenes:tecnologia grupo:@"Tecnologia"];
        [[Descargar alloc] descargarImagenes:ropa grupo:@"Ropa"];
    });
    
    
    
    [refreshControl endRefreshing];
    [self.tableView reloadData];
    
}
- (void)obtenerImagenes:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    //NSLog(@"Diccionario %@",dict);
    
    if ([[dict objectForKey:@"grupo"] isEqualToString:@"Comida"]) {
        imagenesComida= [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"Imagenes"]];
    }
    if ([[dict objectForKey:@"grupo"] isEqualToString:@"Tecnologia"]) {
        imagenesTecnologia= [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"Imagenes"]];
    }
    if ([[dict objectForKey:@"grupo"] isEqualToString:@"Ropa"]) {
        imagenesRopa= [[NSMutableArray alloc]initWithArray:[dict objectForKey:@"Imagenes"]];
    }
    
    [self.tableView reloadData];
    
}

-(void)Login{
    //  [self performSegueWithIdentifier:@"PrivadoS" sender:self];
    
    UIViewController* secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Login"];
    [secondViewController willMoveToParentViewController:self];
    [self addChildViewController:secondViewController];
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.type = kCATransitionFade;//choose your animation
    [secondViewController.view.layer addAnimation:transition forKey:nil];
    // secondViewController.view.center=self.parentViewController.view.center;
    // [secondViewController.view setFrame:CGRectMake(0, 0, self.parentViewController.view.frame.size.width, self.parentViewController.view.frame.size.height)];
    [self.view addSubview:secondViewController.view];
    
    
    [secondViewController didMoveToParentViewController:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 3;
}
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{

	return 85;
    
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
   
    return 30.0;
}


//PARA CUSTOM VIEW EN LAS SECTIONS
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString * string;
    if (section==0) {
        string= @"Comida";
    }
    if (section==1) {
        string= @"Tecnología";
    }
    if (section==2) {
        string= @"Ropa";
    }
    return string;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numero=0;
    // Return the number of rows in the section.
    if (section==0) {
        numero= [comida count];
    }
    if (section==1) {
       numero= [tecnologia count];
    }
    if (section==2) {
        numero= [ropa count];
    }
    return numero;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLLocation * actualLocation = locationManager.location;
    
    static NSString *CellIdentifier = @"OfertaCell";
    OfertaCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell inicializar];
    Oferta *oferta= [[Oferta alloc]init];
    if (indexPath.section==0) {
        oferta=[comida objectAtIndex:indexPath.row];
        cell.nombre.text=oferta.nombre;
        cell.datos.text=oferta.datos;
        cell.longitude=oferta.longitude;
        cell.latitude=oferta.latitude;
        [cell comprobarDistancia:oferta.longitude latitude:oferta.latitude actual:actualLocation];
        if (imagenesComida !=NULL || [imagenesComida count]>0) {
            cell.imagen.image=[imagenesComida objectAtIndex:indexPath.row];
        }
    }
    if (indexPath.section==1) {
        oferta=[tecnologia objectAtIndex:indexPath.row];
        cell.nombre.text=oferta.nombre;
        cell.datos.text=oferta.datos;
        cell.longitude=oferta.longitude;
        cell.latitude=oferta.latitude;
        [cell comprobarDistancia:oferta.longitude latitude:oferta.latitude actual:actualLocation];
        if (imagenesTecnologia !=NULL || [imagenesTecnologia count]>0) {
            cell.imagen.image=[imagenesTecnologia objectAtIndex:indexPath.row];
            
        }
    }
    if (indexPath.section==2) {
        oferta=[ropa objectAtIndex:indexPath.row];
        cell.nombre.text=oferta.nombre;
        cell.datos.text=oferta.datos;
        cell.longitude=oferta.longitude;
        cell.latitude=oferta.latitude;
        [cell comprobarDistancia:oferta.longitude latitude:oferta.latitude actual:actualLocation];
        if (imagenesRopa !=NULL || [imagenesRopa count]>0) {
            cell.imagen.image=[imagenesRopa objectAtIndex:indexPath.row];
        }
    }
    
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"verOfertaInfo"]) {
        
        
        [segue.destinationViewController setNombreT:cellP.nombre.text ];
        [segue.destinationViewController setDatosT:cellP.datos.text];
        [segue.destinationViewController setLongitude:cellP.longitude];
        [segue.destinationViewController setLatitude:cellP.latitude];
        [segue.destinationViewController setImagenT:cellP.imagen.image];
        
    }
}

 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
     cellP= (OfertaCell*)[tableView cellForRowAtIndexPath:indexPath];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    [self performSegueWithIdentifier:@"verOfertaInfo" sender:self];
    
    //  UIViewController* secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Chat"];
    // [self.navigationController pushViewController:secondViewController animated:YES];
}

@end
