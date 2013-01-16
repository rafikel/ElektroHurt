//
//  EHViewController.m
//  ElektroHurt
//
//  Created by Rafał Maślanka on 13.12.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "EHAppDelegate.h"
#import "EHViewController.h"
#import "TFHpple.h"

@implementation EHViewController
@synthesize items, table, button, switcher, search, searchAnuler, toggleButton, doublePicker;

#pragma mark - Operation
- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@", documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:@"products.plist"];
}

- (BOOL)loadFile {
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        self.items = array;
		return YES;
    } 
    else {

        NSArray *paths = [[NSArray alloc] initWithObjects:
                          @"http://elektro-hurt.bazarek.pl/opis/808275/yky-3x15-kabel-ziemny-1kv.html",
                          @"http://elektro-hurt.bazarek.pl/opis/808272/yky-3x25-kabel-ziemny-1kv.html",
                          @"http://elektro-hurt.bazarek.pl/opis/808270/yky-5x4-kabel-ziemny-1kv.html",
                          @"http://elektro-hurt.bazarek.pl/opis/808269/yky-5x6-kabel-ziemny-1kv.html",
                          @"http://elektro-hurt.bazarek.pl/opis/808266/yky-5x10-kabel-ziemny-1kv.html",
                          @"http://elektro-hurt.bazarek.pl/opis/814976/kabel-telekomunikacyjny-xztkmxpw-5x2x05.html",
                          @"http://elektro-hurt.bazarek.pl/opis/815031/lgy-10mm2-zolto-zielony.html",
                          @"http://elektro-hurt.bazarek.pl/opis/815021/ytdy-6x05-przewod-domofonowyalarmowy.html",
                          @"http://elektro-hurt.bazarek.pl/opis/815018/ytdy-10x05-przewod-domofonowyalarmowy.html",
                          @"http://elektro-hurt.bazarek.pl/opis/815010/ydy-5x6-750v-przewod.html",
                          @"http://elektro-hurt.bazarek.pl/opis/815008/ydy-5x4-750v-przewod.html",
                          @"http://elektro-hurt.bazarek.pl/opis/815007/ydy-5x25-750v-przewod.html",
                          @"http://elektro-hurt.bazarek.pl/opis/814997/ydyp-4x15-750v-przewod.html",
                          @"http://elektro-hurt.bazarek.pl/opis/723088/ydyp-3x25-750v-przewod.html",
                          @"http://elektro-hurt.bazarek.pl/opis/723084/ydyp-3x15-750v-przewod.html",
                          @"http://elektro-hurt.bazarek.pl/opis/1499794/legrand-ochronnik-przeciwprzepieciowy-ogranicznik-przepiec-klasa-bc-60-ka-603953.html",
                          @"http://elektro-hurt.bazarek.pl/opis/825680/legrand-rozlacznik-izolacyjny-fr304-100a-004374.html",
                          @"http://elektro-hurt.bazarek.pl/opis/825677/legrand-rozlacznik-izolacyjny-fr303-100a-004354.html",
                          @"http://elektro-hurt.bazarek.pl/opis/419666/legrand-wylacznik-roznicowopradowy-p304-40a-30ma-ac-008994.html",
                          @"http://elektro-hurt.bazarek.pl/opis/419588/legrand-wylacznik-roznicowopradowy-p312-b16-30ma-008402.html",
                          @"http://elektro-hurt.bazarek.pl/opis/419310/legrand-wylacznik-nadpradowy-s301-b16-605510.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393812/legrand-wylacznik-nadpradowy-s301-b20-605511.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393286/legrand-wylacznik-nadpradowy-s301-b10-605508.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393287/legrand-wylacznik-nadpradowy-s301-b-6-605506.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393808/legrand-lampka-kontrolna-pomaranczowa-l311-604079.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393816/legrand-wylacznik-nadpradowy-s303-c16-605650.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393814/legrand-wylacznik-nadpradowy-s303-c20-605651.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393813/legrand-wylacznik-nadpradowy-s303-c25-605652.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393809/legrand-szyna-laczeniowa-3-fazowa-krotka-bi316x12-607047.html",
                          @"http://elektro-hurt.bazarek.pl/opis/2270845/legrand-szyna-laczeniowa-3-fazowa-dluga-bi316x54-607048.html",
                          @"http://elektro-hurt.bazarek.pl/opis/813156/kabel-glosnikowy-miedziany-cu-2x25.html",
                          @"http://elektro-hurt.bazarek.pl/opis/813155/kabel-glosnikowy-miedziany-cu-2x15.html",
                          @"http://elektro-hurt.bazarek.pl/opis/2346094/blok-rozdzielczy-mocowany-na-szyne-th35-4x7-zaciskow-e4076.html",
                          @"http://elektro-hurt.bazarek.pl/opis/813179/wago-szybkozlaczka-525-nr-kat273-255.html",
                          @"http://elektro-hurt.bazarek.pl/opis/813177/wago-szybkozlaczka-425-nr-kat273-254.html",
                          @"http://elektro-hurt.bazarek.pl/opis/813175/wago-szybkozlaczka-325-nr-kat273-253.html",
                          @"http://elektro-hurt.bazarek.pl/opis/813169/wago-szybkozlaczka-225-nr-kat273-252.html",
                          @"http://elektro-hurt.bazarek.pl/opis/2258728/ochronnik-ogranicznik-przepiec-przepieciowka-4-pol-klasa-bc-els.html",
                          @"http://elektro-hurt.bazarek.pl/opis/1992389/eaton-moeller-ogranicznik-przepiec-przepieciowka-klasa-bc-spb-122804-285082.html",
                          @"http://elektro-hurt.bazarek.pl/opis/814925/ochronnik-ogranicznik-przepiec-przepieciowka-km30bc1-275-4-pol-klasa-bc-kvr.html",
                          @"http://elektro-hurt.bazarek.pl/opis/860591/szyna-do-wyrownania-potencjalow-duza.html",
                          @"http://elektro-hurt.bazarek.pl/opis/807687/simet-puszka-pt-60-gleboka-do-laczenia-s60df.html",
                          @"http://elektro-hurt.bazarek.pl/opis/807555/simet-pokrywa-sygnalizacyjna-ps-60-pt.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393285/legrand-rozdzielnia-rozdzielnica-pt-rwn-4x12-602434.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393284/legrand-rozdzielnia-rozdzielnica-pt-rwn-3x12-602433.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393810/legrand-rozdzielnia-rozdzielnica-pt-rwn-2x12-602432.html",
                          @"http://elektro-hurt.bazarek.pl/opis/393289/legrand-rozdzielnia-rozdzielnica-pt-rwn-1x12-602431.html", 
                          nil];
        
        items = [[NSMutableArray alloc] init];

        NSInteger i;
        for (i = 0; i<paths.count; i++) {
            NSMutableDictionary *item = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[paths objectAtIndex:i], @"path", nil];
            [items addObject:item];
        }

		return NO;
    }
    
    NSLog(@"%@", items);
    
}

