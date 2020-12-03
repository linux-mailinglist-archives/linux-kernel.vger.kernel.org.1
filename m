Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2804D2CDCEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgLCR7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:59:47 -0500
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:47370 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgLCR7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:59:46 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 59BA0837F27E;
        Thu,  3 Dec 2020 17:59:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:69:327:334:355:368:369:379:599:857:967:968:973:982:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1430:1437:1515:1516:1518:1593:1594:1605:1730:1747:1777:1792:1963:1981:2194:2198:2199:2200:2393:2525:2560:2563:2682:2685:2693:2740:2743:2828:2859:2892:2897:2903:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3770:3834:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4384:4605:5007:6120:6238:6741:7688:7875:7903:7904:7974:8957:9008:9010:9025:9108:9121:9386:9388:10226:10394:10848:11026:11232:11320:11876:11914:12043:12048:12050:12291:12295:12296:12297:12438:12555:12683:12712:12737:12740:12760:12895:12986:13130:13138:13149:13230:13231:13439:13972:14096:14097:14659:14877:21063:21080:21121:21222:21324:21325:21433:21451:21611:21627:21740:21773:21781:21789:21795:21810:21939:30009:30029:30051:30054:30065:30070:30075:30080:30089:30090:30091,0,RBL:no
X-HE-Tag: smash21_2906684273bd
X-Filterd-Recvd-Size: 48774
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu,  3 Dec 2020 17:59:01 +0000 (UTC)
Message-ID: <a83033e9fcc706be129e9c4c0d30a0542f13d406.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: correctly detect lines of help text
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Date:   Thu, 03 Dec 2020 09:58:59 -0800
In-Reply-To: <16f0bfd4-61ca-48d8-c9ab-10bfc9a233ad@infradead.org>
References: <133ac827-c0d2-c5c7-39d8-7d2c17de7c76@fau.de>
         <8436bc4191d92af283ea6aa7ca450e36da653e2e.camel@perches.com>
         <16f0bfd4-61ca-48d8-c9ab-10bfc9a233ad@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-02 at 10:59 -0800, Randy Dunlap wrote:

> There are also large hunks of block/Kconfig and drivers/hid/Kconfig
> that don't use any indentation for help text...
> in case that matters here.

Maybe something like this could help.

Indent the unindented help blocks by 2 spaces and reflow where appropriate.

---
 block/Kconfig       | 105 +++++-----
 drivers/hid/Kconfig | 549 +++++++++++++++++++++++++++-------------------------
 2 files changed, 335 insertions(+), 319 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index a2297edfdde8..870107419a8b 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -67,14 +67,14 @@ config BLK_DEV_BSGLIB
 config BLK_DEV_INTEGRITY
 	bool "Block layer data integrity support"
 	help
-	Some storage devices allow extra information to be
-	stored/retrieved to help protect the data.  The block layer
-	data integrity option provides hooks which can be used by
-	filesystems to ensure better data integrity.
+	  Some storage devices allow extra information to be
+	  stored/retrieved to help protect the data.  The block layer
+	  data integrity option provides hooks which can be used by
+	  filesystems to ensure better data integrity.
 
-	Say yes here if you have a storage device that provides the
-	T10/SCSI Data Integrity Field or the T13/ATA External Path
-	Protection.  If in doubt, say N.
+	  Say yes here if you have a storage device that provides the
+	  T10/SCSI Data Integrity Field or the T13/ATA External Path
+	  Protection.  If in doubt, say N.
 
 config BLK_DEV_INTEGRITY_T10
 	tristate
@@ -85,64 +85,65 @@ config BLK_DEV_ZONED
 	bool "Zoned block device support"
 	select MQ_IOSCHED_DEADLINE
 	help
-	Block layer zoned block device support. This option enables
-	support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
-	devices.
+	  Block layer zoned block device support. This option enables
+	  support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
+	  devices.
 
-	Say yes here if you have a ZAC, ZBC, or ZNS storage device.
+	  Say yes here if you have a ZAC, ZBC, or ZNS storage device.
 
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
 	depends on BLK_CGROUP=y
 	select BLK_CGROUP_RWSTAT
 	help
-	Block layer bio throttling support. It can be used to limit
-	the IO rate to a device. IO rate policies are per cgroup and
-	one needs to mount and use blkio cgroup controller for creating
-	cgroups and specifying per device IO rate policies.
+	  Block layer bio throttling support. It can be used to limit
+	  the IO rate to a device. IO rate policies are per cgroup and
+	  one needs to mount and use blkio cgroup controller for creating
+	  cgroups and specifying per device IO rate policies.
 
-	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
+	  See Documentation/admin-guide/cgroup-v1/blkio-controller.rst
+	  for more information.
 
 config BLK_DEV_THROTTLING_LOW
 	bool "Block throttling .low limit interface support (EXPERIMENTAL)"
 	depends on BLK_DEV_THROTTLING
 	help
-	Add .low limit interface for block throttling. The low limit is a best
-	effort limit to prioritize cgroups. Depending on the setting, the limit
-	can be used to protect cgroups in terms of bandwidth/iops and better
-	utilize disk resource.
+	  Add .low limit interface for block throttling.
+	  The low limit is a best effort limit to prioritize cgroups.
+	  Depending on the setting, the limit can be used to protect cgroups
+	  in terms of bandwidth/iops and better utilize disk resource.
 
-	Note, this is an experimental interface and could be changed someday.
+	  Note, this is an experimental interface and could be changed someday.
 
 config BLK_CMDLINE_PARSER
 	bool "Block device command line partition parser"
 	help
-	Enabling this option allows you to specify the partition layout from
-	the kernel boot args.  This is typically of use for embedded devices
-	which don't otherwise have any standardized method for listing the
-	partitions on a block device.
+	  Enabling this option allows you to specify the partition layout from
+	  the kernel boot args.  This is typically of use for embedded devices
+	  which don't otherwise have any standardized method for listing the
+	  partitions on a block device.
 
-	See Documentation/block/cmdline-partition.rst for more information.
+	  See Documentation/block/cmdline-partition.rst for more information.
 
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
 	help
-	Enabling this option enables the block layer to throttle buffered
-	background writeback from the VM, making it more smooth and having
-	less impact on foreground operations. The throttling is done
-	dynamically on an algorithm loosely based on CoDel, factoring in
-	the realtime performance of the disk.
+	  Enabling this option enables the block layer to throttle buffered
+	  background writeback from the VM, making it more smooth and having
+	  less impact on foreground operations. The throttling is done
+	  dynamically on an algorithm loosely based on CoDel, factoring in
+	  the realtime performance of the disk.
 
 config BLK_CGROUP_IOLATENCY
 	bool "Enable support for latency based cgroup IO protection"
 	depends on BLK_CGROUP=y
 	help
