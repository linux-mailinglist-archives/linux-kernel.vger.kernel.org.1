Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5EE2DB767
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 01:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgLPAB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 19:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLOX6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 18:58:19 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12786C0613D6;
        Tue, 15 Dec 2020 15:57:39 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x22so762541wmc.5;
        Tue, 15 Dec 2020 15:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lUHfgR7voTj/dWme2Hr2kocup9jTK1s5eob8kvVduFM=;
        b=EbA3Cni/0LWI/iOO7rkoIy0R56+pzrbFeAbExCZv0MVhVjX/rqReGF0HCkkLrZfB00
         rRgMz4aT3lTKhXcEJNk3lKdB4DNxMkRtISGq9Ha/SdBUIuEqrZVrd5d8ddsWMVTaVeVK
         0GZZyUCV/SnvuQfjIMuos3mSe4rlB0D5LiOeAExjzpmnHRZiqcsuXbRU52zzd2vJMuB/
         ah/DbcKM/5eKVdScl2Q18LQRPnLFAoBJLRc0yfqXo1oYnsPUvUCLoKQaHiWF5CQyVoG5
         gGaxhDhjmEm0rQzDlpmCmpc5cLbC3it7jV3xR/03PqGW9CVgGBf5yKMr+jTiu4OAINoS
         9gRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lUHfgR7voTj/dWme2Hr2kocup9jTK1s5eob8kvVduFM=;
        b=XMcY6vNlAL2Fnnaa7J0s6BT09SsMdZtDz5scqgEgRLwspNGqdhBsCDMNvNORosO58B
         Vxe0TmoeLXl8yVsdShQR6yNXv/UI0TVX0d0SIMybPnhDVIg5y0I0Lr+9Fe2A3Xcy1Jzo
         asmaJ/wAKcJkJxnqZX1xsIK9eR4kYP5+4HvJZPDCj4EUdiNCgBh8xJoOvIKfby/qAR5+
         HlLn6DjWVJYuwq9YXPGbSlTUF2iM0/+TEUssJOdEQ9Z6mGXSkjuYDwlpn6YFOgPyZnPC
         nAfMUsrrJlNAylK+15vwhpQg8xhrSrSiGa0+0aYOM+4KxQRVKFIIDsuKzCXYXW7KMzAP
         bzEA==
X-Gm-Message-State: AOAM5312MDMHzUrAp20N5BHKPrVW9WNsQAL++8EIuwAGuHu4BDn5cbqO
        bADNr8AHq9ilppWwHHoGcvs=
X-Google-Smtp-Source: ABdhPJzHxbxs02Tkw8pcWFHP4iu4UsC8TM8EXrife0CTrKKm16IT/kfXIX2GoSCqUqXtoNZP7pAg0Q==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr826335wmh.114.1608076657796;
        Tue, 15 Dec 2020 15:57:37 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c10sm204160wrb.92.2020.12.15.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:57:37 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 5/7] regulator: pf8x00: remove nxp,ilim-ma property
Date:   Wed, 16 Dec 2020 00:56:37 +0100
Message-Id: <20201215235639.31516-6-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201215235639.31516-1-adrien.grassein@gmail.com>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This property seems useless because we can use the
regulator-max-microamp generic property to do the same
and using generic code.

