Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A505B2C6CFF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 22:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbgK0Vsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 16:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54431 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728726AbgK0VoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 16:44:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606513420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WFeBx23kEAl+eNuj6DIkR9Ky2f4Tq/9VhDEIduXZYzs=;
        b=gBbWZs64sVNhvb+4f2bF6W2QZsJH9jUj13lfBoilKhnvzF0O79XrD1ps2Cx08+S94CwhQR
        XJeHym1GAUkBg3QxyoLz0z089L1EIDsy19SrPnTliZReLpy+ji48Vr6Rbjijmkw0yQuWV7
        RGeu1sYcrRswMMUg2EA+0nkfXY6Bw4w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-nx5msN28PPeozk4bhQ2_TQ-1; Fri, 27 Nov 2020 16:43:25 -0500
X-MC-Unique: nx5msN28PPeozk4bhQ2_TQ-1
Received: by mail-qv1-f70.google.com with SMTP id s8so3707249qvr.20
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 13:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WFeBx23kEAl+eNuj6DIkR9Ky2f4Tq/9VhDEIduXZYzs=;
        b=ge+7Ssjx6Xr1i1jt0apo4K6Ulono22BIds4lgfGe4MKnPAy53qYH3UEfCZcH8YM2X+
         iMq2nSXgei5pjy4QIzd15xrd+OMSmA3LnR7l4Ads3Lw+16KG9ODUdKP/69D+WZFs5oDw
         ak0bhDNf4tO0xwTW8soYxZSawoQhxBxHrFZpmbsfq2WjrTO0AgV3Qti/gjM2YzoK6tBR
         /NfYMHOQamKIGavL4f/O+gKBr2V9KcoGEw1FRej7//D3WtSQ4Yt6uqjuxbJAslKbd0iP
         hPtA9LW5+gb9A+/ZwUua9NQTMGtqXvskKUmeCa0J3GkUI3z3yQL9hbDtPSQ1/V0gO6pe
         Wokg==
X-Gm-Message-State: AOAM532yHpDiCI8LGfgmoKeRGoaPbkw2PdsugoCwbfyLGB7KbbiM0o5Z
        KBK312byeIXWzIHcDCqfG6ijGcDPTEOJ+TJNuszrLP1V3d0LniASrp7qI9+jVWFXXjti98IPQ1O
        0J24SqIuJ403dfrPWSJqqAhcG
X-Received: by 2002:ac8:594f:: with SMTP id 15mr10122260qtz.347.1606513403869;
        Fri, 27 Nov 2020 13:43:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeu2K3L2LVwem4QP/oNwKyRAZgmKorXVrmV/UxmOxqlqfz6bx2ufG/SS9oEKRIcgSUUBwPTw==
X-Received: by 2002:ac8:594f:: with SMTP id 15mr10122220qtz.347.1606513403152;
        Fri, 27 Nov 2020 13:43:23 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w65sm7128057qtd.94.2020.11.27.13.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 13:43:22 -0800 (PST)
From:   trix@redhat.com
To:     apw@canonical.com, joe@perches.com, nickhu@andestech.com,
        green.hu@gmail.com, deanbo422@gmail.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] MAINTAINERS add D: tag for subsystem commit prefix
Date:   Fri, 27 Nov 2020 13:43:16 -0800
Message-Id: <20201127214316.3045640-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

From
RFC MAINTAINERS tag for cleanup robot
https://lkml.org/lkml/2020/11/21/190

The prefix used by subsystems in their commit log is arbitrary.
To elimitate the time and effort to manually find a reasonable
prefix, store the preferred prefix in the MAINTAINERS file.

Populate with reasonable prefixes using this algorithm.
What did the maintainers use in their commits?
If there were no maintainers commits then what did everyone
else use in their commits.

The results were manually reviewed and about 25% were rejected.

Add 'D' tag to checkpatch.pl

Use 'D' tag by adding --subsystem_commit_prefix option
get_maintainer.pl

Signed-off-by: Tom Rix <trix@redhat.com>
---
 MAINTAINERS               | 200 ++++++++++++++++++++++++++++++++++++++
 scripts/checkpatch.pl     |   2 +-
 scripts/get_maintainer.pl |  19 +++-
 3 files changed, 217 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f2048b51dd3..bb765ef98493 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -135,6 +135,7 @@ Descriptions of section entries and preferred order
 	      matches patches or files that contain one or more of the words
 	      printk, pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
+	D: Subsystem commit prefix
 
 Maintainers List
 ----------------
@@ -149,6 +150,7 @@ L:	netdev@vger.kernel.org
 S:	Odd Fixes
 F:	Documentation/networking/device_drivers/ethernet/3com/vortex.rst
 F:	drivers/net/ethernet/3com/3c59x.c
+D:	3c59x:
 
 3CR990 NETWORK DRIVER
 M:	David Dillow <dave@thedillows.org>
@@ -162,6 +164,7 @@ L:	linux-scsi@vger.kernel.org
 S:	Supported
 W:	http://www.lsi.com
 F:	drivers/scsi/3w-*
+D:	[SCSI] 3w-9xxx:
 
 53C700 AND 53C700-66 SCSI DRIVER
 M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
@@ -178,12 +181,14 @@ S:	Maintained
 F:	Documentation/networking/6lowpan.rst
 F:	include/net/6lowpan.h
 F:	net/6lowpan/
+D:	6lowpan:
 
 6PACK NETWORK DRIVER FOR AX.25
 M:	Andreas Koensgen <ajk@comnets.uni-bremen.de>
 L:	linux-hams@vger.kernel.org
 S:	Maintained
 F:	drivers/net/hamradio/6pack.c
+D:	6pack:
 
 802.11 (including CFG80211/NL80211)
 M:	Johannes Berg <johannes@sipsolutions.net>
@@ -208,6 +213,7 @@ M:	Heiner Kallweit <hkallweit1@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/realtek/r8169*
+D:	r8169:
 
 8250/16?50 (AND CLONE UARTS) SERIAL DRIVER
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
@@ -216,11 +222,13 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
 F:	drivers/tty/serial/8250*
 F:	include/linux/serial_8250.h
+D:	tty:
 
 8390 NETWORK DRIVERS [WD80x3/SMC-ELITE, SMC-ULTRA, NE2000, 3C503, etc.]
 L:	netdev@vger.kernel.org
 S:	Orphan / Obsolete
 F:	drivers/net/ethernet/8390/
+D:	drivers/net:
 
 9P FILE SYSTEM
 M:	Eric Van Hensbergen <ericvh@gmail.com>
@@ -238,6 +246,7 @@ F:	include/net/9p/
 F:	include/trace/events/9p.h
 F:	include/uapi/linux/virtio_9p.h
 F:	net/9p/
+D:	9p:
 
 A8293 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
@@ -248,6 +257,7 @@ W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/a8293*
+D:	[media] a8293:
 
 AACRAID SCSI RAID DRIVER
 M:	Adaptec OEM Raid Solutions <aacraid@microsemi.com>
@@ -256,6 +266,7 @@ S:	Supported
 W:	http://www.adaptec.com/
 F:	Documentation/scsi/aacraid.rst
 F:	drivers/scsi/aacraid/
+D:	scsi: aacraid:
 
 ABI/API
 L:	linux-api@vger.kernel.org
@@ -267,30 +278,35 @@ M:	Hans de Goede <hdegoede@redhat.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/abituguru.c
+D:	hwmon:
 
 ABIT UGURU 3 HARDWARE MONITOR DRIVER
 M:	Alistair John Strachan <alistair@devzero.co.uk>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/abituguru3.c
+D:	hwmon:
 
 ACCES 104-DIO-48E GPIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-dio-48e.c
+D:	gpio: 104-dio-48e:
 
 ACCES 104-IDI-48 GPIO DRIVER
 M:	"William Breathitt Gray" <vilhelm.gray@gmail.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-idi-48.c
+D:	gpio: 104-idi-48:
 
 ACCES 104-IDIO-16 GPIO DRIVER
 M:	"William Breathitt Gray" <vilhelm.gray@gmail.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-104-idio-16.c
