Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D02DE8FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgLRSix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:38:53 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:50606 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbgLRSiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:38:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 35771FB03;
        Fri, 18 Dec 2020 19:38:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Bdg8r9sBTr0; Fri, 18 Dec 2020 19:38:08 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id B611A43FDC; Fri, 18 Dec 2020 19:38:07 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] regulators: bd718x7: Add enable times
Date:   Fri, 18 Dec 2020 19:38:07 +0100
Message-Id: <41fb2ed19f584f138336344e2297ae7301f72b75.1608316658.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the typical startup times from the data sheet so boards get a
reasonable default. Not setting any enable time can lead to board hangs
when e.g. clocks are enabled too soon afterwards.

This fixes gpu power domain resume on the Librem 5.

Signed-off-by: Guido Günther <agx@sigxcpu.org>

---
v2
- As per review comment by Matti Vaittinen
  https://lore.kernel.org/lkml/beba25e85db20649aa040fc0ae549895c9265f6f.camel@fi.rohmeurope.com/
  Use defines instead of plain values
- As per review comment by Mark Brown
  https://lore.kernel.org/lkml/20201216130637.GC4861@sirena.org.uk/
  Drop cover letter
---
 drivers/regulator/bd718x7-regulator.c | 27 ++++++++++++++++++++++++
 include/linux/mfd/rohm-bd718x7.h      | 30 +++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index e6d5d98c3cea..f7597832d2c5 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -613,6 +613,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD718XX_REG_BUCK1_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71847_BUCK1_STARTUP_TIME,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -646,6 +647,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71847_BUCK2_STARTUP_TIME,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -680,6 +682,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.linear_range_selectors = bd71847_buck3_volt_range_sel,
 			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71847_BUCK3_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -706,6 +709,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_range_mask = BD71847_BUCK4_RANGE_MASK,
 			.linear_range_selectors = bd71847_buck4_volt_range_sel,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71847_BUCK4_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -727,6 +731,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_3RD_NODVS_BUCK_MASK,
 			.enable_reg = BD718XX_REG_3RD_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71847_BUCK5_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -750,6 +755,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_4TH_NODVS_BUCK_MASK,
 			.enable_reg = BD718XX_REG_4TH_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71847_BUCK6_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -775,6 +781,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO1_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71847_LDO1_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -796,6 +803,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.n_voltages = ARRAY_SIZE(ldo_2_volts),
 			.enable_reg = BD718XX_REG_LDO2_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71847_LDO2_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -818,6 +826,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_LDO3_MASK,
 			.enable_reg = BD718XX_REG_LDO3_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71847_LDO3_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -840,6 +849,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_LDO4_MASK,
 			.enable_reg = BD718XX_REG_LDO4_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71847_LDO4_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -865,6 +875,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.linear_range_selectors = bd71847_ldo5_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO5_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71847_LDO5_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -889,6 +900,7 @@ static struct bd718xx_regulator_data bd71847_regulators[] = {
 			.vsel_mask = BD718XX_LDO6_MASK,
 			.enable_reg = BD718XX_REG_LDO6_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71847_LDO6_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -942,6 +954,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD718XX_REG_BUCK1_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71837_BUCK1_STARTUP_TIME,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -975,6 +988,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD718XX_REG_BUCK2_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71837_BUCK2_STARTUP_TIME,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -1005,6 +1019,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD71837_REG_BUCK3_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71837_BUCK3_STARTUP_TIME,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -1033,6 +1048,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = DVS_BUCK_RUN_MASK,
 			.enable_reg = BD71837_REG_BUCK4_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71837_BUCK4_STARTUP_TIME,
 			.owner = THIS_MODULE,
 			.of_parse_cb = buck_set_hw_dvs_levels,
 		},
@@ -1065,6 +1081,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.linear_range_selectors = bd71837_buck5_volt_range_sel,
 			.enable_reg = BD718XX_REG_1ST_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71837_BUCK5_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1088,6 +1105,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD71837_BUCK6_MASK,
 			.enable_reg = BD718XX_REG_2ND_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71837_BUCK6_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1109,6 +1127,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_3RD_NODVS_BUCK_MASK,
 			.enable_reg = BD718XX_REG_3RD_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71837_BUCK7_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1132,6 +1151,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_4TH_NODVS_BUCK_MASK,
 			.enable_reg = BD718XX_REG_4TH_NODVS_BUCK_CTRL,
 			.enable_mask = BD718XX_BUCK_EN,
