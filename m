Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7414423B569
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgHDHJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 03:09:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:34082 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbgHDHJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:09:17 -0400
IronPort-SDR: ViY2Pzia8poEEv07no8uYH7HlvYcqhuBw16ysfrUcU+tgwisXrrXXpIrK8saitH0HIDTwDOU/N
 dnowwKIv26tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="152228329"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="152228329"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 00:09:13 -0700
IronPort-SDR: FIT4y+ixAKT/Xp6QDJHQJWoFonJjY2zWG4JdLxsCX6gV3OOrSQpn6K7xKnGT+0v6Lfw2dYiDTU
 MZuIVWWrnqvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="315226208"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2020 00:09:08 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
Subject: [PATCH v3 4/4] fpga: dfl: add support for N3000 nios private feature
Date:   Tue,  4 Aug 2020 15:05:15 +0800
Message-Id: <1596524715-18038-5-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
References: <1596524715-18038-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the nios handshake private feature on Intel
N3000 FPGA Card. This private feature provides a handshake interface to
FPGA NIOS firmware, which receives retimer configuration command from host
and executes via an internal SPI master. When nios finished the
configuration, host takes over the ownership of the SPI master to control
an Intel MAX10 BMC Chip on the SPI bus.

For NIOS firmware handshake part, this driver requests the retimer
configuration for NIOS with parameters from module param, and adds some
sysfs nodes for user to query NIOS state.

For SPI part, this driver adds a spi-altera platform device as well as
the MAX10 BMC spi slave info. A spi-altera driver will be matched to
handle following the SPI work.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v3: Add the doc for this driver.
    Minor fixes for comments from Tom.
---
 .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  18 +
 Documentation/fpga/dfl-n3000-nios.rst              |  39 ++
 Documentation/fpga/index.rst                       |   1 +
 drivers/fpga/Kconfig                               |  12 +
 drivers/fpga/Makefile                              |   2 +
 drivers/fpga/dfl-n3000-nios.c                      | 518 +++++++++++++++++++++
 6 files changed, 590 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
 create mode 100644 Documentation/fpga/dfl-n3000-nios.rst
 create mode 100644 drivers/fpga/dfl-n3000-nios.c

diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
new file mode 100644
index 0000000..fcfcdbd
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
@@ -0,0 +1,18 @@
+What:		/sys/bus/dfl/devices/dfl-fme.X.X/fec_mode
+Date:		July 2020
+KernelVersion:	5.9
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. It returns the FEC mode of the ethernet retimer
+		configured by NIOS firmware. "rs" for RS FEC mode, "kr" for
+		KR FEC mode, "no" FOR NO FEC mode. The FEC mode could be set
+		by module parameters, but it could only be set once after the
+		board powers up.
+		Format: string
+
+What:		/sys/bus/dfl/devices/dfl-fme.X.X/nios_fw_version
+Date:		July 2020
+KernelVersion:	5.9
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read-only. It returns the NIOS firmware version in FPGA. Its
+		format is "major.minor.patch".
+		Format: %x.%x.%x
diff --git a/Documentation/fpga/dfl-n3000-nios.rst b/Documentation/fpga/dfl-n3000-nios.rst
new file mode 100644
index 0000000..391528e
--- /dev/null
+++ b/Documentation/fpga/dfl-n3000-nios.rst
@@ -0,0 +1,39 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+DFL N3000 Nios Private Feature Driver
+=====================================
+
+The dfl n3000 nios driver supports for the nios handshake private feature on
+Intel N3000 FPGA Card.
+
+This private feature provides a handshake interface to FPGA NIOS firmware,
+which receives the ethernet retimer configuration command from host and
+do the configuration via an internal SPI master. When nios finished the
+configuration, host takes over the ownership of the SPI master to control an
+Intel MAX10 BMC Chip on the SPI bus.
+
+So the driver does 2 major tasks on probe, requires NIOS firmware to configure
+the ethernet retimer by operating the handshake interfaces, and then creates a
+spi master platform device with the MAX10 device info in spi_board_info.
+
+Module Parameters
+=================
+
+The dfl n3000 nios driver supports the following module parameters:
+
+* fec_mode: string
+  Require the NIOS firmware to set the FEC mode of the ethernet retimer on
+  the PAC N3000 FPGA card. The possible values could be:
+
+  - "rs": RS FEC mode (default)
+  - "kr": KR FEC mode
+  - "no": NO FEC mode
+
+  The configuration could only be set once after the board powers up, the
+  firmware will not accept a second configuration afterward. So the fec mode
+  will not be changed if the module is reloaded with a different param value.
+
+  The configured value of the fec mode could be queried from sysfs node:
+
+  /sys/bus/dfl/devices/dfl-fme.X.X/fec_mode
diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
index f80f956..5fd3c37 100644
--- a/Documentation/fpga/index.rst
+++ b/Documentation/fpga/index.rst
@@ -8,6 +8,7 @@ fpga
     :maxdepth: 1
 
     dfl
