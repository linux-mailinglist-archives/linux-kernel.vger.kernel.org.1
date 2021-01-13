Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D451A2F57E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbhANCKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbhAMWWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:22:13 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7628C0617A2;
        Wed, 13 Jan 2021 14:20:24 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id h17so2757733wmq.1;
        Wed, 13 Jan 2021 14:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e0qzq5GFWJhIlfTRRTu2x5Ocj16Bkaz6W/a5NchpwUE=;
        b=Ox7TP60eaxinx4kYcBtjsLTVnPmt6IATpb+3D8o5JwiTlbMHNbKxFVlzTOjlAgj6Xe
         FIHV+6I05P9ko0ii/tZ2r50AVcPBWQBk+BRbzr2Ciy5LbQpjSzJVbzW8tZCUws6nzGbM
         0GgmZBlgWHSeMS+/3hXt+p5zaNR+CVVWCrtgPn8rHodD9XoH/fv3CysRHVaDKhqg3sPA
         zHRaz3OchkJw2BsOUQj+DRNjQvrs6JgDOUfD0aQV+Xdre2yr4UHWFEcIetzRCxQjuCvf
         6P8gZa/8v47fVYvuJYCRqSJuYmXIckS1KVMQ0tlgIDoyOXzsp5uYF+6amOptx+SSqzWs
         mwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e0qzq5GFWJhIlfTRRTu2x5Ocj16Bkaz6W/a5NchpwUE=;
        b=U1LCLnaySqgHSso6uOBF5Id2V2jRJCuhnJH/v9cXU9/ntl1I7vvPUfkajYL/tJnWmx
         /QoDjocmay8jLT37szvc8C73p425iU3/9kgZL4AGtTP9GdfwbGvCL4TA4YFgrEvK+Wzd
         tN4/U3/54I6An3T81xvCerFsifG2xkInG3x77CAldIgNwmAJpkzTok5OJl0iTluOR71X
         w02wxWcCmoF18H/C6Zwm/jX9ONoT7iKjYvGj7rUa7PrtcuVzoWtsZXIL74+SpzpAnePB
         VgACM/cSHZr6Y2uMzdcFibeWN8DAwAYYGn3SeAVklVClw3cW4XjGPgni/d/qz7btGo6L
         zjwg==
X-Gm-Message-State: AOAM533/UHM/lBsVAqw5tH0oqx5vNtx+BT84VuOKdMsuKMcrllgxRoKt
        7B4lQSkHgZEnlMp9qw1TN7I=
X-Google-Smtp-Source: ABdhPJyDMvhvZiI86RTCiTcra3W21i/3Kyp9XeHtG3cI63wa98WMwDOPbvhmmXvxKVr+shUe0KFanA==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr1113088wmb.43.1610576423451;
        Wed, 13 Jan 2021 14:20:23 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27000d88c7723353ad1a.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:d88:c772:3353:ad1a])
        by smtp.gmail.com with ESMTPSA id t1sm5594929wro.27.2021.01.13.14.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:20:22 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     broonie@kernel.org, jagan@amarulasolutions.com,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 5/6] regulator: pf8x00: use linear range for buck 1-6
Date:   Wed, 13 Jan 2021 23:20:15 +0100
Message-Id: <20210113222016.1915993-6-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113222016.1915993-1-adrien.grassein@gmail.com>
References: <20210113222016.1915993-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a linear range to describe the voltages of the
bucks 1-6 instead of listing it one by one (via a macro)

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/regulator/pf8x00-regulator.c | 83 +++++++++++++++++-----------
 1 file changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
index 0c0f643b9c60..866162fddd07 100644
--- a/drivers/regulator/pf8x00-regulator.c
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -154,35 +154,11 @@ static const unsigned int pf8x00_sw_current_table[] = {
 	2100000, 2600000, 3000000, 4500000,
 };
 
-#define SWV(i)		(6250 * i + 400000)
-#define SWV_LINE(i)	SWV(i*8+0), SWV(i*8+1), SWV(i*8+2), SWV(i*8+3), \
-			SWV(i*8+4), SWV(i*8+5), SWV(i*8+6), SWV(i*8+7)
-
 /* Output: 0.4V to 1.8V */
