//
//  TypeSomethingViewController.m
//  Pickers
//

#import "TypeSomethingViewController.h"
NSString *nname,*aadress,*pperson;

@implementation TypeSomethingViewController

@synthesize textField;
@synthesize delegate,personlabel;

- (IBAction)doneButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(typeSomethingViewController:didTypeSomething:)]) {
        [self.delegate typeSomethingViewController:self didTypeSomething:textField.text];
    }
	
	if(textField.text == @"")
	{
		nname=@"          -";
	}else
	{
	nname= textField.text;
	}
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if(interfaceOrientation ==UIInterfaceOrientationLandscapeRight)
	{
		return YES;
	}
	else
	{
		return NO;	
	}
	
}

- ( BOOL)textFieldShouldReturn:(UITextField *)textfField
{
	[textfField resignFirstResponder];
	return YES;
}

- (IBAction)showPeoplePicker:(id)sender
{
    ABPeoplePickerNavigationController *peoplePickerController = [[ABPeoplePickerNavigationController alloc] init];
    peoplePickerController.peoplePickerDelegate = self;
    
    [self presentModalViewController:peoplePickerController animated:YES];
    
    [peoplePickerController release];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [self dismissModalViewControllerAnimated:YES];
}






- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSString *lastname = (NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
	if(lastname == nil)
	{
		lastname=@"-";
	}
	NSString *firstname = (NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
	if(firstname == nil)
	{
		firstname=@"-";
	}
	NSString *company = (NSString *)ABRecordCopyValue(person, kABPersonOrganizationProperty);
	if(company == nil)
	{
		company=@"-";
	}
	NSString *name = [[NSString alloc] initWithFormat:@"%@,\n%@ %@ ",company,firstname, lastname];
	
	personlabel.text=[[NSString alloc]initWithFormat:@"%@",name];
	pperson = [[NSString alloc]initWithFormat:@"%@",name];
		
    ABMutableMultiValueRef addrMulti = ABRecordCopyValue(person, kABPersonAddressProperty);
	aadress = @"-";
	
	//NSString *addressLabel;
	CFDictionaryRef addressDict;
	
	
	
	
	for (CFIndex i = 0; i < ABMultiValueGetCount(addrMulti); i++) 
	{
		
		//addressLabel = (NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(addrMulti, i));
		addressDict = (CFDictionaryRef)ABMultiValueCopyValueAtIndex(addrMulti, i);
		NSString *streetStr = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressStreetKey);
		NSString *zipStr = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressZIPKey);
		NSString *cityStr = (NSString *)CFDictionaryGetValue(addressDict, kABPersonAddressCityKey);
		NSString *addrStr = [[NSString alloc] initWithFormat:@"%@,\n%@ %@", streetStr, zipStr, cityStr];
		if(i==0)
		{	
		aadress = [[NSString alloc] initWithFormat:@"%@",addrStr];
		}
		[addrStr release];
		[streetStr release];
		[zipStr release];
		[cityStr release];
			
	}
	[lastname release];
	[firstname release];
	[company release];
	
	CFRelease(addrMulti);
	
	[self dismissModalViewControllerAnimated:YES];
    return NO;
	CFRelease(addressDict);
	//CFRelease(addressLabel);
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return NO;
}


- (void)dealloc {
    [textField release];
    [super dealloc];
}


@end
