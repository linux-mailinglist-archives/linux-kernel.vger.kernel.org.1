Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5AF295468
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506386AbgJUVm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:42:58 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:40408 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506368AbgJUVm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:42:56 -0400
Received: from twocubed.nippynetworks.com (office.nippynetworks.com [46.17.61.232])
        by mail1.nippynetworks.com (Postfix) with SMTP id 4CGkVy2WvpzTgZ7;
        Wed, 21 Oct 2020 22:42:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1603316571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvFinFWDt4SzvnQ+Xp0JMq1NOr4pvx4vTPJekFh3eJQ=;
        b=VzEjiuRk/G4PJ0ecSNS/2jbMaB7MJKE+kFeIrL+uUcFZ+SbGOuTkahuiu3JzxQJrUrFhmg
        UGoy5HieS8fivt6HAjTs9XF3dZe1xUTENjVLC5E9IudNH5fmxd2yZk/8/Tf7voNL95wQbS
        ggcuNo1yT5aBjYIVXHkoO9hChNhvxio=
Received: by twocubed.nippynetworks.com (sSMTP sendmail emulation); Wed, 21 Oct 2020 22:42:50 +0100
From:   Ed Wildgoose <lists@wildgooses.com>
To:     linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, hdegoede@redhat.com,
        Ed Wildgoose <lists@wildgooses.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/2] x86: Support APU5 & APU6 in PCEngines platform driver
Date:   Wed, 21 Oct 2020 22:41:50 +0100
Message-Id: <20201021214151.32229-2-lists@wildgooses.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201021214151.32229-1-lists@wildgooses.com>
References: <2ba7fc12-a3a7-2783-54e6-27e9eb60ec9c@redhat.com>
 <20201021214151.32229-1-lists@wildgooses.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCEngines make a number of SBC. APU5 has 5 mpcie slots + MSATA
It also has support for 3x LTE modems with 6x SIM slots (pairs with a
SIM switch device). Each mpcie slot for modems has a reset GPIO

To ensure that the naming is sane between APU2-6 the GPIOS are
renamed to be modem1-reset, modem2-reset, etc. This is significant
because the slots that can be reset change between APU2 and APU3/4

GPIO for simswap is moved to the end of the list as it could be dropped
for APU2 boards (but causes no harm to leave it in, hardware could be
added to a future rev of the board).

Structure of the GPIOs for APU5 is extremely similar to APU2-4, but
many lines are moved around and there are simply more
modems/resets/sim-swap lines to breakout.

Also added APU6, which is essentially APU4 with a different ethernet
interface

Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
---
 drivers/platform/x86/pcengines-apuv2.c | 123 +++++++++++++++++++++----
 1 file changed, 107 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index 45f7a89de..089756693 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 
 /*
- * PC-Engines APUv2/APUv3 board platform driver
+ * PC-Engines APUv2-6 board platform driver
  * for GPIO buttons and LEDs
  *
  * Copyright (C) 2018 metux IT consult
@@ -22,38 +22,70 @@
 #include <linux/platform_data/gpio/gpio-amd-fch.h>
 
 /*
- * NOTE: this driver only supports APUv2/3 - not APUv1, as this one
+ * NOTE: this driver only supports APUv2-6 - not APUv1, as this one
  * has completely different register layouts.
  */
 
+/*
+ * There are a number of APU variants, with differing features
+ * APU2 has SIM slots 1/2 mapping to mPCIe sockets 1/2
+ * APU3/4 moved SIM slot 1 to mPCIe socket 3, ie logically reversed
+ * However, most APU3/4 have a SIM switch which we default on to reverse
+ * the order and keep physical SIM order matching physical modem order
+ * APU6 is approximately the same as APU4 with different ethernet layout
+ *
+ * APU5 has 3x SIM sockets, all with a SIM switch
+ * several GPIOs are shuffled (see schematic), including MODESW
+ */
+
 /* Register mappings */
 #define APU2_GPIO_REG_LED1		AMD_FCH_GPIO_REG_GPIO57
 #define APU2_GPIO_REG_LED2		AMD_FCH_GPIO_REG_GPIO58
 #define APU2_GPIO_REG_LED3		AMD_FCH_GPIO_REG_GPIO59_DEVSLP1
 #define APU2_GPIO_REG_MODESW		AMD_FCH_GPIO_REG_GPIO32_GE1
 #define APU2_GPIO_REG_SIMSWAP		AMD_FCH_GPIO_REG_GPIO33_GE2
