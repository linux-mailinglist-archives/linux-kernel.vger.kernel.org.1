Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AD3274911
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIVT1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgIVT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:27:14 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBA9C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id y17so19311021lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Amzt9vWSUKeXSzNpgJnjETaLPwDbO4A1EADm/e3IkpY=;
        b=Zt5JnYKdV4K2/69PQSt1t3//vt75f4+c9QX3TLJrdDrxo3X5X1uokrJVvx0SUXQ+sX
         Edrsys6nlprfZV01LRAtgYRNG2YRHfu64TAmp3vukkJPdXi3/NJLIlewCAaIrzwzukzW
         InQ1cCXFubJJnesLvD++VHr/TGsK0feg4RO5MWc45z3X7TJsJOcUcKaUcKNovA8bQMvW
         vNgbSgIbXg7WAmGcX/jbgBQdkn0bHkNfYg2DT00TwxtrcX7yNeSGPZHztsrQSN4Y8I0a
         JPOSol8DZrBa9XovQz/TUWhV8ZKiDlFPxEKsJ4QIyvEumKLUdjJu8P0hyK1QfrzqudYM
         Ngwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Amzt9vWSUKeXSzNpgJnjETaLPwDbO4A1EADm/e3IkpY=;
        b=pR91mTRM2NLOROtoMhn+i/t4vkzlygtWzVSbq6BtdDPvyefCVLQReP05co5RMRxr0U
         +Z6jXGxWqx46ciRK3+uxh9Vt9db54T3xX7ptBCka330qm0GB9SEs/NLCQ2Esyp0BfpiD
         HulBe/Byk+m83k0opzio2OnHK7dc6iCnMv8nLro3Te9h31HJrF2/RwXiZ4W06At46pCK
         JF/MaUqpVF9SIW5q3crVpqKspni3NSTj20HWowZpfxG9AZJfyUHmBnVduomHbhlvTFZg
         7GfC4J5pLfWcpe7mXYuKG8+TbrzoROv792nafBI8z0kclqzM1YZt4F+stRvht5Fc34/f
         GlfA==
X-Gm-Message-State: AOAM5301mHkJRxyrzuoe+35jqAoVscP2qUW03MiA3hr3QEdQnlW63shb
        b4ZD0CZpIcIy9Edl3EPW2hQ=
X-Google-Smtp-Source: ABdhPJy52i+61sfFsT2ZpYHLmfTkUeMi4HyqZD+UFI+7QdSDNkmiJLfopiMgJ69AQD2Ala8gg9F62A==
X-Received: by 2002:a19:8044:: with SMTP id b65mr2016130lfd.366.1600802832808;
        Tue, 22 Sep 2020 12:27:12 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r132sm3770013lff.167.2020.09.22.12.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:27:11 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        patches@opensource.cirrus.com
Subject: [PATCH 4/8] mfd: wm: Constify static struct resource
Date:   Tue, 22 Sep 2020 21:26:55 +0200
Message-Id: <20200922192659.14535-5-rikard.falkeborn@gmail.com>
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
 drivers/mfd/wm831x-core.c | 52 +++++++++++++++++++--------------------
 drivers/mfd/wm8994-core.c |  4 +--
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/mfd/wm831x-core.c b/drivers/mfd/wm831x-core.c
index b0344e5353e4..bcef08f58fb3 100644
--- a/drivers/mfd/wm831x-core.c
+++ b/drivers/mfd/wm831x-core.c
@@ -616,7 +616,7 @@ int wm831x_set_bits(struct wm831x *wm831x, unsigned short reg,
 }
 EXPORT_SYMBOL_GPL(wm831x_set_bits);
 
