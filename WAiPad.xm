#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "fishhook.h"


int (*orig_WAUIDevicesIsDeviceSupported)(void);
int new_WAUIDevicesIsDeviceSupported(void){
        return 1;
}

// iPad

%hook UIDevice

- (BOOL)wa_isDeviceSupported {
    return true;
}

%end

%hook UIApplication

- (BOOL)_isClassic{

    return NO;
}
%end


%hook SBApplication

- (BOOL)_supportsApplicationType:(id)arg1{
    return true;
}

%end


%hook SBApplicationInfo

- (BOOL)wantsFullScreen{
    return true;
}

- (BOOL)wantsExclusiveForeground{
    return true;
}

- (BOOL)disablesClassicMode{
    return true;
}


%end


%ctor {
    struct rebinding binds[1];

    struct rebinding bind1 = {"WAUIDevicesIsDeviceSupported", (void *)new_WAUIDevicesIsDeviceSupported, (void **)&orig_WAUIDevicesIsDeviceSupported};
    binds[0] = bind1;


    rebind_symbols(binds, 1);

}
