Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BD9274913
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIVT1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVT1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:27:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6367DC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:20 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b12so19302818lfp.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMSuAkZtX27i7TDRkVOKwB/SKG94w4AGTTD8RQ/V2uw=;
        b=rMUmVWunXVF2vdfabhg6Ef4Ooj0EkLhq85qSlcWi3DaIxVfbfxV2gYbbnO25DRwHtt
         GSipah4fXf13HqCogkhfJNLvO3ZmtOo+tEnEkdDcKYopjPyMVRacpF7gx7WzUznZ7WvE
         d4VUsEzGkRwBqaBW6fJ2VPF59WjkErDiHb0RhtTpUw6nlEC6jTEpXZtEYOM73LPQsG8R
         5/kr16jGvCGy7EjP8DVWOba9QD/dtlE4mBK5HIt6ct7FENswQJ39cnlm31JOGqONACdw
         ATaKrQSEXXCdIIZ1gmUkMzGogqfn5q8+4QBq4xIG2T7MCy2aewNjSLe8u1Wm8gK2hVRn
         SXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMSuAkZtX27i7TDRkVOKwB/SKG94w4AGTTD8RQ/V2uw=;
        b=gkhnSRbtEZArD7QovZeUB30N2codu1opOx1a0Qg9Qp43+RstGNqr/YSB2jTBJAGKVR
         9njAlPVx4ufC1uOMOVD1COWqPT/z1PG4eCx/QfrTdQJXg/mvwsFfIwrEiGPW5HaFNx4S
         wzSN+/VSEhgy/aE11fzOYvvFcZIydf0j5CZ/I/kc36KallRrS5KxivD5okJeijeM5L3l
         Mr5W7T9HF2eWKjr3Qg0VSry2ZU3YYy6eWBpIz1sfkrzb14WB0Bayen77kgYdHj8LYDs7
         x/rP+vm6MbXN36i7OdnhoKruC0rgI6Ha6NcjaNVz2hdet6BxF8OBxj8bRf5z9nVAh8B5
         5vwQ==
X-Gm-Message-State: AOAM531dTdQosLJI1smdMRf/JyTqylZ+hr/mn8fL5/Vq8S7RK/owf2Wn
        qrJukLvRSP2CsHAal8zgNlTMDF63d3eQ7Q==
X-Google-Smtp-Source: ABdhPJy3VcrR692NnB1Ie+aRjHTyrZH6FB27waniKLmwzHYfTYndOC0zLo3Bd0dwpbdumB6YgvLsRw==
X-Received: by 2002:a19:c7d7:: with SMTP id x206mr2047255lff.540.1600802838743;
        Tue, 22 Sep 2020 12:27:18 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r132sm3770013lff.167.2020.09.22.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:27:17 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 8/8] mfd: Constify static struct resource
Date:   Tue, 22 Sep 2020 21:26:59 +0200
Message-Id: <20200922192659.14535-9-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Constify a number of static struct resource. The only usage of the
structs are to assign their address to the resources field in the
mfd_cell struct. This allows the compiler to put them in read-only
memory. Done with the help of Coccinelle.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/mfd/88pm800.c              |  2 +-
 drivers/mfd/88pm860x-core.c        | 50 +++++++++++++-------------
 drivers/mfd/hi655x-pmic.c          |  2 +-
 drivers/mfd/intel_quark_i2c_gpio.c |  4 +--
 drivers/mfd/ioc3.c                 | 16 ++++-----
 drivers/mfd/max8925-core.c         | 56 +++++++++++++++---------------
 drivers/mfd/rdc321x-southbridge.c  |  4 +--
 drivers/mfd/retu-mfd.c             |  4 +--
 drivers/mfd/rk808.c                |  8 ++---
 drivers/mfd/tc3589x.c              |  4 +--
 drivers/mfd/tc6387xb.c             |  2 +-
 drivers/mfd/tc6393xb.c             |  6 ++--
 drivers/mfd/tps65090.c             |  2 +-
 drivers/mfd/tps6586x.c             |  2 +-
 drivers/mfd/tps80031.c             |  2 +-
 15 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