-	Enabling this option enables the .latency interface for IO throttling.
-	The IO controller will attempt to maintain average IO latencies below
-	the configured latency target, throttling anybody with a higher latency
-	target than the victimized group.
+	  Enabling this option enables the .latency interface for IO throttling.
+	  The IO controller will attempt to maintain average IO latencies below
+	  the configured latency target, throttling anybody with a higher
+	  latency target than the victimized group.
 
-	Note, this is an experimental interface and could be changed someday.
+	  Note, this is an experimental interface and could be changed someday.
 
 config BLK_CGROUP_IOCOST
 	bool "Enable support for cost model based cgroup IO controller"
@@ -150,29 +151,29 @@ config BLK_CGROUP_IOCOST
 	select BLK_RQ_IO_DATA_LEN
 	select BLK_RQ_ALLOC_TIME
 	help
-	Enabling this option enables the .weight interface for cost
-	model based proportional IO control.  The IO controller
-	distributes IO capacity between different groups based on
-	their share of the overall weight distribution.
+	  Enabling this option enables the .weight interface for cost model
+	  based proportional IO control.  The IO controller distributes IO
+	  capacity between different groups based on their share of the
+	  overall weight distribution.
 
 config BLK_WBT_MQ
 	bool "Multiqueue writeback throttling"
 	default y
 	depends on BLK_WBT
 	help
-	Enable writeback throttling by default on multiqueue devices.
+	  Enable writeback throttling by default on multiqueue devices.
 
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
 	depends on DEBUG_FS
 	help
-	Include block layer debugging information in debugfs. This information
-	is mostly useful for kernel developers, but it doesn't incur any cost
-	at runtime.
+	  Include block layer debugging information in debugfs.
+	  This information is mostly useful for kernel developers, but it
+	  doesn't incur any cost at runtime.
 
-	Unless you are building a kernel for a tiny system, you should
-	say Y here.
+	  Unless you are building a kernel for a tiny system, you should
+	  say Y here.
 
 config BLK_DEBUG_FS_ZONED
        bool
@@ -181,9 +182,9 @@ config BLK_DEBUG_FS_ZONED
 config BLK_SED_OPAL
 	bool "Logic for interfacing with Opal enabled SEDs"
 	help
-	Builds Logic for interfacing with Opal enabled controllers.
-	Enabling this option enables users to setup/unlock/lock
-	Locking ranges for SED devices using the Opal protocol.
+	  Builds Logic for interfacing with Opal enabled controllers.
+	  Enabling this option enables users to setup/unlock/lock
+	  Locking ranges for SED devices using the Opal protocol.
 
 config BLK_INLINE_ENCRYPTION
 	bool "Enable inline encryption support in block layer"
@@ -198,9 +199,9 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	select CRYPTO
 	select CRYPTO_SKCIPHER
 	help
-	  Enabling this lets the block layer handle inline encryption
-	  by falling back to the kernel crypto API when inline
-	  encryption hardware is not present.
+	  Enabling this lets the block layer handle inline encryption by
+	  falling back to the kernel crypto API when inline encryption
+	  hardware is not present.
 
 menu "Partition Types"
 
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 7bdda1b5b221..fff79a312f41 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -32,62 +32,62 @@ config HID_BATTERY_STRENGTH
 	select POWER_SUPPLY
 	default n
 	help
-	This option adds support of reporting battery strength (for HID devices
-	that support this feature) through power_supply class so that userspace
-	tools, such as upower, can display it.
+	  This option adds support of reporting battery strength for HID devices
+	  that support this feature through power_supply class so that userspace
+	  tools, such as upower, can display it.
 
 config HIDRAW
 	bool "/dev/hidraw raw HID device support"
 	depends on HID
 	help
-	Say Y here if you want to support HID devices (from the USB
-	specification standpoint) that aren't strictly user interface
-	devices, like monitor controls and Uninterruptible Power Supplies.
+	  Say Y here if you want to support HID devices (from the USB
+	  specification standpoint) that aren't strictly user interface
+	  devices, like monitor controls and Uninterruptible Power Supplies.
 
-	This module supports these devices separately using a separate
-	event interface on /dev/hidraw.
+	  This module supports these devices separately using a separate
+	  event interface on /dev/hidraw.
 
-	There is also a /dev/hiddev configuration option in the USB HID
-	configuration menu. In comparison to hiddev, this device does not process
-	the hid events at all (no parsing, no lookups). This lets applications
-	to work on raw hid events when they want to, and avoid using transport-specific
-	userspace libhid/libusb libraries.
+	  There is also a /dev/hiddev configuration option in the USB HID
+	  configuration menu. In comparison to hiddev, this device does not
+	  process the hid events at all (no parsing, no lookups).
+	  This lets applications to work on raw hid events when they want to,
+	  and avoid using transport-specific userspace libhid/libusb libraries.
 
-	If unsure, say Y.
+	  If unsure, say Y.
 
 config UHID
 	tristate "User-space I/O driver support for HID subsystem"
 	depends on HID
 	default n
 	help
-	Say Y here if you want to provide HID I/O Drivers from user-space.
-	This allows to write I/O drivers in user-space and feed the data from
-	the device into the kernel. The kernel parses the HID reports, loads the
-	corresponding HID Device Driver or provides input devices on top of your
-	user-space device.
+	  Say Y here if you want to provide HID I/O Drivers from user-space.
+	  This allows to write I/O drivers in user-space and feed the data from
+	  the device into the kernel. The kernel parses the HID reports, loads
+	  the corresponding HID Device Driver or provides input devices on top
+	  of your user-space device.
 
-	This driver cannot be used to parse HID-reports in user-space and write
-	special HID-drivers. You should use hidraw for that.
-	Instead, this driver allows to write the transport-layer driver in
-	user-space like USB-HID and Bluetooth-HID do in kernel-space.
+	  This driver cannot be used to parse HID-reports in user-space and
+	  write special HID-drivers. You should use hidraw for that.
+	  Instead, this driver allows to write the transport-layer driver in
+	  user-space like USB-HID and Bluetooth-HID do in kernel-space.
 
