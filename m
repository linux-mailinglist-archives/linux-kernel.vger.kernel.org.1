Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 204E91BF745
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgD3L5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:57:13 -0400
Received: from plaes.org ([188.166.43.21]:37020 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD3L5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:57:13 -0400
Received: from localhost (unknown [IPv6:2001:1530:1000:d397:940e:6b9e:3deb:3])
        by plaes.org (Postfix) with ESMTPSA id A676D4066A;
        Thu, 30 Apr 2020 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1588247830; bh=KtrNDTyIYly28OFcUiv1CrKTihke56ToqkXK8VtrLnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpLAHAYxOT56SoKWq8eNcb1vPxjkJV2WJVmtWEl+zOHPQi6PR78R4bLys2kodvc5r
         h3c0u6sizZblpY0lCm0OZHyk7+Qstv6FLC8CrD1oYXEdqeLVH19v2YR4xQGevjxry4
         eYKGBnFgbIrxMrTweE/WW3snMGPm2WgkNwCvCo98cuRsUqrW6HpIuJd0BhR2KNz0nD
         8mHbvuaS0j1mw56hXN8P6aSLn2GN2is99R4XxSEqLEMl9EM7Pwqr1rE97RGgWnQYyY
         WqeSx6Ak+uXtdj1Hk29Ti+TbFNf7tsMVawh2N7R4VGLWYJIjbJ4QebZjYjUmc0HjMd
         48yIjieRaNlEw==
From:   Priit Laes <plaes@plaes.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH v3 2/6] clk: sunxi-ng: a31: Register regmap for sun6i CCU
Date:   Thu, 30 Apr 2020 14:56:58 +0300
Message-Id: <20200430115702.5768-3-plaes@plaes.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200430115702.5768-1-plaes@plaes.org>
References: <20200430115702.5768-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On sun6i, the gmac clock is handled by the dwmac-sunxi driver, but
its configuration register is located in the CCU register range,
requiring proper regmap setup.

In order to do that, we use CLK_OF_DECLARE_DRIVER to initialize
sun7i ccu, which clears the OF_POPULATED flag, allowing the
platform device to probe the same resource with device node.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 62 +++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 9b40d53266a3..3f6f9824b2ca 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -10,6 +10,8 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #include "ccu_common.h"
 #include "ccu_reset.h"
@@ -1262,5 +1264,61 @@ static void __init sun6i_a31_ccu_setup(struct device_node *node)
 	ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
 				  &sun6i_a31_cpu_nb);
 }
-CLK_OF_DECLARE(sun6i_a31_ccu, "allwinner,sun6i-a31-ccu",
-	       sun6i_a31_ccu_setup);
+CLK_OF_DECLARE_DRIVER(sun6i_a31_ccu, "allwinner,sun6i-a31-ccu",
+		      sun6i_a31_ccu_setup);
+
+/*
+ * Regmap for the GMAC driver (dwmac-sunxi) to allow access to
+ * GMAC configuration register.
+ */
+#define SUN6I_A31_GMAC_CFG_REG 0xD0
+static bool sun6i_a31_ccu_regmap_accessible_reg(struct device *dev,
+						unsigned int reg)
+{
+	if (reg == SUN6I_A31_GMAC_CFG_REG)
+		return true;
+	return false;
+}
+
+static struct regmap_config sun6i_a31_ccu_regmap_config = {
+	.reg_bits	= 32,
+	.val_bits	= 32,
+	.reg_stride	= 4,
+	.max_register	= 0x308, /* clk_out_b */
+
+	.readable_reg	= sun6i_a31_ccu_regmap_accessible_reg,
+	.writeable_reg	= sun6i_a31_ccu_regmap_accessible_reg,
+};
+
+static int sun6i_a31_ccu_probe_regmap(struct platform_device *pdev)
+{
+	void __iomem *reg;
+	struct resource *res;
+	struct regmap *regmap;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg = devm_ioremap(&pdev->dev, res->start, resource_size(res));
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	regmap = devm_regmap_init_mmio(&pdev->dev, reg,
+				       &sun6i_a31_ccu_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return 0;
+}
+
+static const struct of_device_id sun6i_a31_ccu_ids[] = {
+	{ .compatible = "allwinner,sun6i-a31-ccu"},
+	{ }
+};
+
+static struct platform_driver sun6i_a31_ccu_driver = {
+	.probe = sun6i_a31_ccu_probe_regmap,
+	.driver = {
+		.name = "sun6i-a31-ccu",
+		.of_match_table = sun6i_a31_ccu_ids,
+	},
+};
+builtin_platform_driver(sun6i_a31_ccu_driver);
-- 
2.26.2

