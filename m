Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9C62774C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgIXPFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgIXPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:05:01 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C46C0613CE;
        Thu, 24 Sep 2020 08:05:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a9so1853222pjg.1;
        Thu, 24 Sep 2020 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ek3reysG96ZJh15Vyft2zsEiGI7CE4Kkx9w8THzaS6s=;
        b=jTNDioecUP7vIMvteHC816cTG1kjGdR4u6l+DYUk+rXWUopx7iyPATG9Mak+exCRnd
         JXHpyIkG8VSkzhH91Zr6p36ajQNio//9wr9siQrWrVeMmfMWQKYGZooWnQV9jB0xXCYL
         G+xZPb2huKElhjwB8GqJwaTlVcNGPyj69Jn5oFUOnVvsWl5fKTNauoMvRvxd/P2azwXb
         n5lo6Z0LSQKQcS2qDn+8PGNMBJa/FdtNr5jxeOl0njgK2KfHTGraPDGMCZtXhBfXlN4X
         Wj9Pft+CYsh73574CeJvfgjPLTpOKj1GuwUaUPC08M7MoE7OGtqvOfz0w1mDZLpeJWZP
         ZtyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ek3reysG96ZJh15Vyft2zsEiGI7CE4Kkx9w8THzaS6s=;
        b=tMwmXNVcRzUid1/E0thTNc2r/3gLybDBasZE2FiIWzpXsUEPmtOXNldXqPdMuuphue
         xQB4IVPkLW21PgJfP3WCQRCO+M/KdoAPb7bujqZg7+BHK2q5ftGZS/6v4AtNVfExOwIY
         RmoXVrPtF01xgsFMwDnI47XmoQ7S+KSlyNfzqCKC/t8lbk8HhESGjtoOh5kmH8JPdHYZ
         7aD2C8d4QaUu4liqPkmkBkDon8uFnTAlrNlzGyD3E4CGQ2PF6kH/0g1eroMt4Adbvk2p
         uHoOjtVry1OZdh5ejYPud7pNeg/CdeXsQMj9WYKBo34VWRTOo8KGpqmlwMvJKXhA/asF
         B8ow==
X-Gm-Message-State: AOAM532nRkv2/b/DcZsocY70ZzzAGHmQKPTZPxO3xRyxHtb2fVeTYN4d
        tXf668nurRLE8o5VfbdPfdk=
X-Google-Smtp-Source: ABdhPJwW0JbOtXDrlyeYwDOiiOat4dtQCmgFIp5jlW48nw1VHRMJMZ7lXVhiNRLNLkm/2SGb9aL4Ug==
X-Received: by 2002:a17:90b:fc4:: with SMTP id gd4mr4423133pjb.129.1600959900067;
        Thu, 24 Sep 2020 08:05:00 -0700 (PDT)
Received: from localhost.localdomain ([123.110.152.116])
        by smtp.gmail.com with ESMTPSA id w203sm3747251pff.0.2020.09.24.08.04.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Sep 2020 08:04:58 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] regulator: rtmv20: Adds support for Richtek RTMV20 load switch regulator
Date:   Thu, 24 Sep 2020 23:04:50 +0800
Message-Id: <1600959891-16606-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add support for Richtek RTMV20 load switch regulator.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/Kconfig            |   9 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/rtmv20-regulator.c | 512 +++++++++++++++++++++++++++++++++++
 3 files changed, 522 insertions(+)
 create mode 100644 drivers/regulator/rtmv20-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index de17ef7..400ad4c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -902,6 +902,15 @@ config REGULATOR_RT5033
 	  RT5033 PMIC. The device supports multiple regulators like
 	  current source, LDO and Buck.
 
+config REGULATOR_RTMV20
+	tristate "RTMV20 Laser Diode Regulator"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  This driver adds support for the load switch current regulator on
+	  the Richtek RTMV20. It can support the load current up to 6A and
+	  integrate strobe/vsync/fsin signal to synchronize the IR camera.
+
 config REGULATOR_S2MPA01
 	tristate "Samsung S2MPA01 voltage regulator"
 	depends on MFD_SEC_CORE
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index d8d3ecf..89a1cb0 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_REGULATOR_RK808)   += rk808-regulator.o
 obj-$(CONFIG_REGULATOR_RN5T618) += rn5t618-regulator.o
 obj-$(CONFIG_REGULATOR_ROHM)	+= rohm-regulator.o
 obj-$(CONFIG_REGULATOR_RT5033)	+= rt5033-regulator.o