-	If unsure, say N.
+	  If unsure, say N.
 
-	To compile this driver as a module, choose M here: the
-	module will be called uhid.
+	  To compile this driver as a module, choose M here: the
+	  module will be called uhid.
 
 config HID_GENERIC
 	tristate "Generic HID driver"
 	depends on HID
 	default HID
 	help
-	Support for generic devices on the HID bus. This includes most
-	keyboards and mice, joysticks, tablets and digitizers.
+	  Support for generic devices on the HID bus. This includes most
+	  keyboards and mice, joysticks, tablets and digitizers.
 
-	To compile this driver as a module, choose M here: the module
-	will be called hid-generic.
+	  To compile this driver as a module, choose M here: the module
+	  will be called hid-generic.
 
-	If unsure, say Y.
+	  If unsure, say Y.
 
 menu "Special HID drivers"
 	depends on HID
@@ -115,37 +115,38 @@ config HID_ACRUX
 	tristate "ACRUX game controller support"
 	depends on HID
 	help
-	Say Y here if you want to enable support for ACRUX game controllers.
+	  Say Y here if you want to enable support for ACRUX game controllers.
 
 config HID_ACRUX_FF
 	bool "ACRUX force feedback support"
 	depends on HID_ACRUX
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for ACRUX
-	game controllers.
+	  Say Y here if you want to enable force feedback support for ACRUX
+	  game controllers.
 
 config HID_APPLE
 	tristate "Apple {i,Power,Mac}Books"
 	depends on HID
 	default !EXPERT
 	help
-	Support for some Apple devices which less or more break
-	HID specification.
+	  Support for some Apple devices which less or more break
+	  HID specification.
 
-	Say Y here if you want support for keyboards of	Apple iBooks, PowerBooks,
-	MacBooks, MacBook Pros and Apple Aluminum.
+	  Say Y here if you want support for keyboards of Apple iBooks,
+	  PowerBooks, MacBooks, MacBook Pros and Apple Aluminum.
 
 config HID_APPLEIR
 	tristate "Apple infrared receiver"
 	depends on (USB_HID)
 	help
-	Support for Apple infrared remote control. All the Apple computers from
-	  2005 onwards include such a port, except the unibody Macbook (2009),
-	  and Mac Pros. This receiver is also used in the Apple TV set-top box
-	  prior to the 2010 model.
+	  Support for Apple infrared remote control.
+	  All the Apple computers from 2005 onwards include such a port,
+	  except the unibody Macbook (2009), and Mac Pros.
+	  This receiver is also used in the Apple TV set-top box prior to
+	  the 2010 model.
 
-	Say Y here if you want support for Apple infrared remote control.
+	  Say Y here if you want support for Apple infrared remote control.
 
 config HID_ASUS
 	tristate "Asus"
@@ -154,37 +155,38 @@ config HID_ASUS
 	depends on ASUS_WMI || ASUS_WMI=n
 	select POWER_SUPPLY
 	help
-	Support for Asus notebook built-in keyboard and touchpad via i2c, and
-	the Asus Republic of Gamers laptop keyboard special keys.
+	  Support for Asus notebook built-in keyboard and touchpad via i2c, and
+	  the Asus Republic of Gamers laptop keyboard special keys.
 
-	Supported devices:
-	- EeeBook X205TA
-	- VivoBook E200HA
-	- GL553V series
-	- GL753V series
+	  Supported devices:
+	  - EeeBook X205TA
+	  - VivoBook E200HA
+	  - GL553V series
+	  - GL753V series
 
 config HID_AUREAL
 	tristate "Aureal"
 	depends on HID
 	help
-	Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
+	  Support for Aureal Cy se W-01RN Remote Controller and other
+	  Aureal derived remotes.
 
 config HID_BELKIN
 	tristate "Belkin Flip KVM and Wireless keyboard"
 	depends on HID
 	default !EXPERT
 	help
-	Support for Belkin Flip KVM and Wireless keyboard.
+	  Support for Belkin Flip KVM and Wireless keyboard.
 
 config HID_BETOP_FF
 	tristate "Betop Production Inc. force feedback support"
 	depends on USB_HID
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for devices by
-	BETOP Production Ltd.
-	Currently the following devices are known to be supported:
-	 - BETOP 2185 PC & BFM MODE
+	  Say Y here if you want to enable force feedback support for devices by
+	  BETOP Production Ltd.
+	  Currently the following devices are known to be supported:
+	  - BETOP 2185 PC & BFM MODE
 
 config HID_BIGBEN_FF
 	tristate "BigBen Interactive Kids' gamepad support"
@@ -203,165 +205,166 @@ config HID_CHERRY
 	depends on HID
 	default !EXPERT
 	help
-	Support for Cherry Cymotion keyboard.
+	  Support for Cherry Cymotion keyboard.
 
 config HID_CHICONY
 	tristate "Chicony devices"
 	depends on HID
 	default !EXPERT
 	help
-	Support for Chicony Tactical pad and special keys on Chicony keyboards.
+	  Support for Chicony Tactical pad and special keys on Chicony
+	  keyboards.
 
 config HID_CORSAIR
 	tristate "Corsair devices"
 	depends on HID && USB && LEDS_CLASS
 	help
-	Support for Corsair devices that are not fully compliant with the
-	HID standard.
+	  Support for Corsair devices that are not fully compliant with the
+	  HID standard.
 
-	Supported devices:
-	- Vengeance K90
-	- Scimitar PRO RGB
+	  Supported devices:
+	  - Vengeance K90
+	  - Scimitar PRO RGB
 
 config HID_COUGAR
 	tristate "Cougar devices"
 	depends on HID
 	help
-	Support for Cougar devices that are not fully compliant with the
-	HID standard.
+	  Support for Cougar devices that are not fully compliant with the
+	  HID standard.
 
-	Supported devices:
-	- Cougar 500k Gaming Keyboard
+	  Supported devices:
+	  - Cougar 500k Gaming Keyboard
 
 config HID_MACALLY
 	tristate "Macally devices"
 	depends on HID
 	help
-	Support for Macally devices that are not fully compliant with the
-	HID standard.
+	  Support for Macally devices that are not fully compliant with the
+	  HID standard.
 
-	supported devices:
-	- Macally ikey keyboard
+	  supported devices:
+	  - Macally ikey keyboard
 
 config HID_PRODIKEYS
 	tristate "Prodikeys PC-MIDI Keyboard support"
 	depends on HID && SND
 	select SND_RAWMIDI
 	help