- (BOOL)saveFile {
    [items writeToFile:[self dataFilePath] atomically:YES];
	return YES;
}

- (void)setPrice {

    UIActionSheet *menu = [[UIActionSheet alloc] initWithTitle:@"Ustal cenę"
                                                      delegate:self
                                             cancelButtonTitle:@"Anuluj"
                                        destructiveButtonTitle:@"Zmień"
                                             otherButtonTitles:@"Wyzeruj",nil];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0,240,0,0)];        
    pickerView.delegate = self;
    pickerView.showsSelectionIndicator = YES;
    
    NSDictionary *item = [items objectAtIndex:selectedItem];
    NSString *value;
    
    if (actionSheetType==1)
        value = [item objectForKey:@"compare"];
    else
        value = [item objectForKey:@"my"];
    
	NSArray *parts = [value componentsSeparatedByString:@","];
    zlote = [[parts objectAtIndex:0] intValue];
    grosze = [[parts objectAtIndex:1] intValue];
    
    [pickerView selectRow:zlote inComponent:0 animated:YES];
    [pickerView selectRow:grosze inComponent:1 animated:YES];
    
    [menu addSubview:pickerView];
    [menu showInView:self.view];
    [menu setBounds:CGRectMake(0,0,320,640)];

}

- (void)getItemContent:(NSInteger)row {
    
    NSLog(@"%i", row);
    
    if (conn) return;
    if (dynamicData) dynamicData = nil;

    NSMutableDictionary *item = [items objectAtIndex:row];
    NSURL *url = [[NSURL alloc] initWithString:[item objectForKey:@"path"]];
        NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0];
    
    processingRow = row;
    
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    NSLog(@"...");
    
}

