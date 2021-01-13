Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967B72F57F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbhANCMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbhAMWWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:22:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E28CC0617A3;
        Wed, 13 Jan 2021 14:20:25 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id n16so4415474wmc.0;
        Wed, 13 Jan 2021 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGDgOgI8/XSOFKjdfUfIFJTYsXZSv8qURm+3sJRqDQc=;
        b=F2pdNg88PkO4UWNhTAoj27anxGO7pus/Wu25XqLGciATAfW6hkByn8ovRSky4pWBzv
         MeJ4dwc1E92bk3+A9gKO7ETiuozGKGBKo1x3M568C+wDdsohztBWHq/GrerPLmHCuTLh
         uAyOz+VC4vb5sYUJzEinY2izUif6afTlRpQeFORZFwx7Qpx9qvI4oWpGOSHkiRgqxfgl
         ze85MiXAVLztiVCEHKaiVc3pHE35AxVxWBCwq5FOmPXF4SvkkpNUoCZQB0KZyge8Dfjo
         pFgCuaDc4DBYdoULMBEcqUodvbvsqbR8kxioAzxhTHVXu2HxJhgL4MxPEPm02qpqZMPg
         iFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGDgOgI8/XSOFKjdfUfIFJTYsXZSv8qURm+3sJRqDQc=;
        b=KL4tzwEQ2VkWTnvbui4mjjElLzT0lkjpttc6phmJmL9DSuq5qHJwlEmjhGMQMAp9Sk
         UBWD9dDfNgtNHvgPz8LA0ZNH5bIxf9cBz4fbginZHNtcY2lk8A9vE8rhGnDpQjg3z1E7
         qRHakUpWm8DpT5dMj5YO0G9yCo3hN9HInbkIqJbBi5UKANEa57kOrF/cNVql9FTjHprS
         lklngnIQ8jI3sNwoNJ5LPtj/Yo0oQXfi/c5dgDCXUEcDG+0qqDCtoV1eeD8CR7cV6xU6
         kK0WFaNO5P8oduRVklMA5y9kg8+/NEFjxKWqVlxuNduxhmg2X8bpsQoIcVPfC4JHT1Gv
         A9RQ==
X-Gm-Message-State: AOAM531ikXJgTRHwp/UMfpyvjbYyRfSMAPHHqo8qdOBQXMCOREGVzjpe
        kMMQOfBahWOC7qfjyzeoYXg=
X-Google-Smtp-Source: ABdhPJwXoN+PFjF6m2bTRvNmTL4auskaYbJenYXLPz9wXmW6rhP6EIKQib9jXr4z/aYoTvX7y+jc8g==
X-Received: by 2002:a1c:1f86:: with SMTP id f128mr1137005wmf.174.1610576424284;
        Wed, 13 Jan 2021 14:20:24 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id t1sm5594929wro.27.2021.01.13.14.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:20:23 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 6/6] regulator: pf8x00: fix nxp,phase-shift
Date:   Wed, 13 Jan 2021 23:20:16 +0100
Message-Id: <20210113222016.1915993-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113222016.1915993-1-adrien.grassein@gmail.com>
References: <20210113222016.1915993-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the ternary condition which is a bad coding style
in the kernel

I also remove the defering configuration of the nxp,phase-shift.
The configuration is now done at parsing time. It save some memory
and it's better for comprehension.

