Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2352EFB6C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbhAHWvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbhAHWvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:51:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F68C061796;
        Fri,  8 Jan 2021 14:50:55 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w5so10373419wrm.11;
        Fri, 08 Jan 2021 14:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+FFPQC7Z/J2zspNeLZ507qHSJx8NoZiwyfKhZGK7II=;
        b=bt+JeEgIov3sNb7S9SOaiiuKAi9K0lXNZx/f6ELmOyV1G3joLiXKdp45Ch98UWEX1T
         oMp9NXIltR/hybKJ9ZZiGN1Wjndz8QGCG3xWe4CXUAE8P5+ujMTYqid9QYtinvmdm8u/
         idHTKQ2uX59hwekSXaz964BAeo/PzI+YGTzNekQW+9bbjzpEbHwbdimcpow++lxEIWbY
         wUyeDygkB/+2Dk3x1h7FdiTagz72dUDbbhIzi++klCerJ/VNqfmoLdswRmHzF/AZhgG6
         9dS0576obBtlLAhWmROI5zPlCWV4SOb7UjEZDXSW4Z0Zp75vP+aEgjYDtulaL3y+FeIq
         7kHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+FFPQC7Z/J2zspNeLZ507qHSJx8NoZiwyfKhZGK7II=;
        b=C+tYgX/vk0AsmaHuh4D3sfZ8WLULR+TuU8utqTqKUMBJKcoOrvMDmQ/MvNjlohRpIp
         sOjTWjfsTd3ojIea48AwYCDh20Q7oEnZbeyHx1PLMoFdBK/cDi6VsVT5BFLm5C+6pnho
         Bm664Xwk8op9c5JS4l60L35qDUvP8T3f7ac4jyRLHOtBhNjQbGTI2J0pDPmglcbDFDHy
         GuyrkXC+tLOe0y2X24J1ma4ImqwTZmAerdES4Xp4MQUJFJibIAW8Xsxs0jClwVZk2+f8
         +jSOtTd5pC50mbd1XIIusx0Si1P3dWsuwhMwdEDDPRj8+74bmQYUb45Az1uiprezgJUN
         83aA==
X-Gm-Message-State: AOAM531X4p5vUr940CT/h4QFvdQ80IBH0YE7xrNXAi+7HhJAZIVQevHY
        ks1e9Fqs2xdgktrq8K2c4s9i0jYJ3DU=
X-Google-Smtp-Source: ABdhPJy4t7+zPFKzfRgpAblBTDlgp6jDfh9GpR2nEeejCXv9CL3Vox8KQnqcQ5h5di2E065P1n12fw==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr5476465wrr.319.1610146254251;
        Fri, 08 Jan 2021 14:50:54 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270094076597458eade1.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:9407:6597:458e:ade1])
        by smtp.gmail.com with ESMTPSA id o23sm15900644wro.57.2021.01.08.14.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 14:50:53 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 4/6] regulator: pf8x00: remove nxp,ilim-ma property
Date:   Fri,  8 Jan 2021 23:50:04 +0100
Message-Id: <20210108225006.153700-5-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108225006.153700-1-adrien.grassein@gmail.com>
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
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
index af9918cd27aa..90383e394f85 100644
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
2.25.1

