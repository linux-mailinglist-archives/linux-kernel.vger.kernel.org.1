Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5022DB0BE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730739AbgLOP6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 10:58:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:60844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730661AbgLOP5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:57:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 532BFAD0E;
        Tue, 15 Dec 2020 15:56:42 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: [PATCH 2/6] nvmem: Add driver to expose reserved memory as nvmem
Date:   Tue, 15 Dec 2020 16:56:22 +0100
Message-Id: <20201215155627.2513-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215155627.2513-1-nsaenzjulienne@suse.de>
References: <20201215155627.2513-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Firmware/co-processors might use reserved memory areas in order to pass
data stemming from an nvmem device otherwise non accessible to Linux.
For example an EEPROM memory only physically accessible to firmware, or
data only accessible early at boot time.

In order to expose this data to other drivers and user-space, the driver
models the reserved memory area as an nvmem device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/nvmem/Kconfig  |  8 ++++
 drivers/nvmem/Makefile |  2 +
 drivers/nvmem/rmem.c   | 92 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)
 create mode 100644 drivers/nvmem/rmem.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 954d3b4a52ab..fecc19b884bf 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -270,4 +270,12 @@ config SPRD_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sprd-efuse.
 
+config NVMEM_RMEM
+	tristate "Reserved Memory Based Driver Support"
+	help
+	  This drivers maps reserved memory into an nvmem device. It might be
+	  useful to expose information left by firmware in memory.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-rmem.
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index a7c377218341..5376b8e0dae5 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -55,3 +55,5 @@ obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
 obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
 nvmem_sprd_efuse-y		:= sprd-efuse.o
+obj-$(CONFIG_NVMEM_RMEM) 	+= nvmem-rmem.o
+nvmem-rmem-y			:= rmem.o
diff --git a/drivers/nvmem/rmem.c b/drivers/nvmem/rmem.c
new file mode 100644
index 000000000000..d4fb36db0644
--- /dev/null
+++ b/drivers/nvmem/rmem.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+
+struct rmem {
+	struct device *dev;
+	struct nvmem_device *nvmem;
+	struct reserved_mem *rmem;
+
+	const void *base;
+	phys_addr_t size;
+};
+
+static int rmem_read(void *context, unsigned int offset,
+		     void *val, size_t bytes)
+{
+	struct rmem *priv = context;
+	loff_t off = offset;
+
+	return memory_read_from_buffer(val, bytes, &off, priv->base, priv->size);
+}
+
+static int rmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = { };
+	struct device *dev = &pdev->dev;
+	struct device_node *rmem_np;
+	struct reserved_mem *rmem;
+	struct rmem *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	rmem_np = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (!rmem_np) {
+		dev_err(dev, "Failed to lookup reserved memory phandle\n");
+		return -EINVAL;
+	}
+
+	rmem = of_reserved_mem_lookup(rmem_np);
+	of_node_put(rmem_np);
+	if (!rmem) {
+		dev_err(dev, "Failed to lookup reserved memory\n");
+		return -EINVAL;
+	}
+
+	priv->rmem = rmem;
+	priv->size = rmem->size;
+
+	priv->base = devm_memremap(dev, rmem->base, rmem->size, MEMREMAP_WB);
+	if (IS_ERR(priv->base)) {
+		dev_err(dev, "Failed to remap memory region\n");
+		return PTR_ERR(priv->base);
+	}
+
+	config.dev = dev;
+	config.priv = priv;
+	config.name = "rmem";
+	config.size = priv->size;
+	config.reg_read = rmem_read;
+
+	priv->nvmem = devm_nvmem_register(dev, &config);
+	return PTR_ERR_OR_ZERO(priv->nvmem);
+}
+
+static const struct of_device_id rmem_match[] = {
+	{ .compatible = "nvmem-rmem", },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rmem_match);
+
+static struct platform_driver rmem_driver = {
+	.probe = rmem_probe,
+	.driver = {
+		.name = "rmem",
+		.of_match_table = rmem_match,
+	},
+};
+module_platform_driver(rmem_driver);
+
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de>");
+MODULE_DESCRIPTION("Reserved Memory Based nvmem Driver");
+MODULE_LICENSE("GPL");
-- 
2.29.2

