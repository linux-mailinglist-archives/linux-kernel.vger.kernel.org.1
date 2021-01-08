Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FD2EFB71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbhAHWwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbhAHWwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:52:13 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C73C061799;
        Fri,  8 Jan 2021 14:50:57 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id g185so9689859wmf.3;
        Fri, 08 Jan 2021 14:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTn9/sf2WP+vAcNsRG2ZW/CUAbf2TQCT32NuGuwVptE=;
        b=h8Y06fXUNifmcBRDKjduA9iraYXESamRmjF9O235AD9AswsWcWShCxDpT183OGuf66
         pbbLpr0pmoH0pr6Bua6CsjBdcMNyY4Q/V0Ldl1vfHmKuyIRWNb02mql/W1OEIWoPoN88
         1G8JaHmJc6y8YuhtyxfLCUsCL3R9P24yxIoyd3Mv35nyDZ5BmN0fwXIXpJlQklB1Z4+Z
         7SsaJ8dnyaF3u7Fr8Qf4o42xvomA16Bzueyfyaw61TCJcCYGNBsKNpEd3E2hpjVzIPCp
         HuZ1ftqWQ1xj8qj7qD10hUdzwf7viSTbZbNBcwxHqETbQEOeEbS49p0Hgd7sYXrVKsGn
         BhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTn9/sf2WP+vAcNsRG2ZW/CUAbf2TQCT32NuGuwVptE=;
        b=EBuVXjY42Cy+xNtQ/aChJWht8b5HkzHz8BVYUu1I0ZJhIm5eSxrndoDkRvEYbtdBf5
         PUMoJe3VaZdsfHpsW8aYhGxqIW4wsUSCX4sECWkaBzmimfs7ADGNv8sv3nkbN0aXYZoD
         QmIsLgOM9hTJoVdzZXtJAhuRyVKVLNZiDVARyCSe+VBHaSCRZZHU4HZuvyiHABmsaeDV
         E69ngL0Ye9FF1lWy7qwbPIBReB7ALeK19x2rBhOdGdA+klNS7Uhf0MwOkgvar35zBl6+
         0ScQjHgms87j1iUkFL8ibBWuSphcUCSrwgESmhzdqAswzrSO1tDTCNzxjqbqQA2mdDjx
         jx4Q==
X-Gm-Message-State: AOAM533P+Yl7xL7BFpwHOSVqAHr3+mPbybgf9TOgCcSZmhNSjynL60MY
        xhQV7ueh1Zn5P65Wmb2ToFc=
X-Google-Smtp-Source: ABdhPJwNJvGE+k5cr857pWNImY3bh1V0Yl3EQMVcQoOrQy7yyvNxR0aEaZ9zCWC/rs3aTBZgCsvqpw==
X-Received: by 2002:a1c:3cd5:: with SMTP id j204mr4801107wma.53.1610146256506;
        Fri, 08 Jan 2021 14:50:56 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270094076597458eade1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9407:6597:458e:ade1])
        by smtp.gmail.com with ESMTPSA id o23sm15900644wro.57.2021.01.08.14.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:50:55 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 6/6] regulator: pf8x00: fix nxp,phase-shift
Date:   Fri,  8 Jan 2021 23:50:06 +0100
Message-Id: <20210108225006.153700-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108225006.153700-1-adrien.grassein@gmail.com>
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
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
 drivers/regulator/pf8x00-regulator.c | 45 +++++++++++++---------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 4b57f74e7326..9932a580619c 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -107,7 +107,6 @@ enum pf8x00_ldo_states {
 
 #define PF8X00_SWXILIM_MASK		GENMASK(4, 3)
 #define PF8X00_SWXPHASE_MASK		GENMASK(2, 0)
-#define PF8X00_SWXPHASE_DEFAULT		0
 #define PF8X00_SWXPHASE_SHIFT		7
 
 enum pf8x00_devid {
@@ -121,7 +120,6 @@ enum pf8x00_devid {
 
 struct pf8x00_regulator {
 	struct regulator_desc desc;
-	u8 phase_shift;
 };
 
 struct pf8x00_chip {
@@ -167,17 +165,13 @@ static const int pf8x00_vsnvs_voltages[] = {
 	0, 1800000, 3000000, 3300000,
 };
 
-static struct pf8x00_regulator *desc_to_regulator(const struct regulator_desc *desc)
-{
-	return container_of(desc, struct pf8x00_regulator, desc);
-}
-
 static int pf8x00_of_parse_cb(struct device_node *np,
 			      const struct regulator_desc *desc,
 			      struct regulator_config *config)
 {
-	struct pf8x00_regulator *data = desc_to_regulator(desc);
 	struct pf8x00_chip *chip = config->driver_data;
+	unsigned char id = desc->id - PF8X00_LDO4;
+	unsigned char reg = PF8X00_SW_BASE(id) + SW_CONFIG2;
 	int phase;
 	int val;
 	int ret;
@@ -185,21 +179,30 @@ static int pf8x00_of_parse_cb(struct device_node *np,
 	ret = of_property_read_u32(np, "nxp,phase-shift", &val);
 	if (ret) {
 		dev_dbg(chip->dev,
-			"unspecified phase-shift for BUCK%d, use 0 degrees\n",
-			desc->id - PF8X00_LDO4);
-		val = PF8X00_SWXPHASE_DEFAULT;
+			"unspecified phase-shift for BUCK%d, using OTP configuration\n",
+			id);
+		goto end;
 	}
 
-	phase = val / 45;
-	if ((phase * 45) != val) {
+	if (val < 0 || val > 315 || val % 45 != 0) {
 		dev_warn(config->dev,
-			 "invalid phase_shift %d for BUCK%d, use 0 degrees\n",
-			 (phase * 45), desc->id - PF8X00_LDO4);
-		phase = PF8X00_SWXPHASE_SHIFT;
+			 "invalid phase_shift %d for BUCK%d, using OTP configuration\n",
+			 val, id);
+		goto end;
 	}
 
-	data->phase_shift = (phase >= 1) ? phase - 1 : PF8X00_SWXPHASE_SHIFT;
+	phase = val / 45;
+
+	if (phase >= 1)
+		phase -= 1;
+	else
+		phase = PF8X00_SWXPHASE_SHIFT;
+
+	regmap_update_bits(chip->regmap, reg,
+			PF8X00_SWXPHASE_MASK,
+			phase);
 
+end:
 	return 0;
 }
 
@@ -432,14 +435,6 @@ static int pf8x00_i2c_probe(struct i2c_client *client)
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