I also use the OTP default configuration when the parameter is wrong
or not specified.
I think that it's better to use the default configuration from the chip
than an arbitrary value.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/regulator/pf8x00-regulator.c | 71 +++++++++++++++-------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 866162fddd07..1e5582d73405 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -114,7 +114,6 @@ enum swxilim_bits {
 #define PF8X00_SWXILIM_SHIFT		3
 #define PF8X00_SWXILIM_MASK		GENMASK(4, 3)
 #define PF8X00_SWXPHASE_MASK		GENMASK(2, 0)
-#define PF8X00_SWXPHASE_DEFAULT		0
 #define PF8X00_SWXPHASE_SHIFT		7
 
 enum pf8x00_devid {
@@ -128,7 +127,6 @@ enum pf8x00_devid {
 
 struct pf8x00_regulator {
 	struct regulator_desc desc;
-	u8 phase_shift;
 };
 
 struct pf8x00_chip {
@@ -174,11 +172,6 @@ static const int pf8x00_vsnvs_voltages[] = {
 	0, 1800000, 3000000, 3300000,
 };
 
-static struct pf8x00_regulator *desc_to_regulator(const struct regulator_desc *desc)
-{
-	return container_of(desc, struct pf8x00_regulator, desc);
-}
-
 static void swxilim_select(struct pf8x00_chip *chip, int id, int ilim)
 {
 	u8 ilim_sel;
@@ -230,35 +223,55 @@ static void handle_ilim_property(struct device_node *np,
 		dev_warn(chip->dev, "nxp,ilim-ma used with incorrect regulator (%d)\n", desc->id);
 }
 
-static int pf8x00_of_parse_cb(struct device_node *np,
+static void handle_shift_property(struct device_node *np,
 			      const struct regulator_desc *desc,
 			      struct regulator_config *config)
 {
-	struct pf8x00_regulator *data = desc_to_regulator(desc);
+	unsigned char id = desc->id - PF8X00_LDO4;
+	unsigned char reg = PF8X00_SW_BASE(id) + SW_CONFIG2;
 	struct pf8x00_chip *chip = config->driver_data;
+
 	int phase;
 	int val;
 	int ret;
+	if ((desc->id >= PF8X00_BUCK1) && (desc->id <= PF8X00_BUCK7)) {
+		ret = of_property_read_u32(np, "nxp,phase-shift", &val);
+		if (ret) {
+			dev_dbg(chip->dev,
+				"unspecified phase-shift for BUCK%d, using OTP configuration\n",
+				id);
+			return;
+		}
 
-	handle_ilim_property(np, desc, config);
+		if (val < 0 || val > 315 || val % 45 != 0) {
+			dev_warn(config->dev,
+				"invalid phase_shift %d for BUCK%d, using OTP configuration\n",
+				val, id);
+			return;
+		}
 
-	ret = of_property_read_u32(np, "nxp,phase-shift", &val);
-	if (ret) {
-		dev_dbg(chip->dev,
-			"unspecified phase-shift for BUCK%d, use 0 degrees\n",
-			desc->id - PF8X00_LDO4);
-		val = PF8X00_SWXPHASE_DEFAULT;
-	}
+		phase = val / 45;
 
-	phase = val / 45;
-	if ((phase * 45) != val) {
-		dev_warn(config->dev,
-			 "invalid phase_shift %d for BUCK%d, use 0 degrees\n",
-			 (phase * 45), desc->id - PF8X00_LDO4);
-		phase = PF8X00_SWXPHASE_SHIFT;
-	}
+		if (phase >= 1)
+			phase -= 1;
+		else
+			phase = PF8X00_SWXPHASE_SHIFT;
+
+		regmap_update_bits(chip->regmap, reg,
+				PF8X00_SWXPHASE_MASK,
+				phase);
+	} else
+		dev_warn(chip->dev, "nxp,phase-shift used with incorrect regulator (%d)\n", id);
+
+}
+
+static int pf8x00_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
 
-	data->phase_shift = (phase >= 1) ? phase - 1 : PF8X00_SWXPHASE_SHIFT;
+	handle_ilim_property(np, desc, config);
+	handle_shift_property(np, desc, config);
 
 	return 0;
 }
@@ -501,14 +514,6 @@ static int pf8x00_i2c_probe(struct i2c_client *client)
 				"failed to register %s regulator\n", data->desc.name);
 			return PTR_ERR(rdev);
 		}
-
-		if ((id >= PF8X00_BUCK1) && (id <= PF8X00_BUCK7)) {
-			u8 reg = PF8X00_SW_BASE(id) + SW_CONFIG2;
-
-			regmap_update_bits(chip->regmap, reg,
-					   PF8X00_SWXPHASE_MASK,
-					   data->phase_shift);
-		}
 	}
 
 	return 0;
-- 
2.25.1