- (BOOL)doSearchFor:(NSInteger)row {
    
    if (!search.text || [search.text isEqualToString:@""]) return YES;
    
    NSDictionary *item = [items objectAtIndex:row];
    NSString *text = [item objectForKey:@"title"];
    
    NSRange textRange;
    textRange =[[text lowercaseString] rangeOfString:[search.text lowercaseString]];
    
    if(textRange.location==NSNotFound)
        return NO;
        
    return YES;
    
}

#pragma mark - Action

- (IBAction)buttonPressed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Czy na pewno?" message:@"Ponowne odczytanie cen może potrwać dłuższą chwilę. Jesteś pewny, że chcesz odświeżyć ceny produktów?" delegate:self cancelButtonTitle:@"Anuluj" otherButtonTitles:@"OK", nil];
    [alert show];
}

- (IBAction)switchPressed:(id)sender {
    [self.table reloadData];
}

- (IBAction)backgroundPressed:(id)sender {
    searchAnuler.hidden = YES;
    [search resignFirstResponder];
}

- (IBAction)toggleEdit:(id)sender {
	[self.table setEditing:!self.table.editing animated:YES];
	if (self.table.editing) {
		[sender setTitle:@"Zapisz"];
	}
	else {
		[sender setTitle:@"Zmień"];
	}
    [self.table reloadData];
}

- (IBAction)addPressed:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    urlToAdd = pasteboard.string;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Dodać produkt do listy?" message:urlToAdd delegate:self cancelButtonTitle:@"Anuluj" otherButtonTitles:@"OK", nil];
    [alert show];
}

- (IBAction)newPressed:(id)sender {
}


#pragma mark - View

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    searchAnuler.hidden = YES;
    
	if (stackMessages==nil) {
        stackMessages = [[StackMessages alloc] initWithMessageHeight:30.0f];
        stackMessages.heightOffset = self.view.frame.size.height;
        [self.navigationController.view addSubview:stackMessages.view];
        [stackMessages willAnimateRotationToInterfaceOrientation:[[UIApplication sharedApplication] statusBarOrientation] duration:0];
    }
    
    switcher.on = false;

    [self loadFile];

    NSInteger i;
    for (i = 0; i<items.count; i++) {
        NSDictionary *item = [items objectAtIndex:i];
        if (![item objectForKey:@"price"]) {
            [self getItemContent:i];
            return;
        }
    }
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return NO;
    [self.table reloadData];
    
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table

////////////////////////////////////////////////////////////////////
// TABELA
////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [items count];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Zmiana w wierszach
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        [items removeObjectAtIndex:indexPath.row];
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}   
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
	}
    [self saveFile];
}

