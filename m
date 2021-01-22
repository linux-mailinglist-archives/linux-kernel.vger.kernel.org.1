Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435BF3005A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbhAVOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:38:08 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:38107 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbhAVOhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:37:04 -0500
Received: by mail-lj1-f171.google.com with SMTP id n11so6755787lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:36:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eF1HBM/mOL4WB2f3kuBhIxYQxcgJDTTtIsiPzGZu08o=;
        b=HL3gYp1zYaK1ek9UVA+8ZXbKpKjfRmfaxQrZdx1l93zIjM0y3WnZa5VCCdYdmenxQm
         5bqwFY1+e3Rm7iddWJjdBZeEj5VxgZseUwsvWowZEaWduwoaNNjpsIO2T70zoj8zoI3w
         QZL6mIpk8VuZJyJXTSwVUewqRi3/HpYFrvCfYo4sM4tBNw0YyqHtkkBsvX8UhUM8DeBA
         IeDzo5sIxMJlUMyGTwXNdXicI1hXHiv/dZQP1UOfBHnLWq9B6OcT9+5+IiR4vifqImFb
         V0rkspX6r9KpJymTBu8H4Fpf5BkYoq2bD8LxgqInOUdXQ5guR2MR8qZg+nHXCGThwPz/
         TZ+Q==
X-Gm-Message-State: AOAM530Zh1EqVAUHHItgEXEj9kGjftCsP5tvUCO7/5/2o6aCdeDWHGdy
        Ije6r9z3oO/+7ocwJJeClZ4=
X-Google-Smtp-Source: ABdhPJyQ/e6tYRpEaMuVHOo5rDscyCUQRWeVToCC40Q0bflatPo1JtCPwd/QM3M0nN1QCiCZ60jv8A==
X-Received: by 2002:a2e:b00c:: with SMTP id y12mr972847ljk.85.1611326179222;
        Fri, 22 Jan 2021 06:36:19 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id g26sm995502ljn.90.2021.01.22.06.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:36:18 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:36:11 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v7 6/6] regulator: bd9576: Support error reporting
Message-ID: <4d725ea6e9261f22d4c808b39013baf479f252dc.1611324968.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1611324968.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611324968.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BD9573 and BD9576 support set of "protection" interrupts for "fatal"
issues. Those lead to SOC reset as PMIC shuts the power outputs. Thus
there is no relevant IRQ handling for them.

Few "detection" interrupts were added to the BD9576 with the idea that
SOC could take some recovery-action before error gets unrecoverable.

Add support for over and under voltage detection for Vout1 ... Vout4
and VoutL1. Add over-current detection for VoutS1 and finally a
thermal warning (common for all regulators) which alerts shortly
before temperature reaches the thermal shutdown point. This way
consumer drivers can build error-recovery mechanisms.

Unfortunately the BD9576 interrupt logic was not re-evaluated. IRQs
are not designed to be properly acknowleged - and IRQ line is kept
active for whole duration of error condition (in comparison to
informing only about state change).

Disable interrupts at handler and add 1 second timer to re-enable them.
This helps us to avoid staying in IRQ handling loop.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changes since v6:
 - new patch

Please note that the IRQ handling has only received limited set of
testing. I only managed to manually disrupt the VOUTs on board to
cause an IRQ. Usually this lead to IC being shut down. It seems
to me the basic operation of the IRQ limiter is ok.

 drivers/regulator/bd9576-regulator.c | 534 +++++++++++++++++++++------
 1 file changed, 412 insertions(+), 122 deletions(-)

diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index a8b5832a5a1b..737c10f8acbf 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -2,10 +2,11 @@
 // Copyright (C) 2020 ROHM Semiconductors
 // ROHM BD9576MUF/BD9573MUF regulator driver
 
-#include <linux/delay.h>
+//#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/mfd/rohm-bd957x.h>
 #include <linux/mfd/rohm-generic.h>
@@ -16,6 +17,8 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 #define BD957X_VOUTS1_VOLT	3300000
 #define BD957X_VOUTS4_BASE_VOLT	1030000
