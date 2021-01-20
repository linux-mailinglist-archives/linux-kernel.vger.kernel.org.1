Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C352FCCA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbhATIWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:22:14 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:4828 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbhATIUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611130849; x=1642666849;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EbcLxG1So3eoiEt8KRmMnBkGFr3SLIa2rLe+9Zj2PcE=;
  b=F4vviLGX5DX3zUjZJbLKjekke9FkUWencHhcrIyqQggufhk8MsHh4HKS
   pUcItv+GsvMJmnforPBDJnvg16ZMoTmnrWYs0KxypOdj+9i0TsSB70Sau
   ThwYzqtVpKbsV/MLpgSq5P6svTzDOw0+ExA6DDBdYrHPEH0JjuuW9fFLl
   UHC7md1UinITGw84OTPuPELpXstFN11GynqSN8ZztdW0msiEcgHgv9Oeg
   5NZHQRytaTxwOPlbt1WplZJ0YgFU+KrKXXNhlZfwxWxzV/9MC/cFr88MD
   oORl6/4wvjb4FYHeeOXLVPSz/O6i393xh61b4odqt2mitCeGQgOkehgeH
   A==;
IronPort-SDR: WQtLrl3SNpYdCnDz2O7vWlwYRNRx5YWCqy1BMD/oNONGxYhOoORoGt7GBwP85uavM7AK08/Oqk
 aPUfuVTHc5xtT7CbnYh61OErCyC0nG0oTh4KaM/4+XoRnjE6KqXal6GPR3IR76OZvme2pPpI7j
 relgy5CGuWADrJbRNiKDrgdFJEuKyY5orSosX4GwWg93bzW6qVvB8nat2echpQqjytjNKI+pKE
 OrrgRu81gkU87thfKcLrwvNh7R+KtsqIMPDOUphvsLO51dF0yTNeCFiEiocJm+iG5RcCT3r5+e
 PCs=
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="106602465"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 01:19:33 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 01:19:33 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 20 Jan 2021 01:19:31 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 2/3] reset: mchp: sparx5: add switch reset driver
Date:   Wed, 20 Jan 2021 09:19:20 +0100
Message-ID: <20210120081921.3315847-3-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120081921.3315847-1-steen.hegelund@microchip.com>
References: <20210120081921.3315847-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sparx5 Switch SoC has a number of components that can be reset
indiviually, but at least the Switch Core needs to be in a well defined
state at power on, when any of the Sparx5 drivers starts to access the
Switch Core, this reset driver is available.

The reset driver is loaded early via the postcore_initcall interface, and
will then be available for the other Sparx5 drivers (SGPIO, SwitchDev etc)
that are loaded next, and the first of them to be loaded can perform the
one-time Switch Core reset that is needed.

The driver has protection so that the system busses, DDR controller, PCI-E
and ARM A53 CPU and a few other subsystems are not touched by the reset.

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 drivers/reset/Kconfig                  |   8 ++
 drivers/reset/Makefile                 |   1 +
 drivers/reset/reset-microchip-sparx5.c | 120 +++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/reset/reset-microchip-sparx5.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 71ab75a46491..05c240c47a8a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -101,6 +101,14 @@ config RESET_LPC18XX
 	help
 	  This enables the reset controller driver for NXP LPC18xx/43xx SoCs.
 
+config RESET_MCHP_SPARX5
+	bool "Microchip Sparx5 reset driver"
+	depends on HAS_IOMEM || COMPILE_TEST
+	default y if SPARX5_SWITCH
+	select MFD_SYSCON
+	help
+	  This driver supports switch core reset for the Microchip Sparx5 SoC.
+
 config RESET_MESON
 	tristate "Meson Reset Driver"
 	depends on ARCH_MESON || COMPILE_TEST
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 1054123fd187..341fd9ab4bf6 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_INTEL_GW) += reset-intel-gw.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
 obj-$(CONFIG_RESET_LPC18XX) += reset-lpc18xx.o