+D:	gpio: 104-idio-16:
 
 ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
@@ -300,18 +316,21 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 F:	drivers/counter/104-quad-8.c
+D:	counter: 104-quad-8:
 
 ACCES PCI-IDIO-16 GPIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-pci-idio-16.c
+D:	gpio: pci-idio-16:
 
 ACCES PCIe-IDIO-24 GPIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-pcie-idio-24.c
+D:	gpio: pcie-idio-24:
 
 ACENIC DRIVER
 M:	Jes Sorensen <jes@trained-monkey.org>
@@ -325,12 +344,14 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 W:	http://piie.net/?section=acerhdf
 F:	drivers/platform/x86/acerhdf.c
+D:	acerhdf:
 
 ACER WMI LAPTOP EXTRAS
 M:	"Lee, Chun-Yi" <jlee@suse.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/acer-wmi.c
+D:	acer-wmi:
 
 ACPI
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
@@ -352,6 +373,7 @@ F:	include/acpi/
 F:	include/linux/acpi.h
 F:	include/linux/fwnode.h
 F:	tools/power/acpi/
+D:	ACPI:
 
 ACPI APEI
 M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
@@ -361,6 +383,7 @@ R:	Tony Luck <tony.luck@intel.com>
 R:	Borislav Petkov <bp@alien8.de>
 L:	linux-acpi@vger.kernel.org
 F:	drivers/acpi/apei/
+D:	ACPI / APEI:
 
 ACPI COMPONENT ARCHITECTURE (ACPICA)
 M:	Robert Moore <robert.moore@intel.com>
@@ -378,6 +401,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 F:	drivers/acpi/acpica/
 F:	include/acpi/
 F:	tools/power/acpi/
+D:	ACPICA:
 
 ACPI FAN DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
@@ -386,6 +410,7 @@ S:	Supported
 W:	https://01.org/linux-acpi
 B:	https://bugzilla.kernel.org
 F:	drivers/acpi/fan.c
+D:	ACPI fan:
 
 ACPI FOR ARM64 (ACPI/arm64)
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
@@ -395,6 +420,7 @@ L:	linux-acpi@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/acpi/arm64
+D:	ACPI/IORT:
 
 ACPI I2C MULTI INSTANTIATE DRIVER
 M:	Hans de Goede <hdegoede@redhat.com>
@@ -413,6 +439,7 @@ Q:	https://patchwork.kernel.org/project/linux-acpi/list/
 B:	https://bugzilla.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
 F:	drivers/acpi/pmic/
+D:	ACPI / PMIC:
 
 ACPI THERMAL DRIVER
 M:	Zhang Rui <rui.zhang@intel.com>
@@ -429,12 +456,14 @@ S:	Supported
 W:	https://01.org/linux-acpi
 B:	https://bugzilla.kernel.org
 F:	drivers/acpi/acpi_video.c
+D:	ACPI / video:
 
 ACPI WMI DRIVER
 L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
 F:	drivers/platform/x86/wmi.c
 F:	include/uapi/linux/wmi.h
+D:	platform/x86: wmi:
 
 AD1889 ALSA SOUND DRIVER
 L:	linux-parisc@vger.kernel.org
@@ -448,6 +477,7 @@ S:	Supported
 W:	http://wiki.analog.com/AD5254
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/misc/ad525x_dpot.c
+D:	ad525x_dpot:
 
 AD5398 CURRENT REGULATOR DRIVER (AD5398/AD5821)
 M:	Michael Hennerich <michael.hennerich@analog.com>
@@ -455,6 +485,7 @@ S:	Supported
 W:	http://wiki.analog.com/AD5398
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/regulator/ad5398.c
+D:	regulator: ad5398:
 
 AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
 M:	Michael Hennerich <michael.hennerich@analog.com>
@@ -462,6 +493,7 @@ S:	Supported
 W:	http://wiki.analog.com/AD7142
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/input/misc/ad714x.c
+D:	Input:
 
 AD7877 TOUCHSCREEN DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
@@ -469,6 +501,7 @@ S:	Supported
 W:	http://wiki.analog.com/AD7877
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/input/touchscreen/ad7877.c
+D:	Input:
 
 AD7879 TOUCHSCREEN DRIVER (AD7879/AD7889)
 M:	Michael Hennerich <michael.hennerich@analog.com>
@@ -476,6 +509,7 @@ S:	Supported
 W:	http://wiki.analog.com/AD7879
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/input/touchscreen/ad7879.c
+D:	Input:
 
 ADDRESS SPACE LAYOUT RANDOMIZATION (ASLR)
 M:	Jiri Kosina <jikos@kernel.org>
@@ -489,6 +523,7 @@ W:	https://wiki.analog.com/ADF7242
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/net/ieee802154/adf7242.txt
 F:	drivers/net/ieee802154/adf7242.c
+D:	net: ieee802154: adf7242:
 
 ADM1025 HARDWARE MONITOR DRIVER
 M:	Jean Delvare <jdelvare@suse.com>
@@ -496,18 +531,21 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/adm1025.rst
 F:	drivers/hwmon/adm1025.c
+D:	hwmon:
 
 ADM1029 HARDWARE MONITOR DRIVER
 M:	Corentin Labbe <clabbe.montjoie@gmail.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/adm1029.c
+D:	hwmon:
 
 ADM8211 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 S:	Orphan
 W:	https://wireless.wiki.kernel.org/
 F:	drivers/net/wireless/admtek/adm8211.*
+D:	adm80211:
 
 ADP1653 FLASH CONTROLLER DRIVER
 M:	Sakari Ailus <sakari.ailus@iki.fi>
@@ -526,6 +564,7 @@ F:	drivers/input/keyboard/adp5520-keys.c
 F:	drivers/leds/leds-adp5520.c
 F:	drivers/mfd/adp5520.c
 F:	drivers/video/backlight/adp5520_bl.c
+D:	backlight:
 
 ADP5588 QWERTY KEYPAD AND IO EXPANDER DRIVER (ADP5588/ADP5587)
 M:	Michael Hennerich <michael.hennerich@analog.com>
@@ -534,6 +573,7 @@ W:	http://wiki.analog.com/ADP5588
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/gpio/gpio-adp5588.c
 F:	drivers/input/keyboard/adp5588-keys.c
+D:	Input:
 
 ADP8860 BACKLIGHT DRIVER (ADP8860/ADP8861/ADP8863)
 M:	Michael Hennerich <michael.hennerich@analog.com>
@@ -553,6 +593,7 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/adt7475.rst
 F:	drivers/hwmon/adt7475.c
+D:	hwmon:
 
 ADVANSYS SCSI DRIVER
 M:	Matthew Wilcox <willy@infradead.org>
@@ -561,6 +602,7 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	Documentation/scsi/advansys.rst
 F:	drivers/scsi/advansys.c
+D:	[SCSI] advansys:
 
 ADXL34X THREE-AXIS DIGITAL ACCELEROMETER DRIVER (ADXL345/ADXL346)
 M:	Michael Hennerich <michael.hennerich@analog.com>
@@ -569,6 +611,7 @@ W:	http://wiki.analog.com/ADXL345
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl345.yaml
 F:	drivers/input/misc/adxl34x.c
+D:	Input:
 
 ADXL372 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
@@ -578,6 +621,7 @@ F:	Documentation/devicetree/bindings/iio/accel/adi,adxl372.yaml
 F:	drivers/iio/accel/adxl372.c
 F:	drivers/iio/accel/adxl372_i2c.c
 F:	drivers/iio/accel/adxl372_spi.c
+D:	iio: adxl372:
 
 AF9013 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
@@ -588,6 +632,7 @@ W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/af9013*
+D:	[media] af9013:
 
 AF9033 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
@@ -598,6 +643,7 @@ W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/dvb-frontends/af9033*
+D:	[media] af9033:
 
 AFFS FILE SYSTEM
 M:	David Sterba <dsterba@suse.com>
