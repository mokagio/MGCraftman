//
//  MGTidyView.h
//  CatAcademy
//
//  Created by Gio on 05/08/2013.
//  Copyright (c) 2013 Memrise. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGTidyViewProtocol <NSObject>

// could be drawSubviews?
- (void)drawElements;
// could be orderSubviews?
- (void)orderElements;

@end