-	Support for Prodikeys PC-MIDI Keyboard device support.
-	Say Y here to enable support for this device.
-	- Prodikeys PC-MIDI keyboard.
-	  The Prodikeys PC-MIDI acts as a USB Audio device, with one MIDI
-	  input and one MIDI output. These MIDI jacks appear as
-	  a sound "card" in the ALSA sound system.
-	  Note: if you say N here, this device will still function as a basic
-	  multimedia keyboard, but will lack support for the musical keyboard
-	  and some additional multimedia keys.
+	  Support for Prodikeys PC-MIDI Keyboard device support.
+	  Say Y here to enable support for this device.
+	  - Prodikeys PC-MIDI keyboard.
+	    The Prodikeys PC-MIDI acts as a USB Audio device, with one MIDI
+	    input and one MIDI output. These MIDI jacks appear as
+	    a sound "card" in the ALSA sound system.
+	    Note: if you say N here, this device will still function as a basic
+	    multimedia keyboard, but will lack support for the musical keyboard
+	    and some additional multimedia keys.
 
 config HID_CMEDIA
 	tristate "CMedia CM6533 HID audio jack controls"
 	depends on HID
 	help
-	Support for CMedia CM6533 HID audio jack controls.
+	  Support for CMedia CM6533 HID audio jack controls.
 
 config HID_CP2112
 	tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
 	depends on USB_HID && HIDRAW && I2C && GPIOLIB
 	select GPIOLIB_IRQCHIP
 	help
-	Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
-	This is a HID device driver which registers as an i2c adapter
-	and gpiochip to expose these functions of the CP2112. The
-	customizable USB descriptor fields are exposed as sysfs attributes.
+	  Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
+	  This is a HID device driver which registers as an i2c adapter
+	  and gpiochip to expose these functions of the CP2112. The
+	  customizable USB descriptor fields are exposed as sysfs attributes.
 
 config HID_CREATIVE_SB0540
 	tristate "Creative SB0540 infrared receiver"
 	depends on USB_HID
 	help
-	Support for Creative infrared SB0540-compatible remote controls, such
-	as the RM-1500 and RM-1800 remotes.
+	  Support for Creative infrared SB0540-compatible remote controls, such
+	  as the RM-1500 and RM-1800 remotes.
 
-	Say Y here if you want support for Creative SB0540 infrared receiver.
+	  Say Y here if you want support for Creative SB0540 infrared receiver.
 
 config HID_CYPRESS
 	tristate "Cypress mouse and barcode readers"
 	depends on HID
 	default !EXPERT
 	help
-	Support for cypress mouse and barcode readers.
+	  Support for cypress mouse and barcode readers.
 
 config HID_DRAGONRISE
 	tristate "DragonRise Inc. game controller"
 	depends on HID
 	help
-	Say Y here if you have DragonRise Inc. game controllers.
-	These might be branded as:
-	- Tesun USB-703
-	- Media-tech MT1504 "Rogue"
-	- DVTech JS19 "Gear"
-	- Defender Game Master
+	  Say Y here if you have DragonRise Inc. game controllers.
+	  These might be branded as:
+	  - Tesun USB-703
+	  - Media-tech MT1504 "Rogue"
+	  - DVTech JS19 "Gear"
+	  - Defender Game Master
 
 config DRAGONRISE_FF
 	bool "DragonRise Inc. force feedback"
 	depends on HID_DRAGONRISE
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for DragonRise Inc.
-	game controllers.
+	  Say Y here if you want to enable force feedback support for
+	  DragonRise Inc. game controllers.
 
 config HID_EMS_FF
 	tristate "EMS Production Inc. force feedback support"
 	depends on HID
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for devices by
-	EMS Production Ltd.
-	Currently the following devices are known to be supported:
-	 - Trio Linker Plus II
+	  Say Y here if you want to enable force feedback support for devices by
+	  EMS Production Ltd.
+	  Currently the following devices are known to be supported:
+	   - Trio Linker Plus II
 
 config HID_ELAN
 	tristate "ELAN USB Touchpad Support"
 	depends on LEDS_CLASS && USB_HID
 	help
-	Say Y to enable support for the USB ELAN touchpad
-	Currently the following devices are known to be supported:
-	 - HP Pavilion X2 10-p0XX.
+	  Say Y to enable support for the USB ELAN touchpad
+	  Currently the following devices are known to be supported:
+	   - HP Pavilion X2 10-p0XX.
 
 config HID_ELECOM
 	tristate "ELECOM HID devices"
 	depends on HID
 	help
-	Support for ELECOM devices:
-	  - BM084 Bluetooth Mouse
-	  - EX-G Trackballs (M-XT3DRBK, M-XT3URBK)
-	  - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
-	  - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
+	  Support for ELECOM devices:
+	    - BM084 Bluetooth Mouse
+	    - EX-G Trackballs (M-XT3DRBK, M-XT3URBK)
+	    - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
+	    - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
 
 config HID_ELO
 	tristate "ELO USB 4000/4500 touchscreen"
 	depends on USB_HID
 	help
-	Support for the ELO USB 4000/4500 touchscreens. Note that this is for
-	different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
+	  Support for the ELO USB 4000/4500 touchscreens. Note that this is for
+	  different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
 
 config HID_EZKEY
 	tristate "Ezkey BTC 8193 keyboard"
 	depends on HID
 	default !EXPERT
 	help
-	Support for Ezkey BTC 8193 keyboard.
+	  Support for Ezkey BTC 8193 keyboard.
 
 config HID_GEMBIRD
 	tristate "Gembird Joypad"
 	depends on HID
 	help
-	Support for Gembird JPD-DualForce 2.
+	  Support for Gembird JPD-DualForce 2.
 
 config HID_GFRM
 	tristate "Google Fiber TV Box remote control support"
 	depends on HID
 	help
-	Support for Google Fiber TV Box remote controls
+	  Support for Google Fiber TV Box remote controls
 
 config HID_GLORIOUS
 	tristate "Glorious PC Gaming Race mice"
@@ -374,14 +377,14 @@ config HID_HOLTEK
 	tristate "Holtek HID devices"
 	depends on USB_HID
 	help