@@ -605,6 +651,7 @@ L:	linux-fsdevel@vger.kernel.org
 S:	Odd Fixes
 F:	Documentation/filesystems/affs.rst
 F:	fs/affs/
+D:	fs/affs:
 
 AFS FILESYSTEM
 M:	David Howells <dhowells@redhat.com>
@@ -614,6 +661,7 @@ W:	https://www.infradead.org/~dhowells/kafs/
 F:	Documentation/filesystems/afs.rst
 F:	fs/afs/
 F:	include/trace/events/afs.h
+D:	afs:
 
 AGPGART DRIVER
 M:	David Airlie <airlied@linux.ie>
@@ -635,6 +683,7 @@ M:	Hannes Reinecke <hare@suse.com>
 L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/scsi/aic7xxx/
+D:	scsi: aic7xxx:
 
 AIMSLAB FM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
@@ -650,6 +699,7 @@ L:	linux-aio@kvack.org
 S:	Supported
 F:	fs/aio.c
 F:	include/linux/*aio*.h
+D:	aio:
 
 AIRSPY MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
@@ -660,6 +710,7 @@ W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/anttip/media_tree.git
 F:	drivers/media/usb/airspy/
+D:	[media] airspy:
 
 ALACRITECH GIGABIT ETHERNET DRIVER
 M:	Lino Sanfilippo <LinoSanfilippo@gmx.de>
@@ -693,6 +744,7 @@ S:	Maintained
 W:	http://www.allsensors.com/
 F:	Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
 F:	drivers/iio/pressure/dlhl60d.c
+D:	iio: pressure:
 
 ALLEGRO DVT VIDEO IP CORE DRIVER
 M:	Michael Tretter <m.tretter@pengutronix.de>
@@ -700,6 +752,7 @@ R:	Pengutronix Kernel Team <kernel@pengutronix.de>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/media/allegro-dvt/
+D:	media: allegro:
 
 ALLWINNER A10 CSI DRIVER
 M:	Maxime Ripard <mripard@kernel.org>
@@ -715,12 +768,14 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
 F:	drivers/cpufreq/sun50i-cpufreq-nvmem.c
+D:	cpufreq:
 
 ALLWINNER CRYPTO DRIVERS
 M:	Corentin Labbe <clabbe.montjoie@gmail.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	drivers/crypto/allwinner/
+D:	crypto:
 
 ALLWINNER THERMAL DRIVER
 M:	Vasily Khoruzhick <anarsoul@gmail.com>
@@ -729,6 +784,7 @@ L:	linux-pm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/allwinner,sun8i-a83t-ths.yaml
 F:	drivers/thermal/sun8i_thermal.c
+D:	thermal: sun8i:
 
 ALLWINNER VPU DRIVER
 M:	Maxime Ripard <mripard@kernel.org>
@@ -736,6 +792,7 @@ M:	Paul Kocialkowski <paul.kocialkowski@bootlin.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/media/sunxi/cedrus/
+D:	media: cedrus:
 
 ALPHA PORT
 M:	Richard Henderson <rth@twiddle.net>
@@ -744,33 +801,39 @@ M:	Matt Turner <mattst88@gmail.com>
 L:	linux-alpha@vger.kernel.org
 S:	Odd Fixes
 F:	arch/alpha/
+D:	alpha:
 
 ALPS PS/2 TOUCHPAD DRIVER
 R:	Pali Rohár <pali@kernel.org>
 F:	drivers/input/mouse/alps.*
+D:	Input:
 
 ALTERA I2C CONTROLLER DRIVER
 M:	Thor Thayer <thor.thayer@linux.intel.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-altera.txt
 F:	drivers/i2c/busses/i2c-altera.c
+D:	i2c: altera:
 
 ALTERA MAILBOX DRIVER
 M:	Ley Foon Tan <ley.foon.tan@intel.com>
 S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
+D:	mailbox:
 
 ALTERA PIO DRIVER
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-altera.c
+D:	gpio: altera:
 
 ALTERA SYSTEM MANAGER DRIVER
 M:	Thor Thayer <thor.thayer@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/altera-sysmgr.c
 F:	include/linux/mfd/altera-sysmgr.h
+D:	mfd: altera-sysmgr:
 
 ALTERA SYSTEM RESOURCE DRIVER FOR ARRIA10 DEVKIT
 M:	Thor Thayer <thor.thayer@linux.intel.com>
@@ -780,12 +843,14 @@ F:	drivers/mfd/altera-a10sr.c
 F:	drivers/reset/reset-a10sr.c
 F:	include/dt-bindings/reset/altr,rst-mgr-a10sr.h
 F:	include/linux/mfd/altera-a10sr.h
+D:	reset:
 
 ALTERA TRIPLE SPEED ETHERNET DRIVER
 M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/altera/
+D:	Altera TSE:
 
 ALTERA UART/JTAG UART SERIAL DRIVERS
 M:	Tobias Klauser <tklauser@distanz.ch>
@@ -795,12 +860,14 @@ F:	drivers/tty/serial/altera_jtaguart.c
 F:	drivers/tty/serial/altera_uart.c
 F:	include/linux/altera_jtaguart.h
 F:	include/linux/altera_uart.h
+D:	tty: serial: altera_uart:
 
 AMAZON ANNAPURNA LABS FIC DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/amazon,al-fic.txt
 F:	drivers/irqchip/irq-al-fic.c
+D:	irqchip/al-fic:
 
 AMAZON ANNAPURNA LABS MEMORY CONTROLLER EDAC
 M:	Talel Shenhar <talel@amazon.com>
@@ -808,12 +875,14 @@ M:	Talel Shenhar <talelshenhar@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
 F:	drivers/edac/al_mc_edac.c
+D:	EDAC/al-mc-edac:
 
 AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
 M:	Talel Shenhar <talel@amazon.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
 F:	drivers/thermal/thermal_mmio.c
+D:	thermal:
 
 AMAZON ETHERNET DRIVERS
 M:	Netanel Belgazal <netanel@amazon.com>
@@ -825,6 +894,7 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	Documentation/networking/device_drivers/ethernet/amazon/ena.rst
 F:	drivers/net/ethernet/amazon/
+D:	net: ena:
 
 AMAZON RDMA EFA DRIVER
 M:	Gal Pressman <galpress@amazon.com>
@@ -834,6 +904,7 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-rdma/list/
 F:	drivers/infiniband/hw/efa/
 F:	include/uapi/rdma/efa-abi.h
+D:	RDMA/efa:
 
 AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
@@ -842,6 +913,7 @@ L:	linux-crypto@vger.kernel.org
 S:	Supported
 F:	drivers/crypto/ccp/
 F:	include/linux/ccp.h
+D:	crypto:
 
 AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER - SEV SUPPORT
 M:	Brijesh Singh <brijesh.singh@amd.com>
@@ -858,6 +930,7 @@ L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 T:	git git://people.freedesktop.org/~agd5f/linux
 F:	drivers/gpu/drm/amd/display/
+D:	drm/amd/display:
 
 AMD ENERGY DRIVER
 M:	Naveen Krishna Chatradhi <nchatrad@amd.com>
@@ -865,6 +938,7 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/amd_energy.rst
 F:	drivers/hwmon/amd_energy.c
+D:	hwmon:
 
 AMD FAM15H PROCESSOR POWER MONITORING DRIVER
 M:	Huang Rui <ray.huang@amd.com>
@@ -872,6 +946,7 @@ L:	linux-hwmon@vger.kernel.org
 S:	Supported
 F:	Documentation/hwmon/fam15h_power.rst
 F:	drivers/hwmon/fam15h_power.c
+D:	hwmon:
 
 AMD FCH GPIO DRIVER
 M:	Enrico Weigelt, metux IT consult <info@metux.net>
@@ -879,11 +954,13 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	drivers/gpio/gpio-amd-fch.c
 F:	include/linux/platform_data/gpio/gpio-amd-fch.h
+D:	gpio: amd:
 
 AMD GEODE CS5536 USB DEVICE CONTROLLER DRIVER
 L:	linux-geode@lists.infradead.org (moderated for non-subscribers)
 S:	Orphan
 F:	drivers/usb/gadget/udc/amd5536udc.*
+D:	usb: gadget: amd5536udc:
 
 AMD GEODE PROCESSOR/CHIPSET SUPPORT
 M:	Andres Salomon <dilinger@queued.net>
@@ -894,6 +971,7 @@ F:	arch/x86/include/asm/geode.h
 F:	drivers/char/hw_random/geode-rng.c
 F:	drivers/crypto/geode*
 F:	drivers/video/fbdev/geode/
+D:	crypto:
 
 AMD IOMMU (AMD-VI)
 M:	Joerg Roedel <joro@8bytes.org>
@@ -902,6 +980,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
 F:	drivers/iommu/amd/
 F:	include/linux/amd-iommu.h
+D:	iommu/amd:
 
 AMD KFD
 M:	Felix Kuehling <Felix.Kuehling@amd.com>
@@ -915,11 +994,13 @@ F:	drivers/gpu/drm/amd/include/kgd_kfd_interface.h
 F:	drivers/gpu/drm/amd/include/v9_structs.h
 F:	drivers/gpu/drm/amd/include/vi_structs.h
 F:	include/uapi/linux/kfd_ioctl.h
+D:	drm/amdkfd:
 
 AMD SPI DRIVER
 M:	Sanjay R Mehta <sanju.mehta@amd.com>
 S:	Maintained
 F:	drivers/spi/spi-amd.c
+D:	spi: spi-amd:
 
 AMD MP2 I2C DRIVER
 M:	Elie Morisse <syniurge@gmail.com>
@@ -934,6 +1015,7 @@ M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/amd-pmc.*
+D:	platform/x86: amd-pmc:
 
 AMD POWERPLAY
 M:	Evan Quan <evan.quan@amd.com>
@@ -941,6 +1023,7 @@ L:	amd-gfx@lists.freedesktop.org
 S:	Supported
 T:	git git://people.freedesktop.org/~agd5f/linux
 F:	drivers/gpu/drm/amd/pm/powerplay/
+D:	drm/amd/pm:
 
 AMD SEATTLE DEVICE TREE SUPPORT
 M:	Brijesh Singh <brijeshkumar.singh@amd.com>
@@ -948,6 +1031,7 @@ M:	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
 M:	Tom Lendacky <thomas.lendacky@amd.com>
 S:	Supported
 F:	arch/arm64/boot/dts/amd/
+D:	dtb: amd:
 
 AMD XGBE DRIVER
 M:	Tom Lendacky <thomas.lendacky@amd.com>
@@ -955,6 +1039,7 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
 F:	drivers/net/ethernet/amd/xgbe/
+D:	amd-xgbe:
 
 AMD SENSOR FUSION HUB DRIVER
 M:	Nehal Shah <nehal-bakulchandra.shah@amd.com>
@@ -963,6 +1048,7 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/hid/amd-sfh*
 F:	drivers/hid/amd-sfh-hid/
+D:	SFH:
 
 AMS AS73211 DRIVER
 M:	Christian Eggers <ceggers@arri.de>
@@ -970,6 +1056,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
 F:	drivers/iio/light/as73211.c
+D:	iio: light: as73211:
 
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alexandru Tachici <alexandru.tachici@analog.com>
@@ -1015,6 +1102,7 @@ M:	Mircea Caprioru <mircea.caprioru@analog.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/mux/adi,adgs1408.txt
 F:	drivers/mux/adgs1408.c
+D:	mux: adgs1408:
 
 ANALOG DEVICES INC ADIN DRIVER
 M:	Alexandru Ardelean <alexaundru.ardelean@analog.com>
@@ -1023,6 +1111,7 @@ S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/net/adi,adin.yaml
 F:	drivers/net/phy/adin.c
+D:	net: phy: adin:
 
 ANALOG DEVICES INC ADIS DRIVER LIBRARY
 M:	Alexandru Ardelean <alexandru.ardelean@analog.com>
@@ -1030,6 +1119,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/imu/adis.c
 F:	include/linux/iio/imu/adis.h
+D:	iio: imu: adis:
 
 ANALOG DEVICES INC ADIS16460 DRIVER
 M:	Dragos Bogdan <dragos.bogdan@analog.com>
@@ -1038,6 +1128,7 @@ S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 F:	drivers/iio/imu/adis16460.c
+D:	iio: imu: adis16460:
 
 ANALOG DEVICES INC ADIS16475 DRIVER
 M:	Nuno Sa <nuno.sa@analog.com>
@@ -1054,6 +1145,7 @@ S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 F:	drivers/hwmon/adm1177.c
+D:	hwmon:
 
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
@@ -1061,6 +1153,7 @@ L:	linux-pm@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/power/supply/adp5061.c
+D:	power: supply: adp5061:
 
 ANALOG DEVICES INC ADV7180 DRIVER
 M:	Lars-Peter Clausen <lars@metafoo.de>
@@ -1069,12 +1162,14 @@ S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/media/i2c/adv7180.c
 F:	Documentation/devicetree/bindings/media/i2c/adv7180.yaml
+D:	[media] adv7180:
 
 ANALOG DEVICES INC ADV748X DRIVER
 M:	Kieran Bingham <kieran.bingham@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/adv748x/*
+D:	media: i2c: adv748x:
 
 ANALOG DEVICES INC ADV7511 DRIVER
 M:	Hans Verkuil <hverkuil-cisco@xs4all.nl>
@@ -1101,6 +1196,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	drivers/iio/gyro/adxrs290.c
 F:	Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
+D:	iio: gyro: adxrs290:
 
 ANALOG DEVICES INC ASOC CODEC DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
@@ -1121,6 +1217,7 @@ M:	Lars-Peter Clausen <lars@metafoo.de>
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/dma/dma-axi-dmac.c
+D:	dmaengine: axi-dmac:
 
 ANALOG DEVICES INC IIO DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
@@ -1155,11 +1252,13 @@ F:	Documentation/devicetree/bindings/nds32/
 F:	arch/nds32/
 N:	nds32
 K:	nds32
+D:	nds32:
 
 ANDROID CONFIG FRAGMENTS
 M:	Rob Herring <robh@kernel.org>
 S:	Supported
 F:	kernel/configs/android*
+D:	config: android:
 
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
@@ -1181,12 +1280,14 @@ M:	Miodrag Dinic <miodrag.dinic@mips.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.txt
 F:	drivers/irqchip/irq-goldfish-pic.c
+D:	irqchip/irq-goldfish-pic:
 
 ANDROID GOLDFISH RTC DRIVER
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
 F:	drivers/rtc/rtc-goldfish.c
+D:	rtc: goldfish:
 
 AOA (Apple Onboard Audio) ALSA DRIVER
 M:	Johannes Berg <johannes@sipsolutions.net>
@@ -1194,12 +1295,14 @@ L:	linuxppc-dev@lists.ozlabs.org
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	sound/aoa/
+D:	[ALSA] aoa:
 
 APEX EMBEDDED SYSTEMS STX104 IIO DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/iio/adc/stx104.c
+D:	iio: stx104:
 
 APM DRIVER
 M:	Jiri Kosina <jikos@kernel.org>
@@ -1218,18 +1321,21 @@ W:	wiki.apparmor.net
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor
 F:	Documentation/admin-guide/LSM/apparmor.rst
 F:	security/apparmor/
+D:	apparmor:
 
 APPLE BCM5974 MULTITOUCH DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
 L:	linux-input@vger.kernel.org
 S:	Odd fixes
 F:	drivers/input/mouse/bcm5974.c
+D:	Input:
 
 APPLE SMC DRIVER
 M:	Henrik Rydberg <rydberg@bitmath.org>
 L:	linux-hwmon@vger.kernel.org
 S:	Odd fixes
 F:	drivers/hwmon/applesmc.c
+D:	hwmon: applesmc:
 
 APPLETALK NETWORK LAYER
 L:	netdev@vger.kernel.org
@@ -1243,12 +1349,14 @@ APPLIED MICRO (APM) X-GENE DEVICE TREE SUPPORT
 M:	Khuong Dinh <khuong@os.amperecomputing.com>
 S:	Supported
 F:	arch/arm64/boot/dts/apm/
+D:	arm64: dts:
 
 APPLIED MICRO (APM) X-GENE SOC EDAC
 M:	Khuong Dinh <khuong@os.amperecomputing.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/edac/apm-xgene-edac.txt
 F:	drivers/edac/xgene_edac.c
+D:	EDAC, xgene:
 
 APPLIED MICRO (APM) X-GENE SOC ETHERNET (V2) DRIVER
 M:	Iyappan Subramanian <iyappan@os.amperecomputing.com>
@@ -1272,6 +1380,7 @@ S:	Supported
 F:	Documentation/admin-guide/perf/xgene-pmu.rst
 F:	Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
 F:	drivers/perf/xgene_pmu.c
+D:	perf: xgene:
 
 APTINA CAMERA SENSOR PLL
 M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
@@ -1287,6 +1396,7 @@ W:	https://www.marvell.com/
 Q:	https://patchwork.kernel.org/project/netdevbpf/list/
 F:	Documentation/networking/device_drivers/ethernet/aquantia/atlantic.rst
 F:	drivers/net/ethernet/aquantia/atlantic/
+D:	net: atlantic:
 
 AQUANTIA ETHERNET DRIVER PTP SUBSYSTEM
 M:	Egor Pomozov <epomozov@marvell.com>
@@ -1294,6 +1404,7 @@ L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.aquantia.com
 F:	drivers/net/ethernet/aquantia/atlantic/aq_ptp*
+D:	net: aquantia:
 
 ARASAN NAND CONTROLLER DRIVER
 M:	Naga Sureshkumar Relli <nagasure@xilinx.com>
@@ -1307,12 +1418,14 @@ M:	Jaya Kumar <jayalk@intworks.biz>
 S:	Maintained
 F:	drivers/video/fbdev/arcfb.c
 F:	drivers/video/fbdev/core/fb_defio.c
+D:	video: fbdev: arcfb:
 
 ARC PGU DRM DRIVER
 M:	Alexey Brodkin <abrodkin@synopsys.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/display/snps,arcpgu.txt
 F:	drivers/gpu/drm/arc/
+D:	drm/arcpgu:
 
 ARCNET NETWORK LAYER
 M:	Michael Grzeschik <m.grzeschik@pengutronix.de>
@@ -1329,6 +1442,7 @@ S:	Maintained
 F:	arch/arm/include/asm/arch_timer.h
 F:	arch/arm64/include/asm/arch_timer.h
 F:	drivers/clocksource/arm_arch_timer.c
+D:	arm: arch_timer:
 
 ARM HDLCD DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
@@ -1375,6 +1489,7 @@ F:	Documentation/devicetree/bindings/display/arm,komeda.txt
 F:	Documentation/gpu/komeda-kms.rst
 F:	drivers/gpu/drm/arm/display/include/
 F:	drivers/gpu/drm/arm/display/komeda/
+D:	drm/komeda:
 
 ARM MALI PANFROST DRM DRIVER
 M:	Rob Herring <robh@kernel.org>
@@ -1386,6 +1501,7 @@ S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	drivers/gpu/drm/panfrost/
 F:	include/uapi/drm/panfrost_drm.h
+D:	drm/panfrost:
 
 ARM MALI-DP DRM DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
@@ -1396,12 +1512,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 F:	Documentation/devicetree/bindings/display/arm,malidp.txt
 F:	Documentation/gpu/afbc.rst
 F:	drivers/gpu/drm/arm/
+D:	drm: mali-dp:
 
 ARM MFM AND FLOPPY DRIVERS
 M:	Ian Molton <spyro@f2s.com>
 S:	Maintained
 F:	arch/arm/include/asm/floppy.h
 F:	arch/arm/mach-rpc/floppydma.S
+D:	floppy:
 
 ARM PMU PROFILING AND DEBUGGING
 M:	Will Deacon <will@kernel.org>
@@ -1431,29 +1549,34 @@ ARM PRIMECELL AACI PL041 DRIVER
 M:	Russell King <linux@armlinux.org.uk>
 S:	Odd Fixes
 F:	sound/arm/aaci.*
+D:	ALSA: AACI:
 
 ARM PRIMECELL BUS SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
 S:	Odd Fixes
 F:	drivers/amba/
 F:	include/linux/amba/bus.h
+D:	ARM: amba:
 
 ARM PRIMECELL CLCD PL110 DRIVER
 M:	Russell King <linux@armlinux.org.uk>
 S:	Odd Fixes
 F:	drivers/video/fbdev/amba-clcd.*
+D:	video: ARM CLCD:
 
 ARM PRIMECELL KMI PL050 DRIVER
 M:	Russell King <linux@armlinux.org.uk>
 S:	Odd Fixes
 F:	drivers/input/serio/ambakmi.*
 F:	include/linux/amba/kmi.h
+D:	Input:
 
 ARM PRIMECELL MMCI PL180/1 DRIVER
 M:	Russell King <linux@armlinux.org.uk>
 S:	Odd Fixes
 F:	drivers/mmc/host/mmci.*
 F:	include/linux/amba/mmci.h
+D:	mmc: mmci:
 
 ARM PRIMECELL SSP PL022 SPI DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
@@ -1461,12 +1584,14 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-pl022.yaml
 F:	drivers/spi/spi-pl022.c
+D:	spi/pl022:
 
 ARM PRIMECELL UART PL010 AND PL011 DRIVERS
 M:	Russell King <linux@armlinux.org.uk>
 S:	Odd Fixes
 F:	drivers/tty/serial/amba-pl01*.c
 F:	include/linux/amba/serial.h
+D:	tty: amba-pl011:
 
 ARM PRIMECELL VIC PL190/PL192 DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
@@ -1474,6 +1599,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
 F:	drivers/irqchip/irq-vic.c
+D:	irqchip: vic:
 
 ARM SMC WATCHDOG DRIVER
 M:	Julius Werner <jwerner@chromium.org>
@@ -1481,6 +1607,7 @@ R:	Evan Benn <evanbenn@chromium.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
 F:	drivers/watchdog/arm_smc_wdt.c
+D:	watchdog:
 
 ARM SMMU DRIVERS
 M:	Will Deacon <will@kernel.org>
@@ -1547,6 +1674,7 @@ ARM/Allwinner SoC Clock Support
 M:	Emilio López <emilio@elopez.com.ar>
 S:	Maintained
 F:	drivers/clk/sunxi/
+D:	clk: sunxi:
 
 ARM/Allwinner sunXi SoC support
 M:	Maxime Ripard <mripard@kernel.org>
@@ -1580,6 +1708,7 @@ L:	linux-amlogic@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/crypto/amlogic*
 F:	drivers/crypto/amlogic/
+D:	crypto:
 
 ARM/Amlogic Meson SoC Sound Drivers
 M:	Jerome Brunet <jbrunet@baylibre.com>
@@ -1615,6 +1744,7 @@ F:	arch/arm/boot/dts/alpine*
 F:	arch/arm/mach-alpine/
 F:	arch/arm64/boot/dts/amazon/
 F:	drivers/*/*alpine*
