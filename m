Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3412EBAA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbhAFHmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:42:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:10768 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbhAFHmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:42:10 -0500
IronPort-SDR: uxxahCOX8hzR7Eu06r7fwcT0J9eNWhNcGQdM/I/L9l/t29lGOw10P14XyzDy3YfCA6RNbJ7Oij
 jS8iE9DOEpCQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="176462199"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="176462199"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:41:30 -0800
IronPort-SDR: 8zBePuDjyuTWeI6ZmZkXSDSPV2ZNpQ0a4RLP4Bm7ruppetT+a3fJzZaX8dsrW2yS0s6R10lg+x
 anb2yQmfCRuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="361466750"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2021 23:41:27 -0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     arnd@arndb.de, lee.jones@linaro.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        russell.h.weight@intel.com
Subject: [PATCH 2/2] misc: add support for retimers interfaces on Intel MAX 10 BMC
Date:   Wed,  6 Jan 2021 15:36:07 +0800
Message-Id: <1609918567-13339-3-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
References: <1609918567-13339-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports the ethernet retimers (C827) for the Intel PAC
(Programmable Acceleration Card) N3000, which is a FPGA based Smart NIC.

C827 is an Intel(R) Ethernet serdes transceiver chip that supports
up to 100G transfer. On Intel PAC N3000 there are 2 C827 chips
managed by the Intel MAX 10 BMC firmware. They are configured in 4 ports
10G/25G retimer mode. Host could query their link states and firmware
version information via retimer interfaces (Shared registers) on Intel
MAX 10 BMC. The driver creates sysfs interfaces for users to query these
information.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc-retimer |  32 +++++
 drivers/misc/Kconfig                               |  10 ++
 drivers/misc/Makefile                              |   1 +
 drivers/misc/intel-m10-bmc-retimer.c               | 158 +++++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
 create mode 100644 drivers/misc/intel-m10-bmc-retimer.c

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
new file mode 100644
index 0000000..528712a
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-retimer
@@ -0,0 +1,32 @@
+What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/tag
+Date:		Jan 2021
+KernelVersion:	5.12
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the tag of the retimer chip. Now there are 2
+		retimer chips on Intel PAC N3000, they are tagged as
+		'retimer_A' and 'retimer_B'.
+		Format: "retimer_%c".
+
+What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/sbus_version
+Date:		Jan 2021
+KernelVersion:	5.12
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the Transceiver bus firmware version of
+		the retimer chip.
+		Format: "0x%04x".
+
+What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/serdes_version
+Date:		Jan 2021
+KernelVersion:	5.12
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the SERDES firmware version of the retimer
+		chip.
+		Format: "0x%04x".
+
+What:		/sys/bus/platform/devices/n3000bmc-retimer.*.auto/link_statusX
+Date:		Jan 2021
+KernelVersion:	5.12
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the status of each line side link. "1" for
+		link up, "0" for link down.
+		Format: "%u".
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fafa8b0..7cb9433 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -466,6 +466,16 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.
 
+config INTEL_M10_BMC_RETIMER
+	tristate "Intel(R) MAX 10 BMC ethernet retimer interface support"
+	depends on MFD_INTEL_M10_BMC
+	help
+	  This driver supports the ethernet retimer (C827) on Intel(R) MAX 10
+	  BMC, which is used by Intel PAC N3000 FPGA based Smart NIC.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel-m10-bmc-retimer.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index d23231e..67883cf 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -57,3 +57,4 @@ obj-$(CONFIG_HABANA_AI)		+= habanalabs/
 obj-$(CONFIG_UACCE)		+= uacce/
 obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
