Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5D2DA3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441274AbgLNXAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440224AbgLNW74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:59:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641F2C061794;
        Mon, 14 Dec 2020 14:59:16 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t16so18033908wra.3;
        Mon, 14 Dec 2020 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ozRFemFkf9Ud524MI4RDJIo4u+Tyg6CBVheydCwbwmc=;
        b=IVdznJSy0uOBeAh3GOcgUwP/7K1Y0UOAML7lRUdog5O9FJLBld63i1NFGrqRuN3zNc
         89Ov06DasOhpKCWwfYjelFuDswQjQ7jcXyMcawTUsE7B78ulaZRnr/iybSDT480Qobx0
         7X4YE1fvQKclo9vtxkkKftu1UaxtDy4pJBcpp1l7P5yDzbZrHGnuHhQt1AFN6kDZnXrJ
         nU+UdH8k3V6EmvLpfwVVUO+Mg0MQ19teWzpZRq4mCL8TZCfyHET5oGz1h+NA+GTC3qlM
         /7oFZP7vZWyPO8jPfHO3a0DS+6+8xGa3eVw6MIlL9pFiOuVJiQx4hR48jWoD/hFmKVIW
         9otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ozRFemFkf9Ud524MI4RDJIo4u+Tyg6CBVheydCwbwmc=;
        b=F5vCoPZ4+t7SQo2i7ZtjeeXo1FK5DwE7FIZU7+yE/nCcCTM09k9RvBRcQ7/l0Woo14
         rMOsN/Oq6PivCjJPsKQrrv/EfupyUproLfbUkgDr/Yngou1x9P0MP/cuc7iWpDlEJFOX
         cqnsD2fXGXupE+pAnSOdLC/u7DtCapTlivse2H996SOffNocM4XrlE1KHIHDIxWqMF2X
         f6UJCcYkYqJSF42cWzGqHXBOGh8s1pXCHrWp1VhxrWum8vPPN1lbI7x3xZS8Z4RUfued
         nR8bnF4AE0EYZtYc3ZRMfYM3Ic9SyGwrj9HFDRkX++mAbGpfqp3nhKCnl1gb5i6h2lFL
         Qs7A==
X-Gm-Message-State: AOAM530XOyN/L2FzETofMTNH9tyEooS0GDRCrQXNJWe39PsZq5UQ7SyG
        0C/g0dwyagRSaVJcNKAspgw=
X-Google-Smtp-Source: ABdhPJzhPeQdPIsw5C296mO7Q7I21X41cIqhiWPC43yXTeIHiXNlLVkBHgBVPwrUsS2MEe4MXihKOw==
X-Received: by 2002:a5d:6ccc:: with SMTP id c12mr31522146wrc.4.1607986755021;
        Mon, 14 Dec 2020 14:59:15 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id k11sm33091857wmj.42.2020.12.14.14.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 14:59:14 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 2/2] regulator: pf8x00: add support of nxp pf8x00 regulator
Date:   Mon, 14 Dec 2020 23:58:51 +0100
Message-Id: <20201214225851.23342-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201214225851.23342-1-adrien.grassein@gmail.com>
References: <20201214225851.23342-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NXP pf8100 and pf8200 are 12-channel
PMIC for high performance applications.

This driver introduces the support of the 12
regulators available on the PMIC.

Imported from Boundary Devices kernel
with some modifications.

This driver was teste using a Boundary Nitrogen 8M Mini
board that features this PMIC.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 MAINTAINERS                          |   1 +
 drivers/regulator/Kconfig            |  12 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/pf8x00-regulator.c | 798 +++++++++++++++++++++++++++
 4 files changed, 812 insertions(+)
 create mode 100644 drivers/regulator/pf8x00-regulator.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 878e6f25aab7..a7b40ac6a671 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13809,6 +13809,7 @@ M:	Adrien Grassein <adrien.grassein@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
+F:	drivers/regulator/pf8x00-regulator.c
 
 PHOENIX RC FLIGHT CONTROLLER ADAPTER
 M:	Marcus Folkesson <marcus.folkesson@gmail.com>
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 020a00d6696b..d2aba4b487f4 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -791,6 +791,18 @@ config REGULATOR_PCF50633
 	 Say Y here to support the voltage regulators and converters
 	 on PCF50633
 