+D:	ARM: Alpine:
 
 ARM/ARTPEC MACHINE SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
@@ -1640,6 +1770,7 @@ F:	Documentation/devicetree/bindings/i2c/i2c-aspeed.txt
 F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-i2c-ic.txt
 F:	drivers/i2c/busses/i2c-aspeed.c
 F:	drivers/irqchip/irq-aspeed-i2c-ic.c
+D:	i2c: aspeed:
 
 ARM/ASPEED MACHINE SUPPORT
 M:	Joel Stanley <joel@jms.id.au>
@@ -1676,18 +1807,21 @@ ARM/CAVIUM NETWORKS CNS3XXX MACHINE SUPPORT
 M:	Krzysztof Halasa <khalasa@piap.pl>
 S:	Maintained
 F:	arch/arm/mach-cns3xxx/
+D:	CNS3xxx:
 
 ARM/CAVIUM THUNDER NETWORK DRIVER
 M:	Sunil Goutham <sgoutham@marvell.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/net/ethernet/cavium/thunder/
+D:	net: thunderx:
 
 ARM/CIRRUS LOGIC BK3 MACHINE SUPPORT
 M:	Lukasz Majewski <lukma@denx.de>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-ep93xx/ts72xx.c
+D:	ARM: ep93xx: ts72xx:
 
 ARM/CIRRUS LOGIC CLPS711X ARM ARCHITECTURE
 M:	Alexander Shiyan <shc_work@mail.ru>
