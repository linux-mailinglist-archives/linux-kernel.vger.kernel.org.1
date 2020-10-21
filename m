Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A63295466
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506376AbgJUVmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:42:52 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:40372 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506368AbgJUVmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:42:51 -0400
Received: from twocubed.nippynetworks.com (office.nippynetworks.com [46.17.61.232])
        by mail1.nippynetworks.com (Postfix) with SMTP id 4CGkVs3Mj8zTgHH;
        Wed, 21 Oct 2020 22:42:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1603316567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obz0A9+Gwmim9UP/hsOZvznrTgs5bA8jIruEk/dsfsM=;
        b=lrucWI0O2WVTNzhD1s/Iy+3REfEnz4FJMzbFkpn5iIlI0xkwi9Zl+uvbr8dZ2u/Nq/sK2o
        uzRvCSl+Tm2o2svoAd0gWXs417FMWobcW6Fq0vOwmsTNvgY0MjZ+QBINIgOnEifNO/7cUk
        jHNodhAzvdMl9jfZHtqeYUBg7QnPuYE=
Received: by twocubed.nippynetworks.com (sSMTP sendmail emulation); Wed, 21 Oct 2020 22:42:45 +0100
From:   Ed Wildgoose <lists@wildgooses.com>
To:     linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, hdegoede@redhat.com,
        Ed Wildgoose <lists@wildgooses.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/2] x86: Conditional init of pcengines leds/keys gpios
Date:   Wed, 21 Oct 2020 22:41:49 +0100
Message-Id: <20201021214151.32229-1-lists@wildgooses.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <2ba7fc12-a3a7-2783-54e6-27e9eb60ec9c@redhat.com>
References: <2ba7fc12-a3a7-2783-54e6-27e9eb60ec9c@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcengines bios/firmware includes ACPI tables (since 4.10.0.1) which
will cause the kernel to automatically create led + gpio_key devices for
the platform. This means that the platform setup now creates duplicates
of all these led/key devices.

Driver conditionally initialises leds/keys only for older bios.

Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
---
 drivers/platform/x86/pcengines-apuv2.c | 115 +++++++++++++++++++------
 1 file changed, 90 insertions(+), 25 deletions(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index c37349f97..45f7a89de 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -128,6 +128,18 @@ static struct gpiod_lookup_table gpios_key_table = {
 
 /* Board setup */
 
+struct apu_driver_data {
+	const struct amd_fch_gpio_pdata *board_data;
+	const struct gpio_keys_platform_data *apu_keys_pdata;
+	const struct gpio_led_platform_data *apu_leds_pdata;
+};
+
+static struct apu_driver_data apu2_driver_data = {
+	.board_data = &board_apu2,
+	.apu_keys_pdata = &apu2_keys_pdata,
+	.apu_leds_pdata = &apu2_leds_pdata
+};
+
 /* Note: matching works on string prefix, so "apu2" must come before "apu" */
 static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 
@@ -138,7 +150,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
 			DMI_MATCH(DMI_BOARD_NAME, "APU2")
 		},
-		.driver_data	= (void *)&board_apu2,
+		.driver_data	= (void *)&apu2_driver_data,
 	},
 	/* APU2 w/ legacy BIOS >= 4.0.8 */
 	{
@@ -147,7 +159,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
 			DMI_MATCH(DMI_BOARD_NAME, "apu2")
 		},
-		.driver_data	= (void *)&board_apu2,
+		.driver_data	= (void *)&apu2_driver_data,
 	},
 	/* APU2 w/ mainline BIOS */
 	{
@@ -156,7 +168,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
 			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
 		},
-		.driver_data	= (void *)&board_apu2,
+		.driver_data	= (void *)&apu2_driver_data,
 	},
 
 	/* APU3 w/ legacy BIOS < 4.0.8 */
@@ -166,7 +178,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
 			DMI_MATCH(DMI_BOARD_NAME, "APU3")
 		},
-		.driver_data = (void *)&board_apu2,
+		.driver_data = (void *)&apu2_driver_data,
 	},
 	/* APU3 w/ legacy BIOS >= 4.0.8 */
 	{
@@ -175,7 +187,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
 			DMI_MATCH(DMI_BOARD_NAME, "apu3")
 		},
-		.driver_data = (void *)&board_apu2,
+		.driver_data = (void *)&apu2_driver_data,
 	},
 	/* APU3 w/ mainline BIOS */
 	{
@@ -184,7 +196,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
 			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
 		},
-		.driver_data = (void *)&board_apu2,
+		.driver_data = (void *)&apu2_driver_data,
 	},
 	/* APU4 w/ legacy BIOS < 4.0.8 */
 	{
@@ -193,7 +205,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
 			DMI_MATCH(DMI_BOARD_NAME, "APU4")
 		},