+			.enable_time = BD71837_BUCK8_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1157,6 +1177,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.linear_range_selectors = bd718xx_ldo1_volt_range_sel,
 			.enable_reg = BD718XX_REG_LDO1_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71837_LDO1_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1178,6 +1199,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.n_voltages = ARRAY_SIZE(ldo_2_volts),
 			.enable_reg = BD718XX_REG_LDO2_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71837_LDO2_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1200,6 +1222,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_LDO3_MASK,
 			.enable_reg = BD718XX_REG_LDO3_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71837_LDO3_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1222,6 +1245,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_LDO4_MASK,
 			.enable_reg = BD718XX_REG_LDO4_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71837_LDO4_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1246,6 +1270,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD71837_LDO5_MASK,
 			.enable_reg = BD718XX_REG_LDO5_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71837_LDO5_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1272,6 +1297,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD718XX_LDO6_MASK,
 			.enable_reg = BD718XX_REG_LDO6_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71837_LDO6_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
@@ -1296,6 +1322,7 @@ static struct bd718xx_regulator_data bd71837_regulators[] = {
 			.vsel_mask = BD71837_LDO7_MASK,
 			.enable_reg = BD71837_REG_LDO7_VOLT,
 			.enable_mask = BD718XX_LDO_EN,
+			.enable_time = BD71837_LDO7_STARTUP_TIME,
 			.owner = THIS_MODULE,
 		},
 		.init = {
diff --git a/include/linux/mfd/rohm-bd718x7.h b/include/linux/mfd/rohm-bd718x7.h
index bee2474a8f9f..fba80dc2c1d5 100644
--- a/include/linux/mfd/rohm-bd718x7.h
+++ b/include/linux/mfd/rohm-bd718x7.h
@@ -323,4 +323,34 @@ struct bd718xx {
 	struct regmap_irq_chip_data *irq_data;
 };
 
+/* Typical regulator startup times as per data sheet in uS */
+#define BD71847_BUCK1_STARTUP_TIME 144
+#define BD71847_BUCK2_STARTUP_TIME 162
+#define BD71847_BUCK3_STARTUP_TIME 162
+#define BD71847_BUCK4_STARTUP_TIME 240
+#define BD71847_BUCK5_STARTUP_TIME 270
+#define BD71847_BUCK6_STARTUP_TIME 200
+#define BD71847_LDO1_STARTUP_TIME  440
+#define BD71847_LDO2_STARTUP_TIME  370
+#define BD71847_LDO3_STARTUP_TIME  310
+#define BD71847_LDO4_STARTUP_TIME  400
+#define BD71847_LDO5_STARTUP_TIME  530
+#define BD71847_LDO6_STARTUP_TIME  400
+
+#define BD71837_BUCK1_STARTUP_TIME 160
+#define BD71837_BUCK2_STARTUP_TIME 180
+#define BD71837_BUCK3_STARTUP_TIME 180
+#define BD71837_BUCK4_STARTUP_TIME 180
+#define BD71837_BUCK5_STARTUP_TIME 160
+#define BD71837_BUCK6_STARTUP_TIME 240
+#define BD71837_BUCK7_STARTUP_TIME 220
+#define BD71837_BUCK8_STARTUP_TIME 200
+#define BD71837_LDO1_STARTUP_TIME  440
+#define BD71837_LDO2_STARTUP_TIME  370
+#define BD71837_LDO3_STARTUP_TIME  310
+#define BD71837_LDO4_STARTUP_TIME  400
+#define BD71837_LDO5_STARTUP_TIME  310
+#define BD71837_LDO6_STARTUP_TIME  400
+#define BD71837_LDO7_STARTUP_TIME  530
+
 #endif /* __LINUX_MFD_BD718XX_H__ */
-- 
2.29.2

