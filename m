Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA7B269CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIODsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:48:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:6506 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgIODsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:48:51 -0400
IronPort-SDR: 2Wn20IAagPFo3ZtGP554WkbV5IRUv215HXyystyuP+FyfYv3TBPJAEwPLkCCS9NIc5tOYXGZLe
 dENNHEZrBcKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="159242032"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="159242032"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 20:48:47 -0700
IronPort-SDR: 2bu+YbBdotn++G6MqbnShHUniCaI8yBmZqK7Vj9l52FsHmRnPANUTQSGI3+JuVUofbu4sAuYgU
 7Y6mnL310neg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="507386731"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 14 Sep 2020 20:48:45 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, broonie@kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: [PATCH v6] mfd: intel-m10-bmc: add Intel MAX 10 BMC chip support for Intel FPGA PAC
Date:   Tue, 15 Sep 2020 11:44:21 +0800
Message-Id: <1600141461-12999-1-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the basic functions of the BMC chip for some Intel
FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
Intel MAX 10 CPLD.

This BMC chip is connected to the FPGA by a SPI bus. To provide direct
register access from the FPGA, the "SPI slave to Avalon Master Bridge"
(spi-avmm) IP is integrated in the chip. It converts encoded streams of
bytes from the host to the internal register read/write on the Avalon
bus. So This driver uses the regmap-spi-avmm for register accessing.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
v2: Split out the regmap-spi-avmm part.
    Rename the file intel-m10-bmc-main.c to intel-m10-bmc.c, cause
     there is only one source file left for this module now.
v3: Add the sub devices in mfd_cell.
    Some minor fixes.
v4: No change.
v5: Changes the names of mfd_cell.
    Use ATTRIBUTE_GROUPS() to simplify the code.
    Use the generic 'ddata' for the instance of struct intel_m10bmc.
    More comments to clarify the function check_m10bmc_version().
    Some minor fixes.
v6: Defines macro for invalid legacy bmc version value to make the
     version check more clear.
    Add comments for the purpose of abstraction of the regmap ops.
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 ++
 drivers/mfd/Kconfig                                |  13 ++
 drivers/mfd/Makefile                               |   2 +
 drivers/mfd/intel-m10-bmc.c                        | 164 +++++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h                  |  65 ++++++++
 5 files changed, 259 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 create mode 100644 drivers/mfd/intel-m10-bmc.c
 create mode 100644 include/linux/mfd/intel-m10-bmc.h

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
new file mode 100644
index 0000000..979a2d6
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
@@ -0,0 +1,15 @@
+What:		/sys/bus/spi/devices/.../bmc_version
+Date:		June 2020
+KernelVersion:	5.10
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the hardware build version of Intel
+		MAX10 BMC chip.
+		Format: "0x%x".
+
+What:		/sys/bus/spi/devices/.../bmcfw_version
+Date:		June 2020
+KernelVersion:	5.10
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the firmware version of Intel MAX10
+		BMC chip.
+		Format: "0x%x".
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2bc3073..56558fe 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2129,5 +2129,18 @@ config SGI_MFD_IOC3
 	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
 	  then say Y. Otherwise say N.
 