-		.driver_data = (void *)&board_apu2,
+		.driver_data = (void *)&apu2_driver_data,
 	},
 	/* APU4 w/ legacy BIOS >= 4.0.8 */
 	{
@@ -202,7 +214,7 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
 			DMI_MATCH(DMI_BOARD_NAME, "apu4")
 		},
-		.driver_data = (void *)&board_apu2,
+		.driver_data = (void *)&apu2_driver_data,
 	},
 	/* APU4 w/ mainline BIOS */
 	{
@@ -211,11 +223,42 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
 			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu4")
 		},
-		.driver_data = (void *)&board_apu2,
+		.driver_data = (void *)&apu2_driver_data,
 	},
 	{}
 };
 
+int cmp_version(const char *base, const char *test)
+{
+	int i;
+	int oct_base[4], oct_test[4];
+	int matched_base, matched;
+
+	matched_base = sscanf(base, "v%4d.%4d.%4d.%4d",
+					&oct_base[0], &oct_base[1],
+					&oct_base[2], &oct_base[3]);
+	matched = sscanf(test, "v%4d.%4d.%4d.%4d",
+					&oct_test[0], &oct_test[1],
+					&oct_test[2], &oct_test[3]);
+
+	/* opinionated: match as lower if we can't parse test version */
+	if (matched == 0)
+		return -1;
+
+	if (matched_base < matched)
+		matched = matched_base;
+
+	for (i = 0; i < matched; i++) {
+		if (oct_test[i] > oct_base[i])
+			return 1;
+		else if (oct_test[i] < oct_base[i])
+			return -1;
+	}
+
+	return 0;
+}
+
+
 static struct platform_device *apu_gpio_pdev;
 static struct platform_device *apu_leds_pdev;
 static struct platform_device *apu_keys_pdev;
@@ -244,41 +287,63 @@ static struct platform_device * __init apu_create_pdev(
 static int __init apu_board_init(void)
 {
 	const struct dmi_system_id *id;
+	const struct apu_driver_data *driver_data;
+	char const *bios_ver;
+
+	apu_leds_pdev = apu_keys_pdev = NULL;
 
 	id = dmi_first_match(apu_gpio_dmi_table);
 	if (!id) {
 		pr_err("failed to detect APU board via DMI\n");
 		return -ENODEV;
+	} else {
+		pr_info("Detected APU board: %s - BIOS: %s\n",
+		dmi_get_system_info(DMI_BOARD_NAME),
+		dmi_get_system_info(DMI_BIOS_VERSION));
 	}
 
-	gpiod_add_lookup_table(&gpios_led_table);
-	gpiod_add_lookup_table(&gpios_key_table);
+	driver_data = id->driver_data;
+	bios_ver = dmi_get_system_info(DMI_BIOS_VERSION);
 
 	apu_gpio_pdev = apu_create_pdev(
 		AMD_FCH_GPIO_DRIVER_NAME,
-		id->driver_data,
+		driver_data->board_data,
 		sizeof(struct amd_fch_gpio_pdata));
 
-	apu_leds_pdev = apu_create_pdev(
-		"leds-gpio",
-		&apu2_leds_pdata,
-		sizeof(apu2_leds_pdata));
-
-	apu_keys_pdev = apu_create_pdev(
-		"gpio-keys-polled",
-		&apu2_keys_pdata,
-		sizeof(apu2_keys_pdata));
+	if (cmp_version("v4.10", bios_ver) < 0) {
+		/* Newer bios configure LEDs/keys via ACPI */
+
+		if (driver_data->apu_keys_pdata) {
+			gpiod_add_lookup_table(&gpios_key_table);
+			apu_keys_pdev = apu_create_pdev(
+				"gpio-keys-polled",
+				driver_data->apu_keys_pdata,
+				sizeof(struct gpio_keys_platform_data));
+		}
+
+		if (driver_data->apu_leds_pdata) {
+			gpiod_add_lookup_table(&gpios_led_table);
+			apu_leds_pdev = apu_create_pdev(
+				"leds-gpio",
+				driver_data->apu_leds_pdata,
+				sizeof(struct gpio_led_platform_data));
+		}
+	}
 
 	return 0;
 }
 
 static void __exit apu_board_exit(void)
 {
-	gpiod_remove_lookup_table(&gpios_led_table);
-	gpiod_remove_lookup_table(&gpios_key_table);
+	if (apu_keys_pdev) {
+		gpiod_remove_lookup_table(&gpios_key_table);
+		platform_device_unregister(apu_keys_pdev);
+	}
+	if (apu_leds_pdev) {
+		gpiod_remove_lookup_table(&gpios_led_table);
+		platform_device_unregister(apu_leds_pdev);
+	}
 
-	platform_device_unregister(apu_keys_pdev);
-	platform_device_unregister(apu_leds_pdev);
 	platform_device_unregister(apu_gpio_pdev);
 }
 
-- 
2.26.2

