Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6382F5400
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbhAMUUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:20:50 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26935 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbhAMUUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610569248; x=1642105248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OYD86eUaE8+LQL+Qf1Y5T5ybObFugLqeMRGro5lhoYo=;
  b=NJD/gvUcRTZ7Z6Pra1X1xPxwoss0i560ZwZTIh1+G+UFEVDA9R2yPhi1
   JBBb1YjZRM53M6wC6gaNmc079PY3WFXTS9XAHx5Leux2Ua/08zdLbx0Q0
   TIFFINmX+MSwm0qpmc8AMZYNAB3hyD35nTIJc3D4nJYA2NaPfD2Pqaafi
   0+ML1BiqF3nKkLoY+tFKfDSo8DjTVMGTLbBVssuBo2bTsfgQg3v8MJNxO
   il+JJN6RqgjmM7D7lhMzCUIygmKSRap4gmRCmvBebupAwpDqMXe4Dc9lQ
   Fvrpvyxn9ZX1qNYyLCSpigBH/9+Ll9c89TAsc6rAGNdfZs8LJe04qfrB/
   g==;
IronPort-SDR: Ztax1hj9NJ+2gJ+vf2KZp6MPrLvZv28lE3GffEzFh1nnxEuEblaAZr6EYGipK6mOJ6RabwSMHR
 STVJgzvuxSkaSPocNMPz+qU7xzZFF4qxESi+m8QmF+IScYWi8lsjNDBcy76MxpNCSDblKWHMy5
 Y6Kd0aaZagNEjkg8k0Gz5VafJwXFrkBmYP0JdDFky6ms8LU36Z6pgSxq2K+3XQpjYrR8VB6YkR
 YywnxHiIjL2dYxapwBHqseVtkyhGAMYJCheA3UxyUHHgRns3eTWtJyAAf66X39ecflQvM/X6rY
 vyU=
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="105886834"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2021 13:19:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 13 Jan 2021 13:19:32 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 13 Jan 2021 13:19:31 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 2/3] reset: mchp: sparx5: add switch reset driver
Date:   Wed, 13 Jan 2021 21:19:14 +0100
Message-ID: <20210113201915.2734205-3-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113201915.2734205-1-steen.hegelund@microchip.com>
References: <20210113201915.2734205-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 drivers/reset/Kconfig                  |   8 ++
 drivers/reset/Makefile                 |   1 +
 drivers/reset/reset-microchip-sparx5.c | 145 +++++++++++++++++++++++++
 3 files changed, 154 insertions(+)
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
index 000000000000..bb636ebd22d2
--- /dev/null
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Microchip Sparx5 Switch Reset driver
+ *
+ * Copyright (c) 2020 Microchip Technology Inc. and its subsidiaries.
+ *
+ * The Sparx5 Chip Register Model can be browsed at this location:
+ * https://github.com/microchip-ung/sparx-5_reginfo
+ */
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/notifier.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
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
+	struct device *dev;
+	struct regmap *cpu_ctrl;
+	struct regmap *gcb_ctrl;
+	struct reset_controller_dev reset_ctrl;
+};
+
+static u32 sparx5_read_soft_rst(struct mchp_reset_context *ctx)
+{
+	u32 val;
+
+	regmap_read(ctx->gcb_ctrl, SOFT_RESET_REG, &val);
+	return val;
+}
+
+static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	struct mchp_reset_context *ctx =
+		container_of(rcdev, struct mchp_reset_context, reset_ctrl);
+	u32 val;
+
+	/* Make sure the core is PROTECTED from reset */
+	regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT, PROTECT_BIT);
+
+	dev_info(ctx->dev, "soft reset of switchcore\n");
+
+	/* Start soft reset */
+	regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
+
+	/* Wait for soft reset done */
+	return read_poll_timeout(sparx5_read_soft_rst, val,
+				 (val & SOFT_RESET_BIT) == 0,
+				 1, 100, false,
+				 ctx);
+}
+
+static const struct reset_control_ops sparx5_reset_ops = {
+	.reset = sparx5_switch_reset,
+};
+
+static int mchp_sparx5_reset_config(struct platform_device *pdev,
+				    struct mchp_reset_context *ctx)
+{
+	struct device_node *dn = pdev->dev.of_node;
+	struct regmap *cpu_ctrl, *gcb_ctrl;
+	struct device_node *syscon_np;
+	int err;
+
+	syscon_np = of_parse_phandle(dn, "syscons", 0);
+	if (!syscon_np)
+		return -ENODEV;
+	cpu_ctrl = syscon_node_to_regmap(syscon_np);
+	if (IS_ERR(cpu_ctrl))
+		goto err_cpu;
+	of_node_put(syscon_np);
+
+	syscon_np = of_parse_phandle(dn, "syscons", 1);
+	if (!syscon_np)
+		return -ENODEV;
+	gcb_ctrl = syscon_node_to_regmap(syscon_np);
+	if (IS_ERR(gcb_ctrl))
+		goto err_gcb;
+	of_node_put(syscon_np);
+
+	ctx->cpu_ctrl = cpu_ctrl;
+	ctx->gcb_ctrl = gcb_ctrl;
+
+	ctx->reset_ctrl.owner = THIS_MODULE;
+	ctx->reset_ctrl.nr_resets = 1;
+	ctx->reset_ctrl.ops = &sparx5_reset_ops;
+	ctx->reset_ctrl.of_node = dn;
+
+	err = devm_reset_controller_register(&pdev->dev, &ctx->reset_ctrl);
+	if (err)
+		dev_err(&pdev->dev, "could not register reset controller\n");
+	pr_info("%s:%d\n", __func__, __LINE__);
+	return err;
+err_cpu:
+	of_node_put(syscon_np);
+	dev_err(&pdev->dev, "No cpu syscon map\n");
+	return PTR_ERR(cpu_ctrl);
+err_gcb:
+	of_node_put(syscon_np);
+	dev_err(&pdev->dev, "No gcb syscon map\n");
+	return PTR_ERR(gcb_ctrl);
+}
+
+static int mchp_sparx5_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mchp_reset_context *ctx;
+
+	pr_info("%s:%d\n", __func__, __LINE__);
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	ctx->dev = dev;
+	return mchp_sparx5_reset_config(pdev, ctx);
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
-- 
2.29.2

