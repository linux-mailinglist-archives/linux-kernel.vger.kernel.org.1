Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1533005B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbhAVOle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:41:34 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:46397 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbhAVOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:34:28 -0500
Received: by mail-lj1-f171.google.com with SMTP id u11so6692242ljo.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 06:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8efv/db0KKV7RWRIoXQ3UopGLK5dgv94hDeudEX0Gd8=;
        b=H5eKRP3CeKIlwS41RlB53ShFR8kP1fgCQklhRq/cGdAA658+sDz/fG5pRON25FVKEV
         /Ttk68OBu68pi01tGhNNM04W1GOx9t51YY23FvukgxRGT2UOFUwuPghNgdzm14wtt2ga
         UrU2mMvbSfQmldJPV+2L5n+Glz0lTe4WaKDuTZuO9OYNev0/zrBm4P3kTrOygLXoWs8s
         fhcRmsZBM3qjTSrI/+D1yRO7pG/igicb6k8Fdy9gTGYcZI5fRsmTAnEx4LepIguErXGo
         ov1rHtzaPLSx4jBA/CmfeoNMUq7baxzIp1Z1DuXra/KMbYBVhS+5SIyLRNyRL+EEgxOh
         GHbA==
X-Gm-Message-State: AOAM533DFLvJ71EeED5fwVk9M1AdXJdEfV5vM77eEVhU5sbROqfR6bhG
        f3aSbF1F68NHL5WP3P12feNkfVIGm2Kk1Q==
X-Google-Smtp-Source: ABdhPJyRwdOl+izSvCenC0R/Y0en/ZPHvAztDa7pAhSp5PiNKif2W2priuya6XhyslOoT2aqZ4m0rg==
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr996501ljm.507.1611326026208;
        Fri, 22 Jan 2021 06:33:46 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id n6sm907095lfd.1.2021.01.22.06.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 06:33:45 -0800 (PST)
Date:   Fri, 22 Jan 2021 16:33:38 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v7 3/6] mfd: bd9576: Add IRQ support
Message-ID: <8489e5d34a6ae26309772f7cbffaa340fbb6c34e.1611324968.git.matti.vaittinen@fi.rohmeurope.com>
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

Unfortunately the BD9576 interrupt logic was not re-evaluated. IRQs
are not designed to be properly acknowleged - and IRQ line is kept
active for whole duration of error condition (in comparison to
informing only about state change).

For above reason, do not consider missing IRQ as error.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Changes since v6:
 - new patch

 drivers/mfd/rohm-bd9576.c       |  80 +++++++++++++++++-
 include/linux/mfd/rohm-bd957x.h | 140 +++++++++++++++++++++++---------
 2 files changed, 180 insertions(+), 40 deletions(-)

diff --git a/drivers/mfd/rohm-bd9576.c b/drivers/mfd/rohm-bd9576.c
index f4dd9e438427..99fa0f333277 100644
--- a/drivers/mfd/rohm-bd9576.c
+++ b/drivers/mfd/rohm-bd9576.c
@@ -16,12 +16,27 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
+/*
+ * Due to the BD9576MUF nasty IRQ behaiour we don't always populate IRQs.
+ * These will be added to regulator resources only if IRQ information for the
+ * PMIC is populated in device-tree.
+ */
+static const struct resource bd9576_regulator_irqs[] = {
+	DEFINE_RES_IRQ_NAMED(BD9576_INT_THERM, "bd9576-temp"),
+	DEFINE_RES_IRQ_NAMED(BD9576_INT_OVD, "bd9576-ovd"),
+	DEFINE_RES_IRQ_NAMED(BD9576_INT_UVD, "bd9576-uvd"),
+};
+
 static struct mfd_cell bd9573_mfd_cells[] = {
 	{ .name = "bd9573-pmic", },
 	{ .name = "bd9576-wdt", },
 };
 
 static struct mfd_cell bd9576_mfd_cells[] = {
+	/*
+	 * Please keep regulators as first cell as resources may be overwritten
+	 * from probe and the code expects regulators to be at index 0.
+	 */
 	{ .name = "bd9576-pmic", },
 	{ .name = "bd9576-wdt", },
 };