-	Support for Holtek based devices:
-	  - Holtek On Line Grip based game controller
-	  - Trust GXT 18 Gaming Keyboard
-	  - Sharkoon Drakonia / Perixx MX-2000 gaming mice
-	  - Tracer Sniper TRM-503 / NOVA Gaming Slider X200 /
-	    Zalman ZM-GM1
-	  - SHARKOON DarkGlider Gaming mouse
-	  - LEETGION Hellion Gaming Mouse
+	  Support for Holtek based devices:
+	    - Holtek On Line Grip based game controller
+	    - Trust GXT 18 Gaming Keyboard
+	    - Sharkoon Drakonia / Perixx MX-2000 gaming mice
+	    - Tracer Sniper TRM-503 / NOVA Gaming Slider X200 /
+	      Zalman ZM-GM1
+	    - SHARKOON DarkGlider Gaming mouse
+	    - LEETGION Hellion Gaming Mouse
 
 config HOLTEK_FF
 	bool "Holtek On Line Grip force feedback support"
@@ -395,7 +398,7 @@ config HID_GOOGLE_HAMMER
 	tristate "Google Hammer Keyboard"
 	depends on USB_HID && LEDS_CLASS && CROS_EC
 	help
-	Say Y here if you have a Google Hammer device.
+	  Say Y here if you have a Google Hammer device.
 
 config HID_VIVALDI
 	tristate "Vivaldi Keyboard"
@@ -410,45 +413,47 @@ config HID_GT683R
 	tristate "MSI GT68xR LED support"
 	depends on LEDS_CLASS && USB_HID
 	help
-	Say Y here if you want to enable support for the three MSI GT68xR LEDs
+	  Say Y here if you want to enable support for the three MSI GT68xR LEDs
 
-	This driver support following modes:
-	  - Normal: LEDs are fully on when enabled
-	  - Audio:  LEDs brightness depends on sound level
-	  - Breathing: LEDs brightness varies at human breathing rate
+	  This driver support following modes:
+	    - Normal: LEDs are fully on when enabled
+	    - Audio:  LEDs brightness depends on sound level
+	    - Breathing: LEDs brightness varies at human breathing rate
 
-	Currently the following devices are know to be supported:
-	  - MSI GT683R
+	  Currently the following devices are know to be supported:
+	    - MSI GT683R
 
 config HID_KEYTOUCH
 	tristate "Keytouch HID devices"
 	depends on HID
 	help
-	Support for Keytouch HID devices not fully compliant with
-	the specification. Currently supported:
-		- Keytouch IEC 60945
+	  Support for Keytouch HID devices not fully compliant with
+	  the specification.
+
+	  Currently supported:
+	    - Keytouch IEC 60945
 
 config HID_KYE
 	tristate "KYE/Genius devices"
 	depends on HID
 	help
-	Support for KYE/Genius devices not fully compliant with HID standard:
-	- Ergo Mouse
-	- EasyPen i405X tablet
-	- MousePen i608X tablet
-	- EasyPen M610X tablet
+	  Support for KYE/Genius devices not fully compliant with HID standard:
+	  - Ergo Mouse
+	  - EasyPen i405X tablet
+	  - MousePen i608X tablet
+	  - EasyPen M610X tablet
 
 config HID_UCLOGIC
 	tristate "UC-Logic"
 	depends on USB_HID
 	help
-	Support for UC-Logic and Huion tablets.
+	  Support for UC-Logic and Huion tablets.
 
 config HID_WALTOP
 	tristate "Waltop"
 	depends on HID
 	help
-	Support for Waltop tablets.
+	  Support for Waltop tablets.
 
 config HID_VIEWSONIC
 	tristate "ViewSonic/Signotec"
@@ -460,68 +465,69 @@ config HID_GYRATION
 	tristate "Gyration remote control"
 	depends on HID
 	help
-	Support for Gyration remote control.
+	  Support for Gyration remote control.
 
 config HID_ICADE
 	tristate "ION iCade arcade controller"
 	depends on HID
 	help
-	Support for the ION iCade arcade controller to work as a joystick.
+	  Support for the ION iCade arcade controller to work as a joystick.
 
-	To compile this driver as a module, choose M here: the
-	module will be called hid-icade.
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-icade.
 
 config HID_ITE
 	tristate "ITE devices"
 	depends on HID
 	default !EXPERT
 	help
-	Support for ITE devices not fully compliant with HID standard.
+	  Support for ITE devices not fully compliant with HID standard.
 
 config HID_JABRA
 	tristate "Jabra USB HID Driver"
 	depends on HID
 	help
-	Support for Jabra USB HID devices.
+	  Support for Jabra USB HID devices.
+
+	  Prevents mapping of vendor defined HID usages to input events.
+	  Without this driver HID reports from Jabra devices may incorrectly
+	  be seen as mouse button events.
 
-	Prevents mapping of vendor defined HID usages to input events. Without
-	this driver HID	reports from Jabra devices may incorrectly be seen as
-	mouse button events.
-	Say M here if you may ever plug in a Jabra USB device.
+	  Say M here if you may ever plug in a Jabra USB device.
 
 config HID_TWINHAN
 	tristate "Twinhan IR remote control"
 	depends on HID
 	help
-	Support for Twinhan IR remote control.
+	  Support for Twinhan IR remote control.
 
 config HID_KENSINGTON
 	tristate "Kensington Slimblade Trackball"
 	depends on HID
 	default !EXPERT
 	help
-	Support for Kensington Slimblade Trackball.
+	  Support for Kensington Slimblade Trackball.
 
 config HID_LCPOWER
 	tristate "LC-Power"
 	depends on HID
 	help
-	Support for LC-Power RC1000MCE RF remote control.
+	  Support for LC-Power RC1000MCE RF remote control.
 
 config HID_LED
 	tristate "Simple RGB LED support"
 	depends on HID
 	depends on LEDS_CLASS
 	help
-	Support for simple RGB LED devices. Currently supported are:
-	- Riso Kagaku Webmail Notifier
-	- Dream Cheeky Webmail Notifier and Friends Alert
-	- ThingM blink(1)
-	- Delcom Visual Signal Indicator Generation 2
-	- Greynut Luxafor
+	  Support for simple RGB LED devices. Currently supported are:
+	  - Riso Kagaku Webmail Notifier
+	  - Dream Cheeky Webmail Notifier and Friends Alert
+	  - ThingM blink(1)
+	  - Delcom Visual Signal Indicator Generation 2
+	  - Greynut Luxafor
 
-	To compile this driver as a module, choose M here: the
-	module will be called hid-led.
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-led.
 
 config HID_LENOVO
 	tristate "Lenovo / Thinkpad devices"
