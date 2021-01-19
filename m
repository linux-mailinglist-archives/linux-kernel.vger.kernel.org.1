Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E759E2FC2E3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbhASV7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbhASRrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:47:11 -0500
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948EAC061794;
        Tue, 19 Jan 2021 09:44:26 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6BF3A3F179;
        Tue, 19 Jan 2021 18:44:23 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, sumit.semwal@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v4 2/7] regulator: qcom-labibb: Implement current limiting
Date:   Tue, 19 Jan 2021 18:44:16 +0100
Message-Id: <20210119174421.226541-3-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119174421.226541-1-angelogioacchino.delregno@somainline.org>
References: <20210119174421.226541-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAB and IBB regulators can be current-limited by setting the
appropriate registers, but this operation is granted only after
sending an unlock code for secure access.

Besides the secure access, it would be possible to use the
regmap helper for get_current_limit, as there is no security
blocking reads, but I chose not to as to avoid having a very
big array containing current limits, especially for IBB.

That said, these regulators support current limiting for:
- LAB (pos): 200-1600mA, with 200mA per step (8 steps),
- IBB (neg):   0-1550mA, with  50mA per step (32 steps).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/regulator/qcom-labibb-regulator.c | 92 +++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
index 0fe0f6bce4cf..0643713d6aad 100644
--- a/drivers/regulator/qcom-labibb-regulator.c
+++ b/drivers/regulator/qcom-labibb-regulator.c
@@ -29,6 +29,15 @@
 #define LABIBB_STATUS1_VREG_OK_BIT	BIT(7)
 #define LABIBB_CONTROL_ENABLE		BIT(7)
 
+#define REG_LABIBB_CURRENT_LIMIT	0x4b
+ #define LAB_CURRENT_LIMIT_MASK		GENMASK(2, 0)
+ #define IBB_CURRENT_LIMIT_MASK		GENMASK(4, 0)
+ #define LAB_CURRENT_LIMIT_OVERRIDE_EN	BIT(3)
+ #define LABIBB_CURRENT_LIMIT_EN	BIT(7)
+
+#define REG_LABIBB_SEC_ACCESS		0xd0
+ #define LABIBB_SEC_UNLOCK_CODE		0xa5
+
 #define LAB_ENABLE_CTL_MASK		BIT(7)
 #define IBB_ENABLE_CTL_MASK		(BIT(7) | BIT(6))
 
@@ -37,11 +46,18 @@
 #define IBB_ENABLE_TIME			(LABIBB_OFF_ON_DELAY * 10)
 #define LABIBB_POLL_ENABLED_TIME	1000
 
+struct labibb_current_limits {
+	u32				uA_min;
+	u32				uA_step;
+	u8				ovr_val;
+};
+
 struct labibb_regulator {
 	struct regulator_desc		desc;
 	struct device			*dev;
 	struct regmap			*regmap;
 	struct regulator_dev		*rdev;
+	struct labibb_current_limits	uA_limits;
 	u16				base;
 	u8				type;
 };
@@ -53,6 +69,57 @@ struct labibb_regulator_data {
 	const struct regulator_desc	*desc;
 };
 