+config REGULATOR_PF8X00
+	tristate "NXP PF8x00 regulator driver"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	 Say y here to support the regulators found on the NXP
+	 PF8100/PF8200 PMIC
+
+	 Say M here if you want to include support for tte regulators found
+	 on the NXP PF8100/PF8200 PMIC. The module will be named
+	 "pf8x00-regulator".
+
 config REGULATOR_PFUZE100
 	tristate "Freescale PFUZE100/200/3000/3001 regulator driver"
 	depends on I2C
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 6ebae516258e..a9fb449a0dc8 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_REGULATOR_QCOM_SPMI) += qcom_spmi-regulator.o
 obj-$(CONFIG_REGULATOR_QCOM_USB_VBUS) += qcom_usb_vbus-regulator.o
 obj-$(CONFIG_REGULATOR_PALMAS) += palmas-regulator.o
 obj-$(CONFIG_REGULATOR_PCA9450) += pca9450-regulator.o
+obj-$(CONFIG_REGULATOR_PF8X00) += pf8x00-regulator.o
 obj-$(CONFIG_REGULATOR_PFUZE100) += pfuze100-regulator.o
 obj-$(CONFIG_REGULATOR_PV88060) += pv88060-regulator.o
 obj-$(CONFIG_REGULATOR_PV88080) += pv88080-regulator.o