+obj-$(CONFIG_RESET_MCHP_SPARX5) += reset-microchip-sparx5.o
 obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_MESON_AUDIO_ARB) += reset-meson-audio-arb.o
 obj-$(CONFIG_RESET_NPCM) += reset-npcm.o
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
new file mode 100644
index 000000000000..0dbd2b6161ef
--- /dev/null
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip Sparx5 Switch Reset driver
+ *
+ * Copyright (c) 2020 Microchip Technology Inc. and its subsidiaries.
+ *
+ * The Sparx5 Chip Register Model can be browsed at this location:
+ * https://github.com/microchip-ung/sparx-5_reginfo
+ */
+#include <linux/mfd/syscon.h>
+#include <linux/of_device.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+
+#define PROTECT_REG    0x84
+#define PROTECT_BIT    BIT(10)
+#define SOFT_RESET_REG 0x08
+#define SOFT_RESET_BIT BIT(1)
+
+struct mchp_reset_context {
+	struct regmap *cpu_ctrl;
+	struct regmap *gcb_ctrl;
+	struct reset_controller_dev rcdev;
+};
+
+static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct mchp_reset_context *ctx =
+		container_of(rcdev, struct mchp_reset_context, rcdev);
+	u32 val;
+
+	/* Make sure the core is PROTECTED from reset */
+	regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT, PROTECT_BIT);
+
+	/* Start soft reset */
+	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
+
+	/* Wait for soft reset done */
+	return regmap_read_poll_timeout(ctx->gcb_ctrl, SOFT_RESET_REG, val,
+					(val & SOFT_RESET_BIT) == 0,
+					1, 100);
+}
+
+static const struct reset_control_ops sparx5_reset_ops = {
+	.reset = sparx5_switch_reset,
+};
+
+static int mchp_sparx5_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct regmap *cpu_ctrl, *gcb_ctrl;
+	struct device *dev = &pdev->dev;
+	struct mchp_reset_context *ctx;
+	struct device_node *syscon_np;
+	int err;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	syscon_np = of_parse_phandle(dn, "cpu-syscon", 0);
+	if (!syscon_np)
+		return -ENODEV;
+	cpu_ctrl = syscon_node_to_regmap(syscon_np);
+	of_node_put(syscon_np);
+	if (IS_ERR(cpu_ctrl)) {
+		err = PTR_ERR(cpu_ctrl);
+		dev_err(dev, "No cpu-syscon map: %d\n", err);
+		return err;
+	}
+
+	syscon_np = of_parse_phandle(dn, "gcb-syscon", 0);
+	if (!syscon_np)
+		return -ENODEV;
+	gcb_ctrl = syscon_node_to_regmap(syscon_np);
+	of_node_put(syscon_np);
+	if (IS_ERR(gcb_ctrl)) {
+		err = PTR_ERR(gcb_ctrl);
+		dev_err(dev, "No gcb-syscon map: %d\n", err);
+		return err;
+	}
+
+	ctx->cpu_ctrl = cpu_ctrl;
+	ctx->gcb_ctrl = gcb_ctrl;
+
+	ctx->rcdev.owner = THIS_MODULE;
+	ctx->rcdev.nr_resets = 1;
+	ctx->rcdev.ops = &sparx5_reset_ops;
+	ctx->rcdev.of_node = dn;
+
+	return devm_reset_controller_register(dev, &ctx->rcdev);
+}
+
+static const struct of_device_id mchp_sparx5_reset_of_match[] = {
+	{
+		.compatible = "microchip,sparx5-switch-reset",
+	},
+	{ /*sentinel*/ }
+};
+
+static struct platform_driver mchp_sparx5_reset_driver = {
+	.probe = mchp_sparx5_reset_probe,
+	.driver = {
+		.name = "sparx5-switch-reset",
+		.of_match_table = mchp_sparx5_reset_of_match,
+	},
+};
+
+static int __init mchp_sparx5_reset_init(void)
+{
+	return platform_driver_register(&mchp_sparx5_reset_driver);
+}
+
+postcore_initcall(mchp_sparx5_reset_init);
+
+MODULE_DESCRIPTION("Microchip Sparx5 switch reset driver");
+MODULE_AUTHOR("Steen Hegelund <steen.hegelund@microchip.com>");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.29.2