-#define APU2_GPIO_REG_MPCIE2		AMD_FCH_GPIO_REG_GPIO55_DEVSLP0
-#define APU2_GPIO_REG_MPCIE3		AMD_FCH_GPIO_REG_GPIO51
+#define APU2_GPIO_REG_RESETM1		AMD_FCH_GPIO_REG_GPIO51
+#define APU2_GPIO_REG_RESETM2		AMD_FCH_GPIO_REG_GPIO55_DEVSLP0
+
+#define APU5_GPIO_REG_MODESW		AMT_FCH_GPIO_REG_GEVT22
+#define APU5_GPIO_REG_SIMSWAP1		AMD_FCH_GPIO_REG_GPIO68
+#define APU5_GPIO_REG_SIMSWAP2		AMD_FCH_GPIO_REG_GPIO32_GE1
+#define APU5_GPIO_REG_SIMSWAP3		AMD_FCH_GPIO_REG_GPIO33_GE2
+#define APU5_GPIO_REG_RESETM1		AMD_FCH_GPIO_REG_GPIO51
+#define APU5_GPIO_REG_RESETM2		AMD_FCH_GPIO_REG_GPIO55_DEVSLP0
+#define APU5_GPIO_REG_RESETM3		AMD_FCH_GPIO_REG_GPIO64
 
 /* Order in which the GPIO lines are defined in the register list */
 #define APU2_GPIO_LINE_LED1		0
 #define APU2_GPIO_LINE_LED2		1
 #define APU2_GPIO_LINE_LED3		2
 #define APU2_GPIO_LINE_MODESW		3
-#define APU2_GPIO_LINE_SIMSWAP		4
-#define APU2_GPIO_LINE_MPCIE2		5
-#define APU2_GPIO_LINE_MPCIE3		6
+#define APU2_GPIO_LINE_RESETM1		4
+#define APU2_GPIO_LINE_RESETM2		5
+#define APU2_GPIO_LINE_SIMSWAP		6
+
+#define APU5_GPIO_LINE_LED1		0
+#define APU5_GPIO_LINE_LED2		1
+#define APU5_GPIO_LINE_LED3		2
+#define APU5_GPIO_LINE_MODESW		3
+#define APU5_GPIO_LINE_RESETM1		4
+#define APU5_GPIO_LINE_RESETM2		5
+#define APU5_GPIO_LINE_RESETM3		6
+#define APU5_GPIO_LINE_SIMSWAP1		7
+#define APU5_GPIO_LINE_SIMSWAP2		8
+#define APU5_GPIO_LINE_SIMSWAP3		9
+
 
