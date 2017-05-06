//
//  UserCardPortraitCell.m
//  CommonTableView
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import "UserCardPortraitCell.h"
#import "UIView+EXT.h"
#import "UIImage+EXT.h"

@interface UserCardPortraitCell()

@property(nonatomic,strong)UIImageView *avatarImageView;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UIImageView *genderImageView;

@end
@implementation UserCardPortraitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_avatarImageView];
        
        _nameLabel      = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont systemFontOfSize:17.f];
        [self addSubview:_nameLabel];
        
        _nickNameLabel  = [[UILabel alloc] initWithFrame:CGRectZero];
        _nickNameLabel.font = [UIFont systemFontOfSize:14.f];
        _nickNameLabel.textColor = [UIColor grayColor];
        [self addSubview:_nickNameLabel];
        
        _genderImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_genderImageView];
    }
    return self;
}

- (void)refreshData:(CommonTableRow *)rowData tableView:(UITableView *)tableView{
    UIImage *image = [UIImage imageNamed:@"avatar"];
    [self.avatarImageView setImage:[image imageWithCornerRadius:360]];
    self.nameLabel.text = @"王君思密达";
    self.nickNameLabel.text = [NSString stringWithFormat:@"昵称：%@",@"广州-天堂秀"];
    [_nickNameLabel sizeToFit];
}

#define avatarSize 60.f
#define genderSize 16.f
#define AvatarLeft 15.f
#define TitleAndAvatarSpacing 12.f
#define TitleTop 20.f
#define AccountBottom 20.f
#define GenderIconAndTitleSpacing 12.f
- (void)layoutSubviews{
    [super layoutSubviews];
    self.avatarImageView.size = CGSizeMake(avatarSize, avatarSize);
    self.avatarImageView.left    = AvatarLeft;
    self.avatarImageView.centerY = self.height * .5;
    
    CGFloat scale = self.width / 375;
    CGFloat maxTextLabelWidth = 200 * scale;
    [self.nameLabel sizeToFit];
    self.nameLabel.width = MIN(self.nameLabel.width, maxTextLabelWidth);
    self.nameLabel.left = self.avatarImageView.right + TitleAndAvatarSpacing;
    self.nameLabel.top  = TitleTop;
    
    self.nickNameLabel.left    = self.nameLabel.left;
    self.nickNameLabel.bottom  = self.height - AccountBottom;
    
    self.genderImageView.left    = self.nameLabel.right + GenderIconAndTitleSpacing;
    self.genderImageView.centerY = self.nameLabel.centerY;
}

@end
