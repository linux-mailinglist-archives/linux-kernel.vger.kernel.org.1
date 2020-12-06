Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8012CFFF0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 01:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgLFA1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 19:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLFA1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 19:27:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25BC0613D1;
        Sat,  5 Dec 2020 16:26:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c198so8473470wmd.0;
        Sat, 05 Dec 2020 16:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NCj4Bg2uhwlyg0Tp97/b0hoHERgYfWActYuhcDyFfiI=;
        b=cMBaTH/zFOkgI/faFr5kH59UWRqQEyvt5CL/wKU6Tz+i0GG7EeBEvPp1btjyf6zx1K
         yAFfz6R+ScC8vjrA7nl3sq+odxVuCJjA3WOtmwSaCmdTR8FsbeaTY0dU2erP3vS0rDoQ
         +ptl0V31yJqqdDVDCKdH0oNkxC1Q7omozQYQV1ULh4YYj/MCfi9vhkdMSYmqr8Dfad1E
         vGL3++zEIrcuXFhqFL262w8YsPpqLlTa/WaavPHLc5ANAXjf69cWa0JA3wqM89p05RRa
         lLl9Vv0yIlFwegU+OY1ie8uDHI52hyRMXvuzisO6syjImLVDnKtd1j6OQ0Rj8mhCpIra
         e9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NCj4Bg2uhwlyg0Tp97/b0hoHERgYfWActYuhcDyFfiI=;
        b=dIK8SmK3CU+60T8oibU1VepEtrSFsoPgvK6Ed4javbP3fFPtlb6NA8/dkgjZVplGhX
         jPAPauu6pmgHeqz90kOELr+1zBdQBnGvg31j1RLPFn0MZu4Kt4sAzvbCwg6x+Xwe06O/
         Rc3ooe+FsgJ00aoSaDCrwYJpHbRUP1cWeXcJ+BKoYONVH6wK7fpPP4DEVGt5gS6PycDi
         rZkFcFue75cO4lK71kFb6V6cvuxAOu6yyk84d2xjvk7o3F3A0NvjerEDqrsdtLFVjCWF
         iEUoozKpqMtOjZAsWTsj5gNy2d4ZTjshzyOCxeYvNU4+ydXxOqxv0xcIh1ezzqAeH1QM
         IOEA==
X-Gm-Message-State: AOAM533PS0IU68dJbK0w28Nc1oKfmKpQRkI1L0wv/3ocLpH6/Pk0VFJ3
        AesVKpsLCt0r/SVBHLLJBqY=
X-Google-Smtp-Source: ABdhPJzs+DzeGzQmvuMUdxlpBxal1SKrBjhnuXOdfkbgB2RlbGHi1Ak/MwiRpqAcr2TalM1CakgOZg==
X-Received: by 2002:a1c:e342:: with SMTP id a63mr11561278wmh.64.1607214406435;
        Sat, 05 Dec 2020 16:26:46 -0800 (PST)
Received: from adgra-XPS-15-9570.home (lfbn-idf1-1-1007-144.w86-238.abo.wanadoo.fr. [86.238.83.144])
        by smtp.gmail.com with ESMTPSA id c2sm8978407wrv.41.2020.12.05.16.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 16:26:45 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        troy.kisky@boundarydevices.com, gary.bisson@boundarydevices.com,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH 2/2] regulator: pf8x00: add support of nxp pf8x00 regulator