diff --git a/drivers/regulator/pf8x00-regulator.c b/drivers/regulator/pf8x00-regulator.c
new file mode 100644
index 000000000000..35e7d234180a
--- /dev/null
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -0,0 +1,798 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2011-2013 Freescale Semiconductor, Inc. All Rights Reserved.
+// Copyright 2017 NXP
+// Copyright 2019 Boundary Devices
+
+#define DEBUG 1
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#define PF8X00_DEVICEID		0x00
+#define PF8X00_REVID		0x01
+#define PF8X00_EMREV		0x02
+#define PF8X00_PROGID		0x03
+
+#define PF8X00_IMS_INT		0x04
+#define PF8X00_IMS_THERM	0x07
+#define PF8X00_SW_MODE_INT	0x0a
+#define PF8X00_SW_MODE_MASK	0x0b
+
+#define IMS_INT			0
+#define IMS_STATUS		0
+#define IMS_MASK		1
+#define IMS_SENSE		2
+
+#define PF8X00_IMS_SW_ILIM	0x12
+#define PF8X00_IMS_LDO_ILIM	0x15
+#define PF8X00_IMS_SW_UV	0x18
+#define PF8X00_IMS_SW_OV	0x1b
+#define PF8X00_IMS_LDO_UV	0x1e
+#define PF8X00_IMS_LDO_OV	0x21
+#define PF8X00_IMS_PWRON	0x24
+#define PF8X00_SYS_INT		0x27
+
+#define PF8X00_HARD_FAULT	0x29
+#define PF8X00_FSOB_FLAGS	0x2a
+#define PF8X00_FSOB_SELECT	0x2b
+#define PF8X00_ABIST_OV1	0x2c
+#define PF8X00_ABIST_OV2	0x2d
+#define PF8X00_ABIST_UV1	0x2e
+#define PF8X00_ABIST_UV2	0x2f
+#define PF8X00_TEST_FLAGS	0x30
+#define PF8X00_ABIST_RUN	0x31
+
+#define PF8X00_RANDOM_GEN	0x33
+#define PF8X00_RANDOM_CHK	0x34
+#define PF8X00_VMONEN1		0x35
+#define PF8X00_VMONEN2		0x36
+#define PF8X00_CTRL1		0x37
+#define PF8X00_CTRL2		0x38
+#define PF8X00_CTRL3		0x39
+#define PF8X00_PWRUP_CTRL	0x3a
+
+#define PF8X00_RESETBMCU	0x3c
+#define PF8X00_PGOOD		0x3d
+#define PF8X00_PWRDN_DLY1	0x3e
+#define PF8X00_PWRDN_DLY2	0x3f
+#define PF8X00_FREQ_CTRL	0x40
+#define PF8X00_COINCELL_CTRL	0x41
+#define PF8X00_PWRON		0x42
+#define PF8X00_WD_CONFIG	0x43
+#define PF8X00_WD_CLEAR		0x44
+#define PF8X00_WD_EXPIRE	0x45
+#define PF8X00_WD_COUNTER	0x46
+#define PF8X00_FAULT_COUNTER	0x47
+#define PF8X00_FSAFE_COUNTER	0x48
+#define PF8X00_FAULT_TIMER	0x49
+#define PF8X00_AMUX		0x4a
+
+#define SW_CONFIG1	0
+#define SW_CONFIG2	1
+#define SW_PWRUP	2
+#define SW_MODE1	3
+#define SW_RUN_VOLT	4
+#define SW_STBY_VOLT	5
+
+/* i is in REG_SW1..REG_SW7 */
+#define PF8X00_SW(i)		(8 * (i - REG_SW1) + 0x4d)
+
+#define LDO_CONFIG1	0
+#define LDO_CONFIG2	1
+#define LDO_PWRUP	2
+#define LDO_RUN_VOLT	3
+#define LDO_STBY_VOLT	4
+
+/* i is in REG_LDO1..REG_LDO4 */
+#define PF8X00_LDO(i)		(6 * (i - REG_LDO1) + 0x85)
+
+#define PF8X00_VSNVS_CONFIG1	0x9d
+
+#define PF8X00_PAGE_SELECT	0x9f
+#define PF8X00_OTP_FSOB_SELECT	0xa0
+#define PF8X00_OTP_I2C		0xa1
+#define PF8X00_OTP_CTRL1	0xa2
+#define PF8X00_OTP_CTRL2	0xa3
+#define PF8X00_OTP_CTRL3	0xa4
+
+#define PF8X00_OTP_FREQ_CTRL	0xa5
+#define PF8X00_OTP_COINCELL	0xa6
+#define PF8X00_OTP_PWRON	0xa7
+#define PF8X00_OTP_WD_CONFIG	0xa8
+#define PF8X00_OTP_WD_EXPIRE	0xa9
+#define PF8X00_OTP_WD_COUNTER	0xaa
+#define PF8X00_OTP_FAULT_COUNTER 0xab
+#define PF8X00_OTP_FAULT_TIMER	0xac
+#define PF8X00_OTP_PWRDN_DLY1	0xad
+#define PF8X00_OTP_PWRDN_DLY2	0xae
+#define PF8X00_OTP_PWRUP_CTRL	0xaf
+#define PF8X00_OTP_RESETBMCU	0xb0
+#define PF8X00_OTP_PGOOD	0xb1
+
+#define OTP_SW_VOLT	0
+#define OTP_SW_PWRUP	1
+#define OTP_SW_CONFIG1	2
+#define OTP_SW_CONFIG2	3
+
+/* i is in REG_SW1..REG_SW7 */
+#define PF8X00_OTP_SW(i)	(4 * (i - REG_SW1) + 0xb2)
+
+#define OTP_LDO_VOLT	0
+#define OTP_LDO_PWRUP	1
+#define OTP_LDO_CONFIG	2
+
+/* i is in REG_LDO1..REG_LDO4 */
+#define PF8X00_OTP_LDO(i)	(3 * (i - REG_LDO1) + 0xce)
+
+#define PF8X00_OTP_VSNVS_CONFIG	0xda
+#define PF8X00_OTP_OV_BYPASS1	0xdb
+#define PF8X00_OTP_OV_BYPASS2	0xdc
+#define PF8X00_OTP_UV_BYPASS1	0xdd
+#define PF8X00_OTP_UV_BYPASS2	0xde
+#define PF8X00_OTP_ILIM_BYPASS1	0xdf
+#define PF8X00_OTP_ILIM_BYPASS2	0xe0
+
+#define PF8X00_OTP_DEBUG1	0xe3
+#define PF8X_NUMREGS		0xe4
+
+#define REG_LDO1		0
+#define REG_LDO2		1
+#define REG_LDO3		2
+#define REG_LDO4		3
+#define REG_SW1			4
+#define REG_SW2			5
+#define REG_SW3			6
+#define REG_SW4			7
+#define REG_SW5			8
+#define REG_SW6			9
+#define REG_SW7			10
+#define REG_VSNVS		11
+#define REG_NUM_REGULATORS	(4 + 7 + 1)
+
+enum chips {
+	PF8100 = 0x40,
+	PF8121A = 0x42,
+	PF8200 = 0x48,
+};
+
+struct id_name {
+	enum chips id;
+	const char *name;
+};
+
+struct pf8x_regulator {
+	struct regulator_desc desc;
+	unsigned char quad_phase;
+	unsigned char dual_phase;
+	unsigned char fast_slew;
+};
+
+struct pf8x_chip {
+	int	chip_id;
+	int	prog_id;
+	int	clk_freq;
+	struct regmap *regmap;
+	struct device *dev;
+	struct regulator_dev *regulators[REG_NUM_REGULATORS];
+};
+
+/* Output: 1.5V to 5.0V, LDO2 can use VSELECT */
+static const int pf8x00_ldo_voltages[] = {
+	1500000, 1600000, 1800000, 1850000, 2150000, 2500000, 2800000, 3000000,
+	3100000, 3150000, 3200000, 3300000, 3350000, 4000000, 4900000, 5000000,
+};
+
+/* Output: 0.4V to 1.8V */
+#define PF8XOO_SW1_6_VOLTAGE_NUM 0xB2
+static const struct linear_range pf8x00_sw1_to_6_voltages[] = {
+	REGULATOR_LINEAR_RANGE(400000, 0x00, 0xB0, 6250),
+	REGULATOR_LINEAR_RANGE(1800000, 0xB1, 0xB1, 0),
+};
+
+/* Output: 2.1A to 4.5A */
+static const unsigned int pf8x00_sw_current_table[] = {
+	2100000, 2600000, 3000000, 4500000,
+};
+
+/* Output: 1.0V to 4.1V */
+static const int pf8x00_sw7_voltages[] = {
+	1000000, 1100000, 1200000, 1250000, 1300000, 1350000, 1500000, 1600000,
+	1800000, 1850000, 2000000, 2100000, 2150000, 2250000, 2300000, 2400000,
+	2500000, 2800000, 3150000, 3200000, 3250000, 3300000, 3350000, 3400000,
+	3500000, 3800000, 4000000, 4100000, 4100000, 4100000, 4100000, 4100000,
+};
+
+/* Output: 1.8V, 3.0V, or 3.3V */
+static const int pf8x00_vsnvs_voltages[] = {
+	0, 1800000, 3000000, 3300000,
+};
+
+static const struct i2c_device_id pf8x_device_id[] = {
+	{.name = "pf8x00",},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, pf8x_device_id);
+
+static const struct of_device_id pf8x_dt_ids[] = {
+	{ .compatible = "nxp,pf8100",},
+	{ .compatible = "nxp,pf8121a",},
+	{ .compatible = "nxp,pf8200",},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pf8x_dt_ids);
+
+const struct id_name id_list[] = {
+	{PF8100, "PF8100"},
+	{PF8121A, "PF8121A"},
+	{PF8200, "PF8200"},
+};
+
+static const struct id_name *get_id_name(enum chips id)
+{
+	const struct id_name *p = id_list;
+
+	while (p->id) {
+		if (p->id == id)
+			break;
+		p++;
+	}
+	return p;
+}
+
+struct dvs_ramp {
+	unsigned short up_down_slow_fast[4];
+};
+
+/* Units uV/uS */
+struct dvs_ramp ramp_table[] = {
+/*			up_slow,	down_slow,	up_fast,	down_fast */
+	[0]  = {{ 7813,		5208,		15625,		10417 }},
+	[1]  = {{ 8203,		5469,		16406,		10938 }},
+	[2]  = {{ 8594,		5729,		17188,		11458 }},
+	[3]  = {{ 8984,		5990,		17969,		11979 }},
+	[4]  = {{ 9375,		6250,		18750,		12500 }},
+	[9]  = {{ 6250,		4167,		12500,		 8333 }},
+	[10] = {{ 6641,		4427,		13281,		 8854 }},
+	[11] = {{ 7031,		4688,		14063,		 9375 }},
+	[12] = {{ 7422,		4948,		14844,		 9896 }},
+};
+
+static int pf8x00_regulator_common_set_voltage_time_sel(struct regulator_dev *rdev,
+		int old_v, int new_v)
+{
+	struct pf8x_chip *pf = rdev_get_drvdata(rdev);
+	struct pf8x_regulator *rdesc = container_of(rdev->desc, struct pf8x_regulator, desc);
+	unsigned int index = 0;
+	unsigned int slew;
+	int change = new_v - old_v;
+
+	if (rdesc->fast_slew)
+		index = 2;
+
+	if (change < 0)
+		index++;
+
+	slew = ramp_table[pf->clk_freq].up_down_slow_fast[index];
+
+	return DIV_ROUND_UP(abs(change), slew);
+}
+
+static int pf8x00_regulator1_6_set_voltage_time_sel(struct regulator_dev *rdev,
+		unsigned int old_sel, unsigned int new_sel)
+{
+	struct pf8x_regulator *rdesc = container_of(rdev->desc, struct pf8x_regulator, desc);
+	int old_v = regulator_desc_list_voltage_linear_range(&rdesc->desc, old_sel);
+	int new_v = regulator_desc_list_voltage_linear_range(&rdesc->desc, new_sel);
+
+	return pf8x00_regulator_common_set_voltage_time_sel(rdev, old_v, new_v);
+}
+
+static int pf8x00_regulator7_set_voltage_time_sel(struct regulator_dev *rdev,
+		unsigned int old_sel, unsigned int new_sel)
+{
+	const unsigned int *volt_table = rdev->desc->volt_table;
+	int old_v = volt_table[old_sel];
+	int new_v = volt_table[new_sel];
+
+	return pf8x00_regulator_common_set_voltage_time_sel(rdev, old_v, new_v);
+}
+
+static int encode_phase(struct pf8x_chip *pf, int phase)
+{
+	int ph;
+
+	if (phase < 0)
+		return -1;
+
+	ph = phase / 45;
+	if ((ph * 45) != phase) {
+		dev_err(pf->dev, "ignoring, illegal phase %d\n", phase);
+		return -1;
+	}
+
+	if (ph == 0)
+		ph = 7;
+	else
+		ph -= 1;
+
+	return ph;
+}
+
+static int pf8x00_check_dtb_configuration(struct pf8x_chip *pf, int id,
+		unsigned char dual_phase, unsigned char quad_phase,
+		int phase, unsigned char fast_slew,
+		unsigned char hw_en, unsigned char vselect_en)
+{
+	int ret = 0;
+
+	if ((id != REG_SW1) && quad_phase) {
+		dev_warn(pf->dev, "ignoring, only sw1 can use quad-phase\n");
+		ret = 1;
+	}
+
+	if ((id != REG_SW1) && (id != REG_SW3) && (id != REG_SW5) && dual_phase) {
+		dev_warn(pf->dev, "ignoring, only sw1, sw3 and sw5 can use dual-phase\n");
+		ret = 1;
+	}
+
+	if ((id != REG_LDO2) && vselect_en) {
+		dev_warn(pf->dev, "ignoring, only ldo2 can use vselect-en\n");
+		ret = 1;
+	}
+
+	if ((id != REG_LDO2) && hw_en) {
+		dev_warn(pf->dev, "ignoring, only ldo2 can use hw-en\n");
+		ret = 1;
+	}
+
+	if ((id < REG_SW1) && (id >= REG_SW7) && phase >= 0) {
+		dev_warn(pf->dev, "ignoring, only sw1-6 can use phase\n");
+		ret = 1;
+	}
+
+	return ret;
+}
+
+static int pf8x00_configure_sw_regulator(struct pf8x_chip *pf,
+			int id, int phase, unsigned char fast_slew)
+{
+	int ret = 0;
+	unsigned int mask = 0;
+	unsigned int val = 0;
+	unsigned int reg = PF8X00_SW(id) + SW_CONFIG2;
+
+	dev_dbg(pf->dev, "Configuring SW%d: phase = %d,  fast_slew = %u\n",
+		id - 3, phase, fast_slew);
+
+	if (phase >= 0) {
+		mask |= 7;
+		val |= phase;
+	}
+
+	if (fast_slew) {
+		mask |= 1 << 5;
+		val |= fast_slew << 5;
+	}
+
+	if (mask)
+		ret = regmap_update_bits(pf->regmap, reg, mask, val);
+
+	return ret;
+}
+
+static int pf8x00_configure_ld02_regulator(struct pf8x_chip *pf,
+	unsigned char hw_en,  unsigned char vselect_en)
+{
+	unsigned int val = 0;
+
+	dev_dbg(pf->dev, "Configuring ld02: hw_en=%u vselect_en=%u\n",
+		hw_en, vselect_en);
+
+	if (vselect_en)
+		val |= 0x08;
+
+	if (hw_en)
+		val |= 0x10;
+
+	return regmap_update_bits(pf->regmap,
+		PF8X00_LDO(REG_LDO2) + LDO_CONFIG2, 0x18, val);
+}
+
+static int pf8x00_of_parse_cb(struct device_node *np,
+		const struct regulator_desc *desc,
+		struct regulator_config *config)
+{
+	struct pf8x_chip *pf = config->driver_data;
+	struct pf8x_regulator *rdesc = container_of(desc, struct pf8x_regulator, desc);
+
+	unsigned char hw_en = 0;
+	unsigned char vselect_en = 0;
+	unsigned char quad_phase = 0;
+	unsigned char dual_phase = 0;
+	unsigned char fast_slew = 0;
+	int phase = -1;
+	int ret = 0;
+
+	if (!of_property_read_u32(np, "nxp,phase", &phase))
+		phase = encode_phase(pf, phase);
+	if (of_get_property(np, "nxp,fast-slew", NULL))
+		fast_slew = 1;
+	if (of_get_property(np, "nxp,hw-en", NULL))
+		hw_en = 1;
+	if (of_get_property(np, "nxp,quad-phase", NULL))
+		quad_phase = 1;
+	if (of_get_property(np, "nxp,dual-phase", NULL))
+		dual_phase = 1;
+	if (of_get_property(np, "nxp,vselect-en", NULL))
+		vselect_en = 1;
+
+	/* Ignore the return of the check, this will just print warnings */
+	pf8x00_check_dtb_configuration(pf, desc->id, dual_phase, quad_phase,
+		phase, fast_slew, hw_en, vselect_en);
+
+	rdesc->dual_phase = dual_phase;
+	rdesc->quad_phase = quad_phase;
+	rdesc->fast_slew  = fast_slew;
+
+	if ((desc->id >= REG_SW1) && (desc->id <= REG_SW7))
+		ret = pf8x00_configure_sw_regulator(pf, desc->id,
+			phase, fast_slew);
+	else if (desc->id == REG_LDO2)
+		ret = pf8x00_configure_ld02_regulator(pf, hw_en, vselect_en);
+
+	return ret;
+}
+
+static const struct regulator_ops pf8x00_ldo_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+static const struct regulator_ops pf8x00_sw1_6_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = pf8x00_regulator1_6_set_voltage_time_sel,
+	.get_current_limit = regulator_get_current_limit_regmap,
+	.set_current_limit = regulator_set_current_limit_regmap,
+};
+
+static const struct regulator_ops pf8x00_sw7_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = pf8x00_regulator7_set_voltage_time_sel,
+};
+
+static const struct regulator_ops pf8x00_vsnvs_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_ascend,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+};
+
+#define STRUCT_LDO_REG(_id, _name, base)		\
+	[_id] = {						\
+		.desc = {					\
+			.name = #_name,				\
+			.of_match = of_match_ptr(#_name),	\
+			.regulators_node = of_match_ptr("regulators"), \
+			.of_parse_cb = pf8x00_of_parse_cb,	\
+			.n_voltages = ARRAY_SIZE(pf8x00_ldo_voltages),	\
+			.ops = &pf8x00_ldo_regulator_ops,	\
+			.type = REGULATOR_VOLTAGE,		\
+			.id = _id,				\
+			.owner = THIS_MODULE,			\
+			.volt_table = pf8x00_ldo_voltages,			\
+			.vsel_reg = (base) + LDO_RUN_VOLT,	\
+			.vsel_mask = 0xff,			\
+			.enable_reg = (base) + LDO_CONFIG2,	\
+			.enable_val = 0x2,			\
+			.disable_val = 0x0,			\
+			.enable_mask = 2,			\
+		},						\
+	}
+
+#define STRUCT_SW_REG(_id, _name, base)		\
+	[_id] = {						\
+		.desc = {					\
+			.name = #_name,				\
+			.of_match = of_match_ptr(#_name),	\
+			.regulators_node = of_match_ptr("regulators"), \
+			.of_parse_cb = pf8x00_of_parse_cb,	\
+			.n_voltages = PF8XOO_SW1_6_VOLTAGE_NUM, \
+			.ops = &pf8x00_sw1_6_regulator_ops,	\
+			.type = REGULATOR_VOLTAGE,		\
+			.id = _id,				\
+			.owner = THIS_MODULE,			\
+			.linear_ranges = pf8x00_sw1_to_6_voltages, \
+			.n_linear_ranges = \
+				ARRAY_SIZE(pf8x00_sw1_to_6_voltages), \
+			.vsel_reg = (base) + SW_RUN_VOLT,	\
+			.vsel_mask = 0xff,			\
+			.curr_table = pf8x00_sw_current_table, \
+			.n_current_limits = \
+				ARRAY_SIZE(pf8x00_sw_current_table), \
+			.csel_reg = (base) + SW_CONFIG2,	\
+			.csel_mask = 0x18,	\
+			.enable_reg = (base) + SW_MODE1,	\
+			.enable_val = 0x3,			\
+			.disable_val = 0x0,			\
+			.enable_mask = 0x3,			\
+			.enable_time = 500,			\
+		},						\
+	}
+
+#define STRUCT_SW7_REG(_id, _name, base)		\
+	[_id] = {						\
+		.desc = {					\
+			.name = #_name,				\
+			.of_match = of_match_ptr(#_name),	\
+			.regulators_node = of_match_ptr("regulators"), \
+			.of_parse_cb = pf8x00_of_parse_cb,	\
+			.n_voltages = ARRAY_SIZE(pf8x00_sw7_voltages),	\
+			.ops = &pf8x00_sw7_regulator_ops,	\
+			.type = REGULATOR_VOLTAGE,		\
+			.id = _id,				\
+			.owner = THIS_MODULE,			\
+			.volt_table = pf8x00_sw7_voltages,			\
+			.vsel_reg = (base) + SW_RUN_VOLT,	\
+			.vsel_mask = 0xff,			\
+			.enable_reg = (base) + SW_MODE1,	\
+			.enable_val = 0x3,			\
+			.disable_val = 0x0,			\
+			.enable_mask = 0x3,			\
+			.enable_time = 500,			\
+		},						\
+	}
+
+
+#define STRUCT_VSNVS_REG(_id, _name, base)		\
+	[_id] = {						\
+		.desc = {					\
+			.name = #_name,				\
+			.of_match = of_match_ptr(#_name),	\
+			.regulators_node = of_match_ptr("regulators"), \
+			.of_parse_cb = pf8x00_of_parse_cb,	\
+			.n_voltages = ARRAY_SIZE(pf8x00_vsnvs_voltages),	\
+			.ops = &pf8x00_vsnvs_regulator_ops,	\
+			.type = REGULATOR_VOLTAGE,		\
+			.id = _id,				\
+			.owner = THIS_MODULE,			\
+			.volt_table = pf8x00_vsnvs_voltages,			\
+			.vsel_reg = (base),			\
+			.vsel_mask = 0x3,			\
+		},						\
+	}
+
+static struct pf8x_regulator pf8x00_regulators[] = {
+	STRUCT_LDO_REG(REG_LDO1, ldo1, PF8X00_LDO(REG_LDO1)),
+	STRUCT_LDO_REG(REG_LDO2, ldo2, PF8X00_LDO(REG_LDO2)),
+	STRUCT_LDO_REG(REG_LDO3, ldo3, PF8X00_LDO(REG_LDO3)),
+	STRUCT_LDO_REG(REG_LDO4, ldo4, PF8X00_LDO(REG_LDO4)),
+	STRUCT_SW_REG(REG_SW1, sw1, PF8X00_SW(REG_SW1)),
+	STRUCT_SW_REG(REG_SW2, sw2, PF8X00_SW(REG_SW2)),
+	STRUCT_SW_REG(REG_SW3, sw3, PF8X00_SW(REG_SW3)),
+	STRUCT_SW_REG(REG_SW4, sw4, PF8X00_SW(REG_SW4)),
+	STRUCT_SW_REG(REG_SW5, sw5, PF8X00_SW(REG_SW5)),
+	STRUCT_SW_REG(REG_SW6, sw6, PF8X00_SW(REG_SW6)),
+	STRUCT_SW7_REG(REG_SW7, sw7, PF8X00_SW(REG_SW7)),
+	STRUCT_VSNVS_REG(REG_VSNVS, vsnvs, PF8X00_VSNVS_CONFIG1),
+};
+
+static int pf8x_identify(struct pf8x_chip *pf)
+{
+	const struct id_name *p;
+	unsigned int value, id1, id2;
+	int ret;
+
+	ret = regmap_read(pf->regmap, PF8X00_DEVICEID, &value);
+	if (ret)
+		return ret;
+
+	pf->chip_id = value;
+	p = get_id_name(value);
+	if (p->id != value) {
+		dev_warn(pf->dev, "Illegal ID: %x\n", value);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(pf->regmap, PF8X00_REVID, &value);
+	if (ret)
+		value = 0;
+	ret = regmap_read(pf->regmap, PF8X00_EMREV, &id1);
+	if (ret)
+		id1 = 0;
+	ret = regmap_read(pf->regmap, PF8X00_PROGID, &id2);
+	if (ret)
+		id2 = 0;
+	pf->prog_id = (id1 << 8) | id2;
+
+	dev_info(pf->dev, "%s: Full layer: %x, Metal layer: %x, prog_id=0x%04x\n",
+		 p->name, (value & 0xf0) >> 4, value & 0x0f, pf->prog_id);
+
+	return 0;
+}
+
+static const struct regmap_config pf8x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = PF8X_NUMREGS - 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+struct otp_reg_lookup {
+	unsigned short prog_id;
+	unsigned char reg;
+	unsigned char value;
+};
+
+static const struct otp_reg_lookup otp_map[] = {
+	{ 0x401c, PF8X00_OTP_CTRL3, 0 },
+	{ 0x4008, PF8X00_OTP_CTRL3, 0x04 },
+	{ 0x301d, PF8X00_OTP_CTRL3, 0x04 },	/* test only */
+	{ 0, 0, 0 },
+};
+
+static int get_otp_reg(struct pf8x_chip *pf, unsigned char reg)
+{
+	const struct otp_reg_lookup *p = otp_map;
+
+	while (p->reg) {
+		if ((pf->prog_id == p->prog_id) && (reg == p->reg))
+			return p->value;
+		p++;
+	}
+
+	dev_err(pf->dev, "reg(0x%02x) not found for 0x%04x\n",
+		 reg, pf->prog_id);
+	return -EINVAL;
+}
+
+static int pf8x00_check_otp_configuration(struct pf8x_chip *pf)
+{
+	unsigned char quad_phase;
+	unsigned char dual_phase;
+	int ctrl3;
+	const char *format = NULL;
+	int ret = 0;
+
+	ctrl3 = get_otp_reg(pf, PF8X00_OTP_CTRL3);
+	if (ctrl3 >= 0) {
+		quad_phase = pf8x00_regulators[REG_SW1].quad_phase;
+		dual_phase = pf8x00_regulators[REG_SW1].dual_phase;
+		if (quad_phase) {
+			if ((ctrl3 & 3) != 2)
+				format = "sw1 quad_phase not set in otp_ctrl3 %x\n";
+
+		} else if (dual_phase) {
+			if ((ctrl3 & 3) != 1)
+				format = "sw1 dual_phase not set in otp_ctrl3 %x\n";
+		} else if (ctrl3 & 3) {
+			format = "sw1 single_phase not set in otp_ctrl3 %x\n";
+		}
+		if (!quad_phase) {
+			dual_phase = pf8x00_regulators[REG_SW4].dual_phase;
+			if (dual_phase) {
+				if ((ctrl3 & 0x0c) != 4)
+					format = "sw4 dual_phase not set in otp_ctrl3 %x\n";
+			} else if (ctrl3 & 0x0c) {
+				format = "sw4 single_phase not set in otp_ctrl3 %x\n";
+			}
+		}
+		dual_phase = pf8x00_regulators[REG_SW5].dual_phase;
+		if (dual_phase) {
+			if ((ctrl3 & 0x30) != 0x10)
+				format = "sw5 dual_phase not set in otp_ctrl3 %x\n";
+		} else if (ctrl3 & 0x30) {
+			format = "sw5 single_phase not set in otp_ctrl3 %x\n";
+		}
+		if (format) {
+			dev_err(pf->dev, format, ctrl3);
+			dev_err(pf->dev, "!!!try updating u-boot, boot.scr, or pmic\n");
+			ret = -EINVAL;
+		}
+	}
+	return ret;
+}
+
+static int pf8x00_regulator_probe(struct i2c_client *client,
+				    const struct i2c_device_id *id)
+{
+	struct pf8x_chip *pf;
+	struct regulator_config config = { 0 };
+	int i, ret;
+	u32 num_regulators;
+	unsigned int clk_freq = 0;
+
+	pf = devm_kzalloc(&client->dev, sizeof(*pf),
+			GFP_KERNEL);
+	if (!pf)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, pf);
+	pf->dev = &client->dev;
+
+	pf->regmap = devm_regmap_init_i2c(client, &pf8x_regmap_config);
+	if (IS_ERR(pf->regmap)) {
+		ret = PTR_ERR(pf->regmap);
+		dev_err(&client->dev,
+			"regmap allocation failed with err %d\n", ret);
+		return ret;
+	}
+
+	ret = pf8x_identify(pf);
+	if (ret)
+		return ret;
+
+	dev_info(&client->dev, "%s found.\n",
+		get_id_name(pf->chip_id)->name);
+
+	config.dev = &client->dev;
+	config.driver_data = pf;
+
+	ret = regmap_read(pf->regmap, PF8X00_FREQ_CTRL, &clk_freq);
+	clk_freq &= 0xf;
+	if (ret < 0)
+		clk_freq = 0;
+	if (((clk_freq & 7) > 4) || (clk_freq == 8))
+		clk_freq = 0;
+	pf->clk_freq = clk_freq;
+
+	num_regulators = ARRAY_SIZE(pf8x00_regulators);
+	for (i = 0; i < num_regulators; i++) {
+		struct regulator_desc *desc;
+
+		desc = &pf8x00_regulators[i].desc;
+
+		pf->regulators[i] =
+			devm_regulator_register(&client->dev, desc, &config);
+		if (IS_ERR(pf->regulators[i])) {
+			dev_err(&client->dev, "register regulator%s failed\n",
+				desc->name);
+			return PTR_ERR(pf->regulators[i]);
+		}
+	}
+
+	return pf8x00_check_otp_configuration(pf);
+}
+
+static struct i2c_driver pf8x_driver = {
+	.id_table = pf8x_device_id,
+	.driver = {
+		.name = "pf8x00-regulator",
+		.of_match_table = pf8x_dt_ids,
+	},
+	.probe = pf8x00_regulator_probe,
+};
+
+module_i2c_driver(pf8x_driver);
+
+MODULE_AUTHOR("Troy Kisky <troy.kisky@boundarydevices.com>");
+MODULE_AUTHOR("Adrien Grassein <adrien.grassein@gmail.com>");
+MODULE_DESCRIPTION("Regulator Driver for NXP's PF8100/PF8200 PMIC");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

