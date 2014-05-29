#include "MacXFunctions.h"
#include <Cocoa/Cocoa.h>

void setMacXActivationPolicy()
{
    //application does not appear in the Dock
    [NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
}

// Copyright (c) 2011 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
void SetProcessName(QString procname) {

  CFStringRef process_name = CFStringCreateWithCharacters(0, (UniChar *)procname.unicode(), procname.length());


  if (!process_name || CFStringGetLength(process_name) == 0) {
    //"SetProcessName given bad name.";
    return;
  }

  if (![NSThread isMainThread]) {
    //"Should only set process name from main thread.";
    return;
  }

  // Warning: here be dragons! This is SPI reverse-engineered from WebKit's
  // plugin host, and could break at any time (although realistically it's only
  // likely to break in a new major release).
  // When 10.7 is available, check that this still works, and update this
  // comment for 10.8.

  // Private CFType used in these LaunchServices calls.
  typedef CFTypeRef PrivateLSASN;
  typedef PrivateLSASN (*LSGetCurrentApplicationASNType)();
  typedef OSStatus (*LSSetApplicationInformationItemType)(int, PrivateLSASN,
                                                          CFStringRef,
                                                          CFStringRef,
                                                          CFDictionaryRef*);

  static LSGetCurrentApplicationASNType ls_get_current_application_asn_func =
      NULL;
  static LSSetApplicationInformationItemType
      ls_set_application_information_item_func = NULL;
  static CFStringRef ls_display_name_key = NULL;

  CFStringRef* key_pointer;
  ProcessSerialNumber psn;

  static bool did_symbol_lookup = false;
  if (!did_symbol_lookup) {
    did_symbol_lookup = true;
    CFBundleRef launch_services_bundle =
        CFBundleGetBundleWithIdentifier(CFSTR("com.apple.LaunchServices"));

    if (!launch_services_bundle) {
      //"Failed to look up LaunchServices bundle";
      return;
    }

    ls_get_current_application_asn_func =
        reinterpret_cast<LSGetCurrentApplicationASNType>(
            CFBundleGetFunctionPointerForName(
                launch_services_bundle, CFSTR("_LSGetCurrentApplicationASN")));

    if (!ls_get_current_application_asn_func)
      //"Could not find _LSGetCurrentApplicationASN");

    ls_set_application_information_item_func =
        reinterpret_cast<LSSetApplicationInformationItemType>(
            CFBundleGetFunctionPointerForName(
                launch_services_bundle,
                CFSTR("_LSSetApplicationInformationItem")));

    if (!ls_set_application_information_item_func)
      //"Could not find _LSSetApplicationInformationItem");

        key_pointer = reinterpret_cast<CFStringRef*>(
        CFBundleGetDataPointerForName(launch_services_bundle,
                                      CFSTR("_kLSDisplayNameKey")));
    ls_display_name_key = key_pointer ? *key_pointer : NULL;

    if (!ls_display_name_key)
      //"Could not find _kLSDisplayNameKey");

    // Internally, this call relies on the Mach ports that are started up by the
    // Carbon Process Manager.  In debug builds this usually happens due to how
    // the logging layers are started up; but in release, it isn't started in as
    // much of a defined order.  So if the symbols had to be loaded, go ahead
    // and force a call to make sure the manager has been initialized and hence
    // the ports are opened.


    GetCurrentProcess(&psn);

  }
  if (!ls_get_current_application_asn_func ||
      !ls_set_application_information_item_func ||
      !ls_display_name_key) {
     return;
  }

  PrivateLSASN asn = ls_get_current_application_asn_func();
  // Constant used by WebKit; what exactly it means is unknown.
  const int magic_session_constant = -2;
  OSErr err =
      ls_set_application_information_item_func(magic_session_constant, asn,
                                               ls_display_name_key,
                                               process_name,
                                               NULL /* optional out param */);

  //"Call to set process name failed, %@ ",err);
}

char *runWithRootPrivileges(char *command)
{
    OSStatus status;
    AuthorizationRef authorizationRef;

    NSString * pathToIcon = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/Contents/Resources/appicon32.png"];
    const char *icon = [pathToIcon fileSystemRepresentation];

    char *result = NULL;

    char* args[2];
    args [0] = "-c";
    args [1] = command;
    args [2] = NULL;

    FILE *pipe = NULL;

    AuthorizationItem kAuthEnv[] = {
            { kAuthorizationEnvironmentIcon, strlen(icon), (void*)icon, 0 } };
    AuthorizationEnvironment myAuthorizationEnvironment = { 1, kAuthEnv };

    AuthorizationItem right = {kAuthorizationRightExecute, 0, NULL, 0};
    AuthorizationRights rights = {1, &right};
    AuthorizationFlags flags = kAuthorizationFlagDefaults |
    kAuthorizationFlagInteractionAllowed |
    kAuthorizationFlagPreAuthorize |
    kAuthorizationFlagExtendRights;

    status = AuthorizationCreate(NULL, kAuthorizationEmptyEnvironment,
                                     kAuthorizationFlagDefaults, &authorizationRef);
    if (status != errAuthorizationSuccess)
        return NULL;

    // Call AuthorizationCopyRights to determine rights.
    status = AuthorizationCopyRights(authorizationRef, &rights, &myAuthorizationEnvironment, flags, NULL);
    if (status != errAuthorizationSuccess)
        return NULL;

    status = AuthorizationExecuteWithPrivileges(authorizationRef, "/bin/sh",
                                                kAuthorizationFlagDefaults, args, &pipe);
    AuthorizationFree(authorizationRef, kAuthorizationFlagDestroyRights);
    if (status == errAuthorizationSuccess)
    {
        result = new char[1024];
        fread(result, 1024, 1, pipe);
        fclose(pipe);
    }

    return result;
}


bool startAtLogin(bool opt)
{
    NSString * appPath = [[NSBundle mainBundle] bundlePath];

    // Get the path for the MEGAsync application and access login items list
    CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:appPath];
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,kLSSharedFileListSessionLoginItems, NULL);

    //Enable start at login time
    if(opt)
    {
        if (loginItems) {
            //Insert an item to the login list.
            LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(loginItems,
                                                                         kLSSharedFileListItemLast, NULL, NULL,
                                                                         url, NULL, NULL);
            if (item){
                CFRelease(item);
                CFRelease(loginItems);
                return true;
            }
        }

    }else //disable start at login time
    {
        if (loginItems)
        {
            UInt32 seed = 0U;
            NSArray *currentLoginItems = [NSMakeCollectable(LSSharedFileListCopySnapshot(loginItems, &seed)) autorelease];
            for (id itemObject in currentLoginItems)
            {
                LSSharedFileListItemRef item = (LSSharedFileListItemRef)itemObject;

                //Resolve the item with URL
                if (LSSharedFileListItemResolve(item, 0, (CFURLRef*) &url, NULL) == noErr)
                {
                    NSString * urlPath = [(__bridge NSURL*)url path];
                    if ([urlPath compare:appPath] == NSOrderedSame)
                    {
                        LSSharedFileListItemRemove(loginItems,item);

                        CFRelease(loginItems);
                        return true;
                    }
                }
            }

        }

    }

    CFRelease(loginItems);
    return false;
}