The only things it changes is the default value. The original
code was using "2100" (mA) as default one, but I think we should
keep the value in the OTP memory as the default one. This value
is automatically loaded in the register by the chip.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/regulator/pf8x00-regulator.c | 95 ++++++++++++++--------------
 1 file changed, 47 insertions(+), 48 deletions(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 308c27fa6ea8..ebb0ef0745f1 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -105,13 +105,6 @@ enum pf8x00_ldo_states {
 };
 #define PF8X00_LDO_BASE(i)		(6 * (i - PF8X00_LDO1) + PF8X00_LDO1_CONFIG1)
 
-enum swxilim_bits {
-	SWXILIM_2100_MA,
-	SWXILIM_2600_MA,
-	SWXILIM_3000_MA,
-	SWXILIM_4500_MA,
-};
-#define PF8X00_SWXILIM_SHIFT		3
 #define PF8X00_SWXILIM_MASK		GENMASK(4, 3)
 #define PF8X00_SWXPHASE_MASK		GENMASK(2, 0)
 #define PF8X00_SWXPHASE_DEFAULT		0
@@ -128,7 +121,6 @@ enum pf8x00_devid {
 
 struct pf8x00_regulator {
 	struct regulator_desc desc;
-	u8 ilim;
 	u8 phase_shift;
 };
 
@@ -150,6 +142,11 @@ static const int pf8x00_ldo_voltages[] = {
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
@@ -199,32 +196,6 @@ static struct pf8x00_regulator *desc_to_regulator(const struct regulator_desc *d
 	return container_of(desc, struct pf8x00_regulator, desc);
 }
 
-static void swxilim_select(const struct regulator_desc *desc, int ilim)
-{
-	struct pf8x00_regulator *data = desc_to_regulator(desc);
-	u8 ilim_sel;
-
-	switch (ilim) {
-	case 2100:
-		ilim_sel = SWXILIM_2100_MA;
-		break;
-	case 2600:
-		ilim_sel = SWXILIM_2600_MA;
-		break;
-	case 3000:
-		ilim_sel = SWXILIM_3000_MA;
-		break;
-	case 4500:
-		ilim_sel = SWXILIM_4500_MA;
-		break;
-	default:
-		ilim_sel = SWXILIM_2100_MA;
-		break;
-	}
-
-	data->ilim = ilim_sel;
-}
-
 static int pf8x00_of_parse_cb(struct device_node *np,
 			      const struct regulator_desc *desc,
 			      struct regulator_config *config)
@@ -235,13 +206,6 @@ static int pf8x00_of_parse_cb(struct device_node *np,
 	int val;
 	int ret;
 
-	ret = of_property_read_u32(np, "nxp,ilim-ma", &val);
-	if (ret)
-		dev_dbg(chip->dev, "unspecified ilim for BUCK%d, use 2100 mA\n",
-			desc->id - PF8X00_LDO4);
-
-	swxilim_select(desc, val);
-
 	ret = of_property_read_u32(np, "nxp,phase-shift", &val);
 	if (ret) {
 		dev_dbg(chip->dev,
@@ -272,7 +236,18 @@ static const struct regulator_ops pf8x00_ldo_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static const struct regulator_ops pf8x00_buck_ops = {
+static const struct regulator_ops pf8x00_buck1_6_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
+};
+
+static const struct regulator_ops pf8x00_buck7_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -320,13 +295,41 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 			.regulators_node = "regulators",	\
 			.of_parse_cb = pf8x00_of_parse_cb,	\
 			.n_voltages = ARRAY_SIZE(voltages),	\
-			.ops = &pf8x00_buck_ops,		\
+			.ops = &pf8x00_buck1_6_ops,		\
 			.type = REGULATOR_VOLTAGE,		\
 			.id = PF8X00_BUCK ## _id,		\
 			.owner = THIS_MODULE,			\
 			.volt_table = voltages,			\
 			.vsel_reg = (base) + SW_RUN_VOLT,	\
 			.vsel_mask = 0xff,			\
+			.curr_table = pf8x00_sw_current_table, \
+			.n_current_limits = \
+				ARRAY_SIZE(pf8x00_sw_current_table), \
+			.csel_reg = (base) + SW_CONFIG2,	\
+			.csel_mask = PF8X00_SWXILIM_MASK,	\
+			.enable_reg = (base) + SW_MODE1,	\
+			.enable_val = 0x3,			\
+			.disable_val = 0x0,			\
+			.enable_mask = 0x3,			\
+			.enable_time = 500,			\
+		},						\
+	}
+
+#define PF8X00BUCK7(_name, base, voltages)			\
+	[PF8X00_BUCK7] = {				\
+		.desc = {					\
+			.name = _name,				\
+			.of_match = _name,			\
+			.regulators_node = "regulators",	\
+			.of_parse_cb = pf8x00_of_parse_cb,	\
+			.n_voltages = ARRAY_SIZE(voltages),	\
+			.ops = &pf8x00_buck7_ops,		\
+			.type = REGULATOR_VOLTAGE,		\
+			.id = PF8X00_BUCK7,		\
+			.owner = THIS_MODULE,			\
+			.volt_table = voltages,			\
+			.vsel_reg = (base) + SW_RUN_VOLT,	\
+			.vsel_mask = 0xff,			\
 			.enable_reg = (base) + SW_MODE1,	\
 			.enable_val = 0x3,			\
 			.disable_val = 0x0,			\
@@ -363,7 +366,7 @@ static struct pf8x00_regulator pf8x00_regulators_data[PF8X00_MAX_REGULATORS] = {
 	PF8X00BUCK(4, "buck4", PF8X00_SW_BASE(PF8X00_BUCK4), pf8x00_sw1_to_6_voltages),
 	PF8X00BUCK(5, "buck5", PF8X00_SW_BASE(PF8X00_BUCK5), pf8x00_sw1_to_6_voltages),
 	PF8X00BUCK(6, "buck6", PF8X00_SW_BASE(PF8X00_BUCK6), pf8x00_sw1_to_6_voltages),
-	PF8X00BUCK(7, "buck7", PF8X00_SW_BASE(PF8X00_BUCK7), pf8x00_sw7_voltages),
+	PF8X00BUCK7("buck7", PF8X00_SW_BASE(PF8X00_BUCK7), pf8x00_sw7_voltages),
 	PF8X00VSNVS("vsnvs", PF8X00_VSNVS_CONFIG1, pf8x00_vsnvs_voltages),
 };
 
@@ -458,10 +461,6 @@ static int pf8x00_i2c_probe(struct i2c_client *client)
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
2.20.1