@@ -48,6 +63,29 @@ static struct regmap_config bd957x_regmap = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+static struct regmap_irq bd9576_irqs[] = {
+	REGMAP_IRQ_REG(BD9576_INT_THERM, 0, BD957X_MASK_INT_MAIN_THERM),
+	REGMAP_IRQ_REG(BD9576_INT_OVP, 0, BD957X_MASK_INT_MAIN_OVP),
+	REGMAP_IRQ_REG(BD9576_INT_SCP, 0, BD957X_MASK_INT_MAIN_SCP),
+	REGMAP_IRQ_REG(BD9576_INT_OCP, 0, BD957X_MASK_INT_MAIN_OCP),
+	REGMAP_IRQ_REG(BD9576_INT_OVD, 0, BD957X_MASK_INT_MAIN_OVD),
+	REGMAP_IRQ_REG(BD9576_INT_UVD, 0, BD957X_MASK_INT_MAIN_UVD),
+	REGMAP_IRQ_REG(BD9576_INT_UVP, 0, BD957X_MASK_INT_MAIN_UVP),
+	REGMAP_IRQ_REG(BD9576_INT_SYS, 0, BD957X_MASK_INT_MAIN_SYS),
+};
+
+static struct regmap_irq_chip bd9576_irq_chip = {
+	.name = "bd9576_irq",
+	.irqs = &bd9576_irqs[0],
+	.num_irqs = ARRAY_SIZE(bd9576_irqs),
+	.status_base = BD957X_REG_INT_MAIN_STAT,
+	.mask_base = BD957X_REG_INT_MAIN_MASK,
+	.ack_base = BD957X_REG_INT_MAIN_STAT,
+	.init_ack_masked = true,
+	.num_regs = 1,
+	.irq_reg_stride = 1,
+};
+
 static int bd957x_i2c_probe(struct i2c_client *i2c,
 			     const struct i2c_device_id *id)
 {
@@ -56,6 +94,7 @@ static int bd957x_i2c_probe(struct i2c_client *i2c,
 	struct mfd_cell *mfd;
 	int cells;
 	unsigned long chip_type;
+	struct irq_domain *domain;
 
 	chip_type = (unsigned long)of_device_get_match_data(&i2c->dev);
 
@@ -67,6 +106,11 @@ static int bd957x_i2c_probe(struct i2c_client *i2c,
 	case ROHM_CHIP_TYPE_BD9573:
 		mfd = bd9573_mfd_cells;
 		cells = ARRAY_SIZE(bd9573_mfd_cells);
+		/* BD9573 only supports fatal IRQs which we do not handle */
+		if (i2c->irq) {
+			dev_err(&i2c->dev, "no supported irqs on BD9573\n");
+			return -EINVAL;
+		}
 		break;
 	default:
 		dev_err(&i2c->dev, "Unknown device type");
@@ -78,9 +122,43 @@ static int bd957x_i2c_probe(struct i2c_client *i2c,
 		dev_err(&i2c->dev, "Failed to initialize Regmap\n");
 		return PTR_ERR(regmap);
 	}
+	/*
+	 * BD9576 behaves badly. It kepts IRQ asserted for the whole
+	 * duration of detected HW condition (like over temp). This does
+	 * not play nicely under any condition but we can work around it
+	 * except when we have shared IRQs. So we don't require IRQ to be
+	 * populated to help those poor sods who did connect IRQ to shared pin.
+	 * If IRQ information is not given, then we mask all IRQs and do not
+	 * provide IRQ resources to regulator driver - which then just omits
+	 * the notifiers.
+	 */
+	if (i2c->irq) {
+		struct regmap_irq_chip_data *irq_data;
+		struct mfd_cell *regulators = &bd9576_mfd_cells[0];
+
+		regulators->resources = bd9576_regulator_irqs;
+		regulators->num_resources = ARRAY_SIZE(bd9576_regulator_irqs);
+
+		ret = devm_regmap_add_irq_chip(&i2c->dev, regmap, i2c->irq,
+					       IRQF_ONESHOT, 0,
+					       &bd9576_irq_chip, &irq_data);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to add IRQ chip\n");
+			return ret;
+		}
+		domain = regmap_irq_get_domain(irq_data);
+		dev_info(&i2c->dev, "Using IRQs for BD9576MUF\n");
+	} else {
+		ret = regmap_update_bits(regmap, BD957X_REG_INT_MAIN_MASK,
+					 BD957X_MASK_INT_ALL,
+					 BD957X_MASK_INT_ALL);
+		if (ret)
+			return ret;
+		domain = NULL;
+	}
 
 	ret = devm_mfd_add_devices(&i2c->dev, PLATFORM_DEVID_AUTO, mfd, cells,
-				   NULL, 0, NULL);
+				   NULL, 0, domain);
 	if (ret)
 		dev_err(&i2c->dev, "Failed to create subdevices\n");
 
diff --git a/include/linux/mfd/rohm-bd957x.h b/include/linux/mfd/rohm-bd957x.h
index 3e7ca6fe5d4f..4fa632d8467a 100644
--- a/include/linux/mfd/rohm-bd957x.h
+++ b/include/linux/mfd/rohm-bd957x.h
@@ -13,47 +13,109 @@ enum {
 	BD957X_VOUTS1,
 };
 
+/* The BD9576 has own IRQ 'blocks' for:
+ * I2C/THERMAL,
+ * Over voltage protection
+ * Short-circuit protection
+ * Over current protection
+ * Over voltage detection
+ * Under voltage detection
+ * Under voltage protection
+ * and 'system interrupt'.
+ *
+ * Each of the blocks have a status register giving more accurate IRQ source
+ * information - for example which of the regulators have over-voltage.
+ *
+ * On top of this, there is "main IRQ" status register where each bit indicates
+ * which of sub-blocks have active IRQs. Fine. That would fit regmap-irq main
+ * status handling. Except that:
+ *  - Only some sub-IRQs can be masked.
+ *  - The IRQ informs us about fault-condition, not when fault state changes.
+ *    The IRQ line it is kept asserted until the detected condition is cleared
+ *    in HW. This is _really_ annoying for IRQs like the one informing high
+ *    temperature. Best mitigation for high temperature for sure is to
+ *    keep the processor in IRQ loop, right? (NO!)
+ *
+ * So - for now we do just use the main-IRQ register as source for our IRQ
+ * information and bind the regmap-irq to this. We leave fine-grained sub-IRQ
+ * register handling to handlers in sub-devices. The regulator driver shall
+ * read which regulators are source for problem - or if the detected error is
+ * regulator temperature error. The sub-drivers do also handle masking of "sub-
+ * IRQs" if this is supported/needed.
+ *
+ * To overcome the problem with HW keeping IRQ asserted we do call
+ * disable_irq_nosync() from sub-device handler and add a delayed work to
+ * re-enable IRQ roughly 1 second later. This should keep our CPU out of
+ * busy-loop.
+ */
+
+#define IRQS_SILENT_MS 1000
+
+enum {
+	BD9576_INT_THERM,
+	BD9576_INT_OVP,
+	BD9576_INT_SCP,
+	BD9576_INT_OCP,
+	BD9576_INT_OVD,
+	BD9576_INT_UVD,
+	BD9576_INT_UVP,
+	BD9576_INT_SYS,
+};
+
 #define BD957X_REG_SMRB_ASSERT		0x15
 #define BD957X_REG_PMIC_INTERNAL_STAT	0x20
 #define BD957X_REG_INT_THERM_STAT	0x23
-#define BD957X_REG_INT_THERM_MASK 0x24
-#define BD957X_REG_INT_OVP_STAT 0x25
-#define BD957X_REG_INT_SCP_STAT 0x26
-#define BD957X_REG_INT_OCP_STAT 0x27
-#define BD957X_REG_INT_OVD_STAT 0x28
-#define BD957X_REG_INT_UVD_STAT 0x29
-#define BD957X_REG_INT_UVP_STAT 0x2a
-#define BD957X_REG_INT_SYS_STAT 0x2b
-#define BD957X_REG_INT_SYS_MASK 0x2c
-#define BD957X_REG_INT_MAIN_STAT 0x30
-#define BD957X_REG_INT_MAIN_MASK 0x31
-
-#define BD957X_REG_WDT_CONF 0x16
-
-#define BD957X_REG_POW_TRIGGER1 0x41
-#define BD957X_REG_POW_TRIGGER2 0x42
-#define BD957X_REG_POW_TRIGGER3 0x43
-#define BD957X_REG_POW_TRIGGER4 0x44
-#define BD957X_REG_POW_TRIGGERL1 0x45
-#define BD957X_REG_POW_TRIGGERS1 0x46
-
-#define BD957X_REGULATOR_EN_MASK 0xff
-#define BD957X_REGULATOR_DIS_VAL 0xff
-
-#define BD957X_VSEL_REG_MASK	0xff
-
-#define BD957X_MASK_VOUT1_TUNE	0x87
-#define BD957X_MASK_VOUT2_TUNE	0x87
-#define BD957X_MASK_VOUT3_TUNE	0x1f
-#define BD957X_MASK_VOUT4_TUNE	0x1f
-#define BD957X_MASK_VOUTL1_TUNE	0x87
-
-#define BD957X_REG_VOUT1_TUNE	0x50
-#define BD957X_REG_VOUT2_TUNE	0x53
-#define BD957X_REG_VOUT3_TUNE	0x56
-#define BD957X_REG_VOUT4_TUNE	0x59
-#define BD957X_REG_VOUTL1_TUNE	0x5c
-
-#define BD957X_MAX_REGISTER 0x61
+#define BD957X_REG_INT_THERM_MASK	0x24
+#define BD957X_REG_INT_OVP_STAT		0x25
+#define BD957X_REG_INT_SCP_STAT		0x26
+#define BD957X_REG_INT_OCP_STAT		0x27
+#define BD957X_REG_INT_OVD_STAT		0x28
+#define BD957X_REG_INT_UVD_STAT		0x29
+#define BD957X_REG_INT_UVP_STAT		0x2a
+#define BD957X_REG_INT_SYS_STAT		0x2b
+#define BD957X_REG_INT_SYS_MASK		0x2c
+#define BD957X_REG_INT_MAIN_STAT	0x30
+#define BD957X_REG_INT_MAIN_MASK	0x31
+
+#define UVD_IRQ_VALID_MASK		0x6F
+#define OVD_IRQ_VALID_MASK		0x2F
+
+#define BD957X_MASK_INT_MAIN_THERM	BIT(0)
+#define BD957X_MASK_INT_MAIN_OVP	BIT(1)
+#define BD957X_MASK_INT_MAIN_SCP	BIT(2)
+#define BD957X_MASK_INT_MAIN_OCP	BIT(3)
+#define BD957X_MASK_INT_MAIN_OVD	BIT(4)
+#define BD957X_MASK_INT_MAIN_UVD	BIT(5)
+#define BD957X_MASK_INT_MAIN_UVP	BIT(6)
+#define BD957X_MASK_INT_MAIN_SYS	BIT(7)
+#define BD957X_MASK_INT_ALL		0xff
+
+#define BD957X_REG_WDT_CONF		0x16
+
+#define BD957X_REG_POW_TRIGGER1		0x41
+#define BD957X_REG_POW_TRIGGER2		0x42
+#define BD957X_REG_POW_TRIGGER3		0x43
+#define BD957X_REG_POW_TRIGGER4		0x44
+#define BD957X_REG_POW_TRIGGERL1	0x45
+#define BD957X_REG_POW_TRIGGERS1	0x46
+
+#define BD957X_REGULATOR_EN_MASK	0xff
+#define BD957X_REGULATOR_DIS_VAL	0xff
+
+#define BD957X_VSEL_REG_MASK		0xff
+
+#define BD957X_MASK_VOUT1_TUNE		0x87
+#define BD957X_MASK_VOUT2_TUNE		0x87
+#define BD957X_MASK_VOUT3_TUNE		0x1f
+#define BD957X_MASK_VOUT4_TUNE		0x1f
+#define BD957X_MASK_VOUTL1_TUNE		0x87
+
+#define BD957X_REG_VOUT1_TUNE		0x50
+#define BD957X_REG_VOUT2_TUNE		0x53
+#define BD957X_REG_VOUT3_TUNE		0x56
+#define BD957X_REG_VOUT4_TUNE		0x59
+#define BD957X_REG_VOUTL1_TUNE		0x5c
+
+#define BD957X_MAX_REGISTER		0x61
 
 #endif
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