+config MFD_INTEL_M10_BMC
+	tristate "Intel MAX 10 Board Management Controller"
+	depends on SPI_MASTER
+	select REGMAP_SPI_AVMM
+	select MFD_CORE
+	help
+	  Support for the Intel MAX 10 board management controller using the
+	  SPI interface.
+
+	  This driver provides common support for accessing the device,
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d660be7..344653c 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -265,3 +265,5 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
+
+obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
new file mode 100644
index 0000000..b84579b
--- /dev/null
+++ b/drivers/mfd/intel-m10-bmc.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel MAX 10 Board Management Controller chip
+ *
+ * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
+ */
+#include <linux/bitfield.h>
+#include <linux/init.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+enum m10bmc_type {
+	M10_N3000,
+};
+
+static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
+	{ .name = "n3000bmc-hwmon" },
+	{ .name = "n3000bmc-retimer" },
+	{ .name = "n3000bmc-secure" },
+};
+
+static struct regmap_config intel_m10bmc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = M10BMC_MEM_END,
+};
+
+static ssize_t bmc_version_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(ddata, M10BMC_BUILD_VER, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", val);
+}
+static DEVICE_ATTR_RO(bmc_version);
+
+static ssize_t bmcfw_version_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *ddata = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(ddata, NIOS2_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", val);
+}
+static DEVICE_ATTR_RO(bmcfw_version);
+
+static struct attribute *m10bmc_attrs[] = {
+	&dev_attr_bmc_version.attr,
+	&dev_attr_bmcfw_version.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(m10bmc);
+
+static int check_m10bmc_version(struct intel_m10bmc *ddata)
+{
+	unsigned int v;
+	int ret;
+
+	/*
+	 * This check is to filter out the very old legacy BMC versions,
+	 * M10BMC_LEGACY_SYS_BASE is the offset to this old block of mmio
+	 * registers. In the old BMC chips, the BMC version info is stored
+	 * in this old version register (M10BMC_LEGACY_SYS_BASE +
+	 * M10BMC_BUILD_VER), so its read out value would have not been
+	 * LEGACY_INVALID (0xffffffff). But in new BMC chips that the
+	 * driver supports, the value of this register should be
+	 * LEGACY_INVALID.
+	 */
+	ret = m10bmc_raw_read(ddata,
+			      M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER, &v);
+	if (ret)
+		return -ENODEV;
+
+	if (v != M10BMC_VER_LEGACY_INVALID) {
+		dev_err(ddata->dev, "bad version M10BMC detected\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int intel_m10_bmc_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct device *dev = &spi->dev;
+	struct mfd_cell *cells;
+	struct intel_m10bmc *ddata;
+	int ret, n_cell;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->dev = dev;
+
+	ddata->regmap =
+		devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
+	if (IS_ERR(ddata->regmap)) {
+		ret = PTR_ERR(ddata->regmap);
+		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
+	spi_set_drvdata(spi, ddata);
+
+	ret = check_m10bmc_version(ddata);
+	if (ret) {
+		dev_err(dev, "Failed to identify m10bmc hardware\n");
+		return ret;
+	}
+
+	switch (id->driver_data) {
+	case M10_N3000:
+		cells = m10bmc_pacn3000_subdevs;
+		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
+				   NULL, 0, NULL);
+	if (ret)
+		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
+
+	return ret;
+}
+
+static const struct spi_device_id m10bmc_spi_id[] = {
+	{ "m10-n3000", M10_N3000 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
+
+static struct spi_driver intel_m10bmc_spi_driver = {
+	.driver = {
+		.name = "intel-m10-bmc",
+		.dev_groups = m10bmc_groups,
+	},
+	.probe = intel_m10_bmc_spi_probe,
+	.id_table = m10bmc_spi_id,
+};
+module_spi_driver(intel_m10bmc_spi_driver);
+
+MODULE_DESCRIPTION("Intel MAX 10 BMC Device Driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:intel-m10-bmc");
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
new file mode 100644
index 0000000..c8ef2f1
--- /dev/null
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Intel MAX 10 Board Management Controller chip.
+ *
+ * Copyright (C) 2018-2020 Intel Corporation, Inc.
+ */
+#ifndef __MFD_INTEL_M10_BMC_H
+#define __MFD_INTEL_M10_BMC_H
+
+#include <linux/regmap.h>
+
+#define M10BMC_LEGACY_SYS_BASE		0x300400
+#define M10BMC_SYS_BASE			0x300800
+#define M10BMC_MEM_END			0x200000fc
+
+/* Register offset of system registers */
+#define NIOS2_FW_VERSION		0x0
+#define M10BMC_TEST_REG			0x3c
+#define M10BMC_BUILD_VER		0x68
+#define M10BMC_VER_MAJOR_MSK		GENMASK(23, 16)
+#define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
+#define M10BMC_VER_LEGACY_INVALID	0xffffffff
+
+/**
+ * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
+ * @dev: this device
+ * @regmap: the regmap used to access registers by m10bmc itself
+ */
+struct intel_m10bmc {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+/*
+ * register access helper functions.
+ *
+ * m10bmc_raw_read - read m10bmc register per addr
+ * m10bmc_sys_read - read m10bmc system register per offset
+ */
+static inline int
+m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
+		unsigned int *val)
+{
+	int ret;
+
+	ret = regmap_read(m10bmc->regmap, addr, val);
+	if (ret)
+		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
+			addr, ret);
+
+	return ret;
+}
+
+/*
+ * The base of the system registers could be configured by HW developers, and
+ * in HW SPEC, the base is not added to the addresses of the system registers.
+ *
+ * This macro helps to simplify the accessing of the system registers. And if
+ * the base is reconfigured in HW, SW developers could simply change the
+ * M10BMC_SYS_BASE accordingly.
+ */
+#define m10bmc_sys_read(m10bmc, offset, val) \
+	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
+
+#endif /* __MFD_INTEL_M10_BMC_H */
-- 
2.7.4