bool isStartAtLoginActive()
{

    Boolean foundIt=false;
    LSSharedFileListRef loginItems = LSSharedFileListCreate(NULL,kLSSharedFileListSessionLoginItems, NULL);

    if (loginItems)
    {
            // This will get the path for the application
            NSURL *itemURL=[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
            UInt32 seed = 0U;
            NSArray *currentLoginItems = [NSMakeCollectable(LSSharedFileListCopySnapshot(loginItems, &seed)) autorelease];
            for (id itemObject in currentLoginItems)
            {
                LSSharedFileListItemRef item = (LSSharedFileListItemRef)itemObject;

                UInt32 resolutionFlags = kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes;
                CFURLRef URL = NULL;
                OSStatus err = LSSharedFileListItemResolve(item, resolutionFlags, &URL, /*outRef*/ NULL);
                if (err == noErr)
                {
                    foundIt = CFEqual(URL, itemURL);
                    CFRelease(URL);

                    if (foundIt)
                        break;
                }
            }
        }

    CFRelease(loginItems);
    return (BOOL)foundIt;
}

void addPathToPlaces(QString path, QString pathName)
{
    IconRef iconRef;
    FSRef fref;

    NSString *folderPath = [[NSString alloc] initWithUTF8String:path.toUtf8().constData()];
    NSString * appPath = [[NSBundle mainBundle] bundlePath];

    //Does not work propertly
    CFStringRef pnString = CFStringCreateWithCharacters(0, (UniChar *)pathName.unicode(), pathName.length());

    CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:folderPath];

    CFURLRef iconURLRef = (CFURLRef)[NSURL fileURLWithPath:[appPath stringByAppendingString:@"/Contents/Resources/app.icns"]];
    CFURLGetFSRef(iconURLRef, &fref);
    RegisterIconRefFromFSRef('SSBL', 'ssic', &fref, &iconRef);

    // Create a reference to the shared file list.
    LSSharedFileListRef favoriteItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListFavoriteItems, NULL);
    if (favoriteItems) {
        //Insert an item to the list.
        LSSharedFileListItemRef item = LSSharedFileListInsertItemURL(favoriteItems,
                                                                     kLSSharedFileListItemLast, pnString, iconRef/*NULL*/,
                                                                     url, NULL, NULL);
        if (item){
            CFRelease(item);
        }
    }

    CFRelease(favoriteItems);
    CFRelease(pnString);
    [folderPath release];

}

