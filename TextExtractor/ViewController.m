//
//  ViewController.m
//  TextExtractor
//
//  Created by Tyson Williams on 11/22/14.
//  Copyright (c) 2014 Tyson Williams. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *recognizedTextLabel;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // G8Tesseract * tesseract = [[G8Tesseract alloc] initWithLanguage:@"eng+ita"];
    //tesseract.delegate = self;
    self.operationQueue = [[NSOperationQueue alloc] init];
    [self recognizeButtonPressed:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openCamera:(UIButton *)sender {
    UIImagePickerController *imgPicker = [UIImagePickerController new];
    imgPicker.delegate = self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imgPicker animated:YES completion:nil];
    }
}

-(void)recognizeImageWithTesseract:(UIImage *)image {
    UIImage *bwImage = [image g8_blackAndWhite];
    self.imageToRecognize.image = bwImage;
    
    G8RecognitionOperation *operation = [[G8RecognitionOperation alloc] init];
    operation.tesseract.language = @"eng";
    operation.tesseract.engineMode = G8OCREngineModeTesseractOnly;
    operation.tesseract.pageSegmentationMode = G8PageSegmentationModeAutoOnly;
    //operation.tesseract.maximumRecognitionTime = 1.0;
    operation.delegate = self;
    
    //operation.tesseract.charWhitelist = @"01234"; //limit search
    //operation.tesseract.charBlacklist = @"56789";
    operation.tesseract.image = bwImage; //image to check
    
    //operation.tesseract.rect = CGRectMake(20, 20, 100, 100); //optional: set the rectangle to recognize text in the image
    
    operation.recognitionCompleteBlock = ^(G8Tesseract *tesseract) {
        NSString *recognizedText = tesseract.recognizedText;
        NSLog(@"%@", recognizedText);
        self.recognizedTextLabel.text = recognizedText;
    };
    [self.operationQueue addOperation:operation];
}

- (IBAction)recognizeButtonPressed:(UIButton *)sender {
    [self recognizeImageWithTesseract:[UIImage imageNamed:@"image_sample.jpg"]];
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self recognizeImageWithTesseract:image];
}

@end