+obj-$(CONFIG_INTEL_M10_BMC_RETIMER)	+= intel-m10-bmc-retimer.o
diff --git a/drivers/misc/intel-m10-bmc-retimer.c b/drivers/misc/intel-m10-bmc-retimer.c
new file mode 100644
index 0000000..d845342b
--- /dev/null
+++ b/drivers/misc/intel-m10-bmc-retimer.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Max10 BMC Retimer Interface Driver
+ *
+ * Copyright (C) 2021 Intel Corporation, Inc.
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/mfd/intel-m10-bmc.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define N3000BMC_RETIMER_DEV_NAME "n3000bmc-retimer"
+
+struct m10bmc_retimer {
+	struct device *dev;
+	struct intel_m10bmc *m10bmc;
+	u32 ver_reg;
+	u32 id;
+};
+
+static ssize_t tag_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct m10bmc_retimer *retimer = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "retimer_%c\n", 'A' + retimer->id);
+}
+static DEVICE_ATTR_RO(tag);
+
+static ssize_t sbus_version_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct m10bmc_retimer *retimer = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(retimer->m10bmc, retimer->ver_reg, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%04x\n",
+			  (u16)FIELD_GET(M10BMC_PKVL_SBUS_VER, val));
+}
+static DEVICE_ATTR_RO(sbus_version);
+
+static ssize_t serdes_version_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct m10bmc_retimer *retimer = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(retimer->m10bmc, retimer->ver_reg, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "0x%04x\n",
+			  (u16)FIELD_GET(M10BMC_PKVL_SERDES_VER, val));
+}
+static DEVICE_ATTR_RO(serdes_version);
+
+struct link_attr {
+	struct device_attribute attr;
+	u32 index;
+};
+
+#define to_link_attr(dev_attr) \
+	container_of(dev_attr, struct link_attr, attr)
+
+static ssize_t
+link_status_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct m10bmc_retimer *retimer = dev_get_drvdata(dev);
+	struct link_attr *lattr = to_link_attr(attr);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(retimer->m10bmc, M10BMC_PKVL_LSTATUS, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%u\n",
+			  !!(val & BIT((retimer->id << 2) + lattr->index)));
+}
+
+#define link_status_attr(_index)				\
+	static struct link_attr link_attr_status##_index =	\
+		{ .attr = __ATTR(link_status##_index, 0444,	\
+				 link_status_show, NULL),	\
+		  .index = (_index) }
+
+link_status_attr(0);
+link_status_attr(1);
+link_status_attr(2);
+link_status_attr(3);
+
+static struct attribute *m10bmc_retimer_attrs[] = {
+	&dev_attr_tag.attr,
+	&dev_attr_sbus_version.attr,
+	&dev_attr_serdes_version.attr,
+	&link_attr_status0.attr.attr,
+	&link_attr_status1.attr.attr,
+	&link_attr_status2.attr.attr,
+	&link_attr_status3.attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(m10bmc_retimer);
+
+static int intel_m10bmc_retimer_probe(struct platform_device *pdev)
+{
+	struct intel_m10bmc *m10bmc = dev_get_drvdata(pdev->dev.parent);
+	struct m10bmc_retimer *retimer;
+	struct resource *res;
+
+	retimer = devm_kzalloc(&pdev->dev, sizeof(*retimer), GFP_KERNEL);
+	if (!retimer)
+		return -ENOMEM;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_REG, "version");
+	if (!res) {
+		dev_err(&pdev->dev, "No REG resource for version\n");
+		return -EINVAL;
+	}
+
+	/* find the id of the retimer via the addr of the version register */
+	if (res->start == M10BMC_PKVL_A_VER) {
+		retimer->id = 0;
+	} else if (res->start == M10BMC_PKVL_B_VER) {
+		retimer->id = 1;
+	} else {
+		dev_err(&pdev->dev, "version REG resource invalid\n");
+		return -EINVAL;
+	}
+
+	retimer->ver_reg = res->start;
+	retimer->dev = &pdev->dev;
+	retimer->m10bmc = m10bmc;
+
+	dev_set_drvdata(&pdev->dev, retimer);
+
+	return 0;
+}
+
+static struct platform_driver intel_m10bmc_retimer_driver = {
+	.probe = intel_m10bmc_retimer_probe,
+	.driver = {
+		.name = N3000BMC_RETIMER_DEV_NAME,
+		.dev_groups = m10bmc_retimer_groups,
+	},
+};
+module_platform_driver(intel_m10bmc_retimer_driver);
+
+MODULE_ALIAS("platform:" N3000BMC_RETIMER_DEV_NAME);
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Intel MAX 10 BMC retimer driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