-/* GPIO device */
+/* GPIO device - APU2/3/4/6 */
 
 static int apu2_gpio_regs[] = {
 	[APU2_GPIO_LINE_LED1]		= APU2_GPIO_REG_LED1,
 	[APU2_GPIO_LINE_LED2]		= APU2_GPIO_REG_LED2,
 	[APU2_GPIO_LINE_LED3]		= APU2_GPIO_REG_LED3,
 	[APU2_GPIO_LINE_MODESW]		= APU2_GPIO_REG_MODESW,
+	[APU2_GPIO_LINE_RESETM1]	= APU2_GPIO_REG_RESETM1,
+	[APU2_GPIO_LINE_RESETM2]	= APU2_GPIO_REG_RESETM2,
 	[APU2_GPIO_LINE_SIMSWAP]	= APU2_GPIO_REG_SIMSWAP,
-	[APU2_GPIO_LINE_MPCIE2]		= APU2_GPIO_REG_MPCIE2,
-	[APU2_GPIO_LINE_MPCIE3]		= APU2_GPIO_REG_MPCIE3,
 };
 
 static const char * const apu2_gpio_names[] = {
@@ -61,9 +93,9 @@ static const char * const apu2_gpio_names[] = {
 	[APU2_GPIO_LINE_LED2]		= "front-led2",
 	[APU2_GPIO_LINE_LED3]		= "front-led3",
 	[APU2_GPIO_LINE_MODESW]		= "front-button",
+	[APU2_GPIO_LINE_RESETM1]	= "modem1-reset",
+	[APU2_GPIO_LINE_RESETM2]	= "modem2-reset",
 	[APU2_GPIO_LINE_SIMSWAP]	= "simswap",
-	[APU2_GPIO_LINE_MPCIE2]		= "mpcie2_reset",
-	[APU2_GPIO_LINE_MPCIE3]		= "mpcie3_reset",
 };
 
 static const struct amd_fch_gpio_pdata board_apu2 = {
@@ -72,6 +104,41 @@ static const struct amd_fch_gpio_pdata board_apu2 = {
 	.gpio_names	= apu2_gpio_names,
 };
 
+/* GPIO device - APU5 */
+
+static int apu5_gpio_regs[] = {
+	[APU5_GPIO_LINE_LED1]		= APU2_GPIO_REG_LED1,
+	[APU5_GPIO_LINE_LED2]		= APU2_GPIO_REG_LED2,
+	[APU5_GPIO_LINE_LED3]		= APU2_GPIO_REG_LED3,
+	[APU5_GPIO_LINE_MODESW]		= APU5_GPIO_REG_MODESW,
+	[APU5_GPIO_LINE_RESETM1]	= APU5_GPIO_REG_RESETM1,
+	[APU5_GPIO_LINE_RESETM2]	= APU5_GPIO_REG_RESETM2,
+	[APU5_GPIO_LINE_RESETM3]	= APU5_GPIO_REG_RESETM3,
+	[APU5_GPIO_LINE_SIMSWAP1]	= APU5_GPIO_REG_SIMSWAP1,
+	[APU5_GPIO_LINE_SIMSWAP2]	= APU5_GPIO_REG_SIMSWAP2,
+	[APU5_GPIO_LINE_SIMSWAP3]	= APU5_GPIO_REG_SIMSWAP3,
+};
+
+static const char * const apu5_gpio_names[] = {
+	[APU5_GPIO_LINE_LED1]		= "front-led1",
+	[APU5_GPIO_LINE_LED2]		= "front-led2",
+	[APU5_GPIO_LINE_LED3]		= "front-led3",
+	[APU5_GPIO_LINE_MODESW]		= "front-button",
+	[APU5_GPIO_LINE_RESETM1]	= "modem1-reset",
+	[APU5_GPIO_LINE_RESETM2]	= "modem2-reset",
+	[APU5_GPIO_LINE_RESETM3]	= "modem3-reset",
+	[APU5_GPIO_LINE_SIMSWAP1]	= "simswap1",
+	[APU5_GPIO_LINE_SIMSWAP2]	= "simswap2",
+	[APU5_GPIO_LINE_SIMSWAP3]	= "simswap3",
+};
+
+static const struct amd_fch_gpio_pdata board_apu5 = {
+	.gpio_num	= ARRAY_SIZE(apu5_gpio_regs),
+	.gpio_reg	= apu5_gpio_regs,
+	.gpio_names	= apu5_gpio_names,
+};
+
+
 /* GPIO LEDs device */
 
 static const struct gpio_led apu2_leds[] = {
@@ -140,6 +207,12 @@ static struct apu_driver_data apu2_driver_data = {
 	.apu_leds_pdata = &apu2_leds_pdata
 };
 
+static struct apu_driver_data apu5_driver_data = {
+	.board_data = &board_apu5,
+	.apu_keys_pdata = NULL,
+	.apu_leds_pdata = NULL
+};
+
 /* Note: matching works on string prefix, so "apu2" must come before "apu" */
 static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 
@@ -225,6 +298,24 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 		},
 		.driver_data = (void *)&apu2_driver_data,
 	},
+	/* APU5 w/ mainline BIOS */
+	{
+		.ident		= "apu5",
+		.matches	= {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu5")
+		},
+		.driver_data	= (void *)&apu5_driver_data,
+	},
+	/* APU6 w/ mainline BIOS */
+	{
+		.ident		= "apu6",
+		.matches	= {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu6")
+		},
+		.driver_data	= (void *)&apu2_driver_data,
+	},
 	{}
 };
 
@@ -294,12 +385,12 @@ static int __init apu_board_init(void)
 
 	id = dmi_first_match(apu_gpio_dmi_table);
 	if (!id) {
-		pr_err("failed to detect APU board via DMI\n");
+		pr_err("No APU board detected via DMI\n");
 		return -ENODEV;
 	} else {
 		pr_info("Detected APU board: %s - BIOS: %s\n",
-		dmi_get_system_info(DMI_BOARD_NAME),
-		dmi_get_system_info(DMI_BIOS_VERSION));
+			dmi_get_system_info(DMI_BOARD_NAME),
+			dmi_get_system_info(DMI_BIOS_VERSION));
 	}
 
 	driver_data = id->driver_data;
@@ -351,7 +442,7 @@ module_init(apu_board_init);
 module_exit(apu_board_exit);
 
 MODULE_AUTHOR("Enrico Weigelt, metux IT consult <info@metux.net>");
-MODULE_DESCRIPTION("PC Engines APUv2/APUv3 board GPIO/LEDs/keys driver");
+MODULE_DESCRIPTION("PC Engines APUv2-6 board GPIO/LEDs/keys driver");
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(dmi, apu_gpio_dmi_table);
 MODULE_ALIAS("platform:pcengines-apuv2");
-- 
2.26.2

