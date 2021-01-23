Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5C2301515
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 13:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAWMRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 07:17:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38570 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726829AbhAWMPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 07:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611404017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lFXYvyZ0CLcvB3R48S1XXO1n1GmYgmgWHpO6/q9B+/s=;
        b=c6mKE2OUebZI8oRDoUPQBj7clTfEznDRts82fhEzls0v//vfvkMMYLtJ+dV3h1N6H1TB4U
        Ek9g2kFXXmPRKjWTcC5hhH3UrVMfiH7cWHPoG0j39u4ZddDoCIyqlrzCsi2FEXxk1RU1TU
        Hh5Sc6EoGiBJr7xkSrnWBKrQonhtnSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-91UtL8GSMf6hEMYN07eiTA-1; Sat, 23 Jan 2021 07:13:33 -0500
X-MC-Unique: 91UtL8GSMf6hEMYN07eiTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0736910054FF;
        Sat, 23 Jan 2021 12:13:32 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-82.ams2.redhat.com [10.36.112.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6BF8189B8;
        Sat, 23 Jan 2021 12:13:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 06/13] ASoC/extcon: arizona: Move arizona jack code to sound/soc/codecs/arizona-jack.c
Date:   Sat, 23 Jan 2021 13:13:06 +0100
Message-Id: <20210123121313.79530-7-hdegoede@redhat.com>
In-Reply-To: <20210123121313.79530-1-hdegoede@redhat.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jack handling for arizona codecs is being refactored so that it is
done directly by the codec drivers, instead of having an extcon-driver
bind to a separate "arizona-extcon" child-device for this.

drivers/mfd/arizona-core.c has already been updated to no longer
instantiate an "arizona-extcon" child-device for the arizona codecs.

This means that the "arizona-extcon" driver is no longer useful
(there are no longer any devices for it to bind to).

This commit drops the extcon Kconfig / Makefile bits and moves
drivers/extcon/extcon-arizona.c to sound/soc/codecs/arizona-jack.c .

This is a preparation patch for converting the arizona extcon-driver into
a helper library for letting the arizona codec-drivers directly report jack
state through the standard sound/soc/soc-jack.c functions.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
- Add sound/soc/codecs/arizona-jack.c to the WOLFSON MICROELECTRONICS DRIVERS
  MAINTAINERS section

Changes in v3:
- Fold the 2 separate patches to add a copy of extcon-arizona.c as
  sound/soc/codecs/arizona-jack.c and the follow up patch to remove the
  extcon driver into 1 patch simply moving the extcon driver code.
---
 MAINTAINERS                                               | 3 +--
 drivers/extcon/Kconfig                                    | 8 --------
 drivers/extcon/Makefile                                   | 1 -
 .../extcon-arizona.c => sound/soc/codecs/arizona-jack.c   | 0
 4 files changed, 1 insertion(+), 11 deletions(-)
 rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 036a03c794de..873817694fd2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19249,7 +19249,6 @@ F:	Documentation/devicetree/bindings/sound/wlf,arizona.yaml
 F:	Documentation/hwmon/wm83??.rst
 F:	arch/arm/mach-s3c/mach-crag6410*
 F:	drivers/clk/clk-wm83*.c
-F:	drivers/extcon/extcon-arizona.c
 F:	drivers/gpio/gpio-*wm*.c
 F:	drivers/gpio/gpio-arizona.c
 F:	drivers/hwmon/wm83??-hwmon.c
@@ -19273,7 +19272,7 @@ F:	include/linux/mfd/wm8400*
 F:	include/linux/regulator/arizona*
 F:	include/linux/wm97xx.h
 F:	include/sound/wm????.h
-F:	sound/soc/codecs/arizona.?
+F:	sound/soc/codecs/arizona*
 F:	sound/soc/codecs/cs47l24*
 F:	sound/soc/codecs/wm*
 
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index af58ebca2bf6..e3db936becfd 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -21,14 +21,6 @@ config EXTCON_ADC_JACK
 	help
 	  Say Y here to enable extcon device driver based on ADC values.
 
-config EXTCON_ARIZONA
-	tristate "Wolfson Arizona EXTCON support"
-	depends on MFD_ARIZONA && INPUT && SND_SOC
-	help
-	  Say Y here to enable support for external accessory detection
-	  with Wolfson Arizona devices. These are audio CODECs with
-	  advanced audio accessory detection support.
-
 config EXTCON_AXP288
 	tristate "X-Power AXP288 EXTCON support"
 	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
diff --git a/drivers/extcon/Makefile b/drivers/extcon/Makefile
index fe10a1b7d18b..1b390d934ca9 100644
--- a/drivers/extcon/Makefile
+++ b/drivers/extcon/Makefile
@@ -6,7 +6,6 @@
 obj-$(CONFIG_EXTCON)		+= extcon-core.o
 extcon-core-objs		+= extcon.o devres.o
 obj-$(CONFIG_EXTCON_ADC_JACK)	+= extcon-adc-jack.o
-obj-$(CONFIG_EXTCON_ARIZONA)	+= extcon-arizona.o
 obj-$(CONFIG_EXTCON_AXP288)	+= extcon-axp288.o
 obj-$(CONFIG_EXTCON_FSA9480)	+= extcon-fsa9480.o
 obj-$(CONFIG_EXTCON_GPIO)	+= extcon-gpio.o
diff --git a/drivers/extcon/extcon-arizona.c b/sound/soc/codecs/arizona-jack.c
similarity index 100%
rename from drivers/extcon/extcon-arizona.c
rename to sound/soc/codecs/arizona-jack.c
-- 
2.29.2

