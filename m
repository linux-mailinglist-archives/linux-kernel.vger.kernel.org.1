Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EEA2A8753
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbgKETf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732201AbgKETfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:35:25 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE54C0613D2;
        Thu,  5 Nov 2020 11:35:24 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id E3F9E23E3F;
        Thu,  5 Nov 2020 20:35:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604604923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MRGcEQ4FWCf2nRxtp5HPwwf68ZV2KBF7aB2+L+IOaTs=;
        b=TaXk45NFvaZ2zcgY5A0Y8gNmnOL2P1eN3Vf0G3dzN+H+lRBAXL5plB8veOTvDfjTyDiOjr
        d8dmRHohM1ed7aNH+xmtOFJnL9umXUzuVjFPlqn/QVwl9Ef3+/glTl9cSqGb/uFgx1VlS7
        opUYZ1s0IED2xLD2ykqdGQKmRW3rloc=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 3/5] clk: fsl-flexspi: new driver
Date:   Thu,  5 Nov 2020 20:35:10 +0100
Message-Id: <20201105193512.22388-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105193512.22388-1-michael@walle.cc>
References: <20201105193512.22388-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the FlexSPI clock on Freescale Layerscape SoCs. The
clock is a simple divider based one and is located inside the device
configuration space (DCFG).

This will allow switching the SCK frequencies for the FlexSPI interface
on the LS1028A and the LX2160A.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v1:
 - use devm_clk_hw_register_divider_table() and drop remove()

 drivers/clk/Kconfig           |   8 +++
 drivers/clk/Makefile          |   1 +
 drivers/clk/clk-fsl-flexspi.c | 106 ++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 drivers/clk/clk-fsl-flexspi.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c715d4681a0b..0066f5af9e77 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -188,6 +188,14 @@ config COMMON_CLK_CS2000_CP
 	help
 	  If you say yes here you get support for the CS2000 clock multiplier.
 
+config COMMON_CLK_FSL_FLEXSPI
+	tristate "Clock driver for FlexSPI on Layerscape SoCs"
+	depends on ARCH_LAYERSCAPE || COMPILE_TEST
+    default ARCH_LAYERSCAPE && SPI_NXP_FLEXSPI
+	help
+	  On Layerscape SoCs there is a special clock for the FlexSPI
+	  interface.
+
 config COMMON_CLK_FSL_SAI
 	bool "Clock driver for BCLK of Freescale SAI cores"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index da8fcf147eb1..dbdc590e7de3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_COMMON_CLK_CS2000_CP)	+= clk-cs2000-cp.o
 obj-$(CONFIG_ARCH_EFM32)		+= clk-efm32gg.o
 obj-$(CONFIG_ARCH_SPARX5)		+= clk-sparx5.o
 obj-$(CONFIG_COMMON_CLK_FIXED_MMIO)	+= clk-fixed-mmio.o
+obj-$(CONFIG_COMMON_CLK_FSL_FLEXSPI)	+= clk-fsl-flexspi.o
 obj-$(CONFIG_COMMON_CLK_FSL_SAI)	+= clk-fsl-sai.o
 obj-$(CONFIG_COMMON_CLK_GEMINI)		+= clk-gemini.o
 obj-$(CONFIG_COMMON_CLK_ASPEED)		+= clk-aspeed.o
diff --git a/drivers/clk/clk-fsl-flexspi.c b/drivers/clk/clk-fsl-flexspi.c
new file mode 100644
index 000000000000..87d5d7b74f29
--- /dev/null
+++ b/drivers/clk/clk-fsl-flexspi.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Layerscape FlexSPI clock driver
+ *
+ * Copyright 2020 Michael Walle <michael@walle.cc>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+static const struct clk_div_table ls1028a_flexspi_divs[] = {
+	{ .val = 0, .div = 1, },
+	{ .val = 1, .div = 2, },
+	{ .val = 2, .div = 3, },
+	{ .val = 3, .div = 4, },
+	{ .val = 4, .div = 5, },
+	{ .val = 5, .div = 6, },
+	{ .val = 6, .div = 7, },
+	{ .val = 7, .div = 8, },
+	{ .val = 11, .div = 12, },
+	{ .val = 15, .div = 16, },
+	{ .val = 16, .div = 20, },
+	{ .val = 17, .div = 24, },
+	{ .val = 18, .div = 28, },
+	{ .val = 19, .div = 32, },
+	{ .val = 20, .div = 80, },
+	{}
+};
+
+static const struct clk_div_table lx2160a_flexspi_divs[] = {
+	{ .val = 1, .div = 2, },
+	{ .val = 3, .div = 4, },
+	{ .val = 5, .div = 6, },
+	{ .val = 7, .div = 8, },
+	{ .val = 11, .div = 12, },
+	{ .val = 15, .div = 16, },
+	{ .val = 16, .div = 20, },
+	{ .val = 17, .div = 24, },
+	{ .val = 18, .div = 28, },
+	{ .val = 19, .div = 32, },
+	{ .val = 20, .div = 80, },
+	{}
+};
+
+static int fsl_flexspi_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const char *clk_name = np->name;
+	const char *clk_parent;
+	struct resource *res;
+	void __iomem *reg;
+	struct clk_hw *hw;
+	const struct clk_div_table *divs;
+
+	divs = device_get_match_data(dev);
+	if (!divs)
+		return -ENOENT;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOENT;
+
+	/*
+	 * Can't use devm_ioremap_resource() or devm_of_iomap() because the
+	 * resource might already be taken by the parent device.
+	 */
+	reg = devm_ioremap(dev, res->start, resource_size(res));
+	if (!reg)
+		return -ENOMEM;
+
+	clk_parent = of_clk_get_parent_name(np, 0);
+	if (!clk_parent)
+		return -EINVAL;
+
+	of_property_read_string(np, "clock-output-names", &clk_name);
+
+	hw = devm_clk_hw_register_divider_table(dev, clk_name, clk_parent, 0,
+						reg, 0, 5, 0, divs, NULL);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
+}
+
+static const struct of_device_id fsl_flexspi_clk_dt_ids[] = {
+	{ .compatible = "fsl,ls1028a-flexspi-clk", .data = &ls1028a_flexspi_divs },
+	{ .compatible = "fsl,lx2160a-flexspi-clk", .data = &lx2160a_flexspi_divs },
+	{}
+};
+
+static struct platform_driver fsl_flexspi_clk_driver = {
+	.driver = {
+		.name = "fsl-flexspi-clk",
+		.of_match_table = fsl_flexspi_clk_dt_ids,
+	},
+	.probe = fsl_flexspi_clk_probe,
+};
+module_platform_driver(fsl_flexspi_clk_driver);
+
+MODULE_DESCRIPTION("FlexSPI clock driver for Layerscape SoCs");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:fsl-flexspi-clk");
-- 
2.20.1