+obj-$(CONFIG_REGULATOR_RTMV20)	+= rtmv20-regulator.o
 obj-$(CONFIG_REGULATOR_S2MPA01) += s2mpa01.o
 obj-$(CONFIG_REGULATOR_S2MPS11) += s2mps11.o
 obj-$(CONFIG_REGULATOR_S5M8767) += s5m8767.o
diff --git a/drivers/regulator/rtmv20-regulator.c b/drivers/regulator/rtmv20-regulator.c
new file mode 100644
index 00000000..8fa083c
--- /dev/null
+++ b/drivers/regulator/rtmv20-regulator.c
@@ -0,0 +1,512 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+
+#define RTMV20_REG_DEVINFO	0x00
+#define RTMV20_REG_PULSEDELAY	0x01
+#define RTMV20_REG_PULSEWIDTH	0x03
+#define RTMV20_REG_LDCTRL1	0x05
+#define RTMV20_REG_ESPULSEWIDTH	0x06
+#define RTMV20_REG_ESLDCTRL1	0x08
+#define RTMV20_REG_LBP		0x0A
+#define RTMV20_REG_LDCTRL2	0x0B
+#define RTMV20_REG_FSIN1CTRL1	0x0D
+#define RTMV20_REG_FSIN1CTRL3	0x0F
+#define RTMV20_REG_FSIN2CTRL1	0x10
+#define RTMV20_REG_FSIN2CTRL3	0x12
+#define RTMV20_REG_ENCTRL	0x13
+#define RTMV20_REG_STRBVSYNDLYL 0x29
+#define RTMV20_REG_LDIRQ	0x30
+#define RTMV20_REG_LDSTAT	0x40
+#define RTMV20_REG_LDMASK	0x50
+
+#define RTMV20_VID_MASK		GENMASK(7, 4)
+#define RICHTEK_VID		0x80
+#define RTMV20_LDCURR_MASK	GENMASK(7, 0)
+#define RTMV20_DELAY_MASK	GENMASK(9, 0)
+#define RTMV20_WIDTH_MASK	GENMASK(13, 0)
+#define RTMV20_WIDTH2_MASK	GENMASK(7, 0)
+#define RTMV20_LBPLVL_MASK	GENMASK(3, 0)
+#define RTMV20_LBPEN_MASK	BIT(7)
+#define RTMV20_STROBEPOL_MASK	BIT(1)
+#define RTMV20_VSYNPOL_MASK	BIT(1)
+#define RTMV20_FSINEN_MASK	BIT(7)
+#define RTMV20_ESEN_MASK	BIT(6)
+#define RTMV20_FSINOUT_MASK	BIT(2)
+#define LDENABLE_MASK		(BIT(3) | BIT(0))
+
+#define OTPEVT_MASK		BIT(4)
+#define SHORTEVT_MASK		BIT(3)
+#define OPENEVT_MASK		BIT(2)
+#define LBPEVT_MASK		BIT(1)
+#define OCPEVT_MASK		BIT(0)
+#define FAILEVT_MASK		(SHORTEVT_MASK | OPENEVT_MASK | LBPEVT_MASK)
+
+#define RTMV20_1BYTE_ACCES	1
+#define RTMV20_2BYTE_ACCES	2
+
+#define RTMV20_LSW_MINUA	0
+#define RTMV20_LSW_MAXUA	6000000
+#define RTMV20_LSW_STEPUA	30000
+
+#define RTMV20_LSW_DEFAULTUA	3000000
+
+#define RTMV20_I2CRDY_TIMEUS	200
+#define RTMV20_CSRDY_TIMEUS	2000
+
+/* All uint in microsecond or microamp */
+struct init_properties {
+	u16 ld_pulse_delay;
+	u16 ld_pulse_width;
+	u16 fsin1_delay;
+	u8 fsin1_width;
+	u16 fsin2_delay;
+	u8 fsin2_width;
+	u16 es_pulse_width;
+	u8 es_ld_current;
+	u8 lbp_level;
+	u8 lbp_enable;
+	u8 strobe_polarity;
+	u8 vsync_polarity;
+	u8 fsin_enable;
+	u8 fsin_output;
+	u8 es_enable;
+};
+
+struct rtmv20_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *enable_gpio;
+	struct regulator_dev *rdev;
+	struct init_properties properties;
+	bool is_chip_enabled;
+	unsigned int curr_selector;
+};
+
+#define PROP_REG_DECL(_name, reg, mask) \
+{ offsetof(struct init_properties, _name), sizeof_field(struct init_properties, _name), reg, mask }
+
+static int rtmv20_apply_properties(struct rtmv20_priv *priv)
+{
+	const struct {
+		int offset;
+		int len;
+		unsigned int reg;
+		unsigned int mask;
+	} props[] = {
+		PROP_REG_DECL(ld_pulse_delay, RTMV20_REG_PULSEDELAY, RTMV20_DELAY_MASK),
+		PROP_REG_DECL(ld_pulse_width, RTMV20_REG_PULSEWIDTH, RTMV20_WIDTH_MASK),
+		PROP_REG_DECL(fsin1_delay, RTMV20_REG_FSIN1CTRL1, RTMV20_DELAY_MASK),
+		PROP_REG_DECL(fsin1_width, RTMV20_REG_FSIN1CTRL3, RTMV20_WIDTH2_MASK),
+		PROP_REG_DECL(fsin2_delay, RTMV20_REG_FSIN2CTRL1, RTMV20_DELAY_MASK),
+		PROP_REG_DECL(fsin2_width, RTMV20_REG_FSIN2CTRL3, RTMV20_WIDTH2_MASK),
+		PROP_REG_DECL(es_pulse_width, RTMV20_REG_ESPULSEWIDTH, RTMV20_WIDTH_MASK),
+		PROP_REG_DECL(es_ld_current, RTMV20_REG_ESLDCTRL1, RTMV20_LDCURR_MASK),
+		PROP_REG_DECL(lbp_level, RTMV20_REG_LBP, RTMV20_LBPLVL_MASK),
+		PROP_REG_DECL(lbp_enable, RTMV20_REG_LBP, RTMV20_LBPEN_MASK),
+		PROP_REG_DECL(strobe_polarity, RTMV20_REG_LDCTRL2, RTMV20_STROBEPOL_MASK),
+		PROP_REG_DECL(vsync_polarity, RTMV20_REG_LDCTRL2, RTMV20_VSYNPOL_MASK),
+		PROP_REG_DECL(fsin_enable, RTMV20_REG_ENCTRL, RTMV20_FSINEN_MASK),
+		PROP_REG_DECL(fsin_output, RTMV20_REG_ENCTRL, RTMV20_FSINOUT_MASK),
+		PROP_REG_DECL(es_enable, RTMV20_REG_ENCTRL, RTMV20_ESEN_MASK),
+	};
+	void *start = &priv->properties;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		u16 tmp = 0;
+		u16 *u16p = start + props[i].offset;
+		u8 *u8p = start + props[i].offset;
+		int shift = ffs(props[i].mask) - 1, ret;
+
+		switch (props[i].len) {
+		case RTMV20_2BYTE_ACCES:
+			ret = regmap_raw_read(priv->regmap, props[i].reg, &tmp, props[i].len);
+			if (ret)
+				return ret;
+
+			tmp = be16_to_cpu(tmp);
+			tmp &= ~props[i].mask;
+			tmp |= (*u16p << shift);
+			tmp = cpu_to_be16(tmp);
+
+			ret = regmap_raw_write(priv->regmap, props[i].reg, &tmp, props[i].len);
+			break;
+		case RTMV20_1BYTE_ACCES:
+			ret = regmap_update_bits(priv->regmap, props[i].reg, props[i].mask,
+						 *u8p << shift);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtmv20_lsw_set_current_limit(struct regulator_dev *rdev, int min_uA, int max_uA)
+{
+	struct rtmv20_priv *priv = rdev_get_drvdata(rdev);
+	int sel = -1;
+
+	if (min_uA > max_uA)
+		return -EINVAL;
+
+	if (max_uA < RTMV20_LSW_MINUA)
+		max_uA = RTMV20_LSW_MINUA;
+
+	if (max_uA > RTMV20_LSW_MAXUA)
+		max_uA = RTMV20_LSW_MAXUA;
+
+	sel = (max_uA - RTMV20_LSW_MINUA) / RTMV20_LSW_STEPUA;
+	sel <<= ffs(rdev->desc->csel_mask) - 1;
+
+	priv->curr_selector = sel;
+
+	/* If chip is not enabled, only kept the value, instead */
+	if (!priv->is_chip_enabled)
+		return 0;
+
+	return regmap_update_bits(priv->regmap, rdev->desc->csel_reg, rdev->desc->csel_mask, sel);
+}
+
+static int rtmv20_lsw_get_current_limit(struct regulator_dev *rdev)
+{
+	struct rtmv20_priv *priv = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	/* If chip is not enabled, just use the stored selector to calculate the load current */
+	if (!priv->is_chip_enabled) {
+		val = priv->curr_selector;
+		goto bypass_read;
+	}
+
+	ret = regmap_read(priv->regmap, rdev->desc->csel_reg, &val);
+	if (ret)
+		return ret;
+
+	val &= rdev->desc->csel_mask;
+	val >>= ffs(rdev->desc->csel_mask) - 1;
+
+bypass_read:
+	return (RTMV20_LSW_STEPUA * val) + RTMV20_LSW_MINUA;
+}
+
+static int rtmv20_lsw_enable(struct regulator_dev *rdev)
+{
+	struct rtmv20_priv *priv = rdev_get_drvdata(rdev);
+	int ret;
+
+	gpiod_set_value(priv->enable_gpio, 1);
+	/* Wait for I2C can be accessed */
+	usleep_range(RTMV20_I2CRDY_TIMEUS, RTMV20_I2CRDY_TIMEUS + 100);
+
+	/* If enable gpio from low to high, the whole registers will be reset, applied here */
+	ret = rtmv20_apply_properties(priv);
+	if (ret)
+		dev_err(&rdev->dev, "Failed to apply properties\n");
+
+	/* Apply the selector after chip already enabled */
+	ret = regmap_update_bits(priv->regmap, rdev->desc->csel_reg, rdev->desc->csel_mask,
+				 priv->curr_selector);
+	if (ret)
+		dev_err(&rdev->dev, "Failed to config current selector\n");
+
+	ret = regmap_write(priv->regmap, RTMV20_REG_LDMASK, 0);
+	if (ret)
+		dev_err(&rdev->dev, "Failed to unmask all events\n");
+
+	priv->is_chip_enabled = true;
+	return regulator_enable_regmap(rdev);
+}
+
+static int rtmv20_lsw_disable(struct regulator_dev *rdev)
+{
+	struct rtmv20_priv *priv = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = regulator_disable_regmap(rdev);
+	if (ret)
+		return ret;
+
+	priv->is_chip_enabled = false;
+	gpiod_set_value(priv->enable_gpio, 0);
+
+	return 0;
+}
+
+static int rtmv20_lsw_is_enabled(struct regulator_dev *rdev)
+{
+	struct rtmv20_priv *priv = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	/* If chip is not enabled, directly return */
+	if (!priv->is_chip_enabled)
+		return 0;
+
+	ret = regmap_read(priv->regmap, rdev->desc->enable_reg, &val);
+	if (ret)
+		return ret;
+
+	return ((val & rdev->desc->enable_mask) == rdev->desc->enable_mask) ? 1 : 0;
+}
+
+static const struct regulator_ops rtmv20_regulator_ops = {
+	.set_current_limit = rtmv20_lsw_set_current_limit,
+	.get_current_limit = rtmv20_lsw_get_current_limit,
+	.enable = rtmv20_lsw_enable,
+	.disable = rtmv20_lsw_disable,
+	.is_enabled = rtmv20_lsw_is_enabled,
+};
+
+static const struct regulator_desc rtmv20_lsw_desc = {
+	.name = "rtmv20,lsw",
+	.of_match = of_match_ptr("lsw"),
+	.type = REGULATOR_CURRENT,
+	.owner = THIS_MODULE,
+	.ops = &rtmv20_regulator_ops,
+	.csel_reg = RTMV20_REG_LDCTRL1,
+	.csel_mask = RTMV20_LDCURR_MASK,
+	.enable_reg = RTMV20_REG_ENCTRL,
+	.enable_mask = LDENABLE_MASK,
+	.enable_time = RTMV20_CSRDY_TIMEUS,
+};
+
+static irqreturn_t rtmv20_irq_handler(int irq, void *data)
+{
+	struct rtmv20_priv *priv = data;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, RTMV20_REG_LDIRQ, &val);
+	if (ret) {
+		dev_err(priv->dev, "Failed to get irq flags\n");
+		return IRQ_NONE;
+	}
+
+	if (val & OTPEVT_MASK)
+		regulator_notifier_call_chain(priv->rdev, REGULATOR_EVENT_OVER_TEMP, NULL);
+
+	if (val & OCPEVT_MASK)
+		regulator_notifier_call_chain(priv->rdev, REGULATOR_EVENT_OVER_CURRENT, NULL);
+
+	if (val & FAILEVT_MASK)
+		regulator_notifier_call_chain(priv->rdev, REGULATOR_EVENT_FAIL, NULL);
+
+	return IRQ_HANDLED;
+}
+
+#define PROP_DEFAULT_DECL(_name, _default, _min, _max, _step) \
+{ #_name, offsetof(struct init_properties, _name), sizeof_field(struct init_properties, _name), \
+	_default, _min, _max, _step }
+
+static int rtmv20_properties_init(struct device *dev, struct init_properties *properties)
+{
+	const struct {
+		const char *name;
+		int offset;
+		int len;
+		u32 def;
+		u32 min;
+		u32 max;
+		u32 step;
+	} props[] = {
+		PROP_DEFAULT_DECL(ld_pulse_delay, 0, 0, 100000, 100),
+		PROP_DEFAULT_DECL(ld_pulse_width, 1200, 0, 10000, 1),
+		PROP_DEFAULT_DECL(fsin1_delay, 23000, 0, 100000, 100),
+		PROP_DEFAULT_DECL(fsin1_width, 160, 40, 10000, 40),
+		PROP_DEFAULT_DECL(fsin2_delay, 23000, 0, 100000, 100),
+		PROP_DEFAULT_DECL(fsin2_width, 160, 40, 10000, 40),
+		PROP_DEFAULT_DECL(es_pulse_width, 1200, 0, 10000, 1),
+		PROP_DEFAULT_DECL(es_ld_current, 3000000, 0, 6000000, 30000),
+		PROP_DEFAULT_DECL(lbp_level, 2700000, 2400000, 3700000, 100000),
+		PROP_DEFAULT_DECL(lbp_enable, 0, 0, 1, 1),
+		PROP_DEFAULT_DECL(strobe_polarity, 1, 0, 1, 1),
+		PROP_DEFAULT_DECL(vsync_polarity, 1, 0, 1, 1),
+		PROP_DEFAULT_DECL(fsin_enable, 0, 0, 1, 1),
+		PROP_DEFAULT_DECL(fsin_output, 0, 0, 1, 1),
+		PROP_DEFAULT_DECL(es_enable, 0, 0, 1, 1),
+	};
+	void *start = properties;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(props); i++) {
+		u32 temp;
+		u16 *pu16val = start + props[i].offset;
+		u8 *pu8val = start + props[i].offset;
+		int ret;
+
+		ret = device_property_read_u32(dev, props[i].name, &temp);
+		if (ret)
+			temp = props[i].def;
+
+		if (temp < props[i].min)
+			temp = props[i].min;
+		if (temp > props[i].max)
+			temp = props[i].max;
+
+		switch (props[i].len) {
+		case RTMV20_2BYTE_ACCES:
+			*pu16val = (temp - props[i].min) / props[i].step;
+			break;
+		case RTMV20_1BYTE_ACCES:
+			*pu8val = (temp - props[i].min) / props[i].step;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int rtmv20_check_chip_exist(struct rtmv20_priv *priv)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(priv->regmap, RTMV20_REG_DEVINFO, &val);
+	if (ret)
+		return ret;
+
+	if ((val & RTMV20_VID_MASK) != RICHTEK_VID)
+		return -ENODEV;
+
+	return 0;
+}
+
+static bool rtmv20_is_accessible_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case RTMV20_REG_DEVINFO ... RTMV20_REG_STRBVSYNDLYL:
+	case RTMV20_REG_LDIRQ:
+	case RTMV20_REG_LDSTAT:
+	case RTMV20_REG_LDMASK:
+		return true;
+	}
+	return false;
+}
+
+static const struct regmap_config rtmv20_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = RTMV20_REG_LDMASK,
+	.writeable_reg = rtmv20_is_accessible_reg,
+	.readable_reg = rtmv20_is_accessible_reg,
+};
+
+static int rtmv20_probe(struct i2c_client *i2c)
+{
+	struct rtmv20_priv *priv;
+	struct regulator_config config = {};
+	int ret;
+
+	priv = devm_kzalloc(&i2c->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &i2c->dev;
+	/* Config IC default selector */
+	priv->curr_selector = (RTMV20_LSW_DEFAULTUA - RTMV20_LSW_MINUA) / RTMV20_LSW_STEPUA;
+
+	priv->regmap = devm_regmap_init_i2c(i2c, &rtmv20_regmap_config);
+	if (IS_ERR(priv->regmap)) {
+		dev_err(&i2c->dev, "Failed to allocate register map\n");
+		return PTR_ERR(priv->regmap);
+	}
+
+	priv->enable_gpio = devm_gpiod_get(&i2c->dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->enable_gpio)) {
+		dev_err(&i2c->dev, "Failed to get enable gpio\n");
+		return PTR_ERR(priv->enable_gpio);
+	}
+
+	/* Wait for I2C can be accessed */
+	usleep_range(RTMV20_I2CRDY_TIMEUS, RTMV20_I2CRDY_TIMEUS + 100);
+
+	ret = rtmv20_check_chip_exist(priv);
+	if (ret) {
+		dev_err(&i2c->dev, "Chip vendor info is not matched\n");
+		return ret;
+	}
+
+	/* After chip check, keep in shutdown mode for low quiescent current */
+	gpiod_set_value(priv->enable_gpio, 0);
+
+	ret = rtmv20_properties_init(&i2c->dev, &priv->properties);
+	if (ret) {
+		dev_err(&i2c->dev, "Failed to init properties\n");
+		return ret;
+	}
+
+	config.dev = &i2c->dev;
+	config.regmap = priv->regmap;
+	config.driver_data = priv;
+	priv->rdev = devm_regulator_register(&i2c->dev, &rtmv20_lsw_desc, &config);
+	if (IS_ERR(priv->rdev)) {
+		dev_err(&i2c->dev, "Failed to register regulator\n");
+		return PTR_ERR(priv->rdev);
+	}
+
+	return devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL, rtmv20_irq_handler,
+					 IRQF_ONESHOT, dev_name(&i2c->dev), priv);
+}
+
+static int __maybe_unused rtmv20_suspend(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+
+	/* When system suspend, disable irq to prevent interrupt trigger during I2C bus suspend */
+	disable_irq(i2c->irq);
+	if (device_may_wakeup(dev))
+		enable_irq_wake(i2c->irq);
+
+	return 0;
+}
+
+static int __maybe_unused rtmv20_resume(struct device *dev)
+{
+	struct i2c_client *i2c = to_i2c_client(dev);
+
+	/* Enable irq here after I2C bus already resume */
+	enable_irq(i2c->irq);
+	if (device_may_wakeup(dev))
+		disable_irq_wake(i2c->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(rtmv20_pm, rtmv20_suspend, rtmv20_resume);
+
+static const struct of_device_id __maybe_unused rtmv20_of_id[] = {
+	{ .compatible = "richtek,rtmv20", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, rtmv20_of_id);
+
+static struct i2c_driver rtmv20_driver = {
+	.driver = {
+		.name = "rtmv20",
+		.of_match_table = of_match_ptr(rtmv20_of_id),
+		.pm = &rtmv20_pm,
+	},
+	.probe_new = rtmv20_probe,
+};
+module_i2c_driver(rtmv20_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Richtek RTMV20 Regulator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

