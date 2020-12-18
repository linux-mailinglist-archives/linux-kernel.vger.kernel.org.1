Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C21D2DE6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgLRPoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:44:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:43142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbgLRPoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:44:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8C472ACC6;
        Fri, 18 Dec 2020 15:43:37 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        nsaenzjulienne@suse.de, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.com,
        phil@raspberrypi.com
Subject: [PATCH v2 2/5] nvmem: Add driver to expose reserved memory as nvmem
Date:   Fri, 18 Dec 2020 16:43:17 +0100
Message-Id: <20201218154320.28368-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218154320.28368-1-nsaenzjulienne@suse.de>
References: <20201218154320.28368-1-nsaenzjulienne@suse.de>
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

Changes since v1:
 - Remove reserved memory phandle indirection by directly creating a
   platform device from the reserved memory DT node
 - Only map memory upon reading it to avoid corruption
 - Small cosmetic cleanups

 drivers/nvmem/Kconfig  |  8 ++++
 drivers/nvmem/Makefile |  2 +
 drivers/nvmem/rmem.c   | 97 ++++++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c  |  1 +
 4 files changed, 108 insertions(+)
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
index 000000000000..b11c3c974b3d
--- /dev/null
+++ b/drivers/nvmem/rmem.c
@@ -0,0 +1,97 @@
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
+	struct reserved_mem *mem;
+
+	phys_addr_t size;
+};
+
+static int rmem_read(void *context, unsigned int offset,
+		     void *val, size_t bytes)
+{
+	struct rmem *priv = context;
+	size_t available = priv->mem->size;
+	loff_t off = offset;
+	void *addr;
+	int count;
+
+	/*
+	 * Only map the reserved memory at this point to avoid potential rogue
+	 * kernel threads inadvertently modifying it. Based on the current
+	 * uses-cases for this driver, the performance hit isn't a concern.
+	 * Nor is likely to be, given the nature of the subsystem. Most nvmem
+	 * devices operate over slow buses to begin with.
+	 *
+	 * An alternative would be setting the memory as RO, set_memory_ro(),
+	 * but as of Dec 2020 this isn't possible on arm64.
+	 */
+	addr = memremap(priv->mem->base, available, MEMREMAP_WB);
+	if (IS_ERR(addr)) {
+		dev_err(priv->dev, "Failed to remap memory region\n");
+		return PTR_ERR(addr);
+	}
+
+	count = memory_read_from_buffer(val, bytes, &off, addr, available);
+
+	memunmap(addr);
+
+	return count;
+}
+
+static int rmem_probe(struct platform_device *pdev)
+{
+	struct nvmem_config config = { };
+	struct device *dev = &pdev->dev;
+	struct reserved_mem *mem;
+	struct rmem *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->dev = dev;
+
+	mem = of_reserved_mem_lookup(dev->of_node);
+	if (!mem) {
+		dev_err(dev, "Failed to lookup reserved memory\n");
+		return -EINVAL;
+	}
+	priv->mem = mem;
+
+	config.dev = dev;
+	config.priv = priv;
+	config.name = "rmem";
+	config.size = mem->size;
+	config.reg_read = rmem_read;
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
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
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 79bd5f5a1bf1..6699cdbe58b6 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -511,6 +511,7 @@ static const struct of_device_id reserved_mem_matches[] = {
 	{ .compatible = "qcom,rmtfs-mem" },
 	{ .compatible = "qcom,cmd-db" },
 	{ .compatible = "ramoops" },
+	{ .compatible = "nvmem-rmem" },
 	{}
 };
 
-- 
2.29.2