@@ -529,15 +535,17 @@ config HID_LENOVO
 	select NEW_LEDS
 	select LEDS_CLASS
 	help
-	Support for IBM/Lenovo devices that are not fully compliant with HID standard.
+	  Support for IBM/Lenovo devices that are not fully compliant with
+	  HID standard.
 
-	Say Y if you want support for horizontal scrolling of the IBM/Lenovo
-	Scrollpoint mice or the non-compliant features of the Lenovo Thinkpad
-	standalone keyboards, e.g:
-	- ThinkPad USB Keyboard with TrackPoint (supports extra LEDs and trackpoint
-	  configuration)
-	- ThinkPad Compact Bluetooth Keyboard with TrackPoint (supports Fn keys)
-	- ThinkPad Compact USB Keyboard with TrackPoint (supports Fn keys)
+	  Say Y if you want support for horizontal scrolling of the IBM/Lenovo
+	  Scrollpoint mice or the non-compliant features of the Lenovo Thinkpad
+	  standalone keyboards, e.g:
+	  - ThinkPad USB Keyboard with TrackPoint
+	    (supports extra LEDs and trackpoint configuration)
+	  - ThinkPad Compact Bluetooth Keyboard with TrackPoint
+	    (supports Fn keys)
+	  - ThinkPad Compact USB Keyboard with TrackPoint (supports Fn keys)
 
 config HID_LOGITECH
 	tristate "Logitech devices"
@@ -545,7 +553,8 @@ config HID_LOGITECH
 	depends on LEDS_CLASS
 	default !EXPERT
 	help
-	Support for Logitech devices that are not fully compliant with HID standard.
+	  Support for Logitech devices that are not fully compliant with
+	  HID standard.
 
 config HID_LOGITECH_DJ
 	tristate "Logitech receivers full support"
@@ -554,23 +563,26 @@ config HID_LOGITECH_DJ
 	depends on HID_LOGITECH
 	select HID_LOGITECH_HIDPP
 	help
-	Say Y if you want support for Logitech receivers and devices.
-	Logitech receivers are capable of pairing multiple Logitech compliant
-	devices to the same receiver. Without this driver it will be handled by
-	generic USB_HID driver and all incoming events will be multiplexed
-	into a single mouse and a single keyboard device.
+	  Say Y if you want support for Logitech receivers and devices.
+	  Logitech receivers are capable of pairing multiple Logitech compliant
+	  devices to the same receiver.
+
+	  Without this driver it will be handled by generic USB_HID driver and
+	  all incoming events will be multiplexed into a single mouse and a
+	  single keyboard device.
 
 config HID_LOGITECH_HIDPP
 	tristate "Logitech HID++ devices support"
 	depends on HID_LOGITECH
 	select POWER_SUPPLY
 	help
-	Support for Logitech devices relyingon the HID++ Logitech specification
+	  Support for Logitech devices relying on the HID++ Logitech
+	  specification
 
-	Say Y if you want support for Logitech devices relying on the HID++
-	specification. Such devices are the various Logitech Touchpads (T650,
-	T651, TK820), some mice (Zone Touch mouse), or even keyboards (Solar
-	Keyboard).
+	  Say Y if you want support for Logitech devices relying on the HID++
+	  specification. Such devices are the various Logitech Touchpads (T650,
+	  T651, TK820), some mice (Zone Touch mouse), or even keyboards (Solar
+	  Keyboard).
 
 config LOGITECH_FF
 	bool "Logitech force feedback support"
@@ -583,8 +595,8 @@ config LOGITECH_FF
 	  - Logitech WingMan Force 3D
 
 	  and if you want to enable force feedback for them.
-	  Note: if you say N here, this device will still be supported, but without
-	  force feedback.
+	  Note: if you say N here, this device will still be supported,
+	  but without force feedback.
 
 config LOGIRUMBLEPAD2_FF
 	bool "Logitech force feedback support (variant 2)"
@@ -631,32 +643,32 @@ config HID_MAGICMOUSE
 	tristate "Apple Magic Mouse/Trackpad multi-touch support"
 	depends on HID
 	help
-	Support for the Apple Magic Mouse/Trackpad multi-touch.
+	  Support for the Apple Magic Mouse/Trackpad multi-touch.
 
-	Say Y here if you want support for the multi-touch features of the
-	Apple Wireless "Magic" Mouse and the Apple Wireless "Magic" Trackpad.
+	  Say Y here if you want support for the multi-touch features of the
+	  Apple Wireless "Magic" Mouse and the Apple Wireless "Magic" Trackpad.
 
 config HID_MALTRON
 	tristate "Maltron L90 keyboard"
 	depends on HID
 	help
-	Adds support for the volume up, volume down, mute, and play/pause buttons
-	of the Maltron L90 keyboard.
+	  Adds support for the volume up, volume down, mute, and play/pause
+	  buttons of the Maltron L90 keyboard.
 
 config HID_MAYFLASH
 	tristate "Mayflash game controller adapter force feedback"
 	depends on HID
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have HJZ Mayflash PS3 game controller adapters
-	and want to enable force feedback support.
+	  Say Y here if you have HJZ Mayflash PS3 game controller adapters
+	  and want to enable force feedback support.
 
 config HID_REDRAGON
 	tristate "Redragon keyboards"
 	depends on HID
 	default !EXPERT
 	help
-    Support for Redragon keyboards that need fix-ups to work properly.
+	  Support for Redragon keyboards that need fix-ups to work properly.
 
 config HID_MICROSOFT
 	tristate "Microsoft non-fully HID-compliant devices"
@@ -664,14 +676,15 @@ config HID_MICROSOFT
 	default !EXPERT
 	select INPUT_FF_MEMLESS
 	help
-	Support for Microsoft devices that are not fully compliant with HID standard.
+	  Support for Microsoft devices that are not fully compliant with the
+	  HID standard.
 
 config HID_MONTEREY
 	tristate "Monterey Genius KB29E keyboard"
 	depends on HID
 	default !EXPERT
 	help
-	Support for Monterey Genius KB29E.
+	  Support for Monterey Genius KB29E.
 
 config HID_MULTITOUCH
 	tristate "HID Multitouch panels"
@@ -722,27 +735,28 @@ config HID_MULTITOUCH
 config HID_NTI
 	tristate "NTI keyboard adapters"
 	help
