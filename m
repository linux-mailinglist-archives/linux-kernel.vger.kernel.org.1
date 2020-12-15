Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610412DB74B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgLPAB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgLOX6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:58:38 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57867C0613D3;
        Tue, 15 Dec 2020 15:57:58 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 91so21484204wrj.7;
        Tue, 15 Dec 2020 15:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1I/x1exlJLsm3WeNJRlwrbpzwfSR6O258jSLiqBkyC4=;
        b=kgAp2ZEQWXFQUErft2vomP9iqJ8qY1ouCvn68LzDjLKyQ0XbyrFtTOeC+xnsOX6zS+
         ruuFijEoBpRX9z0EMFIFyTvQkAKETi5JG0tMkU/KvI5GO0CPoYS2Dqelf4D2dqQy1QAg
         qa+kZVX8rgN+eAaO/eqk6v2+Mro/+VWZjemdmGQfJGHhUUZGGt0V6a6gdikIm1iUNhs+
         neoSty3zzPS29tecbBH0qM16SZBw+CfYT2vdh+5Y1UTlJbE9sWBOxNcPoK/ukWhTAwaZ
         +yIlWCCeHU7B1PNE3uZIKO973FK2NSEIIiDCzYocxpd+BlwczBb6wwEhLo8f5R/VQRI8
         rWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1I/x1exlJLsm3WeNJRlwrbpzwfSR6O258jSLiqBkyC4=;
        b=gchZESH35RcB7rH4je6HO7NUlIHDKMDk9BlfOuU+jIW9AVmybngyH7EUHJ2slLZxGS
         fnLkBe6i76sy06UPVhI0v3I2VZRenauT8ngQ3eb8osHrNLyy7M1HAopEPG4xkKXCzQYL
         pk+2waK7xW4Jl0TlC7DRfUjA9KTayPt0HdJ8QjHEb2r6cVME8XgovFne2ILWU+lJ/GvF
         3KDY8+PNecMRkHuK7xHDQ88uunMT3WzFuSNiqojdonL9pFn11MfuOV3YPak0uy4DyEnm
         4KQUT1SIOZWmRvgnovKpFngN7Am238+TS+WrQjVaZloQDJn3gLZ8D7WEdH9IRz5HRKP1
         JqpA==
X-Gm-Message-State: AOAM533ArtRGGb+oabkVEZzZ01TE7a6lVjA+jdhrnEyr6/yto+NgzgfV
        uGiL7zzCc3u2Pv82gqdGZFM=
X-Google-Smtp-Source: ABdhPJwPypN9h32sGAN0lqpW3qvgk90sap/+pSguIjFq2jay9rl9yUFUeNPSgGrOodaz77Z3yr3J2w==
X-Received: by 2002:adf:c14d:: with SMTP id w13mr24944905wre.383.1608076677046;
        Tue, 15 Dec 2020 15:57:57 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c10sm204160wrb.92.2020.12.15.15.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:57:56 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 7/7] regulator: pf8x00: fix nxp,phase-shift
Date:   Wed, 16 Dec 2020 00:56:39 +0100
Message-Id: <20201215235639.31516-8-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215235639.31516-1-adrien.grassein@gmail.com>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
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

I also use the OTP default configuration when the paramater is wrong
or not specified.
I think that it's better to use the default configuration from the chip
than an arbitrary value.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/regulator/pf8x00-regulator.c | 45 +++++++++++++---------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 5ad940b3db0a..b8b3ac393ee8 100644
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
2.20.1