@@ -39,6 +42,22 @@ static int voutl1_volt_table[] = {2500000, 2540000, 2580000, 2620000, 2660000,
 struct bd957x_regulator_data {
 	struct regulator_desc desc;
 	int base_voltage;
+	struct regulator_dev *rdev;
+	int regulator_err; /* Error flag set from IRQ */
+};
+
+#define BD9576_NUM_REGULATORS 6
+struct bd957x_data {
+	struct bd957x_regulator_data regulator_data[BD9576_NUM_REGULATORS];
+	struct regmap *regmap;
+	struct delayed_work therm_irq_suppress;
+	struct delayed_work ovd_irq_suppress;
+	struct delayed_work uvd_irq_suppress;
+	unsigned int therm_irq;
+	unsigned int ovd_irq;
+	unsigned int uvd_irq;
+	spinlock_t err_lock;
+	int regulator_global_err;
 };
 
 static int bd957x_vout34_list_voltage(struct regulator_dev *rdev,
@@ -72,151 +91,392 @@ static int bd957x_list_voltage(struct regulator_dev *rdev,
 	return desc->volt_table[index];
 }
 
+static int bd9576_get_error_flags(struct regulator_dev *rdev,
+				  unsigned int *flags)
+{
+	struct bd957x_data *d;
+	struct bd957x_regulator_data *r;
+
+	r = container_of(rdev->desc, struct bd957x_regulator_data, desc);
+	d = rdev_get_drvdata(rdev);
+
+	spin_lock(&d->err_lock);
+	*flags = d->regulator_global_err | r->regulator_err;
+	spin_unlock(&d->err_lock);
+
+	return 0;
+}
+
 static const struct regulator_ops bd957x_vout34_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = bd957x_vout34_list_voltage,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.get_error_flags = bd9576_get_error_flags,
 };
 
 static const struct regulator_ops bd957X_vouts1_regulator_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
+	.get_error_flags = bd9576_get_error_flags,
 };
 
 static const struct regulator_ops bd957x_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.list_voltage = bd957x_list_voltage,
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.get_error_flags = bd9576_get_error_flags,
 };
 