+static int qcom_labibb_set_current_limit(struct regulator_dev *rdev,
+					 int min_uA, int max_uA)
+{
+	struct labibb_regulator *vreg = rdev_get_drvdata(rdev);
+	struct regulator_desc *desc = &vreg->desc;
+	struct labibb_current_limits *lim = &vreg->uA_limits;
+	u32 mask, val;
+	int i, ret, sel = -1;
+
+	if (min_uA < lim->uA_min || max_uA < lim->uA_min)
+		return -EINVAL;
+
+	for (i = 0; i < desc->n_current_limits; i++) {
+		int uA_limit = (lim->uA_step * i) + lim->uA_min;
+
+		if (max_uA >= uA_limit && min_uA <= uA_limit)
+			sel = i;
+	}
+	if (sel < 0)
+		return -EINVAL;
+
+	/* Current limit setting needs secure access */
+	ret = regmap_write(vreg->regmap, vreg->base + REG_LABIBB_SEC_ACCESS,
+			   LABIBB_SEC_UNLOCK_CODE);
+	if (ret)
+		return ret;
+
+	mask = desc->csel_mask | lim->ovr_val;
+	mask |= LABIBB_CURRENT_LIMIT_EN;
+	val = (u32)sel | lim->ovr_val;
+	val |= LABIBB_CURRENT_LIMIT_EN;
+
+	return regmap_update_bits(vreg->regmap, desc->csel_reg, mask, val);
+}
+
+static int qcom_labibb_get_current_limit(struct regulator_dev *rdev)
+{
+	struct labibb_regulator *vreg = rdev_get_drvdata(rdev);
+	struct regulator_desc *desc = &vreg->desc;
+	struct labibb_current_limits *lim = &vreg->uA_limits;
+	unsigned int cur_step;
+	int ret;
+
+	ret = regmap_read(vreg->regmap, desc->csel_reg, &cur_step);
+	if (ret)
+		return ret;
+	cur_step &= desc->csel_mask;
+
+	return (cur_step * lim->uA_step) + lim->uA_min;
+}
+
 static const struct regulator_ops qcom_labibb_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -61,6 +128,8 @@ static const struct regulator_ops qcom_labibb_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
+	.set_current_limit	= qcom_labibb_set_current_limit,
+	.get_current_limit	= qcom_labibb_get_current_limit,
 };
 
 static const struct regulator_desc pmi8998_lab_desc = {
@@ -73,6 +142,9 @@ static const struct regulator_desc pmi8998_lab_desc = {
 	.vsel_mask		= LAB_VOLTAGE_SET_MASK,
 	.apply_reg		= (PMI8998_LAB_REG_BASE + REG_LABIBB_VOLTAGE),
 	.apply_bit		= LABIBB_VOLTAGE_OVERRIDE_EN,
+	.csel_reg		= (PMI8998_LAB_REG_BASE + REG_LABIBB_CURRENT_LIMIT),
+	.csel_mask		= LAB_CURRENT_LIMIT_MASK,
+	.n_current_limits	= 8,
 	.off_on_delay		= LABIBB_OFF_ON_DELAY,
 	.owner			= THIS_MODULE,
 	.type			= REGULATOR_VOLTAGE,
@@ -92,6 +164,9 @@ static const struct regulator_desc pmi8998_ibb_desc = {
 	.vsel_mask		= IBB_VOLTAGE_SET_MASK,
 	.apply_reg		= (PMI8998_IBB_REG_BASE + REG_LABIBB_VOLTAGE),
 	.apply_bit		= LABIBB_VOLTAGE_OVERRIDE_EN,
+	.csel_reg		= (PMI8998_IBB_REG_BASE + REG_LABIBB_CURRENT_LIMIT),
+	.csel_mask		= IBB_CURRENT_LIMIT_MASK,
+	.n_current_limits	= 32,
 	.off_on_delay		= LABIBB_OFF_ON_DELAY,
 	.owner			= THIS_MODULE,
 	.type			= REGULATOR_VOLTAGE,
@@ -163,6 +238,23 @@ static int qcom_labibb_regulator_probe(struct platform_device *pdev)
 		vreg->base = reg_data->base;
 		vreg->type = reg_data->type;
 
+		switch (vreg->type) {
+		case QCOM_LAB_TYPE:
+			/* LAB Limits: 200-1600mA */
+			vreg->uA_limits.uA_min  = 200000;
+			vreg->uA_limits.uA_step = 200000;
+			vreg->uA_limits.ovr_val = LAB_CURRENT_LIMIT_OVERRIDE_EN;
+			break;
+		case QCOM_IBB_TYPE:
+			/* IBB Limits: 0-1550mA */
+			vreg->uA_limits.uA_min  = 0;
+			vreg->uA_limits.uA_step = 50000;
+			vreg->uA_limits.ovr_val = 0; /* No override bit */
+			break;
+		default:
+			return -EINVAL;
+		}
+
 		memcpy(&vreg->desc, reg_data->desc, sizeof(vreg->desc));
 		vreg->desc.of_match = reg_data->name;
 		vreg->desc.name = reg_data->name;
-- 
2.30.0