-static struct resource wm831x_dcdc1_resources[] = {
+static const struct resource wm831x_dcdc1_resources[] = {
 	{
 		.start = WM831X_DC1_CONTROL_1,
 		.end   = WM831X_DC1_DVS_CONTROL,
@@ -637,7 +637,7 @@ static struct resource wm831x_dcdc1_resources[] = {
 };
 
 
-static struct resource wm831x_dcdc2_resources[] = {
+static const struct resource wm831x_dcdc2_resources[] = {
 	{
 		.start = WM831X_DC2_CONTROL_1,
 		.end   = WM831X_DC2_DVS_CONTROL,
@@ -657,7 +657,7 @@ static struct resource wm831x_dcdc2_resources[] = {
 	},
 };
 
-static struct resource wm831x_dcdc3_resources[] = {
+static const struct resource wm831x_dcdc3_resources[] = {
 	{
 		.start = WM831X_DC3_CONTROL_1,
 		.end   = WM831X_DC3_SLEEP_CONTROL,
@@ -671,7 +671,7 @@ static struct resource wm831x_dcdc3_resources[] = {
 	},
 };
 
-static struct resource wm831x_dcdc4_resources[] = {
+static const struct resource wm831x_dcdc4_resources[] = {
 	{
 		.start = WM831X_DC4_CONTROL,
 		.end   = WM831X_DC4_SLEEP_CONTROL,
@@ -685,7 +685,7 @@ static struct resource wm831x_dcdc4_resources[] = {
 	},
 };
 
-static struct resource wm8320_dcdc4_buck_resources[] = {
+static const struct resource wm8320_dcdc4_buck_resources[] = {
 	{
 		.start = WM831X_DC4_CONTROL,
 		.end   = WM832X_DC4_SLEEP_CONTROL,
@@ -699,7 +699,7 @@ static struct resource wm8320_dcdc4_buck_resources[] = {
 	},
 };
 
-static struct resource wm831x_gpio_resources[] = {
+static const struct resource wm831x_gpio_resources[] = {
 	{
 		.start = WM831X_IRQ_GPIO_1,
 		.end   = WM831X_IRQ_GPIO_16,
@@ -707,7 +707,7 @@ static struct resource wm831x_gpio_resources[] = {
 	},
 };
 
-static struct resource wm831x_isink1_resources[] = {
+static const struct resource wm831x_isink1_resources[] = {
 	{
 		.start = WM831X_CURRENT_SINK_1,
 		.end   = WM831X_CURRENT_SINK_1,
@@ -720,7 +720,7 @@ static struct resource wm831x_isink1_resources[] = {
 	},
 };
 
-static struct resource wm831x_isink2_resources[] = {
+static const struct resource wm831x_isink2_resources[] = {
 	{
 		.start = WM831X_CURRENT_SINK_2,
 		.end   = WM831X_CURRENT_SINK_2,
@@ -733,7 +733,7 @@ static struct resource wm831x_isink2_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo1_resources[] = {
+static const struct resource wm831x_ldo1_resources[] = {
 	{
 		.start = WM831X_LDO1_CONTROL,
 		.end   = WM831X_LDO1_SLEEP_CONTROL,
@@ -747,7 +747,7 @@ static struct resource wm831x_ldo1_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo2_resources[] = {
+static const struct resource wm831x_ldo2_resources[] = {
 	{
 		.start = WM831X_LDO2_CONTROL,
 		.end   = WM831X_LDO2_SLEEP_CONTROL,
@@ -761,7 +761,7 @@ static struct resource wm831x_ldo2_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo3_resources[] = {
+static const struct resource wm831x_ldo3_resources[] = {
 	{
 		.start = WM831X_LDO3_CONTROL,
 		.end   = WM831X_LDO3_SLEEP_CONTROL,
@@ -775,7 +775,7 @@ static struct resource wm831x_ldo3_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo4_resources[] = {
+static const struct resource wm831x_ldo4_resources[] = {
 	{
 		.start = WM831X_LDO4_CONTROL,
 		.end   = WM831X_LDO4_SLEEP_CONTROL,
@@ -789,7 +789,7 @@ static struct resource wm831x_ldo4_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo5_resources[] = {
+static const struct resource wm831x_ldo5_resources[] = {
 	{
 		.start = WM831X_LDO5_CONTROL,
 		.end   = WM831X_LDO5_SLEEP_CONTROL,
@@ -803,7 +803,7 @@ static struct resource wm831x_ldo5_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo6_resources[] = {
+static const struct resource wm831x_ldo6_resources[] = {
 	{
 		.start = WM831X_LDO6_CONTROL,
 		.end   = WM831X_LDO6_SLEEP_CONTROL,
@@ -817,7 +817,7 @@ static struct resource wm831x_ldo6_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo7_resources[] = {
+static const struct resource wm831x_ldo7_resources[] = {
 	{
 		.start = WM831X_LDO7_CONTROL,
 		.end   = WM831X_LDO7_SLEEP_CONTROL,
@@ -831,7 +831,7 @@ static struct resource wm831x_ldo7_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo8_resources[] = {
+static const struct resource wm831x_ldo8_resources[] = {
 	{
 		.start = WM831X_LDO8_CONTROL,
 		.end   = WM831X_LDO8_SLEEP_CONTROL,
@@ -845,7 +845,7 @@ static struct resource wm831x_ldo8_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo9_resources[] = {
+static const struct resource wm831x_ldo9_resources[] = {
 	{
 		.start = WM831X_LDO9_CONTROL,
 		.end   = WM831X_LDO9_SLEEP_CONTROL,
@@ -859,7 +859,7 @@ static struct resource wm831x_ldo9_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo10_resources[] = {
+static const struct resource wm831x_ldo10_resources[] = {
 	{
 		.start = WM831X_LDO10_CONTROL,
 		.end   = WM831X_LDO10_SLEEP_CONTROL,
@@ -873,7 +873,7 @@ static struct resource wm831x_ldo10_resources[] = {
 	},
 };
 
-static struct resource wm831x_ldo11_resources[] = {
+static const struct resource wm831x_ldo11_resources[] = {
 	{
 		.start = WM831X_LDO11_ON_CONTROL,
 		.end   = WM831X_LDO11_SLEEP_CONTROL,
@@ -881,7 +881,7 @@ static struct resource wm831x_ldo11_resources[] = {
 	},
 };
 
-static struct resource wm831x_on_resources[] = {
+static const struct resource wm831x_on_resources[] = {
 	{
 		.start = WM831X_IRQ_ON,
 		.end   = WM831X_IRQ_ON,
@@ -890,7 +890,7 @@ static struct resource wm831x_on_resources[] = {
 };
 
 
-static struct resource wm831x_power_resources[] = {
+static const struct resource wm831x_power_resources[] = {
 	{
 		.name = "SYSLO",
 		.start = WM831X_IRQ_PPM_SYSLO,
@@ -959,7 +959,7 @@ static struct resource wm831x_power_resources[] = {
 	},
 };
 
-static struct resource wm831x_rtc_resources[] = {
+static const struct resource wm831x_rtc_resources[] = {
 	{
 		.name = "PER",
 		.start = WM831X_IRQ_RTC_PER,
@@ -974,7 +974,7 @@ static struct resource wm831x_rtc_resources[] = {
 	},
 };
 
-static struct resource wm831x_status1_resources[] = {
+static const struct resource wm831x_status1_resources[] = {
 	{
 		.start = WM831X_STATUS_LED_1,
 		.end   = WM831X_STATUS_LED_1,
@@ -982,7 +982,7 @@ static struct resource wm831x_status1_resources[] = {
 	},
 };
 
-static struct resource wm831x_status2_resources[] = {
+static const struct resource wm831x_status2_resources[] = {
 	{
 		.start = WM831X_STATUS_LED_2,
 		.end   = WM831X_STATUS_LED_2,
@@ -990,7 +990,7 @@ static struct resource wm831x_status2_resources[] = {
 	},
 };
 
-static struct resource wm831x_touch_resources[] = {
+static const struct resource wm831x_touch_resources[] = {
 	{
 		.name = "TCHPD",
 		.start = WM831X_IRQ_TCHPD,
@@ -1005,7 +1005,7 @@ static struct resource wm831x_touch_resources[] = {
 	},
 };
 
-static struct resource wm831x_wdt_resources[] = {
+static const struct resource wm831x_wdt_resources[] = {
 	{
 		.start = WM831X_IRQ_WDOG_TO,
 		.end   = WM831X_IRQ_WDOG_TO,
diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 3b2b93c5bbcb..e6d2319f15b6 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -40,7 +40,7 @@ static const struct mfd_cell wm8994_regulator_devs[] = {
 	},
 };
 
-static struct resource wm8994_codec_resources[] = {
+static const struct resource wm8994_codec_resources[] = {
 	{
 		.start = WM8994_IRQ_TEMP_SHUT,
 		.end   = WM8994_IRQ_TEMP_WARN,
@@ -48,7 +48,7 @@ static struct resource wm8994_codec_resources[] = {
 	},
 };
 
-static struct resource wm8994_gpio_resources[] = {
+static const struct resource wm8994_gpio_resources[] = {
 	{
 		.start = WM8994_IRQ_GPIO(1),
 		.end   = WM8994_IRQ_GPIO(11),
-- 
2.28.0

