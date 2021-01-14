Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9D52F6818
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbhANRsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbhANRsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:48:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA1BC0613CF;
        Thu, 14 Jan 2021 09:47:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t16so6687810wra.3;
        Thu, 14 Jan 2021 09:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ga6RWsMGRnOBRU223li1MY5FtCYIzdzZznWAiBLHlds=;
        b=f/17cztYGGsFK/7aaaGpvZa5EbwK9sNQ1TmSNtC6qjocJtgpJzlKziBuakpDcUmZNd
         JVIxR5MFYiHgnI3h4jNRLYeld+Ec4iFhqAkziAfWjTj+xqaYvOK7qgEK/mekPdZN34MT
         OEQjWSMWGe0TLzzKNX3a17AKGgHaJdBMyPgErMtcHafpT620DzbQpWNxX0a3uTrqLN+O
         QI9+diAzfjCyuAuvBlkt/NDhH4TkrA9zq/XHbD9VtzOnm/MeJ8UBu8DgnYa3/il1Igpy
         TGHW4F6KPbchcrwXRMRrsO+b+GTaAsDrQsaAZX731DglmZg7Xzuf50UYg9mMcdZfxHdy
         Y3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ga6RWsMGRnOBRU223li1MY5FtCYIzdzZznWAiBLHlds=;
        b=k09Q75C11lAyyrbpV7JkGSx54WmWDvOysHqJCIfEbIaupLRmhShiaIftAEWP5tDszD
         34M+eld8JuvH/i482XUIwYP9DrdcEXPGzI4dHOU+zaUf6Z3ftJayWcUikqP9kUR9W7QA
         JtsfwbH4mNSgIDwqKP/SiIjpimG3PA0Ykzn4MKkuVb2q9KxIEnxapFCWp+CKif8+HDxm
         583yY0LqgtRIPMQVsyexV4gKzuFgF9JQku5+f4gWb3lrdCYoEXZeda41+oPeSbuutYNC
         q3u0hGiR2rWPROaIbW9ly/WoOd8lA+9UypKggT6s8TfPsWdAYqcaPHGrD9bkP1MxFrOq
         fXbA==
X-Gm-Message-State: AOAM532z2/f6dG+iRjJYTCzF/miOQ3UcZqwpCczhTPorlXa85w7KA6lg
        2RXq3nLcb4X1a0CluivhqD0=
X-Google-Smtp-Source: ABdhPJwiDxYJ3eb57uGDOOCwa8m9322/vFSyP7y0Bd4TDutL8scEjmM1ByljlBT/VDP1FXV/mbShig==
X-Received: by 2002:a05:6000:1884:: with SMTP id a4mr9174998wri.42.1610646440227;
        Thu, 14 Jan 2021 09:47:20 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd2700adae03a5d647a4d0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:adae:3a5:d647:a4d0])
        by smtp.gmail.com with ESMTPSA id g18sm5120663wrw.61.2021.01.14.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:47:19 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v5 4/6] regulator: pf8x00: mark nxp,ilim-ma property as deprecated
Date:   Thu, 14 Jan 2021 18:47:12 +0100
Message-Id: <20210114174714.122561-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114174714.122561-1-adrien.grassein@gmail.com>
References: <20210114174714.122561-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property seems useless because we can use the
regulator-max-microamp generic property to do the same
and using generic code.

As this property was already released in a kernel version,
we can't remove it, just mark it as deprecated.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/regulator/pf8x00-regulator.c | 55 +++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index af9918cd27aa..0c0f643b9c60 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -128,7 +128,6 @@ enum pf8x00_devid {
 
 struct pf8x00_regulator {
 	struct regulator_desc desc;
-	u8 ilim;
 	u8 phase_shift;
 };
 
@@ -150,6 +149,11 @@ static const int pf8x00_ldo_voltages[] = {
 	3100000, 3150000, 3200000, 3300000, 3350000, 1650000, 1700000, 5000000,
 };
 
