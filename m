Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9441D200827
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 13:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732820AbgFSLzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 07:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732343AbgFSLzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:55:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F61C0613EF
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:55:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s10so4420670pgm.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 04:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dcN3meLAI17H/mxoVJQTTxgzB2Vv0fY9Kr8wPSUTW+E=;
        b=FTp4Ik5oWvgmg6rVSFIxHcJ/QLbu1kBf50kBC+XBVcG97UMArK1uMyBog2z0E/H6wb
         knjyN9qFaDm6oH6xP0RYTzuWJP3KV6oAFa8UjNZKGLc63aAU7TsMIupxGQsvnP/rcs9v
         nRJ6FGF+pBMbzlWpDcGj5fzNSpqMN/xsbAZA3kR3gnmX5C1cVIjVz9vc720NCjkjFaY0
         DJdEgwBQdrbAr5s/R92F1LwxprJ8dDytQMK4WIHVLbNvXPeGl3nAQ9ezGInp38LX5PlJ
         13yvsFNNN8bgPgwdBWRmoxAiuR5Evgj4tLfqP7pO2Fq86TvN669LzIe4KoqBeyP0fhMV
         12Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dcN3meLAI17H/mxoVJQTTxgzB2Vv0fY9Kr8wPSUTW+E=;
        b=rGTvFjo9sFLgL2geM9TaX5Tnq+IKGrM8X1W4xiThnni/19tP6pFZnRFfN4CY/C1/CF
         7phDksdcnM5Zjmuy52X4mHv8eYEBRLP7Z6FsOPpVDsSLHzHMcYprjvgZ1CyEyN5DlOVi
         RcP5Swm/sikzxZlnd0TrXQirwDlupZ+RsNLj9RR0V1KKyDhm83ohWx+2vy/cswjty8bP
         Zs0y6Kl9b5widasfRcg9F4evTwALs3GruuKSzrPDWqQ5g9fSQjoqiLv6XoupucXdwk6F
         9ETz5FSnzYnB4wESaYhkNPZ7yxjEcOHN1u1zALduSxGpfRPt5GNdV4XKbtL6Q3lKJftw
         b1VA==
X-Gm-Message-State: AOAM532GhUn4IKBHcbi1S3wxprZ2Ob9A5+ZgwY6Rz/ut63f1pebhMQRg
        WZSwuW5KAPfKwUqvAKaodts=
X-Google-Smtp-Source: ABdhPJwRULU+2sQ6xiSpEtBJmt71hLIyZtH2JJH+60C9gdSU6VGOhh1cV4rLtkrM6BmS2Si3hCOMNA==
X-Received: by 2002:a62:8106:: with SMTP id t6mr7994109pfd.103.1592567700002;
        Fri, 19 Jun 2020 04:55:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46c:79b7:a5d3:5b37:1d99:175a])
        by smtp.gmail.com with ESMTPSA id n64sm5026712pga.38.2020.06.19.04.54.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jun 2020 04:54:59 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, jic23@kernel.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, matthias.bgg@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        dmurphy@ti.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH v2 4/4] regulator: mt6360: Add support for MT6360 regulator
Date:   Fri, 19 Jun 2020 19:53:51 +0800
Message-Id: <1592567631-20363-5-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
References: <1592567631-20363-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Add MT6360 regulator driver include 2-channel buck and
6-channel ldo

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/regulator/Kconfig            |   9 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/mt6360-regulator.c | 485 +++++++++++++++++++++++++++++++++++
 3 files changed, 495 insertions(+)
 create mode 100644 drivers/regulator/mt6360-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 8f677f5..9ae5711 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -691,6 +691,15 @@ config REGULATOR_MT6358
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
+config REGULATOR_MT6360
+	tristate "MT6360 SubPMIC Regulator"
+	depends on MFD_MT6360
+	help
+	  Say Y here to enable MT6360 regulator support.
+	  This is support MT6360 PMIC/LDO part include
+	  2-channel buck with Thermal Shutdown and Overload Protection
+	  6-channel High PSRR and Low Dropout LDO.
+
 config REGULATOR_MT6380
 	tristate "MediaTek MT6380 PMIC"
 	depends on MTK_PMIC_WRAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index e8f1633..7256457 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
+obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_RPM) += qcom_rpm-regulator.o
diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
new file mode 100644
index 0000000..f3c8911
--- /dev/null
+++ b/drivers/regulator/mt6360-regulator.c
@@ -0,0 +1,485 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (c) 2020 MediaTek Inc.
+
+// Author: Gene Chen <gene_chen@richtek.com>
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/version.h>
+
+#include <dt-bindings/mfd/mt6360.h>
+
+enum {
+	MT6360_REGULATOR_BUCK1 = 0,
+	MT6360_REGULATOR_BUCK2,
+	MT6360_REGULATOR_LDO6,
+	MT6360_REGULATOR_LDO7,
+	MT6360_REGULATOR_LDO1,
+	MT6360_REGULATOR_LDO2,
+	MT6360_REGULATOR_LDO3,
+	MT6360_REGULATOR_LDO5,
+	MT6360_REGULATOR_MAX,
+};
+
+struct mt6360_irq_mapping {
+	const char *name;
+	irq_handler_t handler;
+};
+
+struct mt6360_regulator_desc {
+	const struct regulator_desc desc;
+	unsigned int mode_reg;
+	unsigned int mode_mask;
+	unsigned int state_reg;
+	unsigned int state_mask;
+	const struct mt6360_irq_mapping *irq_tables;
+	int irq_table_size;
+};
+
+struct mt6360_regulator_data {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+static irqreturn_t mt6360_pgb_event_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_FAIL, NULL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mt6360_oc_event_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_CURRENT, NULL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mt6360_ov_event_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev,
+				      REGULATOR_EVENT_REGULATION_OUT, NULL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mt6360_uv_event_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev,
+				      REGULATOR_EVENT_UNDER_VOLTAGE, NULL);
+	return IRQ_HANDLED;
+}
+
+static const struct mt6360_irq_mapping buck1_irq_tbls[] = {
+	{ "buck1_pgb_evt", mt6360_pgb_event_handler },
+	{ "buck1_oc_evt", mt6360_oc_event_handler },
+	{ "buck1_ov_evt", mt6360_ov_event_handler },
+	{ "buck1_uv_evt", mt6360_uv_event_handler },
+};
+
+static const struct mt6360_irq_mapping buck2_irq_tbls[] = {
+	{ "buck2_pgb_evt", mt6360_pgb_event_handler },
+	{ "buck2_oc_evt", mt6360_oc_event_handler },
+	{ "buck2_ov_evt", mt6360_ov_event_handler },
+	{ "buck2_uv_evt", mt6360_uv_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo6_irq_tbls[] = {
+	{ "ldo6_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo6_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo7_irq_tbls[] = {
+	{ "ldo7_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo7_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo1_irq_tbls[] = {
+	{ "ldo1_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo1_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo2_irq_tbls[] = {
+	{ "ldo2_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo2_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo3_irq_tbls[] = {
+	{ "ldo3_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo3_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct mt6360_irq_mapping ldo5_irq_tbls[] = {
+	{ "ldo5_pgb_evt", mt6360_pgb_event_handler },
+	{ "ldo5_oc_evt", mt6360_oc_event_handler },
+};
+
+static const struct linear_range buck_vout_ranges[] = {
+	REGULATOR_LINEAR_RANGE(300000, 0x00, 0xc7, 5000),
+	REGULATOR_LINEAR_RANGE(1300000, 0xc8, 0xff, 0),
+};
+
+static const struct linear_range ldo_vout_ranges1[] = {
+	REGULATOR_LINEAR_RANGE(500000, 0x00, 0x09, 10000),
+	REGULATOR_LINEAR_RANGE(600000, 0x0a, 0x10, 0),
+	REGULATOR_LINEAR_RANGE(610000, 0x11, 0x19, 10000),
+	REGULATOR_LINEAR_RANGE(700000, 0x1a, 0x20, 0),
+	REGULATOR_LINEAR_RANGE(710000, 0x21, 0x29, 10000),
+	REGULATOR_LINEAR_RANGE(800000, 0x2a, 0x30, 0),
+	REGULATOR_LINEAR_RANGE(810000, 0x31, 0x39, 10000),
+	REGULATOR_LINEAR_RANGE(900000, 0x3a, 0x40, 0),
+	REGULATOR_LINEAR_RANGE(910000, 0x41, 0x49, 10000),
+	REGULATOR_LINEAR_RANGE(1000000, 0x4a, 0x50, 0),
+	REGULATOR_LINEAR_RANGE(1010000, 0x51, 0x59, 10000),
+	REGULATOR_LINEAR_RANGE(1100000, 0x5a, 0x60, 0),
+	REGULATOR_LINEAR_RANGE(1110000, 0x61, 0x69, 10000),
+	REGULATOR_LINEAR_RANGE(1200000, 0x6a, 0x70, 0),
+	REGULATOR_LINEAR_RANGE(1210000, 0x71, 0x79, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0x7a, 0x80, 0),
+	REGULATOR_LINEAR_RANGE(1310000, 0x81, 0x89, 10000),
+	REGULATOR_LINEAR_RANGE(1400000, 0x8a, 0x90, 0),
+	REGULATOR_LINEAR_RANGE(1410000, 0x91, 0x99, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 0x9a, 0xa0, 0),
+	REGULATOR_LINEAR_RANGE(1510000, 0xa1, 0xa9, 10000),
+	REGULATOR_LINEAR_RANGE(1600000, 0xaa, 0xb0, 0),
+	REGULATOR_LINEAR_RANGE(1610000, 0xb1, 0xb9, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 0xba, 0xc0, 0),
+	REGULATOR_LINEAR_RANGE(1710000, 0xc1, 0xc9, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0xca, 0xd0, 0),
+	REGULATOR_LINEAR_RANGE(1810000, 0xd1, 0xd9, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 0xda, 0xe0, 0),
+	REGULATOR_LINEAR_RANGE(1910000, 0xe1, 0xe9, 10000),
+	REGULATOR_LINEAR_RANGE(2000000, 0xea, 0xf0, 0),
+	REGULATOR_LINEAR_RANGE(2010000, 0xf1, 0xf9, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0xfa, 0xff, 0),
+};
+
+static const struct linear_range ldo_vout_ranges2[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x00, 0x09, 10000),
+	REGULATOR_LINEAR_RANGE(1300000, 0x0a, 0x10, 0),
+	REGULATOR_LINEAR_RANGE(1310000, 0x11, 0x19, 10000),
+	REGULATOR_LINEAR_RANGE(1400000, 0x1a, 0x1f, 0),
+	REGULATOR_LINEAR_RANGE(1500000, 0x20, 0x29, 10000),
+	REGULATOR_LINEAR_RANGE(1600000, 0x2a, 0x2f, 0),
+	REGULATOR_LINEAR_RANGE(1700000, 0x30, 0x39, 10000),
+	REGULATOR_LINEAR_RANGE(1800000, 0x3a, 0x40, 0),
+	REGULATOR_LINEAR_RANGE(1810000, 0x41, 0x49, 10000),
+	REGULATOR_LINEAR_RANGE(1900000, 0x4a, 0x4f, 0),
+	REGULATOR_LINEAR_RANGE(2000000, 0x50, 0x59, 10000),
+	REGULATOR_LINEAR_RANGE(2100000, 0x5a, 0x60, 0),
+	REGULATOR_LINEAR_RANGE(2110000, 0x61, 0x69, 10000),
+	REGULATOR_LINEAR_RANGE(2200000, 0x6a, 0x6f, 0),
+	REGULATOR_LINEAR_RANGE(2500000, 0x70, 0x79, 10000),
+	REGULATOR_LINEAR_RANGE(2600000, 0x7a, 0x7f, 0),
+	REGULATOR_LINEAR_RANGE(2700000, 0x80, 0x89, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0x8a, 0x90, 0),
+	REGULATOR_LINEAR_RANGE(2810000, 0x91, 0x99, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0x9a, 0xa0, 0),
+	REGULATOR_LINEAR_RANGE(2910000, 0xa1, 0xa9, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0xaa, 0xb0, 0),
+	REGULATOR_LINEAR_RANGE(3010000, 0xb1, 0xb9, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0xba, 0xc0, 0),
+	REGULATOR_LINEAR_RANGE(3110000, 0xc1, 0xc9, 10000),
+	REGULATOR_LINEAR_RANGE(3200000, 0xca, 0xcf, 0),
+	REGULATOR_LINEAR_RANGE(3300000, 0xd0, 0xd9, 10000),
+	REGULATOR_LINEAR_RANGE(3400000, 0xda, 0xe0, 0),
+	REGULATOR_LINEAR_RANGE(3410000, 0xe1, 0xe9, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0xea, 0xf0, 0),
+	REGULATOR_LINEAR_RANGE(3510000, 0xf1, 0xf9, 10000),
+	REGULATOR_LINEAR_RANGE(3600000, 0xfa, 0xff, 0),
+};
+
+static const struct linear_range ldo_vout_ranges3[] = {
+	REGULATOR_LINEAR_RANGE(2700000, 0x00, 0x09, 10000),
+	REGULATOR_LINEAR_RANGE(2800000, 0x0a, 0x10, 0),
+	REGULATOR_LINEAR_RANGE(2810000, 0x11, 0x19, 10000),
+	REGULATOR_LINEAR_RANGE(2900000, 0x1a, 0x20, 0),
+	REGULATOR_LINEAR_RANGE(2910000, 0x21, 0x29, 10000),
+	REGULATOR_LINEAR_RANGE(3000000, 0x2a, 0x30, 0),
+	REGULATOR_LINEAR_RANGE(3010000, 0x31, 0x39, 10000),
+	REGULATOR_LINEAR_RANGE(3100000, 0x3a, 0x40, 0),
+	REGULATOR_LINEAR_RANGE(3110000, 0x41, 0x49, 10000),
+	REGULATOR_LINEAR_RANGE(3200000, 0x4a, 0x4f, 0),
+	REGULATOR_LINEAR_RANGE(3300000, 0x50, 0x59, 10000),
+	REGULATOR_LINEAR_RANGE(3400000, 0x5a, 0x60, 0),
+	REGULATOR_LINEAR_RANGE(3410000, 0x61, 0x69, 10000),
+	REGULATOR_LINEAR_RANGE(3500000, 0x6a, 0x70, 0),
+	REGULATOR_LINEAR_RANGE(3510000, 0x71, 0x79, 10000),
+	REGULATOR_LINEAR_RANGE(3600000, 0x7a, 0x7f, 0),
+};
+
+static int mt6360_regulator_set_mode(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	const struct mt6360_regulator_desc *rdesc =
+			       (const struct mt6360_regulator_desc *)rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int shift = ffs(rdesc->mode_mask) - 1;
+	unsigned int val;
+	int ret;
+
+	switch (mode) {
+	case REGULATOR_MODE_NORMAL:
+		val = MT6360_OPMODE_NORMAL;
+		break;
+	case REGULATOR_MODE_STANDBY:
+		val = MT6360_OPMODE_ULP;
+		break;
+	case REGULATOR_MODE_IDLE:
+		val = MT6360_OPMODE_LP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(regmap, rdesc->mode_reg,
+				 rdesc->mode_mask, val << shift);
+	if (ret) {
+		dev_err(&rdev->dev, "%s: fail (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static unsigned int mt6360_regulator_get_mode(struct regulator_dev *rdev)
+{
+	const struct mt6360_regulator_desc *rdesc =
+			       (const struct mt6360_regulator_desc *)rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	int shift = ffs(rdesc->mode_mask) - 1;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, rdesc->mode_reg, &val);
+	if (ret)
+		return ret;
+
+	val &= rdesc->mode_mask;
+	val >>= shift;
+
+	switch (val) {
+	case MT6360_OPMODE_LP:
+		return REGULATOR_MODE_IDLE;
+	case MT6360_OPMODE_ULP:
+		return REGULATOR_MODE_STANDBY;
+	case MT6360_OPMODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mt6360_regulator_get_status(struct regulator_dev *rdev)
+{
+	const struct mt6360_regulator_desc *rdesc =
+			       (const struct mt6360_regulator_desc *)rdev->desc;
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, rdesc->state_reg, &val);
+	if (ret)
+		return ret;
+
+	if (val & rdesc->state_mask)
+		return REGULATOR_STATUS_ON;
+
+	return REGULATOR_STATUS_OFF;
+}
+
+static const struct regulator_ops mt6360_regulator_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_mode = mt6360_regulator_set_mode,
+	.get_mode = mt6360_regulator_get_mode,
+	.get_status = mt6360_regulator_get_status,
+};
+
+static unsigned int mt6360_regulator_of_map_mode(unsigned int hw_mode)
+{
+	switch (hw_mode) {
+	case MT6360_OPMODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case MT6360_OPMODE_LP:
+		return REGULATOR_MODE_IDLE;
+	case MT6360_OPMODE_ULP:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+#define MT6360_REGULATOR_DESC(_name, _sname, ereg, emask, vreg,	vmask,	\
+			      mreg, mmask, streg, stmask, vranges,	\
+			      vcnts, offon_delay, irq_tbls)		\
+{									\
+	.desc = {							\
+		.name = #_name,						\
+		.supply_name = #_sname,					\
+		.id =  MT6360_REGULATOR_##_name,			\
+		.of_match = of_match_ptr(#_name),			\
+		.of_map_mode = mt6360_regulator_of_map_mode,		\
+		.owner = THIS_MODULE,					\
+		.ops = &mt6360_regulator_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.vsel_reg = vreg,					\
+		.vsel_mask = vmask,					\
+		.enable_reg = ereg,					\
+		.enable_mask = emask,					\
+		.linear_ranges = vranges,				\
+		.n_linear_ranges = ARRAY_SIZE(vranges),			\
+		.n_voltages = vcnts,					\
+		.off_on_delay = offon_delay,				\
+	},								\
+	.mode_reg = mreg,						\
+	.mode_mask = mmask,						\
+	.state_reg = streg,						\
+	.state_mask = stmask,						\
+	.irq_tables = irq_tbls,						\
+	.irq_table_size = ARRAY_SIZE(irq_tbls),				\
+}
+
+static const struct mt6360_regulator_desc mt6360_regulator_descs[] =  {
+	MT6360_REGULATOR_DESC(BUCK1, BUCK1_VIN, 0x117, 0x40, 0x110, 0xff, 0x117,
+			      0x30, 0x117, 0x04, buck_vout_ranges, 256, 0,
+			      buck1_irq_tbls),
+	MT6360_REGULATOR_DESC(BUCK2, BUCK2_VIN, 0x127, 0x40, 0x120, 0xff, 0x127,
+			      0x30, 0x127, 0x04, buck_vout_ranges, 256, 0,
+			      buck2_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO6, LDO_VIN3, 0x137, 0x40, 0x13B, 0xff, 0x137,
+			      0x30, 0x137, 0x04, ldo_vout_ranges1, 256, 0,
+			      ldo6_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO7, LDO_VIN3, 0x131, 0x40, 0x135, 0xff, 0x131,
+			      0x30, 0x131, 0x04, ldo_vout_ranges1, 256, 0,
+			      ldo7_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO1, LDO_VIN1, 0x217, 0x40, 0x21B, 0xff, 0x217,
+			      0x30, 0x217, 0x04, ldo_vout_ranges2, 256, 0,
+			      ldo1_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO2, LDO_VIN1, 0x211, 0x40, 0x215, 0xff, 0x211,
+			      0x30, 0x211, 0x04, ldo_vout_ranges2, 256, 0,
+			      ldo2_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO3, LDO_VIN1, 0x205, 0x40, 0x209, 0xff, 0x205,
+			      0x30, 0x205, 0x04, ldo_vout_ranges2, 256, 100,
+			      ldo3_irq_tbls),
+	MT6360_REGULATOR_DESC(LDO5, LDO_VIN2, 0x20B, 0x40, 0x20F, 0x7f, 0x20B,
+			      0x30, 0x20B, 0x04, ldo_vout_ranges3, 128, 100,
+			      ldo5_irq_tbls),
+};
+
+static int mt6360_regulator_irq_register(struct platform_device *pdev,
+					 struct regulator_dev *rdev,
+					 const struct mt6360_irq_mapping *tbls,
+					 int tbl_size)
+{
+	int i, irq, ret;
+
+	for (i = 0; i < tbl_size; i++) {
+		const struct mt6360_irq_mapping *irq_desc = tbls + i;
+
+		irq = platform_get_irq_byname(pdev, irq_desc->name);
+		if (irq < 0) {
+			dev_err(&pdev->dev,
+				"Fail to get %s irq\n", irq_desc->name);
+			return irq;
+		}
+
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						irq_desc->handler,
+						IRQF_TRIGGER_NONE,
+						irq_desc->name,
+						rdev);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Fail to request %s irq\n", irq_desc->name);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mt6360_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6360_regulator_data *mrd;
+	struct regulator_config config = {};
+	int i, ret;
+
+	mrd = devm_kzalloc(&pdev->dev, sizeof(*mrd), GFP_KERNEL);
+	if (!mrd)
+		return -ENOMEM;
+
+	mrd->dev = &pdev->dev;
+
+	mrd->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!mrd->regmap) {
+		dev_err(&pdev->dev, "Failed to get parent regmap\n");
+		return -ENODEV;
+	}
+
+	config.dev = &pdev->dev;
+	config.driver_data = mrd;
+	config.regmap = mrd->regmap;
+
+	for (i = 0; i < ARRAY_SIZE(mt6360_regulator_descs); i++) {
+		const struct mt6360_regulator_desc *rdesc =
+						mt6360_regulator_descs + i;
+		struct regulator_dev *rdev;
+
+		rdev = devm_regulator_register(&pdev->dev,
+					       &rdesc->desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev,
+				"Failed to register  %d regulaotr\n", i);
+			return PTR_ERR(rdev);
+		}
+
+		ret = mt6360_regulator_irq_register(pdev, rdev,
+						    rdesc->irq_tables,
+						    rdesc->irq_table_size);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to register  %d regulaotr irqs\n", i);
+			return ret;
+		}
+	}
+
+	platform_set_drvdata(pdev, mrd);
+
+	return 0;
+}
+
+static const struct of_device_id __maybe_unused mt6360_regulator_of_id[] = {
+	{ .compatible = "mediatek,mt6360-regulator", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt6360_regulator_of_id);
+
+static struct platform_driver mt6360_regulator_driver = {
+	.driver = {
+		.name = "mt6360-regulator",
+		.of_match_table = mt6360_regulator_of_id,
+	},
+	.probe = mt6360_regulator_probe,
+};
+module_platform_driver(mt6360_regulator_driver);
+
+MODULE_AUTHOR("Gene Chen <gene_chen@richtek.com>");
+MODULE_DESCRIPTION("MT6360 Regulator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

