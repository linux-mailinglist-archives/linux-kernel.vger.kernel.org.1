Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6FC2C9541
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 03:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgLACen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 21:34:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:26608 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgLACen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 21:34:43 -0500
IronPort-SDR: PXDOfc3zAkOskRde4l3vYjU/ov5BL4UbzRoSy5ircNajNlqanaun/T0PAd7h8My/7C2CtcADFR
 mrhqcGjca3pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="169250297"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="169250297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 18:33:02 -0800
IronPort-SDR: zXcY+biFsFvXtq4RKOc6b1tEV5g2R3/Na2MHTETLLRTHfzgFUVItIpq5WwErn2OlaItB2MOesK
 gTNN3tkjcYfw==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="549360103"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 18:32:58 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 2/5] regmap/SoundWire: sdw: add support for SoundWire 1.2 MBQ
Date:   Mon, 30 Nov 2020 22:40:17 +0800
Message-Id: <20201130144020.19757-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
References: <20201130144020.19757-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The SoundWire 1.1 specification only allowed for reads and writes of
bytes. The SoundWire 1.2 specification adds a new capability to
transfer "Multi-Byte Quantities" (MBQ) across the bus. The transfers
still happens one-byte-at-a-time, but the update is atomic.

For example when writing a 16-bit volume, the first byte transferred
is only taken into account when the second byte is successfully
transferred.

The mechanism is symmetrical for read and writes:
- On a read, the address of the last byte to be read is modified by
setting the MBQ bit
- On a write, the address of all but the last byte to be written are
modified by setting the MBQ bit. The address for the last byte relies
on the MBQ bit being cleared.

The current definitions for MBQ-based controls in the SDCA draft
standard are limited to 16 bits for volumes, so for now this is the
only supported format. An update will be provided if and when support
for 24-bit and 32-bit values is specified by the SDCA standard.

One possible objection is that this code could have been handled with
regmap-sdw.c. However this is a new spec addition not handled by every
SoundWire 1.1 and non-SDCA device, so there's no reason to load code
that will never be used.

Also in practice it's extremely unlikely that CONFIG_REGMAP would not
be selected with CONFIG_REGMAP_MBQ selected. However there's no
functional dependency between the two modules so they can be selected
separately.

Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/base/regmap/Kconfig          |   6 +-
 drivers/base/regmap/Makefile         |   1 +
 drivers/base/regmap/regmap-sdw-mbq.c | 101 +++++++++++++++++++++++++++
 include/linux/regmap.h               |  35 ++++++++++
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/regmap/regmap-sdw-mbq.c

diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
index bcb90d8c3960..50b1e2d06a25 100644
--- a/drivers/base/regmap/Kconfig
+++ b/drivers/base/regmap/Kconfig
@@ -4,7 +4,7 @@
 # subsystems should select the appropriate symbols.
 
 config REGMAP
-	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM)
+	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SOUNDWIRE_MBQ || REGMAP_SCCB || REGMAP_I3C || REGMAP_SPI_AVMM)
 	select IRQ_DOMAIN if REGMAP_IRQ
 	bool
 
@@ -46,6 +46,10 @@ config REGMAP_SOUNDWIRE
 	tristate
 	depends on SOUNDWIRE
 
+config REGMAP_SOUNDWIRE_MBQ
+	tristate
+	depends on SOUNDWIRE
+
 config REGMAP_SCCB
 	tristate
 	depends on I2C
diff --git a/drivers/base/regmap/Makefile b/drivers/base/regmap/Makefile
index ac1b69ee4051..33f63adb5b3d 100644
--- a/drivers/base/regmap/Makefile
+++ b/drivers/base/regmap/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_REGMAP_MMIO) += regmap-mmio.o
 obj-$(CONFIG_REGMAP_IRQ) += regmap-irq.o
 obj-$(CONFIG_REGMAP_W1) += regmap-w1.o
 obj-$(CONFIG_REGMAP_SOUNDWIRE) += regmap-sdw.o
+obj-$(CONFIG_REGMAP_SOUNDWIRE_MBQ) += regmap-sdw-mbq.o
 obj-$(CONFIG_REGMAP_SCCB) += regmap-sccb.o
 obj-$(CONFIG_REGMAP_I3C) += regmap-i3c.o
 obj-$(CONFIG_REGMAP_SPI_AVMM) += regmap-spi-avmm.o
diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
new file mode 100644
index 000000000000..8ce30650b97c
--- /dev/null
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright(c) 2020 Intel Corporation.
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/soundwire/sdw.h>
+#include <linux/soundwire/sdw_registers.h>
+#include "internal.h"
+
+static int regmap_sdw_mbq_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct device *dev = context;
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	int ret;
+
+	ret = sdw_write(slave, SDW_SDCA_MBQ_CTL(reg), (val >> 8) & 0xff);
+	if (ret < 0)
+		return ret;
+
+	return sdw_write(slave, reg, val & 0xff);
+}
+
+static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct device *dev = context;
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+	int read0;
+	int read1;
+
+	read0 = sdw_read(slave, reg);
+	if (read0 < 0)
+		return read0;
+
+	read1 = sdw_read(slave, SDW_SDCA_MBQ_CTL(reg));
+	if (read1 < 0)
+		return read1;
+
+	*val = (read1 << 8) | read0;
+
+	return 0;
+}
+
+static struct regmap_bus regmap_sdw_mbq = {
+	.reg_read = regmap_sdw_mbq_read,
+	.reg_write = regmap_sdw_mbq_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_LITTLE,
+	.val_format_endian_default = REGMAP_ENDIAN_LITTLE,
+};
+
+static int regmap_sdw_mbq_config_check(const struct regmap_config *config)
+{
+	/* MBQ-based controls are only 16-bits for now */
+	if (config->val_bits != 16)
+		return -ENOTSUPP;
+
+	/* Registers are 32 bits wide */
+	if (config->reg_bits != 32)
+		return -ENOTSUPP;
+
+	if (config->pad_bits != 0)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+struct regmap *__regmap_init_sdw_mbq(struct sdw_slave *sdw,
+				     const struct regmap_config *config,
+				     struct lock_class_key *lock_key,
+				     const char *lock_name)
+{
+	int ret;
+
+	ret = regmap_sdw_mbq_config_check(config);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return __regmap_init(&sdw->dev, &regmap_sdw_mbq,
+			&sdw->dev, config, lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__regmap_init_sdw_mbq);
+
+struct regmap *__devm_regmap_init_sdw_mbq(struct sdw_slave *sdw,
+					  const struct regmap_config *config,
+					  struct lock_class_key *lock_key,
+					  const char *lock_name)
+{
+	int ret;
+
+	ret = regmap_sdw_mbq_config_check(config);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return __devm_regmap_init(&sdw->dev, &regmap_sdw_mbq,
+			&sdw->dev, config, lock_key, lock_name);
+}
+EXPORT_SYMBOL_GPL(__devm_regmap_init_sdw_mbq);
+
+MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e7834d98207f..a652d1474d6a 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -570,6 +570,10 @@ struct regmap *__regmap_init_sdw(struct sdw_slave *sdw,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
+struct regmap *__regmap_init_sdw_mbq(struct sdw_slave *sdw,
+				     const struct regmap_config *config,
+				     struct lock_class_key *lock_key,
+				     const char *lock_name);
 struct regmap *__regmap_init_spi_avmm(struct spi_device *spi,
 				      const struct regmap_config *config,
 				      struct lock_class_key *lock_key,
@@ -619,6 +623,10 @@ struct regmap *__devm_regmap_init_sdw(struct sdw_slave *sdw,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
 				 const char *lock_name);
+struct regmap *__devm_regmap_init_sdw_mbq(struct sdw_slave *sdw,
+					  const struct regmap_config *config,
+					  struct lock_class_key *lock_key,
+					  const char *lock_name);
 struct regmap *__devm_regmap_init_slimbus(struct slim_device *slimbus,
 				 const struct regmap_config *config,
 				 struct lock_class_key *lock_key,
@@ -817,6 +825,19 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__regmap_init_sdw, #config,		\
 				sdw, config)
 
+/**
+ * regmap_init_sdw_mbq() - Initialise register map
+ *
+ * @sdw: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer to
+ * a struct regmap.
+ */
+#define regmap_init_sdw_mbq(sdw, config)					\
+	__regmap_lockdep_wrapper(__regmap_init_sdw_mbq, #config,		\
+				sdw, config)
+
 /**
  * regmap_init_spi_avmm() - Initialize register map for Intel SPI Slave
  * to AVMM Bus Bridge
@@ -989,6 +1010,20 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
 	__regmap_lockdep_wrapper(__devm_regmap_init_sdw, #config,	\
 				sdw, config)
 
+/**
+ * devm_regmap_init_sdw_mbq() - Initialise managed register map
+ *
+ * @sdw: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap. The regmap will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_sdw_mbq(sdw, config)			\
+	__regmap_lockdep_wrapper(__devm_regmap_init_sdw_mbq, #config,   \
+				sdw, config)
+
 /**
  * devm_regmap_init_slimbus() - Initialise managed register map
  *
-- 
2.17.1