-static struct bd957x_regulator_data bd9576_regulators[] = {
-	{
-		.desc = {
-			.name = "VD50",
-			.of_match = of_match_ptr("regulator-vd50"),
-			.regulators_node = of_match_ptr("regulators"),
-			.id = BD957X_VD50,
-			.type = REGULATOR_VOLTAGE,
-			.ops = &bd957x_ops,
-			.volt_table = &vout1_volt_table[0],
-			.n_voltages = ARRAY_SIZE(vout1_volt_table),
-			.vsel_reg = BD957X_REG_VOUT1_TUNE,
-			.vsel_mask = BD957X_MASK_VOUT1_TUNE,
-			.enable_reg = BD957X_REG_POW_TRIGGER1,
-			.enable_mask = BD957X_REGULATOR_EN_MASK,
-			.enable_val = BD957X_REGULATOR_DIS_VAL,
-			.enable_is_inverted = true,
-			.owner = THIS_MODULE,
+static struct bd957x_data bd957x_regulators = {
+	.regulator_data = {
+		{
+			.desc = {
+				.name = "VD50",
+				.of_match = of_match_ptr("regulator-vd50"),
+				.regulators_node = of_match_ptr("regulators"),
+				.id = BD957X_VD50,
+				.type = REGULATOR_VOLTAGE,
+				.ops = &bd957x_ops,
+				.volt_table = &vout1_volt_table[0],
+				.n_voltages = ARRAY_SIZE(vout1_volt_table),
+				.vsel_reg = BD957X_REG_VOUT1_TUNE,
+				.vsel_mask = BD957X_MASK_VOUT1_TUNE,
+				.enable_reg = BD957X_REG_POW_TRIGGER1,
+				.enable_mask = BD957X_REGULATOR_EN_MASK,
+				.enable_val = BD957X_REGULATOR_DIS_VAL,
+				.enable_is_inverted = true,
+				.owner = THIS_MODULE,
+			},
 		},
-	},
-	{
-		.desc = {
-			.name = "VD18",
-			.of_match = of_match_ptr("regulator-vd18"),
-			.regulators_node = of_match_ptr("regulators"),
-			.id = BD957X_VD18,
-			.type = REGULATOR_VOLTAGE,
-			.ops = &bd957x_ops,
-			.volt_table = &vout2_volt_table[0],
-			.n_voltages = ARRAY_SIZE(vout2_volt_table),
-			.vsel_reg = BD957X_REG_VOUT2_TUNE,
-			.vsel_mask = BD957X_MASK_VOUT2_TUNE,
-			.enable_reg = BD957X_REG_POW_TRIGGER2,
-			.enable_mask = BD957X_REGULATOR_EN_MASK,
-			.enable_val = BD957X_REGULATOR_DIS_VAL,
-			.enable_is_inverted = true,
-			.owner = THIS_MODULE,
+		{
+			.desc = {
+				.name = "VD18",
+				.of_match = of_match_ptr("regulator-vd18"),
+				.regulators_node = of_match_ptr("regulators"),
+				.id = BD957X_VD18,
+				.type = REGULATOR_VOLTAGE,
+				.ops = &bd957x_ops,
+				.volt_table = &vout2_volt_table[0],
+				.n_voltages = ARRAY_SIZE(vout2_volt_table),
+				.vsel_reg = BD957X_REG_VOUT2_TUNE,
+				.vsel_mask = BD957X_MASK_VOUT2_TUNE,
+				.enable_reg = BD957X_REG_POW_TRIGGER2,
+				.enable_mask = BD957X_REGULATOR_EN_MASK,
+				.enable_val = BD957X_REGULATOR_DIS_VAL,
+				.enable_is_inverted = true,
+				.owner = THIS_MODULE,
+			},
 		},
-	},
-	{
-		.desc = {
-			.name = "VDDDR",
-			.of_match = of_match_ptr("regulator-vdddr"),
-			.regulators_node = of_match_ptr("regulators"),
-			.id = BD957X_VDDDR,
-			.ops = &bd957x_vout34_ops,
-			.type = REGULATOR_VOLTAGE,
-			.n_voltages = BD957X_VOUTS34_NUM_VOLT,
-			.vsel_reg = BD957X_REG_VOUT3_TUNE,
-			.vsel_mask = BD957X_MASK_VOUT3_TUNE,
-			.enable_reg = BD957X_REG_POW_TRIGGER3,
-			.enable_mask = BD957X_REGULATOR_EN_MASK,
-			.enable_val = BD957X_REGULATOR_DIS_VAL,
-			.enable_is_inverted = true,
-			.owner = THIS_MODULE,
+		{
+			.desc = {
+				.name = "VDDDR",
+				.of_match = of_match_ptr("regulator-vdddr"),
+				.regulators_node = of_match_ptr("regulators"),
+				.id = BD957X_VDDDR,
+				.ops = &bd957x_vout34_ops,
+				.type = REGULATOR_VOLTAGE,
+				.n_voltages = BD957X_VOUTS34_NUM_VOLT,
+				.vsel_reg = BD957X_REG_VOUT3_TUNE,
+				.vsel_mask = BD957X_MASK_VOUT3_TUNE,
+				.enable_reg = BD957X_REG_POW_TRIGGER3,
+				.enable_mask = BD957X_REGULATOR_EN_MASK,
+				.enable_val = BD957X_REGULATOR_DIS_VAL,
+				.enable_is_inverted = true,
+				.owner = THIS_MODULE,
+			},
 		},
-	},
-	{
-		.desc = {
-			.name = "VD10",
-			.of_match = of_match_ptr("regulator-vd10"),
-			.regulators_node = of_match_ptr("regulators"),
-			.id = BD957X_VD10,
-			.ops = &bd957x_vout34_ops,
-			.type = REGULATOR_VOLTAGE,
-			.fixed_uV = BD957X_VOUTS4_BASE_VOLT,
-			.n_voltages = BD957X_VOUTS34_NUM_VOLT,
-			.vsel_reg = BD957X_REG_VOUT4_TUNE,
-			.vsel_mask = BD957X_MASK_VOUT4_TUNE,
-			.enable_reg = BD957X_REG_POW_TRIGGER4,
-			.enable_mask = BD957X_REGULATOR_EN_MASK,
-			.enable_val = BD957X_REGULATOR_DIS_VAL,
-			.enable_is_inverted = true,
-			.owner = THIS_MODULE,
+		{
+			.desc = {
+				.name = "VD10",
+				.of_match = of_match_ptr("regulator-vd10"),
+				.regulators_node = of_match_ptr("regulators"),
+				.id = BD957X_VD10,
+				.ops = &bd957x_vout34_ops,
+				.type = REGULATOR_VOLTAGE,
+				.fixed_uV = BD957X_VOUTS4_BASE_VOLT,
+				.n_voltages = BD957X_VOUTS34_NUM_VOLT,
+				.vsel_reg = BD957X_REG_VOUT4_TUNE,
+				.vsel_mask = BD957X_MASK_VOUT4_TUNE,
+				.enable_reg = BD957X_REG_POW_TRIGGER4,
+				.enable_mask = BD957X_REGULATOR_EN_MASK,
+				.enable_val = BD957X_REGULATOR_DIS_VAL,
+				.enable_is_inverted = true,
+				.owner = THIS_MODULE,
+			},
 		},
-	},
-	{
-		.desc = {
-			.name = "VOUTL1",
-			.of_match = of_match_ptr("regulator-voutl1"),
-			.regulators_node = of_match_ptr("regulators"),
-			.id = BD957X_VOUTL1,
-			.ops = &bd957x_ops,
-			.type = REGULATOR_VOLTAGE,
-			.volt_table = &voutl1_volt_table[0],
-			.n_voltages = ARRAY_SIZE(voutl1_volt_table),
-			.vsel_reg = BD957X_REG_VOUTL1_TUNE,
-			.vsel_mask = BD957X_MASK_VOUTL1_TUNE,
-			.enable_reg = BD957X_REG_POW_TRIGGERL1,
-			.enable_mask = BD957X_REGULATOR_EN_MASK,
-			.enable_val = BD957X_REGULATOR_DIS_VAL,
-			.enable_is_inverted = true,
-			.owner = THIS_MODULE,
+		{
+			.desc = {
+				.name = "VOUTL1",
+				.of_match = of_match_ptr("regulator-voutl1"),
+				.regulators_node = of_match_ptr("regulators"),
+				.id = BD957X_VOUTL1,
+				.ops = &bd957x_ops,
+				.type = REGULATOR_VOLTAGE,
+				.volt_table = &voutl1_volt_table[0],
+				.n_voltages = ARRAY_SIZE(voutl1_volt_table),
+				.vsel_reg = BD957X_REG_VOUTL1_TUNE,
+				.vsel_mask = BD957X_MASK_VOUTL1_TUNE,
+				.enable_reg = BD957X_REG_POW_TRIGGERL1,
+				.enable_mask = BD957X_REGULATOR_EN_MASK,
+				.enable_val = BD957X_REGULATOR_DIS_VAL,
+				.enable_is_inverted = true,
+				.owner = THIS_MODULE,
+			},
 		},
-	},
-	{
-		.desc = {
-			.name = "VOUTS1",
-			.of_match = of_match_ptr("regulator-vouts1"),
-			.regulators_node = of_match_ptr("regulators"),
-			.id = BD957X_VOUTS1,
-			.ops = &bd957X_vouts1_regulator_ops,
-			.type = REGULATOR_VOLTAGE,
-			.n_voltages = 1,
-			.fixed_uV = BD957X_VOUTS1_VOLT,
-			.enable_reg = BD957X_REG_POW_TRIGGERS1,
-			.enable_mask = BD957X_REGULATOR_EN_MASK,
-			.enable_val = BD957X_REGULATOR_DIS_VAL,
-			.enable_is_inverted = true,
-			.owner = THIS_MODULE,
+		{
+			.desc = {
+				.name = "VOUTS1",
+				.of_match = of_match_ptr("regulator-vouts1"),
+				.regulators_node = of_match_ptr("regulators"),
+				.id = BD957X_VOUTS1,
+				.ops = &bd957X_vouts1_regulator_ops,
+				.type = REGULATOR_VOLTAGE,
+				.n_voltages = 1,
+				.fixed_uV = BD957X_VOUTS1_VOLT,
+				.enable_reg = BD957X_REG_POW_TRIGGERS1,
+				.enable_mask = BD957X_REGULATOR_EN_MASK,
+				.enable_val = BD957X_REGULATOR_DIS_VAL,
+				.enable_is_inverted = true,
+				.owner = THIS_MODULE,
+			},
 		},
 	},
 };
 
+#define BD9576_THERM_IRQ_MASK_TW	BIT(5)
+#define BD9576_xVD_IRQ_MASK_VOUTL1	BIT(5)
+#define BD9576_UVD_IRQ_MASK_VOUTS1_OCW	BIT(6)
+void delayed_enable_irq(struct delayed_work *w, int irq)
+{
+	/* keep the "main" IRQ masked for 1 sec */
+	disable_irq_nosync(irq);
+	schedule_delayed_work(w, msecs_to_jiffies(IRQS_SILENT_MS));
+}
+
+static void bd9576_vd_err(struct bd957x_data *d,
+			  struct bd957x_regulator_data *r, int err)
+{
+	if (!r->rdev)
+		return;
+
+	spin_lock(&d->err_lock);
+	r->regulator_err |= err;
+	spin_unlock(&d->err_lock);
+	regulator_notifier_call_chain(r->rdev, err, NULL);
+}
+
+static irqreturn_t bd9576_irq_uvd(int irq, void *data)
+{
+	struct bd957x_data *d = (struct bd957x_data *)data;
+	int val, ret, i;
+
+	ret = regmap_read(d->regmap, BD957X_REG_INT_UVD_STAT, &val);
+	if (ret)
+		return IRQ_NONE;
+
+	/* bits [0] ... [3] represent xVD source VOUT1 ... VOUT4 */
+	for (i = 0; i < 4; i++)
+		if ((1 << i) & val)
+			bd9576_vd_err(d, &d->regulator_data[i],
+				      REGULATOR_ERROR_UNDER_VOLTAGE);
+
+	if (val & BD9576_xVD_IRQ_MASK_VOUTL1)
+		bd9576_vd_err(d, &d->regulator_data[BD957X_VOUTL1],
+			      REGULATOR_ERROR_UNDER_VOLTAGE);
+
+	if (val & BD9576_UVD_IRQ_MASK_VOUTS1_OCW)
+		bd9576_vd_err(d, &d->regulator_data[BD957X_VOUTS1],
+			      REGULATOR_ERROR_OVER_CURRENT);
+
+	/* Clear the sub-IRQ status */
+	regmap_update_bits(d->regmap, BD957X_REG_INT_UVD_STAT,
+			   UVD_IRQ_VALID_MASK, val);
+	delayed_enable_irq(&d->uvd_irq_suppress, irq);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd9576_irq_ovd(int irq, void *data)
+{
+	struct bd957x_data *d = (struct bd957x_data *)data;
+	int val, ret, i;
+
+	ret = regmap_read(d->regmap, BD957X_REG_INT_OVD_STAT, &val);
+	if (ret)
+		return IRQ_NONE;
+
+	if (!(val & OVD_IRQ_VALID_MASK))
+		return IRQ_NONE;
+
+	/* bits [0] ... [3] represent xVD source VOUT1 ... VOUT4 */
+	for (i = 0; i < 4; i++)
+		if ((1 << i) & val)
+			bd9576_vd_err(d, &d->regulator_data[i],
+				      REGULATOR_ERROR_REGULATION_OUT);
+
+	if (val & BD9576_xVD_IRQ_MASK_VOUTL1)
+		bd9576_vd_err(d, &d->regulator_data[BD957X_VOUTL1],
+			      REGULATOR_ERROR_REGULATION_OUT);
+
+	/* Clear the sub-IRQ status */
+	regmap_update_bits(d->regmap, BD957X_REG_INT_OVD_STAT,
+			   OVD_IRQ_VALID_MASK, val);
+	delayed_enable_irq(&d->ovd_irq_suppress, irq);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bd9576_irq_thermal(int irq, void *data)
+{
+	struct bd957x_data *d = (struct bd957x_data *)data;
+	int val, ret;
+
+	ret = regmap_read(d->regmap, BD957X_REG_INT_THERM_STAT, &val);
+	if (ret)
+		return IRQ_NONE;
+
+	if (!(val & UVD_IRQ_VALID_MASK))
+		return IRQ_NONE;
+
+	if (val & BD9576_THERM_IRQ_MASK_TW) {
+		int i;
+
+		d->regulator_global_err = REGULATOR_ERROR_OVER_TEMP;
+
+		for (i = 0; i < BD9576_NUM_REGULATORS; i++) {
+			struct regulator_dev *rdev;
+
+			rdev = d->regulator_data[i].rdev;
+			if (rdev)
+				regulator_notifier_call_chain(rdev,
+					REGULATOR_EVENT_OVER_TEMP, NULL);
+		}
+
+		/* Clear the sub-IRQ status */
+		regmap_update_bits(d->regmap, BD957X_REG_INT_THERM_STAT,
+				   BD9576_THERM_IRQ_MASK_TW,
+				   BD9576_THERM_IRQ_MASK_TW);
+	} else {
+		return IRQ_NONE;
+	}
+	delayed_enable_irq(&d->therm_irq_suppress, irq);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * BD9576 does not have a register adverticing the current status of errors.
+ * We just clean the errors when unmasking. If problem is still "on" the IRQ
+ * will re-trigger immediately => we send new notification + toggle the error
+ * flag back "on" in IRQ handler.
+ */
+static void therm_irq_work(struct work_struct *w)
+{
+	struct bd957x_data *d;
+
+	d = container_of(w, struct bd957x_data, therm_irq_suppress.work);
+	d->regulator_global_err = 0;
+	enable_irq(d->therm_irq);
+}
+
+static void ovd_irq_work(struct work_struct *w)
+{
+	struct bd957x_data *d;
+	int i, clear = REGULATOR_ERROR_REGULATION_OUT;
+
+	d = container_of(w, struct bd957x_data, ovd_irq_suppress.work);
+	spin_lock(&d->err_lock);
+	for (i = 0; i < BD9576_NUM_REGULATORS; i++)
+		d->regulator_data[i].regulator_err &= clear;
+	spin_unlock(&d->err_lock);
+	enable_irq(d->ovd_irq);
+}
+
+static void uvd_irq_work(struct work_struct *w)
+{
+	int clear, i;
+	struct bd957x_data *d;
+
+	d = container_of(w, struct bd957x_data, uvd_irq_suppress.work);
+	clear = (REGULATOR_ERROR_OVER_CURRENT | REGULATOR_ERROR_UNDER_VOLTAGE);
+
+	spin_lock(&d->err_lock);
+	for (i = 0; i < BD9576_NUM_REGULATORS; i++)
+		d->regulator_data[i].regulator_err &= clear;
+	spin_unlock(&d->err_lock);
+	enable_irq(d->uvd_irq);
+}
+
+static int bd9576_get_irqs(struct platform_device *pdev, struct regmap *regmap,
+			   struct bd957x_data *data)
+{
+	int irq, ret;
+
+	spin_lock_init(&data->err_lock);
+	irq = platform_get_irq_byname(pdev, "bd9576-temp");
+	if (irq > 0) {
+		data->therm_irq = irq;
+		INIT_DELAYED_WORK(&data->therm_irq_suppress, therm_irq_work);
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						&bd9576_irq_thermal,
+						IRQF_ONESHOT, "bd9576-temp",
+						data);
+		if (ret)
+			return ret;
+		/*
+		 * Enable therm IRQ from sub IRQ mask
+		 */
+		ret = regmap_update_bits(regmap, BD957X_REG_INT_THERM_MASK,
+					 BD9576_THERM_IRQ_MASK_TW, 0);
+		if (ret)
+			return ret;
+	}
+	irq = platform_get_irq_byname(pdev, "bd9576-ovd");
+	if (irq > 0) {
+		data->ovd_irq = irq;
+		INIT_DELAYED_WORK(&data->ovd_irq_suppress, ovd_irq_work);
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						&bd9576_irq_ovd,
+						IRQF_ONESHOT, "bd9576-ovd",
+						data);
+		if (ret)
+			return ret;
+
+	}
+	irq = platform_get_irq_byname(pdev, "bd9576-uvd");
+	if (irq > 0) {
+		data->uvd_irq = irq;
+		INIT_DELAYED_WORK(&data->uvd_irq_suppress, uvd_irq_work);
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						&bd9576_irq_uvd,
+						IRQF_ONESHOT, "bd9576-uvd",
+						data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int bd957x_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap;
 	struct regulator_config config = { 0 };
 	int i, err;
 	bool vout_mode, ddr_sel;
-	const struct bd957x_regulator_data *reg_data = &bd9576_regulators[0];
-	unsigned int num_reg_data = ARRAY_SIZE(bd9576_regulators);
+	struct bd957x_data *ic_data;
+	unsigned int num_reg_data;
 	enum rohm_chip_type chip = platform_get_device_id(pdev)->driver_data;
 
+	num_reg_data = ARRAY_SIZE(bd957x_regulators.regulator_data);
+
+	ic_data = &bd957x_regulators;
+
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap) {
 		dev_err(&pdev->dev, "No regmap\n");
 		return -EINVAL;
 	}
+	ic_data->regmap = regmap;
 	vout_mode = of_property_read_bool(pdev->dev.parent->of_node,
 					 "rohm,vout1-en-low");
 	if (vout_mode) {
@@ -263,15 +523,24 @@ static int bd957x_probe(struct platform_device *pdev)
 	 * bytes and use bd9576_regulators directly for non-constant configs
 	 * like DDR voltage selection.
 	 */
+	platform_set_drvdata(pdev, ic_data);
 	ddr_sel =  of_property_read_bool(pdev->dev.parent->of_node,
 					 "rohm,ddr-sel-low");
 	if (ddr_sel)
-		bd9576_regulators[2].desc.fixed_uV = 1350000;
+		ic_data->regulator_data[2].desc.fixed_uV = 1350000;
 	else
-		bd9576_regulators[2].desc.fixed_uV = 1500000;
+		ic_data->regulator_data[2].desc.fixed_uV = 1500000;
 
 	switch (chip) {
 	case ROHM_CHIP_TYPE_BD9576:
+		/*
+		 * And also here we pass pointer to static bd9576_regulators
+		 * for IRQs to use. If we one day allocate driver data - then
+		 * this needs to be changed too.
+		 */
+		err = bd9576_get_irqs(pdev, regmap, ic_data);
+		if (err)
+			goto err_out;
 		dev_dbg(&pdev->dev, "Found BD9576MUF\n");
 		break;
 	case ROHM_CHIP_TYPE_BD9573:
@@ -280,28 +549,26 @@ static int bd957x_probe(struct platform_device *pdev)
 	default:
 		dev_err(&pdev->dev, "Unsupported chip type\n");
 		err = -EINVAL;
-		goto err;
+		goto err_out;
 	}
 
 	config.dev = pdev->dev.parent;
 	config.regmap = regmap;
+	config.driver_data = ic_data;
 
 	for (i = 0; i < num_reg_data; i++) {
 
-		const struct regulator_desc *desc;
-		struct regulator_dev *rdev;
-		const struct bd957x_regulator_data *r;
+		struct bd957x_regulator_data *r = &ic_data->regulator_data[i];
+		const struct regulator_desc *desc = &r->desc;
 
-		r = &reg_data[i];
-		desc = &r->desc;
-
-		rdev = devm_regulator_register(&pdev->dev, desc, &config);
-		if (IS_ERR(rdev)) {
+		r->rdev = devm_regulator_register(&pdev->dev, desc,
+							   &config);
+		if (IS_ERR(r->rdev)) {
 			dev_err(&pdev->dev,
 				"failed to register %s regulator\n",
 				desc->name);
-			err = PTR_ERR(rdev);
-			goto err;
+			err = PTR_ERR(r->rdev);
+			goto err_out;
 		}
 		/*
 		 * Clear the VOUT1 GPIO setting - rest of the regulators do not
@@ -310,10 +577,32 @@ static int bd957x_probe(struct platform_device *pdev)
 		config.ena_gpiod = NULL;
 	}
 
-err:
+err_out:
+	if (err) {
+		if (ic_data->therm_irq)
+			cancel_delayed_work_sync(&ic_data->therm_irq_suppress);
+		if (ic_data->ovd_irq)
+			cancel_delayed_work_sync(&ic_data->ovd_irq_suppress);
+		if (ic_data->uvd_irq)
+			cancel_delayed_work_sync(&ic_data->uvd_irq_suppress);
+	}
 	return err;
 }
 
+static int bd957x_remove(struct platform_device *pdev)
+{
+	struct bd957x_data *ic_data = platform_get_drvdata(pdev);
+
+	if (ic_data->therm_irq)
+		cancel_delayed_work_sync(&ic_data->therm_irq_suppress);
+	if (ic_data->ovd_irq)
+		cancel_delayed_work_sync(&ic_data->ovd_irq_suppress);
+	if (ic_data->uvd_irq)
+		cancel_delayed_work_sync(&ic_data->uvd_irq_suppress);
+
+	return 0;
+}
+
 static const struct platform_device_id bd957x_pmic_id[] = {
 	{ "bd9573-pmic", ROHM_CHIP_TYPE_BD9573 },
 	{ "bd9576-pmic", ROHM_CHIP_TYPE_BD9576 },
@@ -326,6 +615,7 @@ static struct platform_driver bd957x_regulator = {
 		.name = "bd957x-pmic",
 	},
 	.probe = bd957x_probe,
+	.remove = bd957x_remove,
 	.id_table = bd957x_pmic_id,
 };
 
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