-	Support for the "extra" Sun keyboard keys on keyboards attached
-	through Network Technologies USB-SUN keyboard adapters.
+	  Support for the "extra" Sun keyboard keys on keyboards attached
+	  through Network Technologies USB-SUN keyboard adapters.
 
 config HID_NTRIG
 	tristate "N-Trig touch screen"
 	depends on USB_HID
 	help
-	Support for N-Trig touch screen.
+	  Support for N-Trig touch screen.
 
 config HID_ORTEK
 	tristate "Ortek PKB-1700/WKB-2000/Skycable wireless keyboard and mouse trackpad"
 	depends on HID
 	help
-	There are certain devices which have LogicalMaximum wrong in the keyboard
-	usage page of their report descriptor. The most prevailing ones so far
-	are manufactured by Ortek, thus the name of the driver. Currently
-	supported devices by this driver are
+	  There are certain devices which have LogicalMaximum wrong in the
+	  keyboard usage page of their report descriptor. The most prevailing
+	  ones so far are manufactured by Ortek, thus the name of the driver.
 
-	   - Ortek PKB-1700
-	   - Ortek WKB-2000
-	   - Skycable wireless presenter
+	  Currently supported devices by this driver are
+
+	  - Ortek PKB-1700
+	  - Ortek WKB-2000
+	  - Skycable wireless presenter
 
 config HID_PANTHERLORD
 	tristate "Pantherlord/GreenAsia game controller"
@@ -774,7 +788,7 @@ config HID_PETALYNX
 	tristate "Petalynx Maxter remote control"
 	depends on HID
 	help
-	Support for Petalynx Maxter remote control.
+	  Support for Petalynx Maxter remote control.
 
 config HID_PICOLCD
 	tristate "PicoLCD (graphic version)"
@@ -857,41 +871,41 @@ config HID_PRIMAX
 	tristate "Primax non-fully HID-compliant devices"
 	depends on HID
 	help
-	Support for Primax devices that are not fully compliant with the
-	HID standard.
+	  Support for Primax devices that are not fully compliant with the
+	  HID standard.
 
 config HID_RETRODE
 	tristate "Retrode 2 USB adapter for vintage video games"
 	depends on USB_HID
 	help
-	Support for
+	  Support for
 	  * Retrode 2 cartridge and controller adapter
 
 config HID_ROCCAT
 	tristate "Roccat device support"
 	depends on USB_HID
 	help
-	Support for Roccat devices.
-	Say Y here if you have a Roccat mouse or keyboard and want
-	support for its special functionalities.
+	  Support for Roccat devices.
+	  Say Y here if you have a Roccat mouse or keyboard and want
+	  support for its special functionalities.
 
 config HID_SAITEK
 	tristate "Saitek (Mad Catz) non-fully HID-compliant devices"
 	depends on HID
 	help
-	Support for Saitek devices that are not fully compliant with the
-	HID standard.
+	  Support for Saitek devices that are not fully compliant with the
+	  HID standard.
 
-	Supported devices:
-	- PS1000 Dual Analog Pad
-	- Saitek R.A.T.7, R.A.T.9, M.M.O.7 Gaming Mice
-	- Mad Catz R.A.T.5, R.A.T.9 Gaming Mice
+	  Supported devices:
+	  - PS1000 Dual Analog Pad
+	  - Saitek R.A.T.7, R.A.T.9, M.M.O.7 Gaming Mice
+	  - Mad Catz R.A.T.5, R.A.T.9 Gaming Mice
 
 config HID_SAMSUNG
 	tristate "Samsung InfraRed remote control or keyboards"
 	depends on HID
 	help
-	Support for Samsung InfraRed remote control or keyboards.
+	  Support for Samsung InfraRed remote control or keyboards.
 
 config HID_SONY
 	tristate "Sony PS2/3/4 accessories"
@@ -900,7 +914,7 @@ config HID_SONY
 	depends on LEDS_CLASS
 	select POWER_SUPPLY
 	help
-	Support for
+	  Support for
 
 	  * Sony PS3 6-axis controllers
 	  * Sony PS4 DualShock 4 controllers
@@ -914,35 +928,35 @@ config SONY_FF
 	depends on HID_SONY
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have a Sony PS2/3/4 accessory and want to enable
-	force feedback support for it.
+	  Say Y here if you have a Sony PS2/3/4 accessory and want to enable
+	  force feedback support for it.
 
 config HID_SPEEDLINK
 	tristate "Speedlink VAD Cezanne mouse support"
 	depends on HID
 	help
-	Support for Speedlink Vicious and Divine Cezanne mouse.
+	  Support for Speedlink Vicious and Divine Cezanne mouse.
 
 config HID_STEAM
 	tristate "Steam Controller support"
 	depends on HID
 	select POWER_SUPPLY
 	help
-	Say Y here if you have a Steam Controller if you want to use it
-	without running the Steam Client. It supports both the wired and
-	the wireless adaptor.
+	  Say Y here if you have a Steam Controller if you want to use it
+	  without running the Steam Client. It supports both the wired and
+	  the wireless adaptor.
 
 config HID_STEELSERIES
 	tristate "Steelseries SRW-S1 steering wheel support"
 	depends on HID
 	help
-	Support for Steelseries SRW-S1 steering wheel
+	  Support for Steelseries SRW-S1 steering wheel
 
 config HID_SUNPLUS
 	tristate "Sunplus wireless desktop"
 	depends on HID
 	help
-	Support for Sunplus wireless desktop.
+	  Support for Sunplus wireless desktop.
 
 config HID_RMI
 	tristate "Synaptics RMI4 device support"
@@ -953,9 +967,9 @@ config HID_RMI
 	select RMI4_F12
 	select RMI4_F30
 	help
-	Support for Synaptics RMI4 touchpads.
-	Say Y here if you have a Synaptics RMI4 touchpads over i2c-hid or usbhid
-	and want support for its special functionalities.
+	  Support for Synaptics RMI4 touchpads.
+	  Say Y here if you have a Synaptics RMI4 touchpads over i2c-hid or
+	  usbhid and want support for its special functionalities.
 
 config HID_GREENASIA
 	tristate "GreenAsia (Product ID 0x12) game controller support"
@@ -969,46 +983,46 @@ config GREENASIA_FF
 	depends on HID_GREENASIA
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have a GreenAsia (Product ID 0x12) based game controller
-	(like MANTA Warrior MM816 and SpeedLink Strike2 SL-6635) or adapter
-	and want to enable force feedback support for it.
+	  Say Y here if you have a GreenAsia (Product ID 0x12) based game
+	  controller (like MANTA Warrior MM816 or SpeedLink Strike2 SL-6635)
+	  or adapter and want to enable force feedback support for it.
 
 config HID_HYPERV_MOUSE
 	tristate "Microsoft Hyper-V mouse driver"
 	depends on HYPERV
 	help