index 4e8d0d6b9b5c..c7f964996a91 100644
--- a/drivers/mfd/88pm800.c
+++ b/drivers/mfd/88pm800.c
@@ -121,7 +121,7 @@ static const struct i2c_device_id pm80x_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, pm80x_id_table);
 
-static struct resource rtc_resources[] = {
+static const struct resource rtc_resources[] = {
 	{
 	 .name = "88pm80x-rtc",
 	 .start = PM800_IRQ_RTC,
diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index c9bae71f643a..b1e829ea909b 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -26,99 +26,99 @@
 
 #define INT_STATUS_NUM			3
 
-static struct resource bk0_resources[] = {
+static const struct resource bk0_resources[] = {
 	{2, 2, "duty cycle", IORESOURCE_REG, },
 	{3, 3, "always on",  IORESOURCE_REG, },
 	{3, 3, "current",    IORESOURCE_REG, },
 };
-static struct resource bk1_resources[] = {
+static const struct resource bk1_resources[] = {
 	{4, 4, "duty cycle", IORESOURCE_REG, },
 	{5, 5, "always on",  IORESOURCE_REG, },
 	{5, 5, "current",    IORESOURCE_REG, },
 };
-static struct resource bk2_resources[] = {
+static const struct resource bk2_resources[] = {
 	{6, 6, "duty cycle", IORESOURCE_REG, },
 	{7, 7, "always on",  IORESOURCE_REG, },
 	{5, 5, "current",    IORESOURCE_REG, },
 };
 
-static struct resource led0_resources[] = {
+static const struct resource led0_resources[] = {
 	/* RGB1 Red LED */
 	{0xd, 0xd, "control", IORESOURCE_REG, },
 	{0xc, 0xc, "blink",   IORESOURCE_REG, },
 };
-static struct resource led1_resources[] = {
+static const struct resource led1_resources[] = {
 	/* RGB1 Green LED */
 	{0xe, 0xe, "control", IORESOURCE_REG, },
 	{0xc, 0xc, "blink",   IORESOURCE_REG, },
 };
-static struct resource led2_resources[] = {
+static const struct resource led2_resources[] = {
 	/* RGB1 Blue LED */
 	{0xf, 0xf, "control", IORESOURCE_REG, },
 	{0xc, 0xc, "blink",   IORESOURCE_REG, },
 };
-static struct resource led3_resources[] = {
+static const struct resource led3_resources[] = {
 	/* RGB2 Red LED */
 	{0x9, 0x9, "control", IORESOURCE_REG, },
 	{0x8, 0x8, "blink",   IORESOURCE_REG, },
 };
-static struct resource led4_resources[] = {
+static const struct resource led4_resources[] = {
 	/* RGB2 Green LED */
 	{0xa, 0xa, "control", IORESOURCE_REG, },
 	{0x8, 0x8, "blink",   IORESOURCE_REG, },
 };
-static struct resource led5_resources[] = {
+static const struct resource led5_resources[] = {
 	/* RGB2 Blue LED */
 	{0xb, 0xb, "control", IORESOURCE_REG, },
 	{0x8, 0x8, "blink",   IORESOURCE_REG, },
 };
 
-static struct resource buck1_resources[] = {
+static const struct resource buck1_resources[] = {
 	{0x24, 0x24, "buck set", IORESOURCE_REG, },
 };
-static struct resource buck2_resources[] = {
+static const struct resource buck2_resources[] = {
 	{0x25, 0x25, "buck set", IORESOURCE_REG, },
 };
-static struct resource buck3_resources[] = {
+static const struct resource buck3_resources[] = {
 	{0x26, 0x26, "buck set", IORESOURCE_REG, },
 };
-static struct resource ldo1_resources[] = {
+static const struct resource ldo1_resources[] = {
 	{0x10, 0x10, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo2_resources[] = {
+static const struct resource ldo2_resources[] = {
 	{0x11, 0x11, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo3_resources[] = {
+static const struct resource ldo3_resources[] = {
 	{0x12, 0x12, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo4_resources[] = {
+static const struct resource ldo4_resources[] = {
 	{0x13, 0x13, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo5_resources[] = {
+static const struct resource ldo5_resources[] = {
 	{0x14, 0x14, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo6_resources[] = {
+static const struct resource ldo6_resources[] = {
 	{0x15, 0x15, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo7_resources[] = {
+static const struct resource ldo7_resources[] = {
 	{0x16, 0x16, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo8_resources[] = {
+static const struct resource ldo8_resources[] = {
 	{0x17, 0x17, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo9_resources[] = {
+static const struct resource ldo9_resources[] = {
 	{0x18, 0x18, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo10_resources[] = {
+static const struct resource ldo10_resources[] = {
 	{0x19, 0x19, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo12_resources[] = {
+static const struct resource ldo12_resources[] = {
 	{0x1a, 0x1a, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo_vibrator_resources[] = {
+static const struct resource ldo_vibrator_resources[] = {
 	{0x28, 0x28, "ldo set", IORESOURCE_REG, },
 };
-static struct resource ldo14_resources[] = {
+static const struct resource ldo14_resources[] = {
 	{0x1b, 0x1b, "ldo set", IORESOURCE_REG, },
 };
 
diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
index 7e3959aaa285..d3c86a7a3805 100644
--- a/drivers/mfd/hi655x-pmic.c
+++ b/drivers/mfd/hi655x-pmic.c
@@ -49,7 +49,7 @@ static struct regmap_config hi655x_regmap_config = {
 	.max_register = HI655X_BUS_ADDR(0x400) - HI655X_STRIDE,
 };
 
-static struct resource pwrkey_resources[] = {
+static const struct resource pwrkey_resources[] = {
 	{
 		.name	= "down",
 		.start	= PWRON_D20R_INT,
diff --git a/drivers/mfd/intel_quark_i2c_gpio.c b/drivers/mfd/intel_quark_i2c_gpio.c
index 84ca7902e1df..fe8ca945f367 100644
--- a/drivers/mfd/intel_quark_i2c_gpio.c
+++ b/drivers/mfd/intel_quark_i2c_gpio.c
@@ -72,7 +72,7 @@ static const struct dmi_system_id dmi_platform_info[] = {
 	{}
 };
 
-static struct resource intel_quark_i2c_res[] = {
+static const struct resource intel_quark_i2c_res[] = {
 	[INTEL_QUARK_IORES_MEM] = {
 		.flags = IORESOURCE_MEM,
 	},
@@ -85,7 +85,7 @@ static struct mfd_cell_acpi_match intel_quark_acpi_match_i2c = {
 	.adr = MFD_ACPI_MATCH_I2C,
 };
 
-static struct resource intel_quark_gpio_res[] = {
+static const struct resource intel_quark_gpio_res[] = {
 	[INTEL_QUARK_IORES_MEM] = {
 		.flags = IORESOURCE_MEM,
 	},
diff --git a/drivers/mfd/ioc3.c b/drivers/mfd/ioc3.c
index d939ccc46509..c73ec78f255b 100644
--- a/drivers/mfd/ioc3.c
+++ b/drivers/mfd/ioc3.c
@@ -158,13 +158,13 @@ static int ioc3_irq_domain_setup(struct ioc3_priv_data *ipd, int irq)
 	return -ENOMEM;
 }
 
-static struct resource ioc3_uarta_resources[] = {
+static const struct resource ioc3_uarta_resources[] = {
 	DEFINE_RES_MEM(offsetof(struct ioc3, sregs.uarta),
 		       sizeof_field(struct ioc3, sregs.uarta)),
 	DEFINE_RES_IRQ(IOC3_IRQ_SERIAL_A)
 };
 
-static struct resource ioc3_uartb_resources[] = {
+static const struct resource ioc3_uartb_resources[] = {
 	DEFINE_RES_MEM(offsetof(struct ioc3, sregs.uartb),
 		       sizeof_field(struct ioc3, sregs.uartb)),
 	DEFINE_RES_IRQ(IOC3_IRQ_SERIAL_B)
@@ -213,7 +213,7 @@ static int ioc3_serial_setup(struct ioc3_priv_data *ipd)
 	return 0;
 }
 
-static struct resource ioc3_kbd_resources[] = {
+static const struct resource ioc3_kbd_resources[] = {
 	DEFINE_RES_MEM(offsetof(struct ioc3, serio),
 		       sizeof_field(struct ioc3, serio)),
 	DEFINE_RES_IRQ(IOC3_IRQ_KBD)
@@ -242,7 +242,7 @@ static int ioc3_kbd_setup(struct ioc3_priv_data *ipd)
 	return 0;
 }
 
-static struct resource ioc3_eth_resources[] = {
+static const struct resource ioc3_eth_resources[] = {
 	DEFINE_RES_MEM(offsetof(struct ioc3, eth),
 		       sizeof_field(struct ioc3, eth)),
 	DEFINE_RES_MEM(offsetof(struct ioc3, ssram),
@@ -250,7 +250,7 @@ static struct resource ioc3_eth_resources[] = {
 	DEFINE_RES_IRQ(0)
 };
 
-static struct resource ioc3_w1_resources[] = {
+static const struct resource ioc3_w1_resources[] = {
 	DEFINE_RES_MEM(offsetof(struct ioc3, mcr),
 		       sizeof_field(struct ioc3, mcr)),
 };
@@ -294,7 +294,7 @@ static int ioc3_eth_setup(struct ioc3_priv_data *ipd)
 	return 0;
 }
 
-static struct resource ioc3_m48t35_resources[] = {
+static const struct resource ioc3_m48t35_resources[] = {
 	DEFINE_RES_MEM(IOC3_BYTEBUS_DEV0, M48T35_REG_SIZE)
 };
 
@@ -326,7 +326,7 @@ static struct ds1685_rtc_platform_data ip30_rtc_platform_data = {
 	.access_type = ds1685_reg_indirect,
 };
 
-static struct resource ioc3_rtc_ds1685_resources[] = {
+static const struct resource ioc3_rtc_ds1685_resources[] = {
 	DEFINE_RES_MEM(IOC3_BYTEBUS_DEV1, 1),
 	DEFINE_RES_MEM(IOC3_BYTEBUS_DEV2, 1),
 	DEFINE_RES_IRQ(0)
@@ -359,7 +359,7 @@ static int ioc3_ds1685_setup(struct ioc3_priv_data *ipd)
 };
 
 
-static struct resource ioc3_leds_resources[] = {
+static const struct resource ioc3_leds_resources[] = {
 	DEFINE_RES_MEM(offsetof(struct ioc3, gppr[0]),
 		       sizeof_field(struct ioc3, gppr[0])),
 	DEFINE_RES_MEM(offsetof(struct ioc3, gppr[1]),
diff --git a/drivers/mfd/max8925-core.c b/drivers/mfd/max8925-core.c
index 0af6833b4080..eb3f061c8ee6 100644
--- a/drivers/mfd/max8925-core.c
+++ b/drivers/mfd/max8925-core.c
@@ -19,7 +19,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 
-static struct resource bk_resources[] = {
+static const struct resource bk_resources[] = {
 	{ 0x84, 0x84, "mode control", IORESOURCE_REG, },
 	{ 0x85, 0x85, "control",      IORESOURCE_REG, },
 };
@@ -33,7 +33,7 @@ static struct mfd_cell bk_devs[] = {
 	},
 };
 
-static struct resource touch_resources[] = {
+static const struct resource touch_resources[] = {
 	{
 		.name	= "max8925-tsc",
 		.start	= MAX8925_TSC_IRQ,
@@ -51,7 +51,7 @@ static const struct mfd_cell touch_devs[] = {
 	},
 };
 
-static struct resource power_supply_resources[] = {
+static const struct resource power_supply_resources[] = {
 	{
 		.name	= "max8925-power",
 		.start	= MAX8925_CHG_IRQ1,
@@ -69,7 +69,7 @@ static const struct mfd_cell power_devs[] = {
 	},
 };
 
-static struct resource rtc_resources[] = {
+static const struct resource rtc_resources[] = {
 	{
 		.name	= "max8925-rtc",
 		.start	= MAX8925_IRQ_RTC_ALARM0,
@@ -87,7 +87,7 @@ static const struct mfd_cell rtc_devs[] = {
 	},
 };
 
-static struct resource onkey_resources[] = {
+static const struct resource onkey_resources[] = {
 	{
 		.name	= "max8925-onkey",
 		.start	= MAX8925_IRQ_GPM_SW_R,
@@ -110,95 +110,95 @@ static const struct mfd_cell onkey_devs[] = {
 	},
 };
 
-static struct resource sd1_resources[] = {
+static const struct resource sd1_resources[] = {
 	{0x06, 0x06, "sdv", IORESOURCE_REG, },
 };
 
-static struct resource sd2_resources[] = {
+static const struct resource sd2_resources[] = {
 	{0x09, 0x09, "sdv", IORESOURCE_REG, },
 };
 
-static struct resource sd3_resources[] = {
+static const struct resource sd3_resources[] = {
 	{0x0c, 0x0c, "sdv", IORESOURCE_REG, },
 };
 
-static struct resource ldo1_resources[] = {
+static const struct resource ldo1_resources[] = {
 	{0x1a, 0x1a, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo2_resources[] = {
+static const struct resource ldo2_resources[] = {
 	{0x1e, 0x1e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo3_resources[] = {
+static const struct resource ldo3_resources[] = {
 	{0x22, 0x22, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo4_resources[] = {
+static const struct resource ldo4_resources[] = {
 	{0x26, 0x26, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo5_resources[] = {
+static const struct resource ldo5_resources[] = {
 	{0x2a, 0x2a, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo6_resources[] = {
+static const struct resource ldo6_resources[] = {
 	{0x2e, 0x2e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo7_resources[] = {
+static const struct resource ldo7_resources[] = {
 	{0x32, 0x32, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo8_resources[] = {
+static const struct resource ldo8_resources[] = {
 	{0x36, 0x36, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo9_resources[] = {
+static const struct resource ldo9_resources[] = {
 	{0x3a, 0x3a, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo10_resources[] = {
+static const struct resource ldo10_resources[] = {
 	{0x3e, 0x3e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo11_resources[] = {
+static const struct resource ldo11_resources[] = {
 	{0x42, 0x42, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo12_resources[] = {
+static const struct resource ldo12_resources[] = {
 	{0x46, 0x46, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo13_resources[] = {
+static const struct resource ldo13_resources[] = {
 	{0x4a, 0x4a, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo14_resources[] = {
+static const struct resource ldo14_resources[] = {
 	{0x4e, 0x4e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo15_resources[] = {
+static const struct resource ldo15_resources[] = {
 	{0x52, 0x52, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo16_resources[] = {
+static const struct resource ldo16_resources[] = {
 	{0x12, 0x12, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo17_resources[] = {
+static const struct resource ldo17_resources[] = {
 	{0x16, 0x16, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo18_resources[] = {
+static const struct resource ldo18_resources[] = {
 	{0x74, 0x74, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo19_resources[] = {
+static const struct resource ldo19_resources[] = {
 	{0x5e, 0x5e, "ldov", IORESOURCE_REG, },
 };
 
-static struct resource ldo20_resources[] = {
+static const struct resource ldo20_resources[] = {
 	{0x9e, 0x9e, "ldov", IORESOURCE_REG, },
 };
 
diff --git a/drivers/mfd/rdc321x-southbridge.c b/drivers/mfd/rdc321x-southbridge.c
index fbb1faf95e27..c44a76285147 100644
--- a/drivers/mfd/rdc321x-southbridge.c
+++ b/drivers/mfd/rdc321x-southbridge.c
@@ -14,7 +14,7 @@
 
 static struct rdc321x_wdt_pdata rdc321x_wdt_pdata;
 
-static struct resource rdc321x_wdt_resource[] = {
+static const struct resource rdc321x_wdt_resource[] = {
 	{
 		.name	= "wdt-reg",
 		.start	= RDC321X_WDT_CTRL,
@@ -27,7 +27,7 @@ static struct rdc321x_gpio_pdata rdc321x_gpio_pdata = {
 	.max_gpios	= RDC321X_NUM_GPIO,
 };
 
-static struct resource rdc321x_gpio_resources[] = {
+static const struct resource rdc321x_gpio_resources[] = {
 	{
 		.name	= "gpio-reg1",
 		.start	= RDC321X_GPIO_CTRL_REG1,
diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index e7d27b7861c1..c748fd29a220 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -45,7 +45,7 @@ struct retu_dev {
 	struct regmap_irq_chip_data	*irq_data;
 };
 
-static struct resource retu_pwrbutton_res[] = {
+static const struct resource retu_pwrbutton_res[] = {
 	{
 		.name	= "retu-pwrbutton",
 		.start	= RETU_INT_PWR,
@@ -84,7 +84,7 @@ static struct regmap_irq_chip retu_irq_chip = {
 /* Retu device registered for the power off. */
 static struct retu_dev *retu_pm_power_off;
 
-static struct resource tahvo_usb_res[] = {
+static const struct resource tahvo_usb_res[] = {
 	{
 		.name	= "tahvo-usb",
 		.start	= TAHVO_INT_VBUS,
diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index d109b9f14407..ad923dd4e007 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -107,20 +107,20 @@ static const struct regmap_config rk817_regmap_config = {
 	.volatile_reg = rk817_is_volatile_reg,
 };
 
-static struct resource rtc_resources[] = {
+static const struct resource rtc_resources[] = {
 	DEFINE_RES_IRQ(RK808_IRQ_RTC_ALARM),
 };
 
-static struct resource rk817_rtc_resources[] = {
+static const struct resource rk817_rtc_resources[] = {
 	DEFINE_RES_IRQ(RK817_IRQ_RTC_ALARM),
 };
 
-static struct resource rk805_key_resources[] = {
+static const struct resource rk805_key_resources[] = {
 	DEFINE_RES_IRQ(RK805_IRQ_PWRON_RISE),
 	DEFINE_RES_IRQ(RK805_IRQ_PWRON_FALL),
 };
 
-static struct resource rk817_pwrkey_resources[] = {
+static const struct resource rk817_pwrkey_resources[] = {
 	DEFINE_RES_IRQ(RK817_IRQ_PWRON_RISE),
 	DEFINE_RES_IRQ(RK817_IRQ_PWRON_FALL),
 };
diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 7882a37ffc35..7614f8fe0e91 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -141,7 +141,7 @@ int tc3589x_set_bits(struct tc3589x *tc3589x, u8 reg, u8 mask, u8 val)
 }
 EXPORT_SYMBOL_GPL(tc3589x_set_bits);
 
-static struct resource gpio_resources[] = {
+static const struct resource gpio_resources[] = {
 	{
 		.start	= TC3589x_INT_GPIIRQ,
 		.end	= TC3589x_INT_GPIIRQ,
@@ -149,7 +149,7 @@ static struct resource gpio_resources[] = {
 	},
 };
 
-static struct resource keypad_resources[] = {
+static const struct resource keypad_resources[] = {
 	{
 		.start  = TC3589x_INT_KBDIRQ,
 		.end    = TC3589x_INT_KBDIRQ,
diff --git a/drivers/mfd/tc6387xb.c b/drivers/mfd/tc6387xb.c
index c66a701ab21c..e846e4d26b6e 100644
--- a/drivers/mfd/tc6387xb.c
+++ b/drivers/mfd/tc6387xb.c
@@ -25,7 +25,7 @@ struct tc6387xb {
 	struct resource rscr;
 };
 
-static struct resource tc6387xb_mmc_resources[] = {
+static const struct resource tc6387xb_mmc_resources[] = {
 	{
 		.start = 0x800,
 		.end   = 0x9ff,
diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
index 05d5059ca203..3d5b14c60e20 100644
--- a/drivers/mfd/tc6393xb.c
+++ b/drivers/mfd/tc6393xb.c
@@ -133,7 +133,7 @@ static int tc6393xb_nand_enable(struct platform_device *nand)
 	return 0;
 }
 
-static struct resource tc6393xb_nand_resources[] = {
+static const struct resource tc6393xb_nand_resources[] = {
 	{
 		.start	= 0x1000,
 		.end	= 0x1007,
@@ -151,7 +151,7 @@ static struct resource tc6393xb_nand_resources[] = {
 	},
 };
 
-static struct resource tc6393xb_mmc_resources[] = {
+static const struct resource tc6393xb_mmc_resources[] = {
 	{
 		.start	= 0x800,
 		.end	= 0x9ff,
@@ -192,7 +192,7 @@ static const struct resource tc6393xb_ohci_resources[] = {
 	},
 };
 
-static struct resource tc6393xb_fb_resources[] = {
+static const struct resource tc6393xb_fb_resources[] = {
 	{
 		.start	= 0x5000,
 		.end	= 0x51ff,
diff --git a/drivers/mfd/tps65090.c b/drivers/mfd/tps65090.c
index 6cdf6c315034..bd6235308c6b 100644
--- a/drivers/mfd/tps65090.c
+++ b/drivers/mfd/tps65090.c
@@ -38,7 +38,7 @@
 #define TPS65090_INT2_MASK_OVERLOAD_FET6		6
 #define TPS65090_INT2_MASK_OVERLOAD_FET7		7
 
-static struct resource charger_resources[] = {
+static const struct resource charger_resources[] = {
 	{
 		.start  = TPS65090_IRQ_VAC_STATUS_CHANGE,
 		.end    = TPS65090_IRQ_VAC_STATUS_CHANGE,
diff --git a/drivers/mfd/tps6586x.c b/drivers/mfd/tps6586x.c
index c36597797ddd..c9303d3d6602 100644
--- a/drivers/mfd/tps6586x.c
+++ b/drivers/mfd/tps6586x.c
@@ -92,7 +92,7 @@ static const struct tps6586x_irq_data tps6586x_irqs[] = {
 	[TPS6586X_INT_RTC_ALM2] = TPS6586X_IRQ(TPS6586X_INT_MASK4, 1 << 1),
 };
 
-static struct resource tps6586x_rtc_resources[] = {
+static const struct resource tps6586x_rtc_resources[] = {
 	{
 		.start  = TPS6586X_INT_RTC_ALM1,
 		.end	= TPS6586X_INT_RTC_ALM1,
diff --git a/drivers/mfd/tps80031.c b/drivers/mfd/tps80031.c
index 907452b86e32..902e33548dd0 100644
--- a/drivers/mfd/tps80031.c
+++ b/drivers/mfd/tps80031.c
@@ -34,7 +34,7 @@
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-static struct resource tps80031_rtc_resources[] = {
+static const struct resource tps80031_rtc_resources[] = {
 	{
 		.start = TPS80031_INT_RTC_ALARM,
 		.end = TPS80031_INT_RTC_ALARM,
-- 
2.28.0

