Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C9E301F17
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 23:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbhAXWLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 17:11:18 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7800 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbhAXWLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 17:11:03 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10OMAGAZ029284;
        Sun, 24 Jan 2021 17:10:16 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 368ehab9xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 17:10:15 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10OMAEiQ065033
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 24 Jan 2021 17:10:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Sun, 24 Jan
 2021 17:10:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Sun, 24 Jan 2021 17:10:13 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10OMA98x001908;
        Sun, 24 Jan 2021 17:10:11 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <sboyd@kernel.org>,
        <mturquette@baylibre.com>, <petre.minciunescu@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 1/2] clk: ad9545: Add support
Date:   Mon, 25 Jan 2021 00:13:03 +0200
Message-ID: <20210124221304.51007-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210124221304.51007-1-alexandru.tachici@analog.com>
References: <20210124221304.51007-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-24_10:2021-01-22,2021-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101240140
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add support for AD9545 Quad Input, 10-Output, Dual DPLL/IEEE 1588,
1 pps Synchronizer and Jitter Cleaner.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/clk/Kconfig                |    6 +
 drivers/clk/Makefile               |    1 +
 drivers/clk/adi/Kconfig            |   29 +
 drivers/clk/adi/Makefile           |    9 +
 drivers/clk/adi/clk-ad9545-i2c.c   |   61 +
 drivers/clk/adi/clk-ad9545-spi.c   |   75 ++
 drivers/clk/adi/clk-ad9545.c       | 1678 ++++++++++++++++++++++++++++
 drivers/clk/adi/clk-ad9545.h       |   16 +
 include/dt-bindings/clock/ad9545.h |   64 ++
 9 files changed, 1939 insertions(+)
 create mode 100644 drivers/clk/adi/Kconfig
 create mode 100644 drivers/clk/adi/Makefile
 create mode 100644 drivers/clk/adi/clk-ad9545-i2c.c
 create mode 100644 drivers/clk/adi/clk-ad9545-spi.c
 create mode 100644 drivers/clk/adi/clk-ad9545.c
 create mode 100644 drivers/clk/adi/clk-ad9545.h
 create mode 100644 include/dt-bindings/clock/ad9545.h

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 85856cff506c..80c3faf1f42e 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -270,6 +270,11 @@ config CLK_LS1028A_PLLDIG
           features of the PLL are currently supported by the driver. By default,
           configured bypass mode with this PLL.
 
+config COMMON_CLK_ADI
+	def_bool COMMON_CLK
+	---help---
+	  Support for Analog Devices clock providers.
+
 config COMMON_CLK_XGENE
 	bool "Clock driver for APM XGene SoC"
 	default ARCH_XGENE
@@ -369,6 +374,7 @@ config COMMON_CLK_FIXED_MMIO
 	  Support for Memory Mapped IO Fixed clocks
 
 source "drivers/clk/actions/Kconfig"
+source "drivers/clk/adi/Kconfig"
 source "drivers/clk/analogbits/Kconfig"
 source "drivers/clk/baikal-t1/Kconfig"
 source "drivers/clk/bcm/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index dbdc590e7de3..3adc7db7c671 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_COMMON_CLK_XGENE)		+= clk-xgene.o
 
 # please keep this section sorted lexicographically by directory path name
 obj-y					+= actions/
+obj-$(CONFIG_COMMON_CLK_ADI)		+= adi/
 obj-y					+= analogbits/
 obj-$(CONFIG_COMMON_CLK_AT91)		+= at91/
 obj-$(CONFIG_ARCH_ARTPEC)		+= axis/
