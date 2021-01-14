Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B612F6822
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbhANRsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbhANRsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:48:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5203DC0613D6;
        Thu, 14 Jan 2021 09:47:23 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e25so5475785wme.0;
        Thu, 14 Jan 2021 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGDgOgI8/XSOFKjdfUfIFJTYsXZSv8qURm+3sJRqDQc=;
        b=vOTOiAt+Oycdm5PyJ/zqPfkOTzHkb3GC30OxNqxUyvvF37ofl0my5xg8pCzXEh446Z
         HlPf1Z/+cbv+CAWSVWnVk3nQLzW4eEmmiOgsyydVLHPSnwhKj7OW6X4uWukNyrQAC3Dq
         Ukvox5iZtyjCmK4rE3Mch5HiZq6en1BWDgZC4evcy3EBlgm3UUzNsaT3BAgb37Pi1YD/
         m0xz1CnLhj01ee1liuhywv4EPjLlE/BrLS22VqYJr6I0tPl7Zrjw25wENcWGJSK78C/c
         p2fJlt1nRYaBkwmM0BA4ttgG/7fxWoRbhTF9tkT8yodOOEvUYB3MXTtkgQXMgbcZ62/E
         7nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGDgOgI8/XSOFKjdfUfIFJTYsXZSv8qURm+3sJRqDQc=;
        b=A2CFm+SxvGJmmIrWvKiJ/F24YYXrqoDTV80hAS3xFP/D0jDlm54loAT3f4g0lVRyfi
         KGEpqYy4PMBbgvU5oZu3fPUp3G9ZyQhUP11QfmddwDW+x0Y+hJwxAhbN2A6bGA0ITqff
         6Mi8Rs5mairgh9b2wZOHKzChHBmRKK/aXujEEh4j3PZ7mMWye/r7ZQM9T+poo3gVnDX0
         KabP+SeTAhhoe7IyXfsYYZs131Psf1hP4c20WYKSVqlI4yiprt/WocLwCP1nt1YuNEd9
         VDmtddkFXvhHQqTDvFwcul2NSrNAzsrTh02XwaPkrG9PxS0R4AZkI33jTs3c8dhdgr5s
         ooOg==
X-Gm-Message-State: AOAM5308TGihO757ZhWf1WOlEQ+S8/8rjwX2EAzWSKrKG8warvCQNM02
        iKxsSpBB+YSMv+grmcYL21I=
X-Google-Smtp-Source: ABdhPJzYYzB/r1Q/y0uP9NXRK7Vl4/jWZtL5kLGI+1Uyc5kg6oN6Ib1ChuUIaNanOs+3R5tcxY/fkA==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr5061533wma.26.1610646442082;
        Thu, 14 Jan 2021 09:47:22 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700adae03a5d647a4d0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:adae:3a5:d647:a4d0])
        by smtp.gmail.com with ESMTPSA id g18sm5120663wrw.61.2021.01.14.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:47:21 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 6/6] regulator: pf8x00: fix nxp,phase-shift
Date:   Thu, 14 Jan 2021 18:47:14 +0100
Message-Id: <20210114174714.122561-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114174714.122561-1-adrien.grassein@gmail.com>
References: <20210114174714.122561-1-adrien.grassein@gmail.com>
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