void removePathFromPlaces(QString path)
{
    NSString *folderPath = [[NSString alloc] initWithUTF8String:path.toUtf8().constData()];

    // This will get the path for the application
    CFURLRef url = (CFURLRef)[NSURL fileURLWithPath:folderPath];

    // Create a reference to the shared file list of favourite items.
    LSSharedFileListRef favoriteItems = LSSharedFileListCreate(NULL,
                                                            kLSSharedFileListFavoriteItems, NULL);

    // loop through the list of startup items and try to find the MEGAsync app
    CFArrayRef listSnapshot = LSSharedFileListCopySnapshot(favoriteItems, NULL);
    for(int i = 0; i < CFArrayGetCount(listSnapshot); i++)
    {
        LSSharedFileListItemRef item = (LSSharedFileListItemRef)CFArrayGetValueAtIndex(listSnapshot, i);
        //Avoid check special volumes (Airdrop)
        UInt32 resolutionFlags = kLSSharedFileListNoUserInteraction | kLSSharedFileListDoNotMountVolumes;
        CFURLRef currentItemURL = NULL;
        LSSharedFileListItemResolve(item, resolutionFlags, &currentItemURL, NULL);
        if(currentItemURL && CFEqual(currentItemURL, url))
        {

            CFRelease(currentItemURL);
            LSSharedFileListItemRemove(favoriteItems,item);
        }
        if(currentItemURL)
        {
            CFRelease(currentItemURL);
        }
    }


    CFRelease(favoriteItems);
    [folderPath release];


}

void setFolderIcon(QString path)
{

    NSString *folderPath = [[NSString alloc] initWithUTF8String:path.toUtf8().constData()];

    NSString * appPath = [[NSBundle mainBundle] bundlePath];
    NSImage* iconImage = [[NSImage alloc] initWithContentsOfFile:[appPath stringByAppendingString:@"/Contents/Resources/folder.icns"]];

    BOOL didSetIcon = [[NSWorkspace sharedWorkspace] setIcon:iconImage forFile:folderPath options:0];

    if(!didSetIcon)
    {
        [iconImage release];
        [folderPath release];
        return;
    }

    [iconImage release];
    [folderPath release];
}

void unSetFolderIcon(QString path)
{

    NSString *folderPath = [[NSString alloc] initWithUTF8String:path.toUtf8().constData()];
    BOOL didUnsetIcon = [[NSWorkspace sharedWorkspace] setIcon:nil forFile:folderPath options:0];

    if(!didUnsetIcon)
    {
        [folderPath release];
        return;
    }

    [folderPath release];
}