+/* Output: 2.1A to 4.5A */
+static const unsigned int pf8x00_sw_current_table[] = {
+	2100000, 2600000, 3000000, 4500000,
+};
+
 #define SWV(i)		(6250 * i + 400000)
 #define SWV_LINE(i)	SWV(i*8+0), SWV(i*8+1), SWV(i*8+2), SWV(i*8+3), \
 			SWV(i*8+4), SWV(i*8+5), SWV(i*8+6), SWV(i*8+7)
@@ -199,10 +203,10 @@ static struct pf8x00_regulator *desc_to_regulator(const struct regulator_desc *d
 	return container_of(desc, struct pf8x00_regulator, desc);
 }
 
-static void swxilim_select(const struct regulator_desc *desc, int ilim)
+static void swxilim_select(struct pf8x00_chip *chip, int id, int ilim)
 {
-	struct pf8x00_regulator *data = desc_to_regulator(desc);
 	u8 ilim_sel;
+	u8 reg = PF8X00_SW_BASE(id) + SW_CONFIG2;
 
 	switch (ilim) {
 	case 2100:
@@ -222,7 +226,32 @@ static void swxilim_select(const struct regulator_desc *desc, int ilim)
 		break;
 	}
 
-	data->ilim = ilim_sel;
+	regmap_update_bits(chip->regmap, reg,
+					PF8X00_SWXILIM_MASK,
+					ilim_sel << PF8X00_SWXILIM_SHIFT);
+}
+
+static void handle_ilim_property(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
+	struct pf8x00_chip *chip = config->driver_data;
+	int ret;
+	int val;
+
+	if ((desc->id >= PF8X00_BUCK1) && (desc->id <= PF8X00_BUCK7)) {
+		ret = of_property_read_u32(np, "nxp,ilim-ma", &val);
+		if (ret) {
+			dev_dbg(chip->dev, "unspecified ilim for BUCK%d, use value stored in OTP\n",
+				desc->id - PF8X00_LDO4);
+			return;
+		}
+
+		dev_warn(chip->dev, "nxp,ilim-ma is deprecated, please use regulator-max-microamp\n");
+		swxilim_select(chip, desc->id, val);
+
+	} else
+		dev_warn(chip->dev, "nxp,ilim-ma used with incorrect regulator (%d)\n", desc->id);
 }
 
 static int pf8x00_of_parse_cb(struct device_node *np,
@@ -235,12 +264,7 @@ static int pf8x00_of_parse_cb(struct device_node *np,
 	int val;
 	int ret;
 
-	ret = of_property_read_u32(np, "nxp,ilim-ma", &val);
-	if (ret)
-		dev_dbg(chip->dev, "unspecified ilim for BUCK%d, use 2100 mA\n",
-			desc->id - PF8X00_LDO4);
-
-	swxilim_select(desc, val);
+	handle_ilim_property(np, desc, config);
 
 	ret = of_property_read_u32(np, "nxp,phase-shift", &val);
 	if (ret) {
@@ -279,6 +303,8 @@ static const struct regulator_ops pf8x00_buck_ops = {
 	.list_voltage = regulator_list_voltage_table,
 	.set_voltage_sel = regulator_set_voltage_sel_regmap,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
 };
 
 static const struct regulator_ops pf8x00_vsnvs_ops = {
@@ -327,6 +353,11 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 			.volt_table = voltages,			\
 			.vsel_reg = (base) + SW_RUN_VOLT,	\
 			.vsel_mask = 0xff,			\
+			.curr_table = pf8x00_sw_current_table, \
+			.n_current_limits = \
+				ARRAY_SIZE(pf8x00_sw_current_table), \
+			.csel_reg = (base) + SW_CONFIG2,	\
+			.csel_mask = PF8X00_SWXILIM_MASK,	\
 			.enable_reg = (base) + SW_MODE1,	\
 			.enable_val = 0x3,			\
 			.disable_val = 0x0,			\
@@ -458,10 +489,6 @@ static int pf8x00_i2c_probe(struct i2c_client *client)
 			regmap_update_bits(chip->regmap, reg,
 					   PF8X00_SWXPHASE_MASK,
 					   data->phase_shift);
-
-			regmap_update_bits(chip->regmap, reg,
-					   PF8X00_SWXILIM_MASK,
-					   data->ilim << PF8X00_SWXILIM_SHIFT);
 		}
 	}
 
-- 
2.25.1