diff --git a/drivers/clk/adi/Kconfig b/drivers/clk/adi/Kconfig
new file mode 100644
index 000000000000..768b8227f336
--- /dev/null
+++ b/drivers/clk/adi/Kconfig
@@ -0,0 +1,29 @@
+#
+# Analog Devices Clock Drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Analog Devices Clock Drivers"
+
+config COMMON_CLK_AD9545
+	tristate
+
+config COMMON_CLK_AD9545_I2C
+	tristate "Analog Devices AD9545 via I2C"
+	depends on REGMAP_I2C
+	select COMMON_CLK_AD9545
+	help
+	  Say yes here to build support for Analog Devices AD9545
+	  Quad Input, 10-Output, Dual DPLL/IEEE 1588,
+	  1 pps Synchronizer and Jitter Cleaner via I2C
+
+config COMMON_CLK_AD9545_SPI
+	tristate "Analog Devices AD9545 via SPI"
+	depends on REGMAP_SPI
+	select COMMON_CLK_AD9545
+	help
+	  Say yes here to build support for Analog Devices AD9545
+	  Quad Input, 10-Output, Dual DPLL/IEEE 1588,
+	  1 pps Synchronizer and Jitter Cleaner via SPI
+
+endmenu
diff --git a/drivers/clk/adi/Makefile b/drivers/clk/adi/Makefile
new file mode 100644
index 000000000000..7ba1fded3013
--- /dev/null
+++ b/drivers/clk/adi/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+#
+# Makefile for AD9545 Network Clock Generator/Synchronizer
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_COMMON_CLK_AD9545) += clk-ad9545.o
+obj-$(CONFIG_COMMON_CLK_AD9545_I2C) += clk-ad9545-i2c.o
+obj-$(CONFIG_COMMON_CLK_AD9545_SPI) += clk-ad9545-spi.o
diff --git a/drivers/clk/adi/clk-ad9545-i2c.c b/drivers/clk/adi/clk-ad9545-i2c.c
new file mode 100644
index 000000000000..923fec28ece2
--- /dev/null
+++ b/drivers/clk/adi/clk-ad9545-i2c.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * AD9545 Network Clock Generator/Synchronizer
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#include "clk-ad9545.h"
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+static const struct regmap_config ad9545_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = 0x3A3B,
+	.use_single_rw = true,
+};
+
+static int ad9545_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &ad9545_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "devm_regmap_init_i2c failed!\n");
+		return PTR_ERR(regmap);
+	}
+
+	return ad9545_probe(&client->dev, regmap);
+}
+
+static const struct of_device_id ad9545_i2c_of_match[] = {
+	{ .compatible = "adi,ad9545" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad9545_i2c_of_match);
+
+static const struct i2c_device_id ad9545_i2c_id[] = {
+	{"ad9545"},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ad9545_i2c_id);
+
+static struct i2c_driver ad9545_i2c_driver = {
+	.driver = {
+		.name	= "ad9545",
+		.of_match_table = ad9545_i2c_of_match,
+	},
+	.probe_new	= ad9545_i2c_probe,
+	.id_table	= ad9545_i2c_id,
+};
+module_i2c_driver(ad9545_i2c_driver);
+
+MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD9545 I2C");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/clk/adi/clk-ad9545-spi.c b/drivers/clk/adi/clk-ad9545-spi.c
new file mode 100644
index 000000000000..36ded1026843
--- /dev/null
+++ b/drivers/clk/adi/clk-ad9545-spi.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * AD9545 Network Clock Generator/Synchronizer
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#include "clk-ad9545.h"
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+
+#define AD9545_CONFIG_0			0x0000
+
+#define AD9545_4WIRE_SPI		0x3
+#define AD9545_4WIRE_SPI_MSK		GENMASK(4, 3)
+
+static const struct regmap_config ad9545_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = 0x3A3B,
+	.use_single_rw = true,
+};
+
+static int ad9545_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_spi(spi, &ad9545_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "devm_regmap_init_spi failed!\n");
+		return PTR_ERR(regmap);
+	}
+
+	if (!(spi->mode & SPI_3WIRE)) {
+		ret = regmap_write(regmap, AD9545_CONFIG_0,
+				   FIELD_PREP(AD9545_4WIRE_SPI_MSK, AD9545_4WIRE_SPI));
+		if (ret < 0)
+			return ret;
+	}
+
+	return ad9545_probe(&spi->dev, regmap);
+}
+
+static const struct of_device_id ad9545_spi_of_match[] = {
+	{ .compatible = "adi,ad9545" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad9545_spi_of_match);
+
+static const struct spi_device_id ad9545_spi_id[] = {
+	{"ad9545", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad9545_spi_id);
+
+static struct spi_driver ad9545_spi_driver = {
+	.driver = {
+		.name	= "ad9545",
+		.of_match_table = ad9545_spi_of_match,
+	},
+	.probe		= ad9545_spi_probe,
+	.id_table	= ad9545_spi_id,
+};
+module_spi_driver(ad9545_spi_driver);
+
+MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD9545 SPI");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/clk/adi/clk-ad9545.c b/drivers/clk/adi/clk-ad9545.c
new file mode 100644
index 000000000000..df4008e5a5c7
--- /dev/null
+++ b/drivers/clk/adi/clk-ad9545.c
@@ -0,0 +1,1678 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * AD9545 Network Clock Generator/Synchronizer
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/rational.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <dt-bindings/clock/ad9545.h>
+
+#define AD9545_CONFIG_0			0x0000
+#define AD9545_PRODUCT_ID_LOW		0x0004
+#define AD9545_PRODUCT_ID_HIGH		0x0005
+#define AD9545_IO_UPDATE		0x000F
+#define AD9545_CHIP_ID			0x0121
+#define AD9545_SYS_CLK_FB_DIV		0x0200
+#define AD9545_SYS_CLK_INPUT		0x0201
+#define AD9545_SYS_CLK_REF_FREQ		0x0202
+#define AD9545_SYS_STABILITY_T		0x0207
+#define AD9545_REF_A_CTRL		0x0300
+#define AD9545_REF_A_RDIV		0x0400
+#define AD9545_REF_A_PERIOD		0x0404
+#define AD9545_REF_A_OFFSET_LIMIT	0x040C
+#define AD9545_REF_A_MONITOR_HYST	0x040F
+#define AD9545_PHASE_LOCK_THRESH	0x0800
+#define AD9545_FREQ_LOCK_THRESH		0x0805
+#define AD9545_DPLL0_FTW		0x1000
+#define AD9545_DRIVER_0A_CONF		0x10D7
+#define AD9545_SYNC_CTRL0		0x10DB
+#define AD9545_APLL0_M_DIV		0x1081
+#define AD9545_Q0A_DIV			0x1100
+#define AD9545_Q0A_PHASE		0x1104
+#define AD9545_Q0A_PHASE_CONF		0x1108
+#define AD9545_DPLL0_EN			0x1200
+#define AD9545_DPLL0_SOURCE		0x1201
+#define AD9545_DPLL0_LOOP_BW		0x1204
+#define AD9545_DPLL0_N_DIV		0x120C
+#define AD9545_DPLL0_FRAC		0x1210
+#define AD9545_DPLL0_MOD		0x1213
+#define AD9545_DRIVER_1A_CONF		0x14D7
+#define AD9545_Q1A_DIV			0x1500
+#define AD9545_Q1A_PHASE		0x1504
+#define AD9545_Q1A_PHASE_CONF		0x1508
+#define AD9545_CALIB_CLK		0x2000
+#define AD9545_POWER_DOWN_REF		0x2001
+#define AD9545_PWR_CALIB_CH0		0x2100
+#define AD9545_CTRL_CH0			0x2101
+#define AD9545_DIV_OPS_Q0A		0x2102
+#define AD9545_DPLL0_MODE		0x2105
+#define AD9545_DIV_OPS_Q1A		0x2202
+#define AD9545_NCO0_FREQ		0x2805
+#define AD9545_PLL_STATUS		0x3001
+#define AD9545_PLL0_STATUS		0x3100
+
+#define AD9545_REF_CTRL_DIF_MSK			GENMASK(3, 2)
+#define AD9545_REF_CTRL_REFA_MSK		GENMASK(5, 4)
+#define AD9545_REF_CTRL_REFAA_MSK		GENMASK(7, 6)
+
+#define AD9545_UPDATE_REGS			0x1
+#define AD9545_RESET_REGS			0x81
+
+#define AD9545_SYNC_CTRLX(x)			(AD9545_SYNC_CTRL0 + ((x) * 0x400))
+#define AD9545_REF_X_RDIV(x)			(AD9545_REF_A_RDIV + ((x) * 0x20))
+#define AD9545_REF_X_PERIOD(x)			(AD9545_REF_A_PERIOD + ((x) * 0x20))
+#define AD9545_REF_X_OFFSET_LIMIT(x)		(AD9545_REF_A_OFFSET_LIMIT + ((x) * 0x20))
+#define AD9545_REF_X_MONITOR_HYST(x)		(AD9545_REF_A_MONITOR_HYST + ((x) * 0x20))
+
+#define AD9545_SOURCEX_PHASE_THRESH(x)		(AD9545_PHASE_LOCK_THRESH + ((x) * 0x20))
+#define AD9545_SOURCEX_FREQ_THRESH(x)		(AD9545_FREQ_LOCK_THRESH + ((x) * 0x20))
+#define AD9545_NCOX_PHASE_THRESH(x)		(AD9545_SOURCEX_PHASE_THRESH((x) + 4))
+#define AD9545_NCOX_FREQ_THRESH(x)		(AD9545_SOURCEX_FREQ_THRESH((x) + 4))
+
+#define AD9545_APLLX_M_DIV(x)			(AD9545_APLL0_M_DIV + ((x) * 0x400))
+
+#define AD9545_Q0_DIV(x)			(AD9545_Q0A_DIV + ((x) * 0x9))
+#define AD9545_Q1_DIV(x)			(AD9545_Q1A_DIV + ((x) * 0x9))
+#define AD9545_QX_DIV(x) ({					\
+	typeof(x) x_ = (x);					\
+								\
+	(x_ > 5) ? AD9545_Q1_DIV(x_ - 6) : AD9545_Q0_DIV(x_);	\
+})
+
+#define AD9545_Q0_PHASE(x)			(AD9545_Q0A_PHASE + ((x) * 0x9))
+#define AD9545_Q1_PHASE(x)			(AD9545_Q1A_PHASE + ((x) * 0x9))
+#define AD9545_QX_PHASE(x) ({						\
+	typeof(x) x_ = (x);						\
+									\
+	(x_ > 5) ? AD9545_Q1_PHASE(x_ - 6) : AD9545_Q0_PHASE(x_);	\
+})
+
+#define AD9545_Q0_PHASE_CONF(x)			(AD9545_Q0A_PHASE_CONF + ((x) * 0x9))
+#define AD9545_Q1_PHASE_CONF(x)			(AD9545_Q1A_PHASE_CONF + ((x) * 0x9))
+#define AD9545_QX_PHASE_CONF(x) ({						\
+	typeof(x) x_ = (x);							\
+										\
+	(x_ > 5) ? AD9545_Q1_PHASE_CONF(x_ - 6) : AD9545_Q0_PHASE_CONF(x_);	\
+})
+
+#define AD9545_DPLLX_FTW(x)			(AD9545_DPLL0_FTW + ((x) * 0x400))
+#define AD9545_DPLLX_EN(x)			(AD9545_DPLL0_EN + ((x) * 0x400))
+#define AD9545_DPLLX_SOURCE(x)			(AD9545_DPLL0_SOURCE + ((x) * 0x400))
+#define AD9545_DPLLX_LOOP_BW(x)			(AD9545_DPLL0_LOOP_BW + ((x) * 0x400))
+#define AD9545_DPLLX_N_DIV(x)			(AD9545_DPLL0_N_DIV + ((x) * 0x400))
+#define AD9545_DPLLX_FRAC_DIV(x)		(AD9545_DPLL0_FRAC + ((x) * 0x400))
+#define AD9545_DPLLX_MOD_DIV(x)			(AD9545_DPLL0_MOD + ((x) * 0x400))
+
+#define AD9545_DIV_OPS_Q0(x)			(AD9545_DIV_OPS_Q0A + (x))
+#define AD9545_DIV_OPS_Q1(x)			(AD9545_DIV_OPS_Q1A + (x))
+#define AD9545_DIV_OPS_QX(x) ({						\
+	typeof(x) x_ = (x) / 2;						\
+									\
+	(x_ > 2) ? AD9545_DIV_OPS_Q1(x_ - 3) : AD9545_DIV_OPS_Q0(x_);	\
+})
+
+#define AD9545_PWR_CALIB_CHX(x)			(AD9545_PWR_CALIB_CH0 + ((x) * 0x100))
+#define AD9545_PLLX_STATUS(x)			(AD9545_PLL0_STATUS + ((x) * 0x100))
+
+#define AD9545_PROFILE_SEL_MODE_MSK		GENMASK(3, 2)
+#define AD9545_PROFILE_SEL_MODE(x)		FIELD_PREP(AD9545_PROFILE_SEL_MODE_MSK, x)
+
+#define AD9545_NCOX_FREQ(x)			(AD9545_NCO0_FREQ + ((x) * 0x40))
+
+/* AD9545_PWR_CALIB_CHX bitfields */
+#define AD9545_PWR_DOWN_CH			BIT(0)
+#define AD9545_CALIB_APLL			BIT(1)
+
+/* AD9545_SYNC_CTRLX bitfields */
+#define AD9545_SYNC_CTRL_DPLL_REF_MSK		BIT(2)
+#define AD9545_SYNC_CTRL_MODE_MSK		GENMASK(1, 0)
+
+/* AD9545_QX_PHASE_CONF bitfields */
+#define AD9545_QX_HALF_DIV_MSK			BIT(5)
+#define AD9545_QX_PHASE_32_MSK			BIT(6)
+
+/* AD9545_DIV_OPS_QX bitfields */
+#define AD9545_DIV_OPS_MUTE_A_MSK		BIT(2)
+#define AD9545_DIV_OPS_MUTE_AA_MSK		BIT(3)
+
+/* AD9545_PLL_STATUS bitfields */
+#define AD9545_PLLX_LOCK(x, y)			((1 << (4 + (x))) & (y))
+
+#define AD9545_SYS_PLL_STABLE_MSK		GENMASK(1, 0)
+#define AD9545_SYS_PLL_STABLE(x)		(((x) & AD9545_SYS_PLL_STABLE_MSK) == 0x3)
+
+#define AD9545_APLL_LOCKED(x)			((x) & BIT(3))
+
+#define AD9545_SYS_CLK_STABILITY_MS	50
+
+#define AD9545_R_DIV_MAX		0x40000000
+#define AD9545_IN_MAX_TDC_FREQ_HZ	200000
+
+#define AD9545_APLL_M_DIV_MIN		14
+#define AD9545_APLL_M_DIV_MAX		255
+
+#define AD9545_DPLL_MAX_N		1073741823
+#define AD9545_DPLL_MAX_FRAC		116777215
+#define AD9545_DPLL_MAX_MOD		116777215
+
+#define AD9545_NCO_MAX_FREQ		65535
+
+static const unsigned int ad9545_apll_rate_ranges_hz[2][2] = {
+	{2400000000U, 3200000000U}, {3200000000U, 4000000000U}
+};
+
+static const unsigned int ad9545_apll_pfd_rate_ranges_hz[2] = {
+	162000000U, 300000000U
+};
+
+static const unsigned short ad9545_vco_calibration_op[][2] = {
+	{AD9545_CALIB_CLK, 0},
+	{AD9545_IO_UPDATE, AD9545_UPDATE_REGS},
+	{AD9545_CALIB_CLK, BIT(2)},
+	{AD9545_IO_UPDATE, AD9545_UPDATE_REGS},
+};
+
+static const u8 ad9545_tdc_source_mapping[] = {
+	0, 1, 2, 3, 8, 9,
+};
+
+static const u32 ad9545_hyst_scales_bp[] = {
+	0, 3125, 6250, 12500, 25000, 50000, 75000, 87500
+};
+
+static const u32 ad9545_out_source_ua[] = {
+	7500, 12500, 15000
+};
+
+static const char * const ad9545_ref_clk_names[] = {
+	"Ref-A", "Ref-AA", "Ref-B", "Ref-BB",
+};
+
+static const char * const ad9545_in_clk_names[] = {
+	"Ref-A-Div", "Ref-AA-Div", "Ref-B-Div", "Ref-BB-Div",
+};
+
+static const char * const ad9545_out_clk_names[] = {
+	"Q0A-div", "Q0AA-div", "Q0B-div", "Q0BB-div", "Q0C-div", "Q0CC-div", "Q1A-div", "Q1AA-div",
+	"Q1B-div", "Q1BB-div",
+};
+
+static const char * const ad9545_pll_clk_names[] = {
+	"PLL0", "PLL1",
+};
+
+static const char * const ad9545_aux_nco_clk_names[] = {
+	"AUX_NCO0", "AUX_NCO1",
+};
+
+enum ad9545_ref_mode {
+	AD9545_SINGLE_ENDED = 0,
+	AD9545_DIFFERENTIAL,
+};
+
+enum ad9545_single_ended_config {
+	AD9545_AC_COUPLED_IF = 0,
+	AD9545_DC_COUPLED_1V2,
+	AD9545_DC_COUPLED_1V8,
+	AD9545_IN_PULL_UP,
+};
+
+enum ad9545_diferential_config {
+	AD9545_AC_COUPLED = 0,
+	AD9545_DC_COUPLED,
+	AD9545_DC_COUPLED_LVDS,
+};
+
+enum ad9545_output_mode {
+	AD9545_SINGLE_DIV_DIF = 0,
+	AD9545_SINGLE_DIV,
+	AD9545_DUAL_DIV,
+};
+
+struct ad9545_out_clk {
+	struct ad9545_state		*st;
+	bool				output_used;
+	bool				source_current;
+	enum ad9545_output_mode		output_mode;
+	u32				source_ua;
+	struct clk_hw			hw;
+	unsigned int			address;
+};
+
+struct ad9545_ppl_clk {
+	struct ad9545_state		*st;
+	bool				pll_used;
+	unsigned int			address;
+	unsigned int			loop_bw;
+	struct clk_hw			hw;
+	u8				tdc_source;
+};
+
+struct ad9545_ref_in_clk {
+	struct clk_hw			hw;
+	struct ad9545_state		*st;
+	u32				r_div_ratio;
+	bool				ref_used;
+	u32				d_tol_ppb;
+	u8				monitor_hyst_scale;
+	u32				valid_t_ms;
+	struct clk			*parent_clk;
+	unsigned int			address;
+	enum ad9545_ref_mode		mode;
+	unsigned int			freq_thresh_ps;
+	unsigned int			phase_thresh_ps;
+	union {
+		enum ad9545_single_ended_config		s_conf;
+		enum ad9545_diferential_config		d_conf;
+	};
+};
+
+struct ad9545_aux_nco_clk {
+	struct clk_hw			hw;
+	bool				nco_used;
+	struct ad9545_state		*st;
+	unsigned int			address;
+	unsigned int			freq_thresh_ps;
+	unsigned int			phase_thresh_ps;
+};
+
+struct ad9545_sys_clk {
+	bool				sys_clk_freq_doubler;
+	bool				sys_clk_crystal;
+	u32				ref_freq_hz;
+	u32				sys_freq_hz;
+};
+
+struct ad9545_state {
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct ad9545_sys_clk		sys_clk;
+	struct ad9545_ppl_clk		pll_clks[ARRAY_SIZE(ad9545_pll_clk_names)];
+	struct ad9545_ref_in_clk	ref_in_clks[ARRAY_SIZE(ad9545_ref_clk_names)];
+	struct ad9545_out_clk		out_clks[ARRAY_SIZE(ad9545_out_clk_names)];
+	struct ad9545_aux_nco_clk	aux_nco_clks[ARRAY_SIZE(ad9545_aux_nco_clk_names)];
+	struct clk			**clks[3];
+};
+
+#define to_ref_in_clk(_hw)	container_of(_hw, struct ad9545_ref_in_clk, hw)
+#define to_pll_clk(_hw)		container_of(_hw, struct ad9545_ppl_clk, hw)
+#define to_out_clk(_hw)		container_of(_hw, struct ad9545_out_clk, hw)
+#define to_nco_clk(_hw)		container_of(_hw, struct ad9545_aux_nco_clk, hw)
+
+static int ad9545_parse_dt_inputs(struct ad9545_state *st)
+{
+	struct fwnode_handle *fwnode;
+	struct fwnode_handle *child;
+	struct clk *clk;
+	bool prop_found;
+	int ref_ind;
+	u32 val;
+	int ret;
+	int i;
+
+	fwnode = dev_fwnode(st->dev);
+
+	prop_found = false;
+	fwnode_for_each_available_child_node(fwnode, child) {
+		if (!fwnode_property_present(child, "adi,r-divider-ratio"))
+			continue;
+
+		ret = fwnode_property_read_u32(child, "reg", &ref_ind);
+		if (ret < 0) {
+			dev_err(st->dev, "reg not specified in ref node.");
+			return ret;
+		}
+
+		if (ref_ind > 3)
+			return -EINVAL;
+
+		st->ref_in_clks[ref_ind].ref_used = true;
+		st->ref_in_clks[ref_ind].address = ref_ind;
+		st->ref_in_clks[ref_ind].st = st;
+
+		prop_found = fwnode_property_present(child, "adi,single-ended-mode");
+		if (prop_found) {
+			st->ref_in_clks[ref_ind].mode = AD9545_SINGLE_ENDED;
+			ret = fwnode_property_read_u32(child, "adi,single-ended-mode", &val);
+			if (ret < 0)
+				return ret;
+
+			st->ref_in_clks[ref_ind].s_conf = val;
+		} else {
+			st->ref_in_clks[ref_ind].mode = AD9545_DIFFERENTIAL;
+			ret = fwnode_property_read_u32(child, "adi,differential-mode", &val);
+			if (ret < 0)
+				return ret;
+
+			st->ref_in_clks[ref_ind].d_conf = val;
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,r-divider-ratio", &val);
+		if (!ret)
+			st->ref_in_clks[ref_ind].r_div_ratio = val;
+
+		ret = fwnode_property_read_u32(child, "adi,ref-dtol-pbb", &val);
+		if (ret < 0)
+			return ret;
+
+		st->ref_in_clks[ref_ind].d_tol_ppb = val;
+
+		ret = fwnode_property_read_u32(child, "adi,ref-monitor-hysteresis-pbb", &val);
+		if (ret < 0)
+			return ret;
+
+		for (i = 0; i < ARRAY_SIZE(ad9545_hyst_scales_bp); i++) {
+			if (ad9545_hyst_scales_bp[i] == val) {
+				st->ref_in_clks[ref_ind].monitor_hyst_scale = i;
+				break;
+			}
+		}
+
+		if (i == ARRAY_SIZE(ad9545_hyst_scales_bp))
+			return -EINVAL;
+
+		ret = fwnode_property_read_u32(child, "adi,ref-validation-timer-ms", &val);
+		if (ret < 0)
+			return ret;
+
+		st->ref_in_clks[ref_ind].valid_t_ms = val;
+
+		ret = fwnode_property_read_u32(child, "adi,freq-lock-threshold-ps", &val);
+		if (ret < 0)
+			return ret;
+
+		st->ref_in_clks[ref_ind].freq_thresh_ps = val;
+
+		ret = fwnode_property_read_u32(child, "adi,phase-lock-threshold-ps", &val);
+		if (ret < 0)
+			return ret;
+
+		st->ref_in_clks[ref_ind].phase_thresh_ps = val;
+
+		clk = devm_clk_get(st->dev, ad9545_ref_clk_names[ref_ind]);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+
+		st->ref_in_clks[ref_ind].parent_clk = clk;
+	}
+
+	return 0;
+}
+
+static int ad9545_parse_dt_plls(struct ad9545_state *st)
+{
+	struct fwnode_handle *fwnode;
+	struct fwnode_handle *child;
+	bool prop_found;
+	u32 val;
+	u32 addr;
+	int ret;
+
+	fwnode = dev_fwnode(st->dev);
+
+	prop_found = false;
+	fwnode_for_each_available_child_node(fwnode, child) {
+		if (!fwnode_property_present(child, "adi,pll-source"))
+			continue;
+
+		ret = fwnode_property_read_u32(child, "reg", &addr);
+		if (ret < 0)
+			return ret;
+
+		if (addr > 1)
+			return -EINVAL;
+
+		st->pll_clks[addr].pll_used = true;
+		st->pll_clks[addr].address = addr;
+
+		ret = fwnode_property_read_u32(child, "adi,pll-source", &val);
+		if (ret < 0)
+			return ret;
+
+		if (val > 5)
+			return -EINVAL;
+
+		st->pll_clks[addr].tdc_source = val;
+
+		ret = fwnode_property_read_u32(child, "adi,pll-loop-bandwidth-hz", &val);
+		if (ret < 0)
+			return ret;
+
+		st->pll_clks[addr].loop_bw = val;
+	}
+
+	return 0;
+}
+
+static int ad9545_parse_dt_outputs(struct ad9545_state *st)
+{
+	struct fwnode_handle *fwnode;
+	struct fwnode_handle *child;
+	bool prop_found;
+	int ref_ind;
+	u32 val;
+	int ret;
+
+	fwnode = dev_fwnode(st->dev);
+
+	prop_found = false;
+	fwnode_for_each_available_child_node(fwnode, child) {
+		if (!fwnode_property_present(child, "adi,output-mode"))
+			continue;
+
+		ret = fwnode_property_read_u32(child, "reg", &ref_ind);
+		if (ret < 0)
+			return ret;
+
+		if (ref_ind > 9)
+			return -EINVAL;
+
+		st->out_clks[ref_ind].output_used = true;
+		st->out_clks[ref_ind].address = ref_ind;
+
+		if (fwnode_property_present(child, "adi,current-source"))
+			st->out_clks[ref_ind].source_current = true;
+
+		ret = fwnode_property_read_u32(child, "adi,current-source-microamp", &val);
+		if (ret < 0)
+			return ret;
+
+		st->out_clks[ref_ind].source_ua = val;
+
+		ret = fwnode_property_read_u32(child, "adi,output-mode", &val);
+		if (ret < 0)
+			return ret;
+
+		st->out_clks[ref_ind].output_mode = val;
+	}
+
+	return 0;
+}
+
+static int ad9545_parse_dt_ncos(struct ad9545_state *st)
+{
+	struct fwnode_handle *fwnode;
+	struct fwnode_handle *child;
+	bool prop_found;
+	u32 val;
+	u32 addr;
+	int ret;
+
+	fwnode = dev_fwnode(st->dev);
+
+	prop_found = false;
+	fwnode_for_each_available_child_node(fwnode, child) {
+		if (!fwnode_property_present(child, "adi,freq-lock-threshold-ps") ||
+		    fwnode_property_present(child, "adi,ref-dtol-pbb"))
+			continue;
+
+		ret = fwnode_property_read_u32(child, "reg", &addr);
+		if (ret < 0)
+			return ret;
+
+		if (addr > 1)
+			return -EINVAL;
+
+		st->aux_nco_clks[addr].nco_used = true;
+		st->aux_nco_clks[addr].address = addr;
+		st->aux_nco_clks[addr].st = st;
+
+		ret = fwnode_property_read_u32(child, "adi,freq-lock-threshold-ps", &val);
+		if (ret < 0)
+			return ret;
+
+		st->aux_nco_clks[addr].freq_thresh_ps = val;
+
+		ret = fwnode_property_read_u32(child, "adi,phase-lock-threshold-ps", &val);
+		if (ret < 0)
+			return ret;
+
+		st->aux_nco_clks[addr].phase_thresh_ps = val;
+	}
+
+	return 0;
+}
+
+static int ad9545_parse_dt(struct ad9545_state *st)
+{
+	struct fwnode_handle *fwnode;
+	int ret;
+
+	fwnode = dev_fwnode(st->dev);
+
+	ret = fwnode_property_read_u32(fwnode, "adi,ref-frequency-hz", &st->sys_clk.ref_freq_hz);
+	if (ret < 0)
+		return ret;
+
+	st->sys_clk.sys_clk_crystal = fwnode_property_present(fwnode, "adi,ref-crystal");
+	st->sys_clk.sys_clk_freq_doubler = fwnode_property_present(fwnode, "adi,freq-doubler");
+
+	ret = ad9545_parse_dt_inputs(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_parse_dt_plls(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_parse_dt_outputs(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_parse_dt_ncos(st);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ad9545_check_id(struct ad9545_state *st)
+{
+	u32 chip_id;
+	u32 val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD9545_PRODUCT_ID_LOW, &val);
+	if (ret < 0)
+		return ret;
+
+	chip_id = val;
+	ret = regmap_read(st->regmap, AD9545_PRODUCT_ID_HIGH, &val);
+	if (ret < 0)
+		return ret;
+
+	chip_id += val << 8;
+	if (chip_id != AD9545_CHIP_ID) {
+		dev_err(st->dev, "Unrecognized CHIP_ID 0x%X\n", chip_id);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int ad9545_io_update(struct ad9545_state *st)
+{
+	return regmap_write(st->regmap, AD9545_IO_UPDATE, AD9545_UPDATE_REGS);
+}
+
+static int ad9545_sys_clk_setup(struct ad9545_state *st)
+{
+	u64 ref_freq_milihz;
+	__le64 regval64;
+	u8 div_ratio;
+	u32 fosc;
+	int ret;
+	u8 val;
+	u32 fs;
+	int i;
+
+	/*
+	 * System frequency must be between 2250 MHz and 2415 MHz.
+	 * fs = fosc * K / j
+	 * K - feedback divider ratio [4, 255]
+	 * j = 1/2 if frequency doubler is enabled
+	 */
+	fosc = DIV_ROUND_UP(st->sys_clk.ref_freq_hz, 1000000);
+
+	if (st->sys_clk.sys_clk_freq_doubler)
+		fosc *= 2;
+
+	div_ratio = 0;
+	for (i = 4; i < 256; i++) {
+		fs = i * fosc;
+
+		if (fs > 2250 && fs < 2415) {
+			div_ratio = i;
+			break;
+		}
+	}
+
+	if (!div_ratio) {
+		dev_err(st->dev, "No feedback divider ratio for sys clk PLL found.\n");
+		return -EINVAL;
+	}
+
+	st->sys_clk.sys_freq_hz = st->sys_clk.ref_freq_hz * div_ratio;
+	if (st->sys_clk.sys_clk_freq_doubler)
+		st->sys_clk.sys_freq_hz *= 2;
+
+	ret = regmap_write(st->regmap, AD9545_SYS_CLK_FB_DIV, div_ratio);
+	if (ret < 0)
+		return ret;
+
+	/* enable crystal maintaining amplifier */
+	val = 0;
+	if (st->sys_clk.sys_clk_crystal)
+		val |= BIT(3);
+
+	if (st->sys_clk.sys_clk_freq_doubler)
+		val |= BIT(0);
+
+	ret = regmap_write(st->regmap, AD9545_SYS_CLK_INPUT, val);
+	if (ret < 0)
+		return ret;
+
+	/* write reference frequency provided at XOA, XOB in milliherz */
+	ref_freq_milihz = mul_u32_u32(st->sys_clk.ref_freq_hz, 1000);
+	regval64 = cpu_to_le64(ref_freq_milihz);
+
+	ret = regmap_bulk_write(st->regmap, AD9545_SYS_CLK_REF_FREQ, &regval64, 5);
+	if (ret < 0)
+		return ret;
+
+	return regmap_write(st->regmap, AD9545_SYS_STABILITY_T, AD9545_SYS_CLK_STABILITY_MS);
+}
+
+static int ad9545_get_q_div(struct ad9545_state *st, int addr, u32 *q_div)
+{
+	__le32 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, AD9545_QX_DIV(addr), &regval, 4);
+	if (ret < 0)
+		return ret;
+
+	*q_div = le32_to_cpu(regval);
+
+	return 0;
+}
+
+static int ad9545_set_q_div(struct ad9545_state *st, int addr, u32 q_div)
+{
+	__le32 regval;
+	int ret;
+
+	regval = cpu_to_le32(q_div);
+	ret = regmap_bulk_write(st->regmap, AD9545_QX_DIV(addr), &regval, 4);
+	if (ret < 0)
+		return ret;
+
+	return ad9545_io_update(st);
+}
+
+static unsigned long ad9545_out_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct ad9545_out_clk *clk = to_out_clk(hw);
+	u32 qdiv;
+	int ret;
+
+	ret = ad9545_get_q_div(clk->st, clk->address, &qdiv);
+	if (ret < 0) {
+		dev_err(clk->st->dev, "Could not read Q div value.");
+		return 0;
+	}
+
+	return div_u64(parent_rate, qdiv);
+}
+
+static long ad9545_out_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *parent_rate)
+{
+	u32 out_rate;
+	u32 qdiv;
+
+	qdiv = div64_u64(*parent_rate, rate);
+	if (!qdiv)
+		out_rate = *parent_rate;
+	else
+		out_rate = div_u64(*parent_rate, qdiv);
+
+	return out_rate;
+}
+
+static int ad9545_out_clk_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
+{
+	struct ad9545_out_clk *clk = to_out_clk(hw);
+	u32 qdiv = div64_u64(parent_rate, rate);
+
+	if (!qdiv)
+		qdiv = 1;
+
+	return ad9545_set_q_div(clk->st, clk->address, qdiv);
+}
+
+static int ad9545_out_clk_set_phase(struct clk_hw *hw, int degrees)
+{
+	struct ad9545_out_clk *clk = to_out_clk(hw);
+	u64 phase_code;
+	u32 phase_conf;
+	__le64 regval;
+	u32 half_div;
+	u32 qdiv;
+	int ret;
+
+	ret = ad9545_get_q_div(clk->st, clk->address, &qdiv);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(clk->st->regmap, AD9545_QX_PHASE_CONF(clk->address), &phase_conf);
+	if (ret < 0)
+		return ret;
+
+	half_div = !!(phase_conf & AD9545_QX_HALF_DIV_MSK);
+
+	/* Qxy phase bitfield depends on the current Q div value */
+	phase_code = qdiv;
+	phase_code = div_u64((phase_code * 2 + half_div) * degrees, 360);
+
+	/* Qxy phase bitfield is 33 bits long, with last bit in PHASE_CONF reg */
+	regval = cpu_to_le64(phase_code & 0xFFFFFFFF);
+	ret = regmap_bulk_write(clk->st->regmap, AD9545_QX_PHASE(clk->address), &regval, 4);
+	if (ret < 0)
+		return ret;
+
+	if (phase_code > U32_MAX) {
+		ret = regmap_update_bits(clk->st->regmap, AD9545_QX_PHASE_CONF(clk->address),
+					 AD9545_QX_PHASE_32_MSK, AD9545_QX_PHASE_32_MSK);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ad9545_io_update(clk->st);
+}
+
+static int ad9545_out_clk_get_phase(struct clk_hw *hw)
+{
+	struct ad9545_out_clk *clk = to_out_clk(hw);
+	u64 input_edges_nr;
+	u64 phase_code;
+	__le32 regval;
+	u32 phase_conf;
+	u32 qdiv;
+	int ret;
+
+	ret = ad9545_get_q_div(clk->st, clk->address, &qdiv);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(clk->st->regmap, AD9545_QX_PHASE_CONF(clk->address), &phase_conf);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_bulk_read(clk->st->regmap, AD9545_QX_PHASE(clk->address), &regval, 4);
+	if (ret < 0)
+		return ret;
+
+	/* Qxy phase bitfield is 33 bits long, with last bit in PHASE_CONF reg */
+	phase_code = !!(phase_conf & AD9545_QX_PHASE_32_MSK);
+	phase_code = (phase_code >> 32) + cpu_to_le32(regval);
+
+	input_edges_nr = 2 * qdiv + !!(phase_conf & AD9545_QX_HALF_DIV_MSK);
+
+	/*
+	 * phase = 360 * (Qxy Phase / E) where:
+	 * E is the total number of input edges per output period of the Q-divider.
+	 */
+	return div64_u64(phase_code * 360, input_edges_nr);
+}
+
+static int ad9545_output_muting(struct ad9545_out_clk *clk, bool mute)
+{
+	u8 regval = 0;
+	int ret;
+	u8 mask;
+
+	if (clk->address % 2)
+		mask = AD9545_DIV_OPS_MUTE_AA_MSK;
+	else
+		mask = AD9545_DIV_OPS_MUTE_A_MSK;
+
+	if (mute)
+		regval = mask;
+
+	ret = regmap_update_bits(clk->st->regmap, AD9545_DIV_OPS_QX(clk->address), mask, regval);
+	if (ret < 0)
+		return ret;
+
+	return ad9545_io_update(clk->st);
+}
+
+static int ad9545_out_clk_enable(struct clk_hw *hw)
+{
+	struct ad9545_out_clk *clk = to_out_clk(hw);
+
+	return ad9545_output_muting(clk, false);
+}
+
+static void ad9545_out_clk_disable(struct clk_hw *hw)
+{
+	struct ad9545_out_clk *clk = to_out_clk(hw);
+
+	ad9545_output_muting(clk, true);
+}
+
+static int ad9545_out_clk_is_enabled(struct clk_hw *hw)
+{
+	struct ad9545_out_clk *clk = to_out_clk(hw);
+	u32 regval;
+	int ret;
+	u8 mask;
+
+	if (clk->address % 2)
+		mask = AD9545_DIV_OPS_MUTE_AA_MSK;
+	else
+		mask = AD9545_DIV_OPS_MUTE_A_MSK;
+
+	ret = regmap_read(clk->st->regmap, AD9545_DIV_OPS_QX(clk->address), &regval);
+	if (ret < 0)
+		return ret;
+
+	return !!(mask & regval);
+}
+
+static const struct clk_ops ad9545_out_clk_ops = {
+	.enable = ad9545_out_clk_enable,
+	.disable = ad9545_out_clk_disable,
+	.is_enabled = ad9545_out_clk_is_enabled,
+	.recalc_rate = ad9545_out_clk_recalc_rate,
+	.round_rate = ad9545_out_clk_round_rate,
+	.set_rate = ad9545_out_clk_set_rate,
+	.set_phase = ad9545_out_clk_set_phase,
+	.get_phase = ad9545_out_clk_get_phase,
+};
+
+static int ad9545_outputs_setup(struct ad9545_state *st)
+{
+	struct clk_init_data init[ARRAY_SIZE(ad9545_out_clk_names)] = {0};
+	int out_i;
+	u16 addr;
+	int ret;
+	u8 reg;
+	int i;
+	int j;
+
+	/* configure current sources */
+	for (i = 0; i < ARRAY_SIZE(ad9545_out_clk_names) / 2; i++) {
+		st->out_clks[i * 2].st = st;
+		st->out_clks[i * 2 + 1].st = st;
+
+		if (st->out_clks[i * 2].output_used)
+			out_i = i * 2;
+		else if (st->out_clks[i * 2 + 1].output_used)
+			out_i = i * 2 + 1;
+		else
+			continue;
+
+		reg = 0;
+		if (st->out_clks[out_i].source_current)
+			reg = 1;
+
+		for (j = 0; j < ARRAY_SIZE(ad9545_out_source_ua); j++)
+			if (ad9545_out_source_ua[j] == st->out_clks[out_i].source_ua)
+				reg |= FIELD_PREP(GENMASK(2, 1), i);
+
+		reg |= FIELD_PREP(GENMASK(4, 3), st->out_clks[out_i].output_mode);
+
+		if (i < 3)
+			addr = AD9545_DRIVER_0A_CONF + i;
+		else
+			addr = AD9545_DRIVER_1A_CONF + (i - 3);
+
+		ret = regmap_write(st->regmap, addr, reg);
+		if (ret < 0)
+			return ret;
+	}
+
+	st->clks[AD9545_CLK_OUT] = devm_kzalloc(st->dev, ARRAY_SIZE(ad9545_out_clk_names) *
+						sizeof(struct clk *), GFP_KERNEL);
+	if (!st->clks[AD9545_CLK_OUT])
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(ad9545_out_clk_names); i++) {
+		if (!st->out_clks[i].output_used)
+			continue;
+
+		init[i].name = ad9545_out_clk_names[i];
+		init[i].ops = &ad9545_out_clk_ops;
+
+		if (i > 5)
+			init[i].parent_names = &ad9545_pll_clk_names[1];
+		else
+			init[i].parent_names = &ad9545_pll_clk_names[0];
+
+		init[i].num_parents = 1;
+
+		st->out_clks[i].hw.init = &init[i];
+		ret = devm_clk_hw_register(st->dev, &st->out_clks[i].hw);
+		if (ret < 0)
+			return ret;
+
+		st->clks[AD9545_CLK_OUT][i] = st->out_clks[i].hw.clk;
+	}
+
+	/* set to autosync to trigger on DPLL freq lock */
+	for (i = 0; i < ARRAY_SIZE(st->pll_clks); i++) {
+		reg = FIELD_PREP(AD9545_SYNC_CTRL_MODE_MSK, 3);
+		ret = regmap_write(st->regmap, AD9545_SYNC_CTRLX(i), reg);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ad9545_io_update(st);
+}
+
+static int ad9545_set_r_div(struct ad9545_state *st, u32 div, int addr)
+{
+	int ret;
+	u8 reg;
+	int i;
+
+	if (div > AD9545_R_DIV_MAX)
+		return -EINVAL;
+
+	/* r-div ratios are mapped from 0 onward */
+	div -= 1;
+	for (i = 0; i < 4; i++) {
+		reg = (div >> (i * 8)) && 0xFF;
+
+		ret = regmap_write(st->regmap, AD9545_REF_X_RDIV(addr) + i, reg);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ad9545_io_update(st);
+}
+
+static int ad9545_get_r_div(struct ad9545_state *st, int addr, u32 *r_div)
+{
+	int ret;
+	u32 div;
+	u32 reg;
+	int i;
+
+	div = 0;
+	for (i = 0; i < 4; i++) {
+		ret = regmap_read(st->regmap, AD9545_REF_X_RDIV(addr) + i, &reg);
+		if (ret < 0)
+			return ret;
+
+		div += (reg << (i * 8));
+	}
+
+	/* r-div ratios are mapped from 0 onward */
+	*r_div = ++div;
+
+	return 0;
+}
+
+static unsigned long ad9545_in_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct ad9545_ref_in_clk *clk = to_ref_in_clk(hw);
+	u32 div;
+	int ret;
+
+	ret = ad9545_get_r_div(clk->st, clk->address, &div);
+	if (ret < 0) {
+		dev_err(clk->st->dev, "Could not read r div value.");
+		return 1;
+	}
+
+	return DIV_ROUND_CLOSEST(parent_rate, div);
+}
+
+static const struct clk_ops ad9545_in_clk_ops = {
+	.recalc_rate = ad9545_in_clk_recalc_rate,
+};
+
+static int ad9545_input_refs_setup(struct ad9545_state *st)
+{
+	struct clk_init_data init[4] = {0};
+	__le32 regval;
+	__le64 regval64;
+	u64 period_es;
+	int ret;
+	u32 val;
+	u8 reg;
+	int i;
+
+	/* configure input references */
+	for (i = 0; i < ARRAY_SIZE(st->ref_in_clks); i += 2) {
+		if (st->ref_in_clks[i].mode == AD9545_DIFFERENTIAL) {
+			reg = BIT(0);
+			reg |= FIELD_PREP(AD9545_REF_CTRL_DIF_MSK, st->ref_in_clks[i].d_conf);
+		} else {
+			reg = 0;
+			reg |= FIELD_PREP(AD9545_REF_CTRL_REFA_MSK, st->ref_in_clks[i].s_conf);
+			reg |= FIELD_PREP(AD9545_REF_CTRL_REFAA_MSK, st->ref_in_clks[i + 1].s_conf);
+		}
+
+		ret = regmap_write(st->regmap, AD9545_REF_A_CTRL + i * 2, reg);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* configure refs r dividers */
+	for (i = 0; i < ARRAY_SIZE(st->ref_in_clks); i++) {
+		ret = ad9545_set_r_div(st, st->ref_in_clks[i].r_div_ratio, i);
+		if (ret < 0)
+			return ret;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(st->ref_in_clks); i++) {
+		if (!st->ref_in_clks[i].ref_used)
+			continue;
+
+		/* write nominal period in attoseconds */
+		period_es = 1000000000000000000ULL;
+		val = clk_get_rate(st->ref_in_clks[i].parent_clk);
+		if (!val)
+			return -EINVAL;
+
+		period_es = div_u64(period_es, val);
+
+		regval = cpu_to_le32(st->ref_in_clks[i].d_tol_ppb);
+		ret = regmap_bulk_write(st->regmap, AD9545_REF_X_OFFSET_LIMIT(i),
+					&regval, 3);
+		if (ret < 0)
+			return ret;
+
+		regval64 = cpu_to_le64(period_es);
+		ret = regmap_bulk_write(st->regmap, AD9545_REF_X_PERIOD(i), &regval64, 8);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD9545_REF_X_MONITOR_HYST(i),
+				   st->ref_in_clks[i].monitor_hyst_scale);
+		if (ret < 0)
+			return ret;
+
+		regval = cpu_to_le32(st->ref_in_clks[i].freq_thresh_ps);
+		ret = regmap_bulk_write(st->regmap, AD9545_SOURCEX_FREQ_THRESH(i),
+					&regval, 3);
+		if (ret < 0)
+			return ret;
+
+		regval = cpu_to_le32(st->ref_in_clks[i].phase_thresh_ps);
+		ret = regmap_bulk_write(st->regmap, AD9545_SOURCEX_PHASE_THRESH(i),
+					&regval, 3);
+		if (ret < 0)
+			return ret;
+
+		init[i].name = ad9545_in_clk_names[i];
+		init[i].ops = &ad9545_in_clk_ops;
+		init[i].parent_names = &ad9545_ref_clk_names[i];
+		init[i].num_parents = 1;
+
+		st->ref_in_clks[i].hw.init = &init[i];
+		ret = devm_clk_hw_register(st->dev, &st->ref_in_clks[i].hw);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* disable unused references */
+	reg = 0;
+	for (i = 0; i < ARRAY_SIZE(st->ref_in_clks); i++) {
+		if (!st->ref_in_clks[i].ref_used)
+			reg |= (1 << i);
+	}
+
+	return regmap_write(st->regmap, AD9545_POWER_DOWN_REF, reg);
+}
+
+static int ad9545_set_freerun_freq(struct ad9545_ppl_clk *clk, u32 freq)
+{
+	__le64 regval;
+	u64 ftw = 1;
+	u32 ftw_frac;
+	u32 ftw_int;
+	int ret;
+
+	/*
+	 * In case of unlock event the DPLL will go in open-loop mode and output
+	 * the freq given by the freerun tuning word.
+	 * DPLLx Freerun TW = (2 ^ 48) × (f NCO /f System )
+	 */
+	ftw = mul_u64_u32_div(ftw << 48, freq, clk->st->sys_clk.sys_freq_hz);
+
+	/*
+	 * Check if FTW is valid:
+	 * (2 ^ 48) / FTW = INT.FRAC where:
+	 * 7 ≤ INT ≤ 13 and 0.05 ≤ FRAC ≤ 0.95
+	 */
+	ftw_int = div64_u64(1ULL << 48, ftw);
+	if (ftw_int < 7 || ftw_int > 13)
+		return -EINVAL;
+
+	div_u64_rem(div64_u64(100 * (1ULL << 48), ftw), 100, &ftw_frac);
+	if (ftw_frac < 5 || ftw_frac > 95)
+		return -EINVAL;
+
+	regval = cpu_to_le64(ftw);
+	ret = regmap_bulk_write(clk->st->regmap, AD9545_DPLLX_FTW(clk->address), &regval, 6);
+	if (ret < 0)
+		return ret;
+
+	return ad9545_io_update(clk->st);
+}
+
+static u64 ad9545_calc_pll_params(struct ad9545_ppl_clk *clk, unsigned long rate,
+				  unsigned long parent_rate, u32 *m, u32 *n,
+				  unsigned long *frac, unsigned long *mod)
+{
+	u32 min_dpll_n_div;
+	u64 output_rate;
+	u32 dpll_n_div;
+	u32 m_div;
+	u64 den;
+	u64 num;
+
+	/* half divider at output requires APLL to generate twice the frequency demanded */
+	rate *= 2;
+
+	/*
+	 * PFD of APLL has input frequency limits in 162 - 350 Mghz range.
+	 * Use APLL to upconvert this freq to Ghz range.
+	 */
+	m_div = div_u64(rate, ad9545_apll_pfd_rate_ranges_hz[0] / 2 +
+			ad9545_apll_pfd_rate_ranges_hz[1] / 2);
+	m_div = clamp_t(u8, m_div, AD9545_APLL_M_DIV_MIN, AD9545_APLL_M_DIV_MAX);
+
+	/*
+	 * If N + FRAC / MOD = rate / (m_div * parent_rate)
+	 * and N = [rate / (m_div * past_rate)]:
+	 * We get: FRAC/MOD = (rate / (m_div * parent_rate)) - N
+	 */
+	dpll_n_div = div64_u64(rate, parent_rate * m_div);
+
+	/*
+	 * APLL has to be able to satisfy output freq bounds
+	 * thus output of DPLL has a lower bound
+	 */
+	min_dpll_n_div = div_u64(ad9545_apll_rate_ranges_hz[clk->address][0],
+				 AD9545_APLL_M_DIV_MAX * parent_rate);
+	dpll_n_div = clamp_t(u32, dpll_n_div, min_dpll_n_div, AD9545_DPLL_MAX_N);
+
+	num = rate - (dpll_n_div * m_div * parent_rate);
+	den = m_div * parent_rate;
+
+	rational_best_approximation(num, den, AD9545_DPLL_MAX_FRAC, AD9545_DPLL_MAX_MOD, frac, mod);
+	*m = m_div;
+	*n = dpll_n_div;
+
+	output_rate = mul_u64_u32_div(*frac * parent_rate, m_div, *mod);
+	output_rate += parent_rate * dpll_n_div * m_div;
+
+	return (u32)DIV_ROUND_CLOSEST(output_rate, 2);
+}
+
+static unsigned long ad9545_pll_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct ad9545_ppl_clk *clk = to_pll_clk(hw);
+	unsigned long output_rate;
+	__le32 regval;
+	u32 frac;
+	u32 mod;
+	int ret;
+	u32 m;
+	u32 n;
+
+	ret = regmap_bulk_read(clk->st->regmap, AD9545_DPLLX_N_DIV(clk->address), &regval, 4);
+	if (ret < 0)
+		return ret;
+
+	n = le32_to_cpu(regval) + 1;
+
+	m = 0;
+	ret = regmap_read(clk->st->regmap, AD9545_APLLX_M_DIV(clk->address), &m);
+	if (ret < 0)
+		return ret;
+
+	regval = 0;
+	ret = regmap_bulk_read(clk->st->regmap, AD9545_DPLLX_FRAC_DIV(clk->address), &regval, 3);
+	if (ret < 0)
+		return ret;
+
+	frac = le32_to_cpu(regval);
+
+	regval = 0;
+	ret = regmap_bulk_read(clk->st->regmap, AD9545_DPLLX_MOD_DIV(clk->address), &regval, 3);
+	if (ret < 0)
+		return ret;
+
+	mod = le32_to_cpu(regval);
+
+	/* Output rate of APLL = parent_rate * (N + (Frac / Mod)) * M */
+	output_rate = mul_u64_u32_div(frac * parent_rate, m, mod);
+	output_rate += parent_rate * n * m;
+
+	return output_rate / 2;
+}
+
+static long ad9545_pll_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *parent_rate)
+{
+	struct ad9545_ppl_clk *clk = to_pll_clk(hw);
+	unsigned long frac;
+	unsigned long mod;
+	u32 m;
+	u32 n;
+
+	return ad9545_calc_pll_params(clk, rate, *parent_rate, &m, &n, &frac, &mod);
+}
+
+static int ad9545_pll_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
+{
+	struct ad9545_ppl_clk *clk = to_pll_clk(hw);
+	unsigned long out_rate;
+	unsigned long frac;
+	unsigned long mod;
+	__le32 regval;
+	int ret;
+	u32 m;
+	u32 n;
+
+	out_rate = ad9545_calc_pll_params(clk, rate, parent_rate, &m, &n, &frac, &mod);
+	if (out_rate != rate)
+		return -EINVAL;
+
+	regval = cpu_to_le32(n - 1);
+	ret = regmap_bulk_write(clk->st->regmap, AD9545_DPLLX_N_DIV(clk->address), &regval, 4);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(clk->st->regmap, AD9545_APLLX_M_DIV(clk->address), m);
+	if (ret < 0)
+		return ret;
+
+	regval = cpu_to_le32(frac);
+	ret = regmap_bulk_write(clk->st->regmap, AD9545_DPLLX_FRAC_DIV(clk->address), &regval, 3);
+	if (ret < 0)
+		return ret;
+
+	regval = cpu_to_le32(mod);
+	ret = regmap_bulk_write(clk->st->regmap, AD9545_DPLLX_MOD_DIV(clk->address), &regval, 3);
+	if (ret < 0)
+		return ret;
+
+	return ad9545_set_freerun_freq(clk, div_u64(rate * 2, m));
+}
+
+static const struct clk_ops ad9545_pll_clk_ops = {
+	.recalc_rate = ad9545_pll_clk_recalc_rate,
+	.round_rate = ad9545_pll_clk_round_rate,
+	.set_rate = ad9545_pll_set_rate,
+};
+
+static int ad9545_plls_setup(struct ad9545_state *st)
+{
+	struct clk_init_data init[2] = {0};
+	struct ad9545_ppl_clk *pll;
+	__le32 regval;
+	int ret;
+	u8 reg;
+	int i;
+
+	st->clks[AD9545_CLK_PLL] = devm_kzalloc(st->dev, ARRAY_SIZE(ad9545_pll_clk_names) *
+						sizeof(struct clk *), GFP_KERNEL);
+	if (!st->clks[AD9545_CLK_PLL])
+		return -ENOMEM;
+
+	for (i = 0; i < 2; i++) {
+		pll = &st->pll_clks[i];
+		if (!pll->pll_used)
+			continue;
+
+		/* enable pll profile */
+		ret = regmap_write(st->regmap, AD9545_DPLLX_EN(i), 1);
+		if (ret < 0)
+			return ret;
+
+		/* set TDC source */
+		reg = ad9545_tdc_source_mapping[pll->tdc_source];
+		ret = regmap_write(st->regmap, AD9545_DPLLX_SOURCE(i), reg);
+		if (ret < 0)
+			return ret;
+
+		/* write loop bandwidth in microhertz */
+		regval = cpu_to_le32(pll->loop_bw * 1000000);
+		ret = regmap_bulk_write(st->regmap, AD9545_DPLLX_LOOP_BW(i), &regval, 4);
+		if (ret < 0)
+			return ret;
+
+		pll->st = st;
+		pll->address = i;
+
+		init[i].name = ad9545_pll_clk_names[i];
+		init[i].ops = &ad9545_pll_clk_ops;
+		if (pll->tdc_source > 3)
+			init[i].parent_names = &ad9545_aux_nco_clk_names[pll->tdc_source - 4];
+		else
+			init[i].parent_names = &ad9545_in_clk_names[pll->tdc_source];
+
+		init[i].num_parents = 1;
+
+		pll->hw.init = &init[i];
+		ret = devm_clk_hw_register(st->dev, &pll->hw);
+		if (ret < 0)
+			return ret;
+
+		st->clks[AD9545_CLK_PLL][i] = pll->hw.clk;
+	}
+
+	return 0;
+}
+
+static int ad9545_get_nco_freq(struct ad9545_state *st, int addr, u32 *freq)
+{
+	__le16 regval;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, AD9545_NCOX_FREQ(addr), &regval, 2);
+	if (ret < 0)
+		return ret;
+
+	*freq = le16_to_cpu(regval);
+	return 0;
+}
+
+static int ad9545_set_nco_freq(struct ad9545_state *st, int addr, u32 freq)
+{
+	__le32 regval;
+	int ret;
+
+	regval = cpu_to_le32(freq);
+	ret = regmap_bulk_write(st->regmap, AD9545_NCOX_FREQ(addr), &regval, 2);
+	if (ret < 0)
+		return ret;
+
+	return ad9545_io_update(st);
+}
+
+static unsigned long ad9545_nco_clk_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
+{
+	struct ad9545_aux_nco_clk *clk = to_nco_clk(hw);
+	u32 rate;
+	int ret;
+
+	ret = ad9545_get_nco_freq(clk->st, clk->address, &rate);
+	if (ret < 0) {
+		dev_err(clk->st->dev, "Could not read NCO freq.");
+		return 0;
+	}
+
+	return rate;
+}
+
+static long ad9545_nco_clk_round_rate(struct clk_hw *hw, unsigned long rate,
+				      unsigned long *parent_rate)
+{
+	return clamp_t(u16, rate, 1, AD9545_NCO_MAX_FREQ);
+}
+
+static int ad9545_nco_clk_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long parent_rate)
+{
+	struct ad9545_aux_nco_clk *clk = to_nco_clk(hw);
+
+	return ad9545_set_nco_freq(clk->st, clk->address, rate);
+}
+
+static const struct clk_ops ad9545_nco_clk_ops = {
+	.recalc_rate = ad9545_nco_clk_recalc_rate,
+	.round_rate = ad9545_nco_clk_round_rate,
+	.set_rate = ad9545_nco_clk_set_rate,
+};
+
+static int ad9545_aux_ncos_setup(struct ad9545_state *st)
+{
+	struct clk_init_data init[2] = {0};
+	struct ad9545_aux_nco_clk *nco;
+	__le32 regval;
+	int ret;
+	int i;
+
+	st->clks[AD9545_CLK_NCO] = devm_kzalloc(st->dev, ARRAY_SIZE(ad9545_aux_nco_clk_names) *
+						sizeof(struct clk *), GFP_KERNEL);
+	if (!st->clks[AD9545_CLK_NCO])
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(st->aux_nco_clks); i++) {
+		nco = &st->aux_nco_clks[i];
+		if (!nco->nco_used)
+			continue;
+
+		regval = cpu_to_le32(nco->freq_thresh_ps);
+		ret = regmap_bulk_write(st->regmap, AD9545_NCOX_FREQ_THRESH(i), &regval, 3);
+		if (ret < 0)
+			return ret;
+
+		regval = cpu_to_le32(nco->phase_thresh_ps);
+		ret = regmap_bulk_write(st->regmap, AD9545_NCOX_PHASE_THRESH(i), &regval, 3);
+		if (ret < 0)
+			return ret;
+
+		init[i].name = ad9545_aux_nco_clk_names[i];
+		init[i].ops = &ad9545_nco_clk_ops;
+
+		nco->hw.init = &init[i];
+		ret = devm_clk_hw_register(st->dev, &nco->hw);
+		if (ret < 0)
+			return ret;
+
+		st->clks[AD9545_CLK_NCO][i] = nco->hw.clk;
+	}
+
+	return 0;
+}
+
+static int ad9545_calib_system_clock(struct ad9545_state *st)
+{
+	int ret;
+	u32 reg;
+	int i;
+	int j;
+
+	for (i = 0; i < 2; i++) {
+		for (j = 0; j < ARRAY_SIZE(ad9545_vco_calibration_op); j++) {
+			ret = regmap_write(st->regmap, ad9545_vco_calibration_op[j][0],
+					   ad9545_vco_calibration_op[j][1]);
+			if (ret < 0)
+				return ret;
+		}
+
+		/* wait for sys pll to lock and become stable */
+		msleep(50 + AD9545_SYS_CLK_STABILITY_MS);
+
+		ret = regmap_read(st->regmap, AD9545_PLL_STATUS, &reg);
+		if (ret < 0)
+			return ret;
+
+		if (AD9545_SYS_PLL_STABLE(reg)) {
+			ret = regmap_write(st->regmap, AD9545_CALIB_CLK, 0);
+			if (ret < 0)
+				return ret;
+
+			return ad9545_io_update(st);
+		}
+	}
+
+	dev_err(st->dev, "System PLL unlocked.\n");
+	return -EIO;
+}
+
+static int ad9545_calib_apll(struct ad9545_state *st, int i)
+{
+	int cal_count;
+	u32 reg;
+	int ret;
+
+	/* APLL VCO calibration operation */
+	cal_count = 0;
+	while (cal_count < 2) {
+		ret = regmap_write(st->regmap, AD9545_PWR_CALIB_CHX(i), 0);
+		if (ret < 0)
+			return ret;
+
+		ret = ad9545_io_update(st);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD9545_PWR_CALIB_CHX(i),
+				   AD9545_CALIB_APLL);
+		if (ret < 0)
+			return ret;
+
+		ret = ad9545_io_update(st);
+		if (ret < 0)
+			return ret;
+
+		cal_count += 1;
+		msleep(100);
+
+		ret = regmap_read(st->regmap, AD9545_PLLX_STATUS(i), &reg);
+		if (ret < 0)
+			return ret;
+
+		if (AD9545_APLL_LOCKED(reg)) {
+			ret = regmap_write(st->regmap, AD9545_PWR_CALIB_CHX(i), 0);
+			if (ret < 0)
+				return ret;
+
+			ret = ad9545_io_update(st);
+			if (ret < 0)
+				return ret;
+
+			cal_count = 2;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int ad9545_calib_aplls(struct ad9545_state *st)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ad9545_pll_clk_names); i++) {
+		if (!st->pll_clks[i].pll_used)
+			continue;
+
+		ret = ad9545_calib_apll(st, i);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct clk *ad9545_clk_src_twocell_get(struct of_phandle_args *clkspec, void *data)
+{
+	unsigned int clk_address = clkspec->args[1];
+	unsigned int clk_type = clkspec->args[0];
+	struct clk ***clks = data;
+
+	if (clk_type > AD9545_CLK_NCO) {
+		pr_err("%s: invalid clock type %u\n", __func__, clk_type);
+		return ERR_PTR(-EINVAL);
+	}
+	if ((clk_type == AD9545_CLK_PLL && clk_address > AD9545_PLL1) ||
+	    (clk_type == AD9545_CLK_OUT && clk_address > AD9545_Q1BB) ||
+	    (clk_type == AD9545_CLK_NCO && clk_address > AD9545_NCO1)) {
+		pr_err("%s: invalid clock address %u\n", __func__, clk_address);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clks[clk_type][clk_address];
+}
+
+static int ad9545_setup(struct ad9545_state *st)
+{
+	int ret;
+	u32 val;
+	int i;
+
+	ret = regmap_update_bits(st->regmap, AD9545_CONFIG_0, AD9545_RESET_REGS, AD9545_RESET_REGS);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_sys_clk_setup(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_input_refs_setup(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_aux_ncos_setup(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_calib_system_clock(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_calib_aplls(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_io_update(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_plls_setup(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_outputs_setup(st);
+	if (ret < 0)
+		return ret;
+
+	ret = of_clk_add_provider(st->dev->of_node, ad9545_clk_src_twocell_get,
+				  &st->clks[AD9545_CLK_OUT]);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_calib_aplls(st);
+	if (ret < 0)
+		return ret;
+
+	/* check locks */
+	ret = regmap_read(st->regmap, AD9545_PLL_STATUS, &val);
+	for (i = 0; i < ARRAY_SIZE(st->pll_clks); i++)
+		if (st->pll_clks[i].pll_used && !AD9545_PLLX_LOCK(i, val))
+			dev_warn(st->dev, "PLL%d unlocked.\n", i);
+
+	return 0;
+}
+
+int ad9545_probe(struct device *dev, struct regmap *regmap)
+{
+	struct ad9545_state *st;
+	int ret;
+
+	st = devm_kzalloc(dev, sizeof(struct ad9545_state), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->dev = dev;
+	st->regmap = regmap;
+
+	ret = ad9545_check_id(st);
+	if (ret < 0)
+		return ret;
+
+	ret = ad9545_parse_dt(st);
+	if (ret < 0)
+		return ret;
+
+	return ad9545_setup(st);
+}
+EXPORT_SYMBOL_GPL(ad9545_probe);
+
+MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD9545");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/clk/adi/clk-ad9545.h b/drivers/clk/adi/clk-ad9545.h
new file mode 100644
index 000000000000..641acabe9c8e
--- /dev/null
+++ b/drivers/clk/adi/clk-ad9545.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * AD9545 Network Clock Generator/Synchronizer
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#ifndef _CLK_AD9545_H_
+#define _CLK_AD9545_H_
+
+struct device;
+struct regmap;
+
+int ad9545_probe(struct device *dev, struct regmap *regmap);
+
+#endif /* _CLK_AD9545_H_ */
diff --git a/include/dt-bindings/clock/ad9545.h b/include/dt-bindings/clock/ad9545.h
new file mode 100644
index 000000000000..8b45e1b45249
--- /dev/null
+++ b/include/dt-bindings/clock/ad9545.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * AD9545 Network Clock Generator/Synchronizer
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#ifndef _DT_BINDINGS_CLOCK_AD9545_H_
+#define _DT_BINDINGS_CLOCK_AD9545_H_
+
+/* Input Driver Mode
+ * Use for adi,single-ended-mode:
+ */
+#define DRIVER_MODE_AC_COUPLED_IF	0
+#define DRIVER_MODE_DC_COUPLED_1V2	1
+#define DRIVER_MODE_DC_COUPLED_1V8	2
+#define DRIVER_MODE_IN_PULL_UP		3
+
+/* Input Driver Mode
+ * Use for adi,differential-mode:
+ */
+#define DRIVER_MODE_AC_COUPLED		0
+#define DRIVER_MODE_DC_COUPLED		1
+#define DRIVER_MODE_DC_COUPLED_LVDS	2
+
+/* Output Driver Mode
+ * Use for adi,output-mode:
+ */
+#define DRIVER_MODE_SINGLE_DIV_DIF	0
+#define DRIVER_MODE_SINGLE_DIV		1
+#define DRIVER_MODE_DUAL_DIV		2
+
+/* Clock types */
+#define AD9545_CLK_OUT			0
+#define AD9545_CLK_PLL			1
+#define AD9545_CLK_NCO			2
+
+/* PLL addresses */
+#define AD9545_PLL0			0
+#define AD9545_PLL1			1
+
+/* Outputs addresses */
+#define AD9545_Q0A			0
+#define AD9545_Q0AA			1
+#define AD9545_Q0B			2
+#define AD9545_Q0BB			3
+#define AD9545_Q0C			4
+#define AD9545_Q0CC			5
+#define AD9545_Q1A			6
+#define AD9545_Q1AA			7
+#define AD9545_Q1B			8
+#define AD9545_Q1BB			9
+
+/* NCO addresses */
+#define AD9545_NCO0			0
+#define AD9545_NCO1			1
+
+/* Ex:
+ * Output Q0C clock: <&ad9545_clock AD9545_CLK_OUT AD9545_Q0C>;
+ * PLL0 clock: <&ad9545_clock AD9545_CLK_PLL AD9545_PLL0>;
+ * NCO1 clock: <&ad9545_clock AD9545_CLK_NCO AD9545_NCO1>;
+ */
+
+#endif /* _DT_BINDINGS_CLOCK_AD9545_H_ */
-- 
2.20.1