@@ -1707,6 +1841,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-ep93xx/
 F:	arch/arm/mach-ep93xx/include/mach/
+D:	ARM: ep93xx:
 
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
@@ -1714,6 +1849,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.armlinux.org.uk/~rmk/linux-arm.git clkdev
 F:	drivers/clk/clkdev.c
+D:	clk:
 
 ARM/CONEXANT DIGICOLOR MACHINE SUPPORT
 M:	Baruch Siach <baruch@tkos.co.il>
@@ -1721,11 +1857,13 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/boot/dts/cx92755*
 N:	digicolor
+D:	ARM: digicolor:
 
 ARM/CONTEC MICRO9 MACHINE SUPPORT
 M:	Hubert Feurstein <hubert.feurstein@contec.at>
 S:	Maintained
 F:	arch/arm/mach-ep93xx/micro9.c
+D:	ARM: 5751/1: ep93xx/micro9:
 
 ARM/CORESIGHT FRAMEWORK AND DRIVERS
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
@@ -1766,6 +1904,7 @@ F:	arch/arm/mach-gemini/
 F:	drivers/net/ethernet/cortina/
 F:	drivers/pinctrl/pinctrl-gemini.c
 F:	drivers/rtc/rtc-ftrtc010.c
+D:	ARM: gemini:
 
 ARM/CSR SIRFPRIMA2 MACHINE SUPPORT
 M:	Barry Song <baohua@kernel.org>