Date:   Sun,  6 Dec 2020 01:26:29 +0100
Message-Id: <20201206002629.12872-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201206002629.12872-1-adrien.grassein@gmail.com>
References: <20201206002629.12872-1-adrien.grassein@gmail.com>
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
 drivers/regulator/pf8x00-regulator.c | 870 +++++++++++++++++++++++++++
 4 files changed, 884 insertions(+)
 create mode 100644 drivers/regulator/pf8x00-regulator.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e266f1e9a2f..72522a7fd329 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13735,6 +13735,7 @@ M:	Adrien Grassein <adrien.grassein@gmail.com>
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
index 000000000000..84a1f2ddbf74
--- /dev/null
+++ b/drivers/regulator/pf8x00-regulator.c
@@ -0,0 +1,870 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Copyright (C) 2011-2013 Freescale Semiconductor, Inc. All Rights Reserved.
+// Copyright 2017 NXP
+// Copyright 2019 Boundary Devices
+
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
+	unsigned char stby_reg;
+	unsigned char stby_mask;
+	int ilim;
+	int phase;
+	unsigned char hw_en;
+	unsigned char vselect_en;
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
+	struct pf8x_regulator regulator_descs[REG_NUM_REGULATORS];
+	struct regulator_dev *regulators[REG_NUM_REGULATORS];
+};
+
+/* Output: 1.5V to 5.0V, LDO2 can use VSELECT */
+static const int pf8x00_ldo_voltages[] = {
+	1500000, 1600000, 1800000, 1850000, 2150000, 2500000, 2800000, 3000000,
+	3100000, 3150000, 3200000, 3300000, 3350000, 4000000, 4900000, 5000000,
+};
+
+/* sw1 to sw6 voltages, from 0.4V to 1.49375V with 0.006250V increments */
+#define SWV(i)	(6250 * i + 400000)
+
+static const int pf8x00_sw1_to_6_voltages[] = {
+	SWV(0), SWV(1), SWV(2), SWV(3), SWV(4), SWV(5), SWV(6), SWV(7),
+	SWV(8), SWV(9), SWV(10), SWV(11), SWV(12), SWV(13), SWV(14), SWV(15),
+	SWV(16), SWV(17), SWV(18), SWV(19), SWV(20), SWV(21), SWV(22), SWV(23),
+	SWV(24), SWV(25), SWV(26), SWV(27), SWV(28), SWV(29), SWV(30), SWV(31),
+	SWV(32), SWV(33), SWV(34), SWV(35), SWV(36), SWV(37), SWV(38), SWV(39),
+	SWV(40), SWV(41), SWV(42), SWV(43), SWV(44), SWV(45), SWV(46), SWV(47),
+	SWV(48), SWV(49), SWV(50), SWV(51), SWV(52), SWV(53), SWV(54), SWV(55),
+	SWV(56), SWV(57), SWV(58), SWV(59), SWV(60), SWV(61), SWV(62), SWV(63),
+	SWV(64), SWV(65), SWV(66), SWV(67), SWV(68), SWV(69), SWV(70), SWV(71),
+	SWV(72), SWV(73), SWV(74), SWV(75), SWV(76), SWV(77), SWV(78), SWV(79),
+	SWV(80), SWV(81), SWV(82), SWV(83), SWV(84), SWV(85), SWV(86), SWV(87),
+	SWV(88), SWV(89), SWV(90), SWV(91), SWV(92), SWV(93), SWV(94), SWV(95),
+	SWV(96), SWV(97), SWV(98), SWV(99), SWV(100), SWV(101), SWV(102), SWV(103),
+	SWV(104), SWV(105), SWV(106), SWV(107), SWV(108), SWV(109), SWV(110), SWV(111),
+	SWV(112), SWV(113), SWV(114), SWV(115), SWV(116), SWV(117), SWV(118), SWV(119),
+	SWV(120), SWV(121), SWV(122), SWV(123), SWV(124), SWV(125), SWV(126), SWV(127),
+	SWV(128), SWV(129), SWV(130), SWV(131), SWV(132), SWV(133), SWV(134), SWV(135),
+	SWV(136), SWV(137), SWV(138), SWV(139), SWV(140), SWV(141), SWV(142), SWV(143),
+	SWV(144), SWV(145), SWV(146), SWV(147), SWV(148), SWV(149), SWV(150), SWV(151),
+	SWV(152), SWV(153), SWV(154), SWV(155), SWV(156), SWV(157), SWV(158), SWV(159),
+	SWV(160), SWV(161), SWV(162), SWV(163), SWV(164), SWV(165), SWV(166), SWV(167),
+	SWV(168), SWV(169), SWV(170), SWV(171), SWV(172), SWV(173), SWV(174), SWV(175),
+	1500000, 1800000,
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
+	{ .compatible = "nxp,pf8x00",},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pf8x_dt_ids);
+
+const struct id_name id_list[] = {
+	{PF8100, "PF8100"},
+	{PF8121A, "PF8121A"},
+	{PF8200, "PF8200"},
+	{0, "???"},
+};
+
+const struct id_name *get_id_name(enum chips id)
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
+static int pf8x00_regulator_set_voltage_time_sel(struct regulator_dev *rdev,
+		unsigned int old_sel, unsigned int new_sel)
+{
+	struct pf8x_chip *pf = rdev_get_drvdata(rdev);
+	struct pf8x_regulator *rdesc = container_of(rdev->desc, struct pf8x_regulator, desc);
+	const unsigned int *volt_table = rdev->desc->volt_table;
+	int old_v = volt_table[old_sel];
+	int new_v = volt_table[new_sel];
+	int change = (new_v - old_v);
+	unsigned int index;
+	unsigned int slew;
+
+	index = (rdesc->fast_slew & 1) ? 2 : 0;
+	if (change < 0)
+		index++;
+	slew = ramp_table[pf->clk_freq].up_down_slow_fast[index];
+
+	return DIV_ROUND_UP(abs(change), slew);
+}
+
+static short ilim_table[] = {
+	2100, 2600, 3000, /* 4500, */
+};
+
+static int encode_ilim(struct pf8x_chip *pf, int ilim)
+{
+	int i = 0;
+
+	if (ilim <= 0)
+		return -1;
+	while (i < ARRAY_SIZE(ilim_table)) {
+		if (ilim <= ilim_table[i])
+			break;
+		i++;
+	}
+	return i;
+}
+
+static int encode_phase(struct pf8x_chip *pf, int phase)
+{
+	int ph;
+
+	if (phase < 0)
+		return -1;
+	ph = phase / 45;
+	if ((ph * 45) != phase) {
+		dev_err(pf->dev, "ignoring, illegal phase %d\n", phase);
+		return -1;
+	}
+	return (ph >= 1) ? ph - 1 : 7;
+}
+
+static int pf8x00_of_parse_cb(struct device_node *np,
+		const struct regulator_desc *desc,
+		struct regulator_config *config)
+{
+	struct pf8x_chip *pf = config->driver_data;
+	struct pf8x_regulator *rdesc = &pf->regulator_descs[desc->id];
+	unsigned char hw_en = 0;
+	unsigned char vselect_en = 0;
+	unsigned char quad_phase = 0;
+	unsigned char dual_phase = 0;
+	int ilim;
+	int phase;
+	int fast_slew;
+	int ret;
+
+	ret = of_property_read_u32(np, "nxp,ilim-ma",
+			&ilim);
+	if (ret)
+		ilim = -1;
+	ret = of_property_read_u32(np, "nxp,phase",
+			&phase);
+	if (ret)
+		phase = -1;
+	ilim = encode_ilim(pf, ilim);
+	phase = encode_phase(pf, phase);
+
+	ret = of_property_read_u32(np, "nxp,fast-slew", &fast_slew);
+	if (ret)
+		fast_slew = -1;
+
+	if (of_get_property(np, "nxp,hw-en", NULL))
+		hw_en = 1;
+	if (of_get_property(np, "nxp,quad-phase", NULL))
+		quad_phase = 1;
+	if (of_get_property(np, "nxp,dual-phase", NULL))
+		dual_phase = 1;
+	if (of_get_property(np, "nxp,vselect-en", NULL))
+		vselect_en = 1;
+
+	if ((desc->id != REG_SW1) && quad_phase) {
+		dev_err(pf->dev, "ignoring, only sw1 can use quad-phase\n");
+		quad_phase = 0;
+	}
+	if ((desc->id != REG_SW1) && (desc->id != REG_SW4)
+			 && (desc->id != REG_SW5) && dual_phase) {
+		dev_err(pf->dev, "ignoring, only sw1/sw4/sw5 can use dual-phase\n");
+		dual_phase = 0;
+	}
+	if ((desc->id != REG_LDO2) && vselect_en) {
+		/* LDO2 has gpio vselect */
+		dev_err(pf->dev, "ignoring, only ldo2 can use vselect-en\n");
+		vselect_en = 0;
+	}
+	if ((desc->id != REG_LDO2) && hw_en) {
+		/* LDO2 has gpio vselect */
+		dev_err(pf->dev, "ignoring, only ldo2 can use hw-en\n");
+		hw_en = 0;
+	}
+	if ((desc->id < REG_SW1) && (desc->id > REG_SW7)) {
+		if ((unsigned int)ilim <= 3) {
+			dev_err(pf->dev, "ignoring, only sw1-7 can use ilim\n");
+			ilim = -1;
+		}
+		if ((unsigned int)phase <= 7) {
+			dev_err(pf->dev, "ignoring, only sw1-7 can use phase\n");
+			ilim = -1;
+		}
+	}
+	rdesc->ilim = ilim;
+	rdesc->phase = phase;
+	rdesc->hw_en = hw_en;
+	rdesc->vselect_en = vselect_en;
+	rdesc->quad_phase = quad_phase;
+	rdesc->dual_phase = dual_phase;
+	rdesc->fast_slew = fast_slew;
+
+	return 0;
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
+static const struct regulator_ops pf8x00_sw_regulator_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = pf8x00_regulator_set_voltage_time_sel,
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
+#define STRUCT_LDO_REG(_id, _name, base, voltages)		\
+	[_id] = {						\
+		.desc = {					\
+			.name = #_name,				\
+			.of_match = of_match_ptr(#_name),	\
+			.regulators_node = of_match_ptr("regulators"), \
+			.of_parse_cb = pf8x00_of_parse_cb,	\
+			.n_voltages = ARRAY_SIZE(voltages),	\
+			.ops = &pf8x00_ldo_regulator_ops,	\
+			.type = REGULATOR_VOLTAGE,		\
+			.id = _id,				\
+			.owner = THIS_MODULE,			\
+			.volt_table = voltages,			\
+			.vsel_reg = (base) + LDO_RUN_VOLT,	\
+			.vsel_mask = 0xff,			\
+			.enable_reg = (base) + LDO_CONFIG2,	\
+			.enable_val = 0x2,			\
+			.disable_val = 0x0,			\
+			.enable_mask = 2,			\
+		},						\
+		.stby_reg = (base) + LDO_STBY_VOLT,		\
+		.stby_mask = 0x20,				\
+	}
+
+#define STRUCT_SW_REG(_id, _name, base, voltages)		\
+	[_id] = {						\
+		.desc = {					\
+			.name = #_name,				\
+			.of_match = of_match_ptr(#_name),	\
+			.regulators_node = of_match_ptr("regulators"), \
+			.of_parse_cb = pf8x00_of_parse_cb,	\
+			.n_voltages = ARRAY_SIZE(voltages),	\
+			.ops = &pf8x00_sw_regulator_ops,	\
+			.type = REGULATOR_VOLTAGE,		\
+			.id = _id,				\
+			.owner = THIS_MODULE,			\
+			.volt_table = voltages,			\
+			.vsel_reg = (base) + SW_RUN_VOLT,	\
+			.vsel_mask = 0xff,			\
+			.enable_reg = (base) + SW_MODE1,	\
+			.enable_val = 0x3,			\
+			.disable_val = 0x0,			\
+			.enable_mask = 0x3,			\
+			.enable_time = 500,			\
+		},						\
+		.stby_reg = (base) + SW_STBY_VOLT,		\
+		.stby_mask = 0xff,				\
+	}
+
+
+#define STRUCT_VSNVS_REG(_id, _name, base, voltages)		\
+	[_id] = {						\
+		.desc = {					\
+			.name = #_name,				\
+			.of_match = of_match_ptr(#_name),	\
+			.regulators_node = of_match_ptr("regulators"), \
+			.of_parse_cb = pf8x00_of_parse_cb,	\
+			.n_voltages = ARRAY_SIZE(voltages),	\
+			.ops = &pf8x00_vsnvs_regulator_ops,	\
+			.type = REGULATOR_VOLTAGE,		\
+			.id = _id,				\
+			.owner = THIS_MODULE,			\
+			.volt_table = voltages,			\
+			.vsel_reg = (base),			\
+			.vsel_mask = 0x3,			\
+		},						\
+	}
+
+static const struct pf8x_regulator pf8x00_regulators[] = {
+	STRUCT_LDO_REG(REG_LDO1, ldo1, PF8X00_LDO(REG_LDO1), pf8x00_ldo_voltages),
+	STRUCT_LDO_REG(REG_LDO2, ldo2, PF8X00_LDO(REG_LDO2), pf8x00_ldo_voltages),
+	STRUCT_LDO_REG(REG_LDO3, ldo3, PF8X00_LDO(REG_LDO3), pf8x00_ldo_voltages),
+	STRUCT_LDO_REG(REG_LDO4, ldo4, PF8X00_LDO(REG_LDO4), pf8x00_ldo_voltages),
+	STRUCT_SW_REG(REG_SW1, sw1, PF8X00_SW(REG_SW1), pf8x00_sw1_to_6_voltages),
+	STRUCT_SW_REG(REG_SW2, sw2, PF8X00_SW(REG_SW2), pf8x00_sw1_to_6_voltages),
+	STRUCT_SW_REG(REG_SW3, sw3, PF8X00_SW(REG_SW3), pf8x00_sw1_to_6_voltages),
+	STRUCT_SW_REG(REG_SW4, sw4, PF8X00_SW(REG_SW4), pf8x00_sw1_to_6_voltages),
+	STRUCT_SW_REG(REG_SW5, sw5, PF8X00_SW(REG_SW5), pf8x00_sw1_to_6_voltages),
+	STRUCT_SW_REG(REG_SW6, sw6, PF8X00_SW(REG_SW6), pf8x00_sw1_to_6_voltages),
+	STRUCT_SW_REG(REG_SW7, sw7, PF8X00_SW(REG_SW7), pf8x00_sw7_voltages),
+	STRUCT_VSNVS_REG(REG_VSNVS, vsnvs, PF8X00_VSNVS_CONFIG1, pf8x00_vsnvs_voltages),
+};
+
+#ifdef CONFIG_OF
+static struct of_regulator_match pf8x00_matches[] = {
+	{ .name = "ldo1",	},
+	{ .name = "ldo2",	},
+	{ .name = "ldo3",	},
+	{ .name = "ldo4",	},
+	{ .name = "sw1",	},
+	{ .name = "sw2",	},
+	{ .name = "sw3",	},
+	{ .name = "sw4",	},
+	{ .name = "sw5",	},
+	{ .name = "sw6",	},
+	{ .name = "sw7",	},
+	{ .name = "vsnvs",	},
+};
+
+static int pf8x_parse_regulators_dt(struct pf8x_chip *pf)
+{
+	struct device *dev = pf->dev;
+	struct device_node *np, *parent;
+	int ret;
+
+	np = of_node_get(dev->of_node);
+	if (!np)
+		return -EINVAL;
+
+	parent = of_get_child_by_name(np, "regulators");
+	if (!parent) {
+		dev_err(dev, "regulators node not found\n");
+		return -EINVAL;
+	}
+
+	ret = of_regulator_match(dev, parent, pf8x00_matches,
+				 ARRAY_SIZE(pf8x00_matches));
+
+	of_node_put(parent);
+	if (ret < 0) {
+		dev_err(dev, "Error parsing regulator init data: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline struct regulator_init_data *match_init_data(int index)
+{
+	return pf8x00_matches[index].init_data;
+}
+
+static inline struct device_node *match_of_node(int index)
+{
+	return pf8x00_matches[index].of_node;
+}
+#else
+static int pf8x_parse_regulators_dt(struct pf8x_chip *pf)
+{
+	return 0;
+}
+
+static inline struct regulator_init_data *match_init_data(int index)
+{
+	return NULL;
+}
+
+static inline struct device_node *match_of_node(int index)
+{
+	return NULL;
+}
+#endif
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
+static int pf8x00_regulator_probe(struct i2c_client *client,
+				    const struct i2c_device_id *id)
+{
+	struct pf8x_chip *pf;
+	struct regulator_config config = { };
+	int i, ret;
+	u32 num_regulators;
+	unsigned int hw_en;
+	unsigned int vselect_en;
+	unsigned char quad_phase;
+	unsigned char dual_phase;
+	unsigned int val;
+	int ctrl3;
+	const char *format = NULL;
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
+	ret = regmap_read(pf->regmap, PF8X00_FREQ_CTRL, &clk_freq);
+	clk_freq &= 0xf;
+	if (ret < 0)
+		clk_freq = 0;
+	if (((clk_freq & 7) > 4) || (clk_freq == 8))
+		clk_freq = 0;
+	pf->clk_freq = clk_freq;
+
+	memcpy(pf->regulator_descs, pf8x00_regulators,
+		sizeof(pf->regulator_descs));
+
+	ret = pf8x_parse_regulators_dt(pf);
+	if (ret)
+		return ret;
+
+	num_regulators = ARRAY_SIZE(pf->regulator_descs);
+	for (i = 0; i < num_regulators; i++) {
+		struct regulator_init_data *init_data;
+		struct regulator_desc *desc;
+
+		desc = &pf->regulator_descs[i].desc;
+		init_data = match_init_data(i);
+
+		config.dev = &client->dev;
+		config.init_data = init_data;
+		config.driver_data = pf;
+		config.of_node = match_of_node(i);
+		config.ena_gpiod = NULL;
+
+		pf->regulators[i] =
+			devm_regulator_register(&client->dev, desc, &config);
+		if (IS_ERR(pf->regulators[i])) {
+			dev_err(&client->dev, "register regulator%s failed\n",
+				desc->name);
+			return PTR_ERR(pf->regulators[i]);
+		}
+		if ((i >= REG_SW1) && (i <= REG_SW7)) {
+			unsigned int phase = pf->regulator_descs[i].phase;
+			unsigned int ilim = pf->regulator_descs[i].ilim;
+			unsigned int mask = 0;
+			unsigned int val = 0;
+			unsigned int reg = PF8X00_SW(i) + SW_CONFIG2;
+			unsigned int fast_slew = pf->regulator_descs[i].fast_slew;
+
+			if (phase <= 7) {
+				mask |= 7;
+				val |= phase;
+			}
+			if (ilim <= 3) {
+				mask |= 3 << 3;
+				val |= ilim << 3;
+			}
+			if (fast_slew <= 1) {
+				mask |= 1 << 5;
+				val |= fast_slew << 5;
+			}
+			if (mask) {
+				ret = regmap_update_bits(pf->regmap, reg, mask,
+						val);
+			}
+			if (fast_slew > 1) {
+				ret = regmap_read(pf->regmap, reg, &fast_slew);
+				fast_slew &= 0x20;
+				if (ret < 0)
+					fast_slew = 0;
+				pf->regulator_descs[i].fast_slew = fast_slew >> 5;
+			}
+		}
+	}
+	hw_en = pf->regulator_descs[REG_LDO2].hw_en;
+	vselect_en = pf->regulator_descs[REG_LDO2].vselect_en;
+	val = vselect_en ? 8 : 0;
+	if (hw_en)
+		val |= 0x10;
+	ret = regmap_update_bits(pf->regmap,
+			PF8X00_LDO(REG_LDO2) + LDO_CONFIG2,
+				 0x18, val);
+
+	ctrl3 = get_otp_reg(pf, PF8X00_OTP_CTRL3);
+	if (ctrl3 >= 0) {
+		quad_phase = pf->regulator_descs[REG_SW1].quad_phase;
+		dual_phase = pf->regulator_descs[REG_SW1].dual_phase;
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
+			dual_phase = pf->regulator_descs[REG_SW4].dual_phase;
+			if (dual_phase) {
+				if ((ctrl3 & 0x0c) != 4)
+					format = "sw4 dual_phase not set in otp_ctrl3 %x\n";
+			} else if (ctrl3 & 0x0c) {
+				format = "sw4 single_phase not set in otp_ctrl3 %x\n";
+			}
+		}
+		dual_phase = pf->regulator_descs[REG_SW5].dual_phase;
+		if (dual_phase) {
+			if ((ctrl3 & 0x30) != 0x10)
+				format = "sw5 dual_phase not set in otp_ctrl3 %x\n";
+		} else if (ctrl3 & 0x30) {
+			format = "sw5 single_phase not set in otp_ctrl3 %x\n";
+		}
+		if (format) {
+			dev_err(pf->dev, format, ctrl3);
+			dev_err(pf->dev, "!!!try updating u-boot, boot.scr, or pmic\n");
+		}
+	}
+	return 0;
+}
+
+static int pf8x_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int pf8x_resume(struct device *dev)
+{
+	return 0;
+}
+
+static const struct dev_pm_ops pf8x_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pf8x_suspend, pf8x_resume)
+};
+
+static struct i2c_driver pf8x_driver = {
+	.id_table = pf8x_device_id,
+	.driver = {
+		.name = "pf8x00-regulator",
+		.of_match_table = pf8x_dt_ids,
+		.pm = &pf8x_pm_ops,
+	},
+	.probe = pf8x00_regulator_probe,
+};
+
+static int __init pf8x_init(void)
+{
+	return i2c_add_driver(&pf8x_driver);
+}
+subsys_initcall(pf8x_init);
+
+static void __exit pf8x_exit(void)
+{
+	i2c_del_driver(&pf8x_driver);
+}
+module_exit(pf8x_exit);
+
+MODULE_AUTHOR("Troy Kisky <troy.kisky@boundarydevices.com>");
+MODULE_AUTHOR("Adrien Grassein <adrien.grassein@gmail.com>");
+MODULE_DESCRIPTION("Regulator Driver for NXP's PF8100/PF8200 PMIC");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