// Przesuwanie wierszy
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSUInteger fromRow = [fromIndexPath row];
    NSUInteger toRow = [toIndexPath row];
    id object = [items objectAtIndex:fromRow];
    [items removeObjectAtIndex:fromRow];
    [items insertObject:object atIndex:toRow];
    [self saveFile];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	CGFloat width = self.view.frame.size.width;
    NSDictionary *item = [items objectAtIndex:indexPath.row];

    UITableViewCell *cell;
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"aaaa"];
    
    cell = [[UITableViewCell alloc] initWithFrame:CGRectZero];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    if (![self doSearchFor:indexPath.row] && ![table isEditing]) return cell;
    
    if ([tableView isEditing]) width+= 70;

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, width-150, 50)];
    if ([item objectForKey:@"title"])
        title.text = [NSString stringWithString:[item objectForKey:@"title"]];
    else
        title.text = [NSString stringWithString:@""];
    title.font = [UIFont fontWithName:@"Arial" size:13];
    title.backgroundColor = [UIColor clearColor];
    title.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    title.textColor = [UIColor blackColor];
    title.lineBreakMode = UILineBreakModeWordWrap;
    title.numberOfLines = 3;
    [cell.contentView addSubview:title];
    
    if (![tableView isEditing]) {
        
        UILabel *price;
        if (switcher.on)
            price = [[UILabel alloc] initWithFrame:CGRectMake(width-90, 10, 80, 15)];
        else
            price = [[UILabel alloc] initWithFrame:CGRectMake(width-90, 10, 80, 20)];
        price.textAlignment = UITextAlignmentRight;
        if ([item objectForKey:@"price"])
            price.text = [NSString stringWithString:[item objectForKey:@"price"]];
        else {
            price.text = [NSString stringWithString:@""];
            UIActivityIndicatorView *spinnerView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            spinnerView.hidesWhenStopped = YES;
            spinnerView.frame = CGRectMake(width-40, 10, 20, 20);
            [spinnerView startAnimating];
            [cell.contentView addSubview:spinnerView];
        }
        price.font = [UIFont fontWithName:@"Arial" size:14];
        price.backgroundColor = [UIColor clearColor];
        price.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        price.textColor = [UIColor blueColor];
        [cell.contentView addSubview:price];
        
        UILabel *compare;
        if (switcher.on)
            compare = [[UILabel alloc] initWithFrame:CGRectMake(width-90, 25, 80, 15)];
        else
            compare = [[UILabel alloc] initWithFrame:CGRectMake(width-90, 30, 80, 20)];
        compare.textAlignment = UITextAlignmentRight;
        if ([item objectForKey:@"compare"])
            compare.text = [NSString stringWithFormat:@"%@ zł", [item objectForKey:@"compare"]];
        else
            compare.text = [NSString stringWithString:@"--,-- zł"];
        compare.font = [UIFont fontWithName:@"Arial" size:14];
        compare.backgroundColor = [UIColor clearColor];
        compare.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        compare.textColor = [UIColor blackColor];
        [cell.contentView addSubview:compare];

        if (switcher.on) {
            UILabel *my = [[UILabel alloc] initWithFrame:CGRectMake(width-90, 40, 80, 15)];
            my.textAlignment = UITextAlignmentRight;
            if ([item objectForKey:@"my"])
                my.text = [NSString stringWithFormat:@"%@ zł", [item objectForKey:@"my"]];
            else
                my.text = [NSString stringWithString:@"--,-- zł"];
            my.font = [UIFont fontWithName:@"Arial" size:14];
            my.backgroundColor = [UIColor clearColor];
            my.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            my.textColor = [UIColor darkGrayColor];
            [cell.contentView addSubview:my];        
        }
        
    }
    if ([item objectForKey:@"image"]) {
        NSString *itemId = [NSString stringWithFormat:@"%d", indexPath.row];
        AsyncImageView *asyncImage = [itemsThumbnail objectForKey:itemId];
        if (asyncImage==nil) {
            asyncImage = [[AsyncImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
            NSString *path = [[item objectForKey:@"image"] 
                              stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n"]];
            if (![asyncImage loadImageFromTemp:path]) {
                
                [asyncImage loadImage];
            }
        }
        [cell.contentView addSubview:asyncImage];    
        [itemsThumbnail setObject:asyncImage forKey:itemId];
    }
    
    return cell;
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (![self doSearchFor:indexPath.row] && ![table isEditing]) return 0;
	return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [search resignFirstResponder];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedItem = indexPath.row;
    NSDictionary *item = [items objectAtIndex:selectedItem];
    
    actionSheetType = 0;
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:[item objectForKey:@"title"] delegate:self cancelButtonTitle:@"Anuluj" destructiveButtonTitle:@"Zmień cenę" otherButtonTitles:@"Moja własna cena", @"Pobierz aktualną cenę", @"Otwórz stronę produktu", nil];
    [action showInView:self.view];
    return;

}

#pragma mark - Alert
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==1) {
        if (urlToAdd) {
            NSMutableDictionary *item = [[NSMutableDictionary alloc] initWithObjectsAndKeys:urlToAdd, @"path", nil];
            [items insertObject:item atIndex:0];
            [table insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:YES];
            [self getItemContent:0];
            [self saveFile];
        }
        else {
            NSInteger i;
            for (i = 0; i < items.count; i++) {
                NSMutableDictionary *item = [items objectAtIndex:i];
                if ([self doSearchFor:i]) [item removeObjectForKey:@"price"];
            }
            [self.table reloadData];
            [self getItemContent:0];        
        }
    }
    else urlToAdd = nil;
}
- (void)alertViewCancel:(UIAlertView *)alertView {
    urlToAdd = nil;
}