@@ -1794,6 +1933,7 @@ F:	drivers/bus/moxtet.c
 F:	drivers/firmware/turris-mox-rwtm.c
 F:	drivers/gpio/gpio-moxtet.c
 F:	include/linux/moxtet.h
+D:	bus: moxtet:
 
 ARM/ENERGY MICRO (SILICON LABS) EFM32 SUPPORT
 M:	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
@@ -1807,6 +1947,7 @@ M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/ezx.c
+D:	ARM: pxa: ezx:
 
 ARM/FARADAY FA526 PORT
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
@@ -1814,6 +1955,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.berlios.de/gemini-board
 F:	arch/arm/mm/*-fa*
+D:	ARM: Gemini:
 
 ARM/FOOTBRIDGE ARCHITECTURE
 M:	Russell King <linux@armlinux.org.uk>
@@ -1822,6 +1964,7 @@ S:	Maintained
 W:	http://www.armlinux.org.uk/
 F:	arch/arm/include/asm/hardware/dec21285.h
 F:	arch/arm/mach-footbridge/
+D:	ARM: footbridge:
 
 ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
 M:	Shawn Guo <shawnguo@kernel.org>
@@ -1875,6 +2018,7 @@ S:	Maintained
 F:	arch/arm/mach-pxa/hx4700.c
 F:	arch/arm/mach-pxa/include/mach/hx4700.h
 F:	sound/soc/pxa/hx4700.c
+D:	[ARM] pxa/hx4700:
 
 ARM/HISILICON SOC SUPPORT
 M:	Wei Xu <xuwei5@hisilicon.com>
@@ -1909,6 +2053,7 @@ M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/colibri-pxa270-income.c
+D:	[ARM] pxa/income:
 
 ARM/INTEL IOP32X ARM ARCHITECTURE
 M:	Lennert Buytenhek <kernel@wantstofly.org>
@@ -1956,6 +2101,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/stargate2.c
 F:	drivers/pcmcia/pxa2xx_stargate2.c
+D:	[ARM] pxa:
 
 ARM/INTEL XSC3 (MANZANO) ARM CORE
 M:	Lennert Buytenhek <kernel@wantstofly.org>
@@ -2003,6 +2149,7 @@ F:	drivers/net/ethernet/nxp/lpc_eth.c
 F:	drivers/usb/host/ohci-nxp.c
 F:	drivers/watchdog/pnx4008_wdt.c
 N:	lpc32xx
+D:	ARM: lpc32xx:
 
 ARM/MAGICIAN MACHINE SUPPORT
 M:	Philipp Zabel <philipp.zabel@gmail.com>
@@ -2046,6 +2193,7 @@ F:	drivers/irqchip/irq-armada-370-xp.c
 F:	drivers/irqchip/irq-mvebu-*
 F:	drivers/pinctrl/mvebu/
 F:	drivers/rtc/rtc-armada38x.c
+D:	ARM: kirkwood:
 
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
@@ -2122,6 +2270,7 @@ M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/mioa701.c
+D:	[ARM] pxa/MioA701:
 
 ARM/MStar/Sigmastar Armv7 SoC support
 M:	Daniel Palmer <daniel@thingy.jp>
@@ -2131,6 +2280,7 @@ W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar/*
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
+D:	ARM: mstar:
 
 ARM/NEC MOBILEPRO 900/c MACHINE SUPPORT
 M:	Michael Petchkovsky <mkpetch@internode.on.net>
@@ -2198,6 +2348,7 @@ S:	Orphan
 W:	http://wiki.openmoko.org/wiki/Neo_FreeRunner
 F:	arch/arm/mach-s3c/gta02.h
 F:	arch/arm/mach-s3c/mach-gta02.c
+D:	ARM: s3c:
 
 ARM/Orion SoC/Technologic Systems TS-78xx platform support
 M:	Alexander Clouter <alex@digriz.org.uk>
@@ -2205,6 +2356,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.digriz.org.uk/ts78xx/kernel
 F:	arch/arm/mach-orion5x/ts78xx-*
+D:	[ARM] orion5x:
 
 ARM/OXNAS platform support
 M:	Neil Armstrong <narmstrong@baylibre.com>
@@ -2215,6 +2367,7 @@ F:	arch/arm/boot/dts/ox8*.dts*
 F:	arch/arm/mach-oxnas/
 F:	drivers/power/reset/oxnas-restart.c
 N:	oxnas
+D:	ARM: oxnas:
 
 ARM/PALM TREO SUPPORT
 M:	Tomas Cech <sleep_walker@suse.com>
@@ -2222,6 +2375,7 @@ L:	linux-arm-kernel@lists.infradead.org
 S:	Maintained
 W:	http://hackndev.com
 F:	arch/arm/mach-pxa/palmtreo.*
+D:	ARM: pxa:
 
 ARM/PALMTX,PALMT5,PALMLD,PALMTE2,PALMTC SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
@@ -2236,6 +2390,7 @@ F:	arch/arm/mach-pxa/palmt5.*
 F:	arch/arm/mach-pxa/palmtc.c
 F:	arch/arm/mach-pxa/palmte2.*
 F:	arch/arm/mach-pxa/palmtx.c
+D:	[ARM] pxa:
 
 ARM/PALMZ72 SUPPORT
 M:	Sergey Lapin <slapin@ossfans.org>
@@ -2407,6 +2562,7 @@ L:	linux-arm-kernel@lists.infradead.org
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/s5p-g2d/
+D:	[media] s5p-g2d:
 
 ARM/SAMSUNG S5P SERIES HDMI CEC SUBSYSTEM SUPPORT
 M:	Marek Szyprowski <m.szyprowski@samsung.com>
@@ -2424,6 +2580,7 @@ L:	linux-arm-kernel@lists.infradead.org
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/s5p-jpeg/
+D:	[media] s5p-jpeg:
 
 ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
 M:	Andrzej Hajda <a.hajda@samsung.com>
@@ -2431,6 +2588,7 @@ L:	linux-arm-kernel@lists.infradead.org
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/platform/s5p-mfc/
+D:	[media] s5p-mfc:
 
 ARM/SHMOBILE ARM ARCHITECTURE
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
@@ -2468,11 +2626,13 @@ ARM/SOCFPGA CLOCK FRAMEWORK SUPPORT
 M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/clk/socfpga/
+D:	clk: socfpga: stratix10:
 
 ARM/SOCFPGA EDAC SUPPORT
 M:	Dinh Nguyen <dinguyen@kernel.org>
 S:	Maintained
 F:	drivers/edac/altera_edac.[ch]
+D:	EDAC, altera:
 
 ARM/SPREADTRUM SoC SUPPORT
 M:	Orson Zhai <orsonzhai@gmail.com>
@@ -2568,6 +2728,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/memory/*emif*
+D:	memory: emif:
 
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
@@ -2582,6 +2743,7 @@ M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/clk/keystone/
+D:	clk: keystone:
 
 ARM/TEXAS INSTRUMENT KEYSTONE ClOCKSOURCE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
@@ -2589,12 +2751,14 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/clocksource/timer-keystone.c
+D:	clocksource: timer-keystone:
 
 ARM/TEXAS INSTRUMENT KEYSTONE RESET DRIVER
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/power/reset/keystone-reset.c
+D:	power: reset: keystone-reset:
 
 ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
 M:	Tero Kristo <t-kristo@ti.com>
@@ -2671,6 +2835,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.armlinux.org.uk/
 F:	arch/arm/vfp/
+D:	ARM: vfp:
 
 ARM/VOIPAC PXA270 SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
@@ -2678,6 +2843,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/include/mach/vpac270.h
 F:	arch/arm/mach-pxa/vpac270.c
+D:	[ARM] pxa/vpac270:
 
 ARM/VT8500 ARM ARCHITECTURE
 M:	Tony Prisk <linux@prisktech.co.nz>
@@ -2696,6 +2862,7 @@ F:	drivers/usb/host/uhci-platform.c
 F:	drivers/video/fbdev/vt8500lcdfb.*
 F:	drivers/video/fbdev/wm8505fb*
 F:	drivers/video/fbdev/wmt_ge_rops.*
+D:	arm: vt8500:
 
 ARM/ZIPIT Z2 SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
@@ -2703,6 +2870,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-pxa/include/mach/z2.h
 F:	arch/arm/mach-pxa/z2.c
+D:	[ARM] pxa/z2:
 
 ARM/ZTE ARCHITECTURE
 M:	Jun Nie <jun.nie@linaro.org>
@@ -2756,6 +2924,7 @@ F:	drivers/i2c/busses/i2c-xiic.c
 F:	drivers/mmc/host/sdhci-of-arasan.c
 N:	zynq
 N:	xilinx
+D:	ARM: zynq:
 
 ARM64 PORT (AARCH64 ARCHITECTURE)
 M:	Catalin Marinas <catalin.marinas@arm.com>
@@ -2767,12 +2936,14 @@ F:	Documentation/arm64/
 F:	arch/arm64/
 F:	tools/testing/selftests/arm64/
 X:	arch/arm64/boot/dts/
+D:	arm64:
 
 AS3645A LED FLASH CONTROLLER DRIVER
 M:	Sakari Ailus <sakari.ailus@iki.fi>
 L:	linux-leds@vger.kernel.org
 S:	Maintained
 F:	drivers/leds/leds-as3645a.c
+D:	leds: as3645a:
 
 ASAHI KASEI AK7375 LENS VOICE COIL DRIVER
 M:	Tianshu Qiu <tian.shu.qiu@intel.com>
@@ -2781,6 +2952,7 @@ S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/i2c/ak7375.txt
 F:	drivers/media/i2c/ak7375.c
+D:	media: i2c: ak7375:
 
 ASAHI KASEI AK8974 DRIVER
 M:	Linus Walleij <linus.walleij@linaro.org>
@@ -2788,6 +2960,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://www.akm.com/
 F:	drivers/iio/magnetometer/ak8974.c
+D:	iio: magnetometer: ak8974:
 
 ASC7621 HARDWARE MONITOR DRIVER
 M:	George Joseph <george.joseph@fairview5.com>
@@ -2795,6 +2968,7 @@ L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	Documentation/hwmon/asc7621.rst
 F:	drivers/hwmon/asc7621.c
+D:	hwmon:
 
 ASPEED PINCTRL DRIVERS
 M:	Andrew Jeffery <andrew@aj.id.au>
@@ -2804,6 +2978,7 @@ L:	linux-gpio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pinctrl/aspeed,*
 F:	drivers/pinctrl/aspeed/
+D:	pinctrl: aspeed:
 
 ASPEED SCU INTERRUPT CONTROLLER DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
@@ -2812,6 +2987,7 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2xxx-scu-ic.txt
 F:	drivers/irqchip/irq-aspeed-scu-ic.c
 F:	include/dt-bindings/interrupt-controller/aspeed-scu-ic.h
+D:	irqchip:
 
 ASPEED VIDEO ENGINE DRIVER
 M:	Eddie James <eajames@linux.ibm.com>
@@ -2820,6 +2996,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/aspeed-video.txt
 F:	drivers/media/platform/aspeed-video.c
+D:	media: platform: Aspeed:
 
 ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
 M:	Corentin Chary <corentin.chary@gmail.com>
@@ -2829,12 +3006,14 @@ S:	Maintained
 W:	http://acpi4asus.sf.net
 F:	drivers/platform/x86/asus*.c
 F:	drivers/platform/x86/eeepc*.c
+D:	asus-wmi:
 
 ASUS WIRELESS RADIO CONTROL DRIVER
 M:	João Paulo Rechi Vita <jprvita@gmail.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/asus-wireless.c
+D:	platform/x86: asus-wireless:
 
 ASYMMETRIC KEYS
 M:	David Howells <dhowells@redhat.com>
@@ -2845,6 +3024,7 @@ F:	crypto/asymmetric_keys/
 F:	include/crypto/pkcs7.h
 F:	include/crypto/public_key.h
 F:	include/linux/verification.h
+D:	KEYS:
 
 ASYNCHRONOUS TRANSFERS/TRANSFORMS (IOAT) API
 R:	Dan Williams <dan.j.williams@intel.com>
@@ -2863,6 +3043,7 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git
 F:	Documentation/devicetree/bindings/eeprom/at24.yaml
 F:	drivers/misc/eeprom/at24.c
+D:	eeprom: at24:
 
 ATA OVER ETHERNET (AOE) DRIVER
 M:	"Justin Sanders" <justin@coraid.com>
@@ -2870,6 +3051,7 @@ S:	Supported
 W:	http://www.openaoe.org/
 F:	Documentation/admin-guide/aoe/
 F:	drivers/block/aoe/
+D:	aoe:
 
 ATHEROS 71XX/9XXX GPIO DRIVER
 M:	Alban Bedel <albeu@free.fr>
@@ -2878,6 +3060,7 @@ W:	https://github.com/AlbanBedel/linux
 T:	git git://github.com/AlbanBedel/linux
 F:	Documentation/devicetree/bindings/gpio/gpio-ath79.txt
 F:	drivers/gpio/gpio-ath79.c
+D:	gpio: ath79:
 
 ATHEROS 71XX/9XXX USB PHY DRIVER
 M:	Alban Bedel <albeu@free.fr>
@@ -2886,6 +3069,7 @@ W:	https://github.com/AlbanBedel/linux
 T:	git git://github.com/AlbanBedel/linux
 F:	Documentation/devicetree/bindings/phy/phy-ath79-usb.txt
 F:	drivers/phy/qualcomm/phy-ath79-usb.c
+D:	phy: ath79-usb:
 
 ATHEROS ATH GENERIC UTILITIES
 M:	Kalle Valo <kvalo@codeaurora.org>
@@ -2901,6 +3085,7 @@ L:	linux-wireless@vger.kernel.org
 S:	Maintained
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath5k
 F:	drivers/net/wireless/ath/ath5k/
+D:	ath5k:
 
 ATHEROS ATH6KL WIRELESS DRIVER
 M:	Kalle Valo <kvalo@codeaurora.org>
@@ -2909,17 +3094,20 @@ S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath6kl
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git
 F:	drivers/net/wireless/ath/ath6kl/
+D:	ath:
 
 ATI_REMOTE2 DRIVER
 M:	Ville Syrjala <syrjala@sci.fi>
 S:	Maintained
 F:	drivers/input/misc/ati_remote2.c
+D:	Input:
 
 ATK0110 HWMON DRIVER
 M:	Luca Tettamanti <kronos.it@gmail.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Maintained
 F:	drivers/hwmon/asus_atk0110.c
+D:	hwmon:
 
 ATLX ETHERNET DRIVERS
 M:	Jay Cliburn <jcliburn@gmail.com>
@@ -2929,6 +3117,7 @@ S:	Maintained
 W:	http://sourceforge.net/projects/atl1
 W:	http://atl1.sourceforge.net
 F:	drivers/net/ethernet/atheros/
+D:	alx:
 
 ATM
 M:	Chas Williams <3chas3@gmail.com>
@@ -2945,6 +3134,7 @@ M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 S:	Supported
 F:	drivers/net/ethernet/cadence/
+D:	net: macb:
 
 ATMEL MAXTOUCH DRIVER
 M:	Nick Dyer <nick@shmanahar.org>
@@ -2952,6 +3142,7 @@ S:	Maintained
 T:	git git://github.com/ndyer/linux.git
 F:	Documentation/devicetree/bindings/input/atmel,maxtouch.yaml
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
+D:	[media] Input:
 
 ATMEL WIRELESS DRIVER
 M:	Simon Kelley <simon@thekelleys.org.uk>
@@ -2960,6 +3151,7 @@ S:	Maintained
 W:	http://www.thekelleys.org.uk/atmel
 W:	http://atmelwlandriver.sourceforge.net/
 F:	drivers/net/wireless/atmel/atmel*
+D:	atmel:
 
 ATOMIC INFRASTRUCTURE
 M:	Will Deacon <will@kernel.org>
@@ -2977,6 +3169,7 @@ L:	linux-scsi@vger.kernel.org
 S:	Supported
 W:	http://www.attotech.com
 F:	drivers/scsi/esas2r
+D:	scsi: esas2r:
 
 ATUSB IEEE 802.15.4 RADIO DRIVER
 M:	Stefan Schmidt <stefan@datenfreihafen.org>
@@ -2985,6 +3178,7 @@ S:	Maintained
 F:	drivers/net/ieee802154/at86rf230.h
 F:	drivers/net/ieee802154/atusb.c
 F:	drivers/net/ieee802154/atusb.h
+D:	ieee802154: atusb:
 
 AUDIT SUBSYSTEM
 M:	Paul Moore <paul@paul-moore.com>
@@ -2996,6 +3190,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 F:	include/linux/audit.h
 F:	include/uapi/linux/audit.h
 F:	kernel/audit*
+D:	audit:
 
 AUXILIARY DISPLAY DRIVERS
 M:	Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
@@ -3009,6 +3204,7 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
 F:	drivers/iio/adc/hx711.c
+D:	iio: hx711:
 
 AX.25 NETWORK LAYER
 M:	Ralf Baechle <ralf@linux-mips.org>
@@ -3018,6 +3214,7 @@ W:	http://www.linux-ax25.org/
 F:	include/net/ax25.h
 F:	include/uapi/linux/ax25.h
 F:	net/ax25/
+D:	[AX.25]:
 
 AXENTIA ARM DEVICES
 M:	Peter Rosin <peda@axentia.se>
@@ -3034,6 +3231,7 @@ L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
+D:	ASoC: atmel: tse850:
 
 AXI-FAN-CONTROL HARDWARE MONITOR DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
@@ -3042,6 +3240,7 @@ S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,axi-fan-control.yaml
 F:	drivers/hwmon/axi-fan-control.c
+D:	hwmon:
 
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
@@ -3049,6 +3248,7 @@ L:	linux-i2c@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/i2c/i2c-axxia.txt
 F:	drivers/i2c/busses/i2c-axxia.c
+D:	i2c: axxia:
 
 AZ6007 DVB DRIVER
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 7dc094445d83..04c106f7a1c2 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3283,7 +3283,7 @@ sub process {
 				}
 			}
 # check MAINTAINERS entries for the right ordering too
-			my $preferred_order = 'MRLSWQBCPTFXNK';
+			my $preferred_order = 'MRLSWQBCPTFXNKD';
 			if ($rawline =~ /^\+[A-Z]:/ &&
 			    $prevrawline =~ /^[\+ ][A-Z]:/) {
 				$rawline =~ /^\+([A-Z]):\s*(.*)/;
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 2075db0c08b8..5a00fa2f2326 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -54,6 +54,7 @@ my $scm = 0;
 my $tree = 1;
 my $web = 0;
 my $subsystem = 0;
+my $subsystem_commit_prefix = 0;
 my $status = 0;
 my $letters = "";
 my $keywords = 1;
@@ -265,6 +266,7 @@ if (!GetOptions(
 		'rolestats!' => \$output_rolestats,
 		'separator=s' => \$output_separator,
 		'subsystem!' => \$subsystem,
+		'subsystem_commit_prefix!' => \$subsystem_commit_prefix,
 		'status!' => \$status,
 		'scm!' => \$scm,
 		'tree!' => \$tree,
@@ -316,13 +318,14 @@ if ($sections || $letters ne "") {
     $scm = 0;
     $status = 0;
     $subsystem = 0;
+    $subsystem_commit_prefix = 0;
     $web = 0;
     $keywords = 0;
     $interactive = 0;
 } else {
-    my $selections = $email + $scm + $status + $subsystem + $web;
+    my $selections = $email + $scm + $status + $subsystem + $subsystem_commit_prefix + $web;
     if ($selections == 0) {
-	die "$P:  Missing required option: email, scm, status, subsystem or web\n";
+	die "$P:  Missing required option: email, scm, status, subsystem, subsystem_commit_prefix or web\n";
     }
 }
 
@@ -630,6 +633,7 @@ my @list_to = ();
 my @scm = ();
 my @web = ();
 my @subsystem = ();
+my @subsystem_commit_prefix = ();
 my @status = ();
 my %deduplicate_name_hash = ();
 my %deduplicate_address_hash = ();
@@ -655,6 +659,11 @@ if ($subsystem) {
     output(@subsystem);
 }
 
+if ($subsystem_commit_prefix) {
+    @subsystem_commit_prefix = uniq(@subsystem_commit_prefix);
+    output(@subsystem_commit_prefix);
+}
+
 if ($web) {
     @web = uniq(@web);
     output(@web);
@@ -846,6 +855,7 @@ sub get_maintainers {
     @scm = ();
     @web = ();
     @subsystem = ();
+    @subsystem_commit_prefix = ();
     @status = ();
     %deduplicate_name_hash = ();
     %deduplicate_address_hash = ();
@@ -1065,6 +1075,7 @@ MAINTAINER field selection options:
   --scm => print SCM tree(s) if any
   --status => print status if any
   --subsystem => print subsystem name if any
+  --subsystem_commit_prefix => print subsystem commit prefix if any
   --web => print website(s) if any
 
 Output type options:
@@ -1324,7 +1335,9 @@ sub add_categories {
 	if ($tv =~ m/^([A-Z]):\s*(.*)/) {
 	    my $ptype = $1;
 	    my $pvalue = $2;
-	    if ($ptype eq "L") {
+	    if ($ptype eq "D") {
+		push(@subsystem_commit_prefix, $pvalue);
+	    } elsif ($ptype eq "L") {
 		my $list_address = $pvalue;
 		my $list_additional = "";
 		my $list_role = get_list_role($i);
-- 
2.18.4

