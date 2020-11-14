Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FC52B2D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 14:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgKNNw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 08:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgKNNw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 08:52:28 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58128C0617A6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:52:26 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id gi3so1737333pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 05:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nC/ASffZrZM9zs9m0ATeAZTVaoD2XE5WP6BHRrg/xw=;
        b=SbO8pQ/gY4wRQdYv4tE4m/XLDgp8tEQ0rtE3Gy0VKC4RKgUDWj8u90VG/CciDvdixi
         FXU1SiTEyUizW6LcGLjNEuCkRGVPgYNm9Pz9aLe31WRBBa2N/2oiLuNwCGBuy2O8xCZO
         UaNJwTAGyNYHeUuWXVY/zk7SejunR5HudVfd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3nC/ASffZrZM9zs9m0ATeAZTVaoD2XE5WP6BHRrg/xw=;
        b=Vmt2qnvM5NSXDuiwtR6t4YhWwQEnMSNRp6sPt0vPuP9PSWfvkBWoVdr8MwRsUvIA3O
         2G/PPVrhPdNtYzYbAfGqyorcCeYgH2xTIHjv4m92yLtviW/vxN0puXkEIwNQkpyinxMO
         0SelQd4uuLNzwClTOZWc0RrC0r9KlkS1V+ALsUhiiU79jX6FAoIqj6E50gj/88ME5FD2
         7uv/SFrDytEQOvjLo18w8iCKF+HK4Hybghj0xxSK6HQF79AP2+UOPlyqnOSPIj4dyhBI
         emf0UDgPvZjNnQsxBAWzM17I6lQEfvAiPdO+KfyHbFb1ux9pyHqs1fm9U9h4kvTzofVw
         FnIg==
X-Gm-Message-State: AOAM532ZCkSXU969vnzySUsReCbL6GUofpSsXLoLtS1AX+nLrYonyPVM
        mZNGvaw72km5TBHoXEEN2NIa7g==
X-Google-Smtp-Source: ABdhPJzo4WnfBW8T74aUdNFHlKWgPe6EU0rXrC0MGV1dleCfuuuz0baztnTEguyRqTxRujX/reV0qA==
X-Received: by 2002:a17:90a:aa13:: with SMTP id k19mr2206164pjq.145.1605361945873;
        Sat, 14 Nov 2020 05:52:25 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id r205sm13008023pfr.25.2020.11.14.05.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 05:52:25 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/6] clk: mstar: MStar/SigmaStar MPLL driver
Date:   Sat, 14 Nov 2020 22:50:41 +0900
Message-Id: <20201114135044.724385-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201114135044.724385-1-daniel@0x0f.com>
References: <20201114135044.724385-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a basic driver for the MPLL block found in MStar/SigmaStar
ARMv7 SoCs.

Currently this driver is only good for calculating the rates of it's
outputs and the actual configuration must be done before the kernel
boots. Usually this is done even before u-boot starts.

This driver targets the MPLL block found in the MSC313/MSC313E but
there is no documentation this chip so the register descriptions for
the another MStar chip the MST786 were used as they seem to match.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 MAINTAINERS                         |   1 +
 drivers/clk/Kconfig                 |   1 +
 drivers/clk/Makefile                |   1 +
 drivers/clk/mstar/Kconfig           |   5 +
 drivers/clk/mstar/Makefile          |   6 +
 drivers/clk/mstar/clk-msc313-mpll.c | 177 ++++++++++++++++++++++++++++
 6 files changed, 191 insertions(+)
 create mode 100644 drivers/clk/mstar/Kconfig
 create mode 100644 drivers/clk/mstar/Makefile
 create mode 100644 drivers/clk/mstar/clk-msc313-mpll.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d1c98a6f9f24..1783022b4aa8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2135,6 +2135,7 @@ F:	Documentation/devicetree/bindings/clock/mstar,msc313-mpll.yaml
 F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
+F:	drivers/clk/mstar/
 F:	drivers/gpio/gpio-msc313.c
 F:	include/dt-bindings/clock/mstar-*
 F:	include/dt-bindings/gpio/msc313-gpio.h
diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index c715d4681a0b..a002f2605fa3 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -370,6 +370,7 @@ source "drivers/clk/ingenic/Kconfig"
 source "drivers/clk/keystone/Kconfig"
 source "drivers/clk/mediatek/Kconfig"
 source "drivers/clk/meson/Kconfig"
+source "drivers/clk/mstar/Kconfig"
 source "drivers/clk/mvebu/Kconfig"
 source "drivers/clk/qcom/Kconfig"
 source "drivers/clk/renesas/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index da8fcf147eb1..b758aae17ab8 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -124,3 +124,4 @@ endif
 obj-$(CONFIG_ARCH_ZX)			+= zte/
 obj-$(CONFIG_ARCH_ZYNQ)			+= zynq/
 obj-$(CONFIG_COMMON_CLK_ZYNQMP)         += zynqmp/
+obj-$(CONFIG_ARCH_MSTARV7)		+= mstar/
diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
new file mode 100644
index 000000000000..23765edde3af
--- /dev/null
+++ b/drivers/clk/mstar/Kconfig
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config MSTAR_MSC313_MPLL
+	bool
+	select REGMAP
+	select REGMAP_MMIO
diff --git a/drivers/clk/mstar/Makefile b/drivers/clk/mstar/Makefile
new file mode 100644
index 000000000000..f8dcd25ede1d
--- /dev/null
+++ b/drivers/clk/mstar/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for mstar specific clk
+#
+
+obj-$(CONFIG_MSTAR_MSC313_MPLL) += clk-msc313-mpll.o
diff --git a/drivers/clk/mstar/clk-msc313-mpll.c b/drivers/clk/mstar/clk-msc313-mpll.c
new file mode 100644
index 000000000000..c1e2fe0fc412
--- /dev/null
+++ b/drivers/clk/mstar/clk-msc313-mpll.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * MStar MSC313 MPLL driver
+ *
+ * Copyright (C) 2020 Daniel Palmer <daniel@thingy.jp>
+ */
+
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#define REG_CONFIG1	0x8
+#define REG_CONFIG2	0xc
+
+static const struct regmap_config msc313_mpll_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.reg_stride = 4,
+};
+
+static const struct reg_field config1_loop_div_first = REG_FIELD(REG_CONFIG1, 8, 9);
+static const struct reg_field config1_input_div_first = REG_FIELD(REG_CONFIG1, 4, 5);
+static const struct reg_field config2_output_div_first = REG_FIELD(REG_CONFIG2, 12, 13);
+static const struct reg_field config2_loop_div_second = REG_FIELD(REG_CONFIG2, 0, 7);
+
+static const unsigned int output_dividers[] = {
+	2, 3, 4, 5, 6, 7, 10
+};
+
+#define NUMOUTPUTS (ARRAY_SIZE(output_dividers) + 1)
+
+struct msc313_mpll {
+	struct clk_hw clk_hw;
+	struct regmap_field *input_div;
+	struct regmap_field *loop_div_first;
+	struct regmap_field *loop_div_second;
+	struct regmap_field *output_div;
+	struct clk_hw_onecell_data *clk_data;
+};
+
+#define to_mpll(_hw) container_of(_hw, struct msc313_mpll, clk_hw)
+#define to_divider_hw(_mpll, _which) _mpll->clk_data->hws[_which + 1]
+
+static unsigned long msc313_mpll_recalc_rate(struct clk_hw *hw,
+		unsigned long parent_rate)
+{
+	struct msc313_mpll *mpll = to_mpll(hw);
+	unsigned int input_div, output_div, loop_first, loop_second;
+	unsigned long output_rate;
+
+	regmap_field_read(mpll->input_div, &input_div);
+	regmap_field_read(mpll->output_div, &output_div);
+	regmap_field_read(mpll->loop_div_first, &loop_first);
+	regmap_field_read(mpll->loop_div_second, &loop_second);
+
+	output_rate = parent_rate / (1 << input_div);
+	output_rate *= (1 << loop_first) * max(loop_second, 1U);
+	output_rate /= max(output_div, 1U);
+
+	return output_rate;
+}
+
+static const struct clk_ops msc313_mpll_ops = {
+		.recalc_rate = msc313_mpll_recalc_rate,
+};
+
+static int msc313_mpll_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct msc313_mpll *mpll;
+	struct clk_init_data clk_init;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	const char *parents[1], *outputnames[NUMOUTPUTS];
+	const int numparents = ARRAY_SIZE(parents);
+	int ret, i;
+
+	if (of_clk_parent_fill(dev->of_node, parents, numparents) != numparents)
+		return -EINVAL;
+
+	if (of_property_read_string_array(pdev->dev.of_node, "clock-output-names",
+			outputnames, NUMOUTPUTS) != NUMOUTPUTS)
+		return -EINVAL;
+
+	mpll = devm_kzalloc(dev, sizeof(*mpll), GFP_KERNEL);
+	if (!mpll)
+		return -ENOMEM;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap = devm_regmap_init_mmio(dev, base, &msc313_mpll_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	mpll->input_div = devm_regmap_field_alloc(dev, regmap, config1_input_div_first);
+	if (IS_ERR(mpll->input_div))
+		return PTR_ERR(mpll->input_div);
+	mpll->output_div = devm_regmap_field_alloc(dev, regmap, config2_output_div_first);
+	if (IS_ERR(mpll->output_div))
+		return PTR_ERR(mpll->output_div);
+	mpll->loop_div_first = devm_regmap_field_alloc(dev, regmap, config1_loop_div_first);
+	if (IS_ERR(mpll->loop_div_first))
+		return PTR_ERR(mpll->loop_div_first);
+	mpll->loop_div_second = devm_regmap_field_alloc(dev, regmap, config2_loop_div_second);
+	if (IS_ERR(mpll->loop_div_second))
+		return PTR_ERR(mpll->loop_div_second);
+
+	mpll->clk_data = devm_kzalloc(dev, struct_size(mpll->clk_data, hws,
+			ARRAY_SIZE(output_dividers)), GFP_KERNEL);
+	if (!mpll->clk_data)
+		return -ENOMEM;
+
+	clk_init.name = outputnames[0];
+	clk_init.ops = &msc313_mpll_ops;
+	clk_init.num_parents = 1;
+	clk_init.parent_names = parents;
+	mpll->clk_hw.init = &clk_init;
+
+	ret = devm_clk_hw_register(dev, &mpll->clk_hw);
+	if (ret)
+		return ret;
+
+	mpll->clk_data->num = NUMOUTPUTS;
+	mpll->clk_data->hws[0] = &mpll->clk_hw;
+
+	for (i = 0; i < ARRAY_SIZE(output_dividers); i++) {
+		to_divider_hw(mpll, i) = clk_hw_register_fixed_factor(dev,
+				outputnames[i + 1], outputnames[0], 0, 1, output_dividers[i]);
+		if (IS_ERR(to_divider_hw(mpll, i))) {
+			ret = PTR_ERR(to_divider_hw(mpll, i));
+			goto unregister_dividers;
+		}
+	}
+
+	platform_set_drvdata(pdev, mpll);
+
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
+			mpll->clk_data);
+
+unregister_dividers:
+	for (i--; i >= 0; i--)
+		clk_hw_unregister_fixed_factor(to_divider_hw(mpll, i));
+	return ret;
+}
+
+static int msc313_mpll_remove(struct platform_device *pdev)
+{
+	struct msc313_mpll *mpll = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(output_dividers); i++)
+		clk_hw_unregister_fixed_factor(to_divider_hw(mpll, i));
+
+	return 0;
+}
+
+static const struct of_device_id msc313_mpll_of_match[] = {
+	{ .compatible = "mstar,msc313-mpll", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, msc313_mpll_of_match);
+
+static struct platform_driver msc313_mpll_driver = {
+	.driver = {
+		.name = "mstar-msc313-mpll",
+		.of_match_table = msc313_mpll_of_match,
+	},
+	.probe = msc313_mpll_probe,
+	.remove = msc313_mpll_remove,
+};
+builtin_platform_driver(msc313_mpll_driver);
-- 
2.29.2