#pragma mark - ActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    NSLog(@"Action: %d, Button: %d.", actionSheetType, buttonIndex);
    
    if (actionSheetType>0) {
        
        NSMutableDictionary *item = [items objectAtIndex:selectedItem];
        NSString *price = [[NSString alloc] initWithFormat:@"%3d,%02d", zlote, grosze];

        if (buttonIndex==0) {
            if (actionSheetType==1)
                [item setObject:price forKey:@"compare"];
            else
                [item setObject:price forKey:@"my"];            
        }

        if (buttonIndex==1) {
            if (actionSheetType==1)
                [item removeObjectForKey:@"compare"];
            else
                [item removeObjectForKey:@"my"];
        }
        
        [self.table reloadData];
        [self saveFile];
        
    }
    else {
        
        NSMutableDictionary *item = [items objectAtIndex:selectedItem];
        if (buttonIndex==3) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [item objectForKey:@"path"]]];
        }
        if (buttonIndex==2) {
            [item removeObjectForKey:@"price"];
            [self getItemContent:selectedItem];
            [table reloadData];
        }
        if (buttonIndex==1) {
            actionSheetType = 2;
            [self setPrice];
        }
        if (buttonIndex==0) {
            actionSheetType = 1;
            [self setPrice];
        }
        
    }

}

#pragma mark - Connection
////////////////////////////////////////////////////////////////////
// DANE
////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    dynamicData = nil;
    conn = nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    NSDictionary *dic = [httpResponse allHeaderFields];
    dataSizeReceived = 0;
	NSString *size = [dic objectForKey:@"Content-Length"];
	if (size!=nil)
		dataSizeAll = [size intValue];
	else dataSizeAll = 40000;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (dynamicData==nil)
		dynamicData = [[NSMutableData alloc] initWithCapacity:1024];
    [dynamicData appendData:data];
    dataSizeReceived+= [dynamicData length];    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    NSMutableDictionary *item = [items objectAtIndex:processingRow];
    
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:dynamicData];
    
    NSArray *elements;
    TFHppleElement *element;
    
    elements = [xpathParser searchWithXPathQuery:@"//h1[1]"];
    if ([elements count]>0) {

        element = [elements objectAtIndex:0];
        NSString *title = [element content];
    
        elements = [xpathParser searchWithXPathQuery:@"//strong[@id='cenaKoncowa']"];
        element = [elements objectAtIndex:0];
        NSString *price = [element content];
        
        elements = [xpathParser searchWithXPathQuery:@"//img[@id='bigfoto']"];
        element = [elements objectAtIndex:0];
        NSString *image = [element objectForKey:@"src"];
        
        [item setObject:title forKey:@"title"];
        [item setObject:price forKey:@"price"];
        [item setObject:image forKey:@"image"];
    
    }
    
    else {
        [item setObject:[item objectForKey:@"path"] forKey:@"title"];
        [item setObject:@"BRAK!" forKey:@"price"];
        [item setObject:@"http://www.komorniki.pl/items/pl/arts/1954/small_photo_64006.jpg" forKey:@"image"];        
    }
        
    dynamicData = nil;
    conn = nil;
    
    [self saveFile];
    [self.table reloadData];

    NSInteger i;
    for (i = 0; i<items.count; i++) {
        NSDictionary *item = [items objectAtIndex:i];
        if (![item objectForKey:@"price"]) {
            [self getItemContent:i];
            return;
        }
    }

}

#pragma mark - Picker
////////////////////////////////////////////////////////////////////
// PICKER
////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0)
        return 1000;
    else
        return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) 
        return [NSString stringWithFormat:@"%3d zł.", row];
    else
        return [NSString stringWithFormat:@"%02d gr.", row];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component==0) zlote = row;
    else grosze = row;
    NSLog(@"Selected: %3d,%02d zł.", zlote, grosze);
}

#pragma mark - Search
////////////////////////////////////////////////////////////////////
// SZUKAJKA
////////////////////////////////////////////////////////////////////
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [table reloadData];
    NSLog(@"%@", searchText);
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchAnuler.hidden = NO;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    searchAnuler.hidden = YES;
    [searchBar resignFirstResponder];
}

@end
