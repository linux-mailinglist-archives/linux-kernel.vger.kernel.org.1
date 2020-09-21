Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D96273565
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgIUV7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:59:49 -0400
Received: from mail1.nippynetworks.com ([91.220.24.129]:52894 "EHLO
        mail1.nippynetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgIUV7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:59:48 -0400
Received: from twocubed.nippynetworks.com (office.nippynetworks.com [46.17.61.232])
        by mail1.nippynetworks.com (Postfix) with SMTP id 4BwJJJ3DxYzTh52;
        Mon, 21 Sep 2020 22:59:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wildgooses.com;
        s=dkim; t=1600725585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rSEHJXHj9+tzEtZxthMuBV/BCzmmpJbJqqHn0YCShZA=;
        b=eIJ3U+ruHMXCv19xGznQxLQTuXwtFKB1ZqgLJSZ3dQPZ3P/oNp7NUwRhLGd1jYsNbJWikO
        1dp1ifekWiGDD4XQqNUU9/YAb0ot2h9yOi0+/iqzVByPqBAJdxv5f9umBKd8spTC+q4laN
        0Y8umWNjT37zAtxkmXpHC4Tik7BqM8Y=
Received: by twocubed.nippynetworks.com (sSMTP sendmail emulation); Mon, 21 Sep 2020 22:59:44 +0100
From:   Ed Wildgoose <lists@wildgooses.com>
To:     linux-kernel@vger.kernel.org
Cc:     fe@dev.tdt.de, Ed Wildgoose <lists@wildgooses.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 1/2] x86: Remove led/gpio setup from pcengines platform driver
Date:   Mon, 21 Sep 2020 22:59:18 +0100
Message-Id: <20200921215919.3072-1-lists@wildgooses.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcengines bios/firmware includes ACPI tables (since 4.10.0.1) which
will cause the kernel to automatically create led + gpio_key devices for
the platform. This means that the platform setup now creates duplicates
of all these led/key devices.

Anyone with a much older bios can use the 'leds-apu' driver to get the
same set of led devices as created by the kernel with a modern bios.

Signed-off-by: Ed Wildgoose <lists@wildgooses.com>
---
 drivers/platform/x86/pcengines-apuv2.c | 76 +-------------------------
 1 file changed, 1 insertion(+), 75 deletions(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index c37349f97..41e3005cd 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -72,60 +72,6 @@ static const struct amd_fch_gpio_pdata board_apu2 = {
 	.gpio_names	= apu2_gpio_names,
 };
 
-/* GPIO LEDs device */
-
-static const struct gpio_led apu2_leds[] = {
-	{ .name = "apu:green:1" },
-	{ .name = "apu:green:2" },
-	{ .name = "apu:green:3" },
-};
-
-static const struct gpio_led_platform_data apu2_leds_pdata = {
-	.num_leds	= ARRAY_SIZE(apu2_leds),
-	.leds		= apu2_leds,
-};
-
-static struct gpiod_lookup_table gpios_led_table = {
-	.dev_id = "leds-gpio",
-	.table = {
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED1,
-				NULL, 0, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED2,
-				NULL, 1, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED3,
-				NULL, 2, GPIO_ACTIVE_LOW),
-	}
-};
-
-/* GPIO keyboard device */
-
-static struct gpio_keys_button apu2_keys_buttons[] = {
-	{
-		.code			= KEY_RESTART,
-		.active_low		= 1,
-		.desc			= "front button",
-		.type			= EV_KEY,
-		.debounce_interval	= 10,
-		.value			= 1,
-	},
-};
-
-static const struct gpio_keys_platform_data apu2_keys_pdata = {
-	.buttons	= apu2_keys_buttons,
-	.nbuttons	= ARRAY_SIZE(apu2_keys_buttons),
-	.poll_interval	= 100,
-	.rep		= 0,
-	.name		= "apu2-keys",
-};
-
-static struct gpiod_lookup_table gpios_key_table = {
-	.dev_id = "gpio-keys-polled",
-	.table = {
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_MODESW,
-				NULL, 0, GPIO_ACTIVE_LOW),
-	}
-};
-
 /* Board setup */
 
 /* Note: matching works on string prefix, so "apu2" must come before "apu" */
@@ -217,8 +163,6 @@ static const struct dmi_system_id apu_gpio_dmi_table[] __initconst = {
 };
 
 static struct platform_device *apu_gpio_pdev;
-static struct platform_device *apu_leds_pdev;
-static struct platform_device *apu_keys_pdev;
 
 static struct platform_device * __init apu_create_pdev(
 	const char *name,
@@ -247,38 +191,20 @@ static int __init apu_board_init(void)
 
 	id = dmi_first_match(apu_gpio_dmi_table);
 	if (!id) {
-		pr_err("failed to detect APU board via DMI\n");
+		pr_err("No APU board detected via DMI\n");
 		return -ENODEV;
 	}
 
-	gpiod_add_lookup_table(&gpios_led_table);
-	gpiod_add_lookup_table(&gpios_key_table);
-
 	apu_gpio_pdev = apu_create_pdev(
 		AMD_FCH_GPIO_DRIVER_NAME,
 		id->driver_data,
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
-
 	return 0;
 }
 
 static void __exit apu_board_exit(void)
 {
-	gpiod_remove_lookup_table(&gpios_led_table);
-	gpiod_remove_lookup_table(&gpios_key_table);
-
-	platform_device_unregister(apu_keys_pdev);
-	platform_device_unregister(apu_leds_pdev);
 	platform_device_unregister(apu_gpio_pdev);
 }
 
-- 
2.26.2