-static const int pf8x00_sw1_to_6_voltages[] = {
-	SWV_LINE(0),
-	SWV_LINE(1),
-	SWV_LINE(2),
-	SWV_LINE(3),
-	SWV_LINE(4),
-	SWV_LINE(5),
-	SWV_LINE(6),
-	SWV_LINE(7),
-	SWV_LINE(8),
-	SWV_LINE(9),
-	SWV_LINE(10),
-	SWV_LINE(11),
-	SWV_LINE(12),
-	SWV_LINE(13),
-	SWV_LINE(14),
-	SWV_LINE(15),
-	SWV_LINE(16),
-	SWV_LINE(17),
-	SWV_LINE(18),
-	SWV_LINE(19),
-	SWV_LINE(20),
-	SWV_LINE(21),
-	1500000, 1800000,
+#define PF8XOO_SW1_6_VOLTAGE_NUM 0xB2
+static const struct linear_range pf8x00_sw1_to_6_voltages[] = {
+	REGULATOR_LINEAR_RANGE(400000, 0x00, 0xB0, 6250),
+	REGULATOR_LINEAR_RANGE(1800000, 0xB1, 0xB1, 0),
 };
 
 /* Output: 1.0V to 4.1V */
@@ -296,7 +272,19 @@ static const struct regulator_ops pf8x00_ldo_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static const struct regulator_ops pf8x00_buck_ops = {
+
+static const struct regulator_ops pf8x00_buck1_6_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
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
@@ -345,11 +333,41 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 			.of_match = _name,			\
 			.regulators_node = "regulators",	\
 			.of_parse_cb = pf8x00_of_parse_cb,	\
-			.n_voltages = ARRAY_SIZE(voltages),	\
-			.ops = &pf8x00_buck_ops,		\
+			.n_voltages = PF8XOO_SW1_6_VOLTAGE_NUM,	\
+			.ops = &pf8x00_buck1_6_ops,		\
 			.type = REGULATOR_VOLTAGE,		\
 			.id = PF8X00_BUCK ## _id,		\
 			.owner = THIS_MODULE,			\
+			.linear_ranges = pf8x00_sw1_to_6_voltages, \
+			.n_linear_ranges = \
+				ARRAY_SIZE(pf8x00_sw1_to_6_voltages), \
+			.vsel_reg = (base) + SW_RUN_VOLT,	\
+			.vsel_mask = 0xff,			\
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
 			.volt_table = voltages,			\
 			.vsel_reg = (base) + SW_RUN_VOLT,	\
 			.vsel_mask = 0xff,			\
@@ -366,6 +384,7 @@ static const struct regulator_ops pf8x00_vsnvs_ops = {
 		},						\
 	}
 
+
 #define PF8X00VSNVS(_name, base, voltages)			\
 	[PF8X00_VSNVS] = {					\
 		.desc = {					\
@@ -394,7 +413,7 @@ static struct pf8x00_regulator pf8x00_regulators_data[PF8X00_MAX_REGULATORS] = {
 	PF8X00BUCK(4, "buck4", PF8X00_SW_BASE(PF8X00_BUCK4), pf8x00_sw1_to_6_voltages),
 	PF8X00BUCK(5, "buck5", PF8X00_SW_BASE(PF8X00_BUCK5), pf8x00_sw1_to_6_voltages),
 	PF8X00BUCK(6, "buck6", PF8X00_SW_BASE(PF8X00_BUCK6), pf8x00_sw1_to_6_voltages),
-	PF8X00BUCK(7, "buck7", PF8X00_SW_BASE(PF8X00_BUCK7), pf8x00_sw7_voltages),
+	PF8X00BUCK7("buck7", PF8X00_SW_BASE(PF8X00_BUCK7), pf8x00_sw7_voltages),
 	PF8X00VSNVS("vsnvs", PF8X00_VSNVS_CONFIG1, pf8x00_vsnvs_voltages),
 };
 
-- 
2.25.1

