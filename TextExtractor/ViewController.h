//
//  ViewController.h
//  TextExtractor
//
//  Created by Tyson Williams on 11/22/14.
//  Copyright (c) 2014 Tyson Williams. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TesseractOCR/TesseractOCR.h>

@interface ViewController : UIViewController <G8TesseractDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageToRecognize;




@end