-	Select this option to enable the Hyper-V mouse driver.
+	  Select this option to enable the Hyper-V mouse driver.
 
 config HID_SMARTJOYPLUS
 	tristate "SmartJoy PLUS PS2/USB adapter support"
 	depends on HID
 	help
-	Support for SmartJoy PLUS PS2/USB adapter, Super Dual Box,
-	Super Joy Box 3 Pro, Super Dual Box Pro, and Super Joy Box 5 Pro.
+	  Support for SmartJoy PLUS PS2/USB adapter, Super Dual Box,
+	  Super Joy Box 3 Pro, Super Dual Box Pro, and Super Joy Box 5 Pro.
 
-	Note that DDR (Dance Dance Revolution) mode is not supported, nor
-	is pressure sensitive buttons on the pro models.
+	  Note that DDR (Dance Dance Revolution) mode is not supported, nor
+	  is pressure sensitive buttons on the pro models.
 
 config SMARTJOYPLUS_FF
 	bool "SmartJoy PLUS PS2/USB adapter force feedback support"
 	depends on HID_SMARTJOYPLUS
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have a SmartJoy PLUS PS2/USB adapter and want to
-	enable force feedback support for it.
+	  Say Y here if you have a SmartJoy PLUS PS2/USB adapter and want to
+	  enable force feedback support for it.
 
 config HID_TIVO
 	tristate "TiVo Slide Bluetooth remote control support"
 	depends on HID
 	help
-	Say Y if you have a TiVo Slide Bluetooth remote control.
+	  Say Y if you have a TiVo Slide Bluetooth remote control.
 
 config HID_TOPSEED
 	tristate "TopSeed Cyberlink, BTC Emprex, Conceptronic remote control support"
 	depends on HID
 	help
-	Say Y if you have a TopSeed Cyberlink or BTC Emprex or Conceptronic
-	CLLRCMCE remote control.
+	  Say Y if you have a TopSeed Cyberlink or BTC Emprex or Conceptronic
+	  CLLRCMCE remote control.
 
 config HID_THINGM
 	tristate "ThingM blink(1) USB RGB LED"
@@ -1016,9 +1030,9 @@ config HID_THINGM
 	depends on LEDS_CLASS
 	select HID_LED
 	help
-	Support for the ThingM blink(1) USB RGB LED. This driver has been
-	merged into the generic hid led driver. Config symbol HID_THINGM
-	just selects HID_LED and will be removed soon.
+	  Support for the ThingM blink(1) USB RGB LED. This driver has been
+	  merged into the generic hid led driver. Config symbol HID_THINGM
+	  just selects HID_LED and will be removed soon.
 
 config HID_THRUSTMASTER
 	tristate "ThrustMaster devices support"
@@ -1080,31 +1094,32 @@ config HID_WIIMOTE
 	select POWER_SUPPLY
 	select INPUT_FF_MEMLESS
 	help
-	Support for Nintendo Wii and Wii U Bluetooth peripherals. Supported
-	devices are the Wii Remote and its extension devices, but also devices
-	based on the Wii Remote like the Wii U Pro Controller or the
-	Wii Balance Board.
+	  Support for Nintendo Wii and Wii U Bluetooth peripherals. Supported
+	  devices are the Wii Remote and its extension devices, but also devices
+	  based on the Wii Remote like the Wii U Pro Controller or the
+	  Wii Balance Board.
 
-	Support for all official Nintendo extensions is available, however, 3rd
-	party extensions might not be supported. Please report these devices to:
+	  Support for all official Nintendo extensions is available, however,
+	  3rd party extensions might not be supported.
+	  Please report these devices to:
 	  http://github.com/dvdhrm/xwiimote/issues
 
-	Other Nintendo Wii U peripherals that are IEEE 802.11 based (including
-	the Wii U Gamepad) might be supported in the future. But currently
-	support is limited to Bluetooth based devices.
+	  Other Nintendo Wii U peripherals that are IEEE 802.11 based (including
+	  the Wii U Gamepad) might be supported in the future. But currently
+	  support is limited to Bluetooth based devices.
 
-	If unsure, say N.
+	  If unsure, say N.
 
-	To compile this driver as a module, choose M here: the
-	module will be called hid-wiimote.
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-wiimote.
 
 config HID_XINMO
 	tristate "Xin-Mo non-fully compliant devices"
 	depends on HID
 	help
-	Support for Xin-Mo devices that are not fully compliant with the HID
-	standard. Currently only supports the Xin-Mo Dual Arcade. Say Y here
-	if you have a Xin-Mo Dual Arcade controller.
+	  Support for Xin-Mo devices that are not fully compliant with the HID
+	  standard. Currently only supports the Xin-Mo Dual Arcade. Say Y here
+	  if you have a Xin-Mo Dual Arcade controller.
 
 config HID_ZEROPLUS
 	tristate "Zeroplus based game controller support"
@@ -1124,7 +1139,7 @@ config HID_ZYDACRON
 	tristate "Zydacron remote control support"
 	depends on HID
 	help
-	Support for Zydacron remote control.
+	  Support for Zydacron remote control.
 
 config HID_SENSOR_HUB
 	tristate "HID Sensors framework support"
@@ -1159,20 +1174,20 @@ config HID_ALPS
 	tristate "Alps HID device support"
 	depends on HID
 	help
-	Support for Alps I2C HID touchpads and StickPointer.
-	Say Y here if you have a Alps touchpads over i2c-hid or usbhid
-	and want support for its special functionalities.
+	  Support for Alps I2C HID touchpads and StickPointer.
+	  Say Y here if you have a Alps touchpads over i2c-hid or usbhid
+	  and want support for its special functionalities.
 
 config HID_MCP2221
 	tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
 	depends on USB_HID && I2C
 	depends on GPIOLIB
 	help
-	Provides I2C and SMBUS host adapter functionality over USB-HID
-	through MCP2221 device.
+	  Provides I2C and SMBUS host adapter functionality over USB-HID
+	  through MCP2221 device.
 
-	To compile this driver as a module, choose M here: the module
-	will be called hid-mcp2221.ko.
+	  To compile this driver as a module, choose M here: the module
+	  will be called hid-mcp2221.ko.
 
 endmenu
 