+    dfl-n3000-nios
 
 .. only::  subproject and html
 
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 7cd5a29..f820142 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -191,6 +191,18 @@ config FPGA_DFL_AFU
 	  to the FPGA infrastructure via a Port. There may be more than one
 	  Port/AFU per DFL based FPGA device.
 
+config FPGA_DFL_N3000_NIOS
+        tristate "FPGA DFL N3000 NIOS Driver"
+        depends on FPGA_DFL
+        select REGMAP
+        help
+	  This is the driver for the nios handshake private feature on Intel
+	  N3000 FPGA Card. This private feature provides a handshake interface
+	  to FPGA NIOS firmware, which receives retimer configuration command
+	  from host and executes via an internal SPI master. When nios finished
+	  the configuration, host takes over the ownership of the SPI master to
+	  control an Intel MAX10 BMC Chip on the SPI bus.
+
 config FPGA_DFL_PCI
 	tristate "FPGA DFL PCIe Device Driver"
 	depends on PCI && FPGA_DFL
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index d8e21df..27f20f2 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -44,5 +44,7 @@ dfl-fme-objs += dfl-fme-perf.o
 dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o
 dfl-afu-objs += dfl-afu-error.o
 
+obj-$(CONFIG_FPGA_DFL_N3000_NIOS)      += dfl-n3000-nios.o
+
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
diff --git a/drivers/fpga/dfl-n3000-nios.c b/drivers/fpga/dfl-n3000-nios.c
new file mode 100644
index 0000000..041d759
--- /dev/null
+++ b/drivers/fpga/dfl-n3000-nios.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for DFL N3000 NIOS private feature
+ *
+ * Copyright (C) 2019-2020 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Wu Hao <hao.wu@intel.com>
+ *   Xu Yilun <yilun.xu@intel.com>
+ */
+#include <linux/bitfield.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/stddef.h>
+#include <linux/spi/altera.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#include "dfl.h"
+
+/**
+ * DOC: fec_mode (string)
+ *
+ * Require the NIOS firmware to set the FEC mode of the ethernet retimer on
+ * PAC N3000 FPGA card.
+ *
+ * "rs": RS FEC mode (default)
+ *
+ * "kr": KR FEC mode
+ *
+ * "no": NO FEC mode
+ *
+ * The configuration could only be set once after the board powers up, the
+ * firmware will not accept a second configuration afterward. So the fec mode
+ * will not be changed if the module is reloaded with a different param value.
+ *
+ * The configured value of the fec_mode could be queried from sysfs node:
+ *
+ * /sys/bus/dfl/devices/dfl-fme.X.X/fec_mode
+ */
+static char *fec_mode = "rs";
+module_param(fec_mode, charp, 0444);
+MODULE_PARM_DESC(child, "FEC mode");
+
+/* N3000 NIOS private feature registers */
+#define NIOS_SPI_PARAM			0x8
+#define PARAM_SHIFT_MODE_MSK		BIT_ULL(1)
+#define PARAM_SHIFT_MODE_MSB		0
+#define PARAM_SHIFT_MODE_LSB		1
+#define PARAM_DATA_WIDTH		GENMASK_ULL(7, 2)
+#define PARAM_NUM_CS			GENMASK_ULL(13, 8)
+#define PARAM_CLK_POL			BIT_ULL(14)
+#define PARAM_CLK_PHASE			BIT_ULL(15)
+#define PARAM_PERIPHERAL_ID		GENMASK_ULL(47, 32)
+
+#define NIOS_SPI_CTRL			0x10
+#define CTRL_WR_DATA			GENMASK_ULL(31, 0)
+#define CTRL_ADDR			GENMASK_ULL(44, 32)
+#define CTRL_CMD_MSK			GENMASK_ULL(63, 62)
+#define CTRL_CMD_NOP			0
+#define CTRL_CMD_RD			1
+#define CTRL_CMD_WR			2
+
+#define NIOS_SPI_STAT			0x18
+#define STAT_RD_DATA			GENMASK_ULL(31, 0)
+#define STAT_RW_VAL			BIT_ULL(32)
+
+/* nios handshake registers, indirect access */
+#define NIOS_INIT			0x1000
+#define NIOS_INIT_DONE			BIT(0)
+#define NIOS_INIT_START			BIT(1)
+/* Mode for PKVL A, link 0, the same below */
+#define REQ_FEC_MODE_A0_MSK		GENMASK(9, 8)
+#define REQ_FEC_MODE_A1_MSK		GENMASK(11, 10)
+#define REQ_FEC_MODE_A2_MSK		GENMASK(13, 12)
+#define REQ_FEC_MODE_A3_MSK		GENMASK(15, 14)
+#define REQ_FEC_MODE_B0_MSK		GENMASK(17, 16)
+#define REQ_FEC_MODE_B1_MSK		GENMASK(19, 18)
+#define REQ_FEC_MODE_B2_MSK		GENMASK(21, 20)
+#define REQ_FEC_MODE_B3_MSK		GENMASK(23, 22)
+#define REQ_FEC_MODE_NO			0x0
+#define REQ_FEC_MODE_KR			0x1
+#define REQ_FEC_MODE_RS			0x2
+
+#define NIOS_FW_VERSION			0x1004
+#define NIOS_FW_VERSION_PATCH		GENMASK(23, 20)
+#define NIOS_FW_VERSION_MINOR		GENMASK(27, 24)
+#define NIOS_FW_VERSION_MAJOR		GENMASK(31, 28)
+
+#define PKVL_A_MODE_STS			0x1020
+#define PKVL_B_MODE_STS			0x1024
+#define PKVL_MODE_STS_GROUP_MSK		GENMASK(15, 8)
+#define PKVL_MODE_STS_GROUP_OK		0x0
+#define PKVL_MODE_STS_ID_MSK		GENMASK(7, 0)
+
+#define NS_REGBUS_WAIT_TIMEOUT	10000		/* loop count */
+#define NIOS_INIT_TIMEOUT		10000000	/* usec */
+#define NIOS_INIT_TIME_INTV		100000		/* usec */
+
+struct dfl_n3000_nios {
+	void __iomem *base;
+	struct regmap *regmap;
+	struct device *dev;
+	struct platform_device *altera_spi;
+};
+
+static int n3000_nios_writel(struct dfl_n3000_nios *ns, unsigned int reg,
+			     unsigned int val)
+{
+	int ret;
+
+	ret = regmap_write(ns->regmap, reg, val);
+	if (ret)
+		dev_err(ns->dev, "fail to write reg 0x%x val 0x%x: %d\n",
+			reg, val, ret);
+
+	return ret;
+}
+
+static int n3000_nios_readl(struct dfl_n3000_nios *ns, unsigned int reg,
+			    unsigned int *val)
+{
+	int ret;
+
+	ret = regmap_read(ns->regmap, reg, val);
+	if (ret)
+		dev_err(ns->dev, "fail to read reg 0x%x: %d\n", reg, ret);
+
+	return ret;
+}
+
+static ssize_t nios_fw_version_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct dfl_n3000_nios *ns = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = n3000_nios_readl(ns, NIOS_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%x.%x.%x\n",
+		       (u8)FIELD_GET(NIOS_FW_VERSION_MAJOR, val),
+		       (u8)FIELD_GET(NIOS_FW_VERSION_MINOR, val),
+		       (u8)FIELD_GET(NIOS_FW_VERSION_PATCH, val));
+}
+static DEVICE_ATTR_RO(nios_fw_version);
+
+static ssize_t fec_mode_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct dfl_n3000_nios *ns = dev_get_drvdata(dev);
+	unsigned int val, mode;
+	int ret;
+
+	ret = n3000_nios_readl(ns, NIOS_INIT, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * FEC mode should always be the same for all links, as we set them
+	 * in this way.
+	 */
+	mode = FIELD_GET(REQ_FEC_MODE_A0_MSK, val);
+	if (mode != FIELD_GET(REQ_FEC_MODE_A1_MSK, val) ||
+	    mode != FIELD_GET(REQ_FEC_MODE_A2_MSK, val) ||
+	    mode != FIELD_GET(REQ_FEC_MODE_A3_MSK, val) ||
+	    mode != FIELD_GET(REQ_FEC_MODE_B0_MSK, val) ||
+	    mode != FIELD_GET(REQ_FEC_MODE_B1_MSK, val) ||
+	    mode != FIELD_GET(REQ_FEC_MODE_B2_MSK, val) ||
+	    mode != FIELD_GET(REQ_FEC_MODE_B3_MSK, val))
+		return -EFAULT;
+
+	switch (mode) {
+	case REQ_FEC_MODE_NO:
+		return sprintf(buf, "no\n");
+	case REQ_FEC_MODE_KR:
+		return sprintf(buf, "kr\n");
+	case REQ_FEC_MODE_RS:
+		return sprintf(buf, "rs\n");
+	}
+
+	return -EFAULT;
+}
+static DEVICE_ATTR_RO(fec_mode);
+
+static struct attribute *n3000_nios_attrs[] = {
+	&dev_attr_nios_fw_version.attr,
+	&dev_attr_fec_mode.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(n3000_nios);
+
+static bool init_error_detected(struct dfl_n3000_nios *ns)
+{
+	unsigned int val;
+
+	if (n3000_nios_readl(ns, PKVL_A_MODE_STS, &val))
+		return true;
+
+	if (FIELD_GET(PKVL_MODE_STS_GROUP_MSK, val) == PKVL_MODE_STS_GROUP_OK)
+		return true;
+
+	if (n3000_nios_readl(ns, PKVL_B_MODE_STS, &val))
+		return true;
+
+	if (FIELD_GET(PKVL_MODE_STS_GROUP_MSK, val) == PKVL_MODE_STS_GROUP_OK)
+		return true;
+
+	return false;
+}
+
+static void dump_error_stat(struct dfl_n3000_nios *ns)
+{
+	unsigned int val;
+
+	if (n3000_nios_readl(ns, PKVL_A_MODE_STS, &val)) {
+		dev_err(ns->dev, "Could not read register PKVL_A_MODE_STS\n");
+		return;
+	}
+
+	dev_info(ns->dev, "PKVL_A_MODE_STS %x\n", val);
+
+	if (n3000_nios_readl(ns, PKVL_B_MODE_STS, &val)) {
+		dev_err(ns->dev, "Could not read register PKVL_B_MODE_STS\n");
+		return;
+	}
+
+	dev_info(ns->dev, "PKVL_B_MODE_STS %x\n", val);
+}
+
+static int n3000_nios_init_done_check(struct dfl_n3000_nios *ns)
+{
+	struct device *dev = ns->dev;
+	unsigned int val, mode;
+	int ret;
+
+	/*
+	 * this SPI is shared by NIOS core inside FPGA, NIOS will use this SPI
+	 * master to do some one time initialization after power up, and then
+	 * release the control to OS. driver needs to poll on INIT_DONE to
+	 * see when driver could take the control.
+	 *
+	 * Please note that after 3.x.x version, INIT_START is introduced, so
+	 * driver needs to trigger START firstly and then check INIT_DONE.
+	 */
+
+	ret = n3000_nios_readl(ns, NIOS_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * If NIOS version register is totally uninitialized(== 0x0), then the
+	 * NIOS firmware is missing. So host could take control of SPI master
+	 * safely, but initialization work for NIOS is not done. This is an
+	 * issue of FPGA image. We didn't error out because we need SPI master
+	 * to reprogram a new image.
+	 */
+	if (val == 0) {
+		dev_warn(dev, "NIOS version reg = 0x%x, skip INIT_DONE check, but PKVL may be uninitialized\n",
+			 val);
+		return 0;
+	}
+
+	if (FIELD_GET(NIOS_FW_VERSION_MAJOR, val) >= 3) {
+		/* read NIOS_INIT to check if PKVL INIT done or not */
+		ret = n3000_nios_readl(ns, NIOS_INIT, &val);
+		if (ret)
+			return ret;
+
+		/* check if PKVLs are initialized already */
+		if (val & NIOS_INIT_DONE || val & NIOS_INIT_START)
+			goto nios_init_done;
+
+		/* configure FEC mode per module param */
+		val = NIOS_INIT_START;
+
+		/* FEC mode will be ignored by hardware in 10G mode */
+		if (!strcmp(fec_mode, "no"))
+			mode = REQ_FEC_MODE_NO;
+		else if (!strcmp(fec_mode, "kr"))
+			mode = REQ_FEC_MODE_KR;
+		else if (!strcmp(fec_mode, "rs"))
+			mode = REQ_FEC_MODE_RS;
+		else
+			return -EINVAL;
+
+		/* set the same FEC mode for all links */
+		val |= FIELD_PREP(REQ_FEC_MODE_A0_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_A1_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_A2_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_A3_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_B0_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_B1_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_B2_MSK, mode) |
+		       FIELD_PREP(REQ_FEC_MODE_B3_MSK, mode);
+
+		ret = n3000_nios_writel(ns, NIOS_INIT, val);
+		if (ret)
+			return ret;
+	}
+
+nios_init_done:
+	/* polls on NIOS_INIT_DONE */
+	ret = regmap_read_poll_timeout(ns->regmap, NIOS_INIT, val,
+				       val & NIOS_INIT_DONE,
+				       NIOS_INIT_TIME_INTV,
+				       NIOS_INIT_TIMEOUT);
+	if (ret) {
+		dev_err(dev, "NIOS_INIT_DONE %s\n",
+			(ret == -ETIMEDOUT) ? "timed out" : "check error");
+		goto dump_sts;
+	}
+
+	/*
+	 * after INIT_DONE is detected, it still needs to check if any ERR
+	 * detected.
+	 * We won't error out here even if error detected. Nios will release
+	 * spi controller when INIT_DONE is set, so driver could continue to
+	 * initialize spi controller device.
+	 */
+	if (init_error_detected(ns)) {
+		dev_warn(dev, "NIOS_INIT_DONE OK, but err found during init\n");
+		goto dump_sts;
+	}
+	return 0;
+
+dump_sts:
+	dump_error_stat(ns);
+
+	return ret;
+}
+
+struct spi_board_info m10_n3000_info = {
+	.modalias = "m10-n3000",
+	.max_speed_hz = 12500000,
+	.bus_num = 0,
+	.chip_select = 0,
+};
+
+static int create_altera_spi_controller(struct dfl_n3000_nios *ns)
+{
+	struct altera_spi_platform_data pdata = { 0 };
+	struct platform_device_info pdevinfo = { 0 };
+	void __iomem *base = ns->base;
+	u64 v;
+
+	v = readq(base + NIOS_SPI_PARAM);
+
+	pdata.mode_bits = SPI_CS_HIGH;
+	if (FIELD_GET(PARAM_CLK_POL, v))
+		pdata.mode_bits |= SPI_CPOL;
+	if (FIELD_GET(PARAM_CLK_PHASE, v))
+		pdata.mode_bits |= SPI_CPHA;
+
+	pdata.num_chipselect = FIELD_GET(PARAM_NUM_CS, v);
+	pdata.bits_per_word_mask =
+		SPI_BPW_RANGE_MASK(1, FIELD_GET(PARAM_DATA_WIDTH, v));
+
+	pdata.num_devices = 1;
+	pdata.devices = &m10_n3000_info;
+
+	dev_dbg(ns->dev, "%s cs %u bpm 0x%x mode 0x%x\n", __func__,
+		pdata.num_chipselect, pdata.bits_per_word_mask,
+		pdata.mode_bits);
+
+	pdevinfo.name = "subdev_spi_altera";
+	pdevinfo.id = PLATFORM_DEVID_AUTO;
+	pdevinfo.parent = ns->dev;
+	pdevinfo.data = &pdata;
+	pdevinfo.size_data = sizeof(pdata);
+
+	ns->altera_spi = platform_device_register_full(&pdevinfo);
+	return PTR_ERR_OR_ZERO(ns->altera_spi);
+}
+
+static void destroy_altera_spi_controller(struct dfl_n3000_nios *ns)
+{
+	platform_device_unregister(ns->altera_spi);
+}
+
+/* ns is the abbreviation of nios_spi */
+static int ns_bus_poll_stat_timeout(void __iomem *base, u64 *v)
+{
+	int loops = NS_REGBUS_WAIT_TIMEOUT;
+
+	/*
+	 * We don't use the time based timeout here for performance.
+	 *
+	 * The image reprograming engine is on max10 bmc chip, which is the spi
+	 * device connected to altera spi controller. So the regbus read/write
+	 * is on the critical path of PAC N3000 image reprograming. And usually
+	 * the state changes in few loops, the time based timeout checking will
+	 * add too much overhead on it.
+	 *
+	 * Anyway, 10000 times loop is large enough.
+	 */
+	do {
+		*v = readq(base + NIOS_SPI_STAT);
+		if (*v & STAT_RW_VAL)
+			break;
+		cpu_relax();
+	} while (--loops);
+
+	return loops ? 0 : -ETIMEDOUT;
+}
+
+static int ns_bus_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	void __iomem *base = context;
+	u64 v = 0;
+
+	v |= FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_WR);
+	v |= FIELD_PREP(CTRL_ADDR, reg);
+	v |= FIELD_PREP(CTRL_WR_DATA, val);
+	writeq(v, base + NIOS_SPI_CTRL);
+
+	return ns_bus_poll_stat_timeout(base, &v);
+}
+
+static int ns_bus_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	void __iomem *base = context;
+	u64 v = 0;
+	int ret;
+
+	v |= FIELD_PREP(CTRL_CMD_MSK, CTRL_CMD_RD);
+	v |= FIELD_PREP(CTRL_ADDR, reg);
+	writeq(v, base + NIOS_SPI_CTRL);
+
+	ret = ns_bus_poll_stat_timeout(base, &v);
+	if (!ret)
+		*val = FIELD_GET(STAT_RD_DATA, v);
+
+	return ret;
+}
+
+static const struct regmap_config ns_regbus_cfg = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.fast_io = true,
+
+	.reg_write = ns_bus_reg_write,
+	.reg_read = ns_bus_reg_read,
+};
+
+static int dfl_n3000_nios_probe(struct dfl_device *dfl_dev)
+{
+	struct device *dev = &dfl_dev->dev;
+	struct dfl_n3000_nios *ns;
+	int ret;
+
+	ns = devm_kzalloc(dev, sizeof(*ns), GFP_KERNEL);
+	if (!ns)
+		return -ENOMEM;
+
+	dev_set_drvdata(&dfl_dev->dev, ns);
+
+	ns->dev = dev;
+
+	ns->base = devm_ioremap_resource(&dfl_dev->dev, &dfl_dev->mmio_res);
+	if (IS_ERR(ns->base)) {
+		dev_err(dev, "get mem resource fail!\n");
+		return PTR_ERR(ns->base);
+	}
+
+	ns->regmap = devm_regmap_init(dev, NULL, ns->base, &ns_regbus_cfg);
+	if (IS_ERR(ns->regmap))
+		return PTR_ERR(ns->regmap);
+
+	ret = n3000_nios_init_done_check(ns);
+	if (ret)
+		return ret;
+
+	ret = create_altera_spi_controller(ns);
+	if (ret)
+		dev_err(dev, "altera spi controller create failed: %d\n", ret);
+
+	return ret;
+}
+
+static void dfl_n3000_nios_remove(struct dfl_device *dfl_dev)
+{
+	struct dfl_n3000_nios *ns = dev_get_drvdata(&dfl_dev->dev);
+
+	destroy_altera_spi_controller(ns);
+}
+
+#define FME_FEATURE_ID_N3000_NIOS	0xd
+
+static const struct dfl_device_id dfl_n3000_nios_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_N3000_NIOS },
+	{ }
+};
+
+static struct dfl_driver dfl_n3000_nios_driver = {
+	.drv	= {
+		.name       = "dfl-n3000-nios",
+		.dev_groups = n3000_nios_groups,
+	},
+	.id_table = dfl_n3000_nios_ids,
+	.probe   = dfl_n3000_nios_probe,
+	.remove  = dfl_n3000_nios_remove,
+};
+
+module_dfl_driver(dfl_n3000_nios_driver);
+
+MODULE_DEVICE_TABLE(dfl, dfl_n3000_nios_ids);
+MODULE_DESCRIPTION("DFL N3000 NIOS driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

