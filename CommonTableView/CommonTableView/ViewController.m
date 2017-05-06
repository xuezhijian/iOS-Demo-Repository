//
//  ViewController.m
//  CommonTableView
//
//  Created by zj on 16/10/15.
//  Copyright © 2016年 xuezhijian. All rights reserved.
//

#import "ViewController.h"
#import "CommonTableDelegate.h"
#import "CommonTableData.h"

typedef NS_ENUM(NSInteger, UserGender) {
    /**
     *  未知性别
     */
    UserGenderUnknown,
    /**
     *  性别男
     */
    UserGenderMale,
    /**
     *  性别女
     */
    UserGenderFemale,
};

@interface ViewController ()

@property(nonatomic,strong) CommonTableDelegate *delegator;
@property(nonatomic,strong) NSArray *data;

@property(nonatomic,assign) UserGender selectedGender;

@property(nonatomic,strong) NSString *cellText;//输入框的文本内容

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self refresh];
}

- (void)setupUI{
    __weak typeof(self) weakSelf = self;
    _delegator = [[CommonTableDelegate alloc] initWithTableData:^NSArray *{
        return weakSelf.data;
    }];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.delegate   = self.delegator;
    _tableView.dataSource = self.delegator;
    _tableView.showsVerticalScrollIndicator = NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTableView:)];
    [_tableView addGestureRecognizer:tapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onTextFieldChanged:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)buildData{
    NSArray *data = @[
                      @{
                          HeaderTitle  :@"这组是默认样式",
                          HeaderHeight : @(30),
                          RowContent :@[
                                  @{
                                      Title         : @"主标题",
                                      DetailTitle   : @"描述  ",
                                      CellAction    : @"touchCell1",
                                      ShowAccessory : @(YES)
                                      },
                                  @{
                                      Title         : @"主标题",
                                      RowHeight     : @(60),
                                      ShowAccessory : @(YES)
                                      }
                                  ],
                          FooterTitle  : @"",
                          FooterHeight : @(10)
                          },
                      @{
                          HeaderTitle:@"这组是公共样式的CommonTextFieldCell",
                          HeaderHeight : @(30),
                          RowContent :@[
                                  @{
                                      Title        : @"文本cell",
                                      DetailTitle  : @"输入些文字试试",
                                      CellClass    : @"CommonTextFieldCell",
                                      ExtraInfo    : @(UIReturnKeyDone),//设置键盘确认按钮类型
                                      }
                                  ],
                          FooterTitle  : @"",
                          FooterHeight : @(10)
                          },
                      @{
                          HeaderTitle  :@"这组是公共样式的CheckBoxCell",
                          HeaderHeight : @(30),
                          RowContent :@[
                                  @{
                                      Title         : @"男",
                                      CellClass     : @"CommonCheckBoxCell",
                                      CellAction    : @"onTouchMaleCell:",
                                      ExtraInfo     : @(self.selectedGender == UserGenderMale),
                                      ForbidSelect  : @(YES),
                                      },
                                  @{
                                      Title         : @"女",
                                      CellClass     : @"CommonCheckBoxCell",
                                      CellAction    : @"onTouchFemaleCell:",
                                      ExtraInfo     : @(self.selectedGender == UserGenderFemale),
                                      ForbidSelect  : @(YES),
                                      },
                                  @{
                                      Title         : @"未知",
                                      CellClass     : @"CommonCheckBoxCell",
                                      CellAction    : @"onTouchUnkownGenderCell:",
                                      ExtraInfo     : @(self.selectedGender == UserGenderUnknown),
                                      ForbidSelect  : @(YES),
                                      }
                                  ],
                          FooterTitle  : @"",
                          FooterHeight : @(10)
                          },
                      @{
                          HeaderTitle  :@"这组是公共样式的CommonSwitchCell",
                          HeaderHeight : @(30),
                          RowContent :@[
                                  @{
                                      Title         : @"推送通知",
                                      CellClass     : @"CommonSwitchCell",
                                      CellAction    : @"switchChange:",
                                      ExtraInfo     : @(YES),
                                      ForbidSelect  : @(YES)
                                      }
                                  ],
                          FooterTitle  : @"",
                          FooterHeight : @(10)
                          },
                      @{
                          HeaderTitle:@"这组是公共样式的CommonFunctionCell,带图标",
                          HeaderHeight : @(30),
                          RowContent :@[
                                  @{
                                      Title        : @"我的商城",
                                      CellClass    : @"CommonFunctionCell",
                                      ExtraInfo    : [UIImage imageNamed:@"myCenter_shop"],
                                      CellAction    : @"touchShop",
                                      ShowAccessory : @(YES)
                                      }
                                  ],
                          FooterTitle  : @"",
                          FooterHeight : @(10)
                          },
                      @{
                          HeaderTitle:@"自定义就实现我的协议就好",
                          HeaderHeight : @(30),
                          RowContent :@[
                                  @{
                                      ExtraInfo    : @"实际开放中你可以传进去用户的id，在cell里面实现逻辑",
                                      CellClass    : @"UserCardPortraitCell",
                                      RowHeight     : @(90)
                                      }
                                  ],
                          FooterTitle  : @"",
                          FooterHeight : @(30)
                          },
                      ];
    self.data = [CommonTableSection sectionsWithData:data];
}

- (void)refresh{
    [self buildData];
    [self.tableView reloadData];
}

#pragma mark - Action
- (void)touchCell1
{
    [self showAlertWithString:@"加不加点击事件由你"];
}

- (void)onTouchMaleCell:(id)sender{
    self.selectedGender = UserGenderMale;
    [self refresh];
}

- (void)onTouchFemaleCell:(id)sender{
    self.selectedGender = UserGenderFemale;
    [self refresh];
}

- (void)onTouchUnkownGenderCell:(id)sender{
    self.selectedGender = UserGenderUnknown;
    [self refresh];
}

- (void)switchChange:(id) sender{
    BOOL isButtonOn = [(UISwitch*)sender isOn];
    if (isButtonOn) {
        [self showAlertWithString:@"开"];
    }else {
        [self showAlertWithString:@"关"];
    }
}

- (void)touchShop{
    [self showAlertWithString:@"点击了商城"];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];//关闭键盘
    [self showAlertWithString:self.cellText];
    return YES;
}

//其实你写个代理传出来，不过我比较懒就直接用NSNotificationCenter
- (void)onTextFieldChanged:(NSNotification *)notification{
    UITextField *textField = notification.object;
    self.cellText = textField.text;
}

#pragma mark -Private
- (void)showAlertWithString:(NSString *)text
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"cell"message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];

}
#pragma mark - GestureRecognizer
- (void)tapTableView:(UITapGestureRecognizer *)recognizer{
    [self.view endEditing:YES];
}

@end
