Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6B327997A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgIZNDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 09:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbgIZNDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 09:03:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D5C0613CE;
        Sat, 26 Sep 2020 06:03:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so6884579wrt.3;
        Sat, 26 Sep 2020 06:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyHYcuzag3zCE8HDyGV0ByNrr9a3q2xQHkSviD6xcfo=;
        b=Eqazko9aJ51tfMF2QDg3Ik71/FfJGuGEUQsfN3t1c2WyDPgGOW6LrpCIZp4a5xz4dd
         2b8D2NCCZovmV/RQLXavnrN2ZLaM8AaOhlTfmDwOGnI+Ru3vV3SZlLX+4C87OjNiUUqM
         8o8XqcRNoXSGCZJqm1lV7h8OgmAlJk2Komq4BM38bKFePv0nSuT8Zi/2v0fxcpK3oBaU
         JNJaSAjRHxbTtMn31gYMnh5WYc89HF6wb+TyLfMcD9Zc0HThQLTg33zTHb5go3WJywKf
         BX+s9uBWlTLEofQLvh3Xz6QvQjeQqbCoYUElcgMcIAclt5BOP6LLV1n4gjFdy3g7FBHH
         GPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyHYcuzag3zCE8HDyGV0ByNrr9a3q2xQHkSviD6xcfo=;
        b=ip953x+Gpc9x2mIWgBPyFGy1L/saOxCGz+dXzH0R8F/VRtxn7cH+ylnM5xud1ublxh
         triQPH9y4JTklxgnvj+/Cj+OMzCmggcCqbFoGCs7VIEiKsCMOMNlTal6Cd6bSpJLqzJ0
         fqfVdXw6xDxWDq03p9ijVkqFy7y00H7vNs7UMAquLmuSmYxzR3dV8vAYOaWLmsJ+/HIC
         BDw6iOs9kgxZdbIoO5ziXD8mNCnga7q10mXLBYigRWEXJWjai3nAP12S5ZGnPXQQqfYH
         s6C2ZkRuEdVwhUh/o8woxkXtuqUAJ8rLYpU25moIfJuyfZQybyELT/KUS6HC8oyqUwTk
         wtJg==
X-Gm-Message-State: AOAM532BhCXDRXOWWJaImg5TazUIBRKkfkSXskRt/k+X3dZjGIXPp2lO
        S3WQNFThmq+EeZ5Dg6AnQKg=
X-Google-Smtp-Source: ABdhPJxr00v8iMrMeDz6BcBbHfTlYxA9Jx7waYr4Z8nBg1D4aySNkQqQCSwWAKchi9V1qHOANn0khw==
X-Received: by 2002:adf:fa0c:: with SMTP id m12mr9345953wrr.406.1601125390780;
        Sat, 26 Sep 2020 06:03:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu ([2.237.20.237])
        by smtp.gmail.com with ESMTPSA id d83sm2853213wmf.23.2020.09.26.06.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 06:03:10 -0700 (PDT)
From:   kholk11@gmail.com
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, sboyd@kernel.org, kholk11@gmail.com,
        marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] clk: qcom: Add SDM660 Multimedia Clock Controller (MMCC) driver
Date:   Sat, 26 Sep 2020 15:03:02 +0200
Message-Id: <20200926130306.13843-2-kholk11@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926130306.13843-1-kholk11@gmail.com>
References: <20200926130306.13843-1-kholk11@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Botka <martin.botka1@gmail.com>

Add a driver for the multimedia clock controller found on SDM660
based devices. This should allow most multimedia device drivers
to probe and control their clocks.

Signed-off-by: Martin Botka <martin.botka1@gmail.com>
Co-Developed-by: Konrad Dybcio <konradybcio@gmail.com>
Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
Tested-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
---
 drivers/clk/qcom/Kconfig                     |    9 +
 drivers/clk/qcom/Makefile                    |    1 +
 drivers/clk/qcom/mmcc-sdm660.c               | 2855 ++++++++++++++++++
 include/dt-bindings/clock/qcom,mmcc-sdm660.h |  162 +
 4 files changed, 3027 insertions(+)
 create mode 100644 drivers/clk/qcom/mmcc-sdm660.c
 create mode 100644 include/dt-bindings/clock/qcom,mmcc-sdm660.h

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 058327310c25..a12d37a4d729 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -357,6 +357,15 @@ config SDM_GCC_660
 	  Say Y if you want to use peripheral devices such as UART, SPI,
 	  i2C, USB, UFS, SDDC, PCIe, etc.
 
+config SDM_MMCC_660
+	tristate "SDM660 Multimedia Clock Controller"
+	select SDM_GCC_660
+	select QCOM_GDSC
+	help
+	  Support for the multimedia clock controller on SDM660 devices.
+	  Say Y if you want to support multimedia devices such as display,
+	  graphics, video encode/decode, camera, etc.
+
 config QCS_TURING_404
 	tristate "QCS404 Turing Clock Controller"
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 9677e769e7e9..ada4f1bbe203 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_SC_VIDEOCC_7180) += videocc-sc7180.o
 obj-$(CONFIG_SDM_CAMCC_845) += camcc-sdm845.o
 obj-$(CONFIG_SDM_DISPCC_845) += dispcc-sdm845.o
 obj-$(CONFIG_SDM_GCC_660) += gcc-sdm660.o
+obj-$(CONFIG_SDM_MMCC_660) += mmcc-sdm660.o
 obj-$(CONFIG_SDM_GCC_845) += gcc-sdm845.o
 obj-$(CONFIG_SDM_GPUCC_845) += gpucc-sdm845.o
 obj-$(CONFIG_SDM_LPASSCC_845) += lpasscc-sdm845.o
diff --git a/drivers/clk/qcom/mmcc-sdm660.c b/drivers/clk/qcom/mmcc-sdm660.c
new file mode 100644
index 000000000000..234aca7c873b
--- /dev/null
+++ b/drivers/clk/qcom/mmcc-sdm660.c
@@ -0,0 +1,2855 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020, Martin Botka <martin.botka1@gmail.com>
+ * Copyright (c) 2020, Konrad Dybcio <konradybcio@gmail.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/clk-provider.h>
+#include <linux/regmap.h>
+#include <linux/reset-controller.h>
+#include <linux/clk.h>
+#include <dt-bindings/clock/qcom,mmcc-sdm660.h>
+
+#include "common.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "clk-alpha-pll.h"
+#include "clk-rcg.h"
+#include "clk-branch.h"
+#include "reset.h"
+#include "gdsc.h"
+
+enum {
+	P_XO,
+	P_DSI0PLL_BYTE,
+	P_DSI0PLL,
+	P_DSI1PLL_BYTE,
+	P_DSI1PLL,
+	P_GPLL0,
+	P_GPLL0_DIV,
+	P_MMPLL0,
+	P_MMPLL10,
+	P_MMPLL3,
+	P_MMPLL4,
+	P_MMPLL5,
+	P_MMPLL6,
+	P_MMPLL7,
+	P_MMPLL8,
+	P_SLEEP_CLK,
+	P_DP_PHY_PLL_LINK_CLK,
+	P_DP_PHY_PLL_VCO_DIV,
+};
+
+static const struct parent_map mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0, 1 },
+	{ P_MMPLL4, 2 },
+	{ P_MMPLL7, 3 },
+	{ P_MMPLL8, 4 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+};
+
+/* Voteable PLL */
+static struct clk_alpha_pll mmpll0 = {
+	.offset = 0xc000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr = {
+		.enable_reg = 0x1f0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll0",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll mmpll6 =  {
+	.offset = 0xf0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr = {
+		.enable_reg = 0x1f0,
+		.enable_mask = BIT(2),
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll6",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+/* APSS controlled PLLs */
+static struct pll_vco vco[] = {
+	{ 1000000000, 2000000000, 0 },
+	{ 750000000, 1500000000, 1 },
+	{ 500000000, 1000000000, 2 },
+	{ 250000000, 500000000, 3 },
+};
+
+static struct pll_vco mmpll3_vco[] = {
+	{ 750000000, 1500000000, 1 },
+};
+
+static const struct alpha_pll_config mmpll10_config = {
+	.l = 0x1e,
+	.config_ctl_val = 0x00004289,
+	.main_output_mask = 0x1,
+};
+
+static struct clk_alpha_pll mmpll10 = {
+	.offset = 0x190,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll10",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct alpha_pll_config mmpll3_config = {
+	.l = 0x2e,
+	.config_ctl_val = 0x4001055b,
+	.vco_val = 0x1 << 20,
+	.vco_mask = 0x3 << 20,
+	.main_output_mask = 0x1,
+};
+
+static struct clk_alpha_pll mmpll3 = {
+	.offset = 0x0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.vco_table = mmpll3_vco,
+	.num_vco = ARRAY_SIZE(mmpll3_vco),
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll3",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct alpha_pll_config mmpll4_config = {
+	.l = 0x28,
+	.config_ctl_val = 0x4001055b,
+	.vco_val = 0x2 << 20,
+	.vco_mask = 0x3 << 20,
+	.main_output_mask = 0x1,
+};
+
+static struct clk_alpha_pll mmpll4 = {
+	.offset = 0x50,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.vco_table = vco,
+	.num_vco = ARRAY_SIZE(vco),
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll4",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct alpha_pll_config mmpll5_config = {
+	.l = 0x2a,
+	.config_ctl_val = 0x4001055b,
+	.alpha_hi = 0xf8,
+	.alpha_en_mask = BIT(24),
+	.vco_val = 0x2 << 20,
+	.vco_mask = 0x3 << 20,
+	.main_output_mask = 0x1,
+};
+
+static struct clk_alpha_pll mmpll5 = {
+	.offset = 0xa0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.vco_table = vco,
+	.num_vco = ARRAY_SIZE(vco),
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll5",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct alpha_pll_config mmpll7_config = {
+	.l = 0x32,
+	.config_ctl_val = 0x4001055b,
+	.vco_val = 0x2 << 20,
+	.vco_mask = 0x3 << 20,
+	.main_output_mask = 0x1,
+};
+
+static struct clk_alpha_pll mmpll7 = {
+	.offset = 0x140,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.vco_table = vco,
+	.num_vco = ARRAY_SIZE(vco),
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll7",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct alpha_pll_config mmpll8_config = {
+	.l = 0x30,
+	.alpha_hi = 0x70,
+	.alpha_en_mask = BIT(24),
+	.config_ctl_val = 0x4001055b,
+	.vco_val = 0x2 << 20,
+	.vco_mask = 0x3 << 20,
+	.main_output_mask = 0x1,
+};
+
+static struct clk_alpha_pll mmpll8 = {
+	.offset = 0x1c0,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.vco_table = vco,
+	.num_vco = ARRAY_SIZE(vco),
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "mmpll8",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct clk_parent_data mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &mmpll0.clkr.hw },
+	{ .hw = &mmpll4.clkr.hw },
+	{ .hw = &mmpll7.clkr.hw },
+	{ .hw = &mmpll8.clkr.hw },
+	{ .fw_name = "gpll0" },
+	{ .fw_name = "gpll0_div" },
+};
+
+static const struct parent_map mmcc_xo_dsibyte_map[] = {
+	{ P_XO, 0 },
+	{ P_DSI0PLL_BYTE, 1 },
+	{ P_DSI1PLL_BYTE, 2 },
+};
+
+static const struct clk_parent_data mmcc_xo_dsibyte[] = {
+	{ .fw_name = "xo" },
+	{ .fw_name = "dsi0pllbyte" },
+	{ .fw_name = "dsi1pllbyte" },
+};
+
+static const struct parent_map mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0, 1 },
+	{ P_MMPLL4, 2 },
+	{ P_MMPLL7, 3 },
+	{ P_MMPLL10, 4 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+};
+
+static const struct clk_parent_data mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &mmpll0.clkr.hw },
+	{ .hw = &mmpll4.clkr.hw },
+	{ .hw = &mmpll7.clkr.hw },
+	{ .hw = &mmpll10.clkr.hw },
+	{ .fw_name = "gpll0" },
+	{ .fw_name = "gpll0_div" },
+};
+
+static const struct parent_map mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL4, 1 },
+	{ P_MMPLL7, 2 },
+	{ P_MMPLL10, 3 },
+	{ P_SLEEP_CLK, 4 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+};
+
+static const struct clk_parent_data mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &mmpll4.clkr.hw },
+	{ .hw = &mmpll7.clkr.hw },
+	{ .hw = &mmpll10.clkr.hw },
+	{ .fw_name = "sleep_clk" },
+	{ .fw_name = "gpll0" },
+	{ .fw_name = "gpll0_div" },
+};
+
+static const struct parent_map mmcc_xo_mmpll0_mmpll7_mmpll10_sleep_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0, 1 },
+	{ P_MMPLL7, 2 },
+	{ P_MMPLL10, 3 },
+	{ P_SLEEP_CLK, 4 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+};
+
+static const struct clk_parent_data mmcc_xo_mmpll0_mmpll7_mmpll10_sleep_gpll0_gpll0_div[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &mmpll0.clkr.hw },
+	{ .hw = &mmpll7.clkr.hw },
+	{ .hw = &mmpll10.clkr.hw },
+	{ .fw_name = "sleep_clk" },
+	{ .fw_name = "gpll0" },
+	{ .fw_name = "gpll0_div" },
+};
+
+static const struct parent_map mmcc_xo_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+};
+
+static const struct clk_parent_data mmcc_xo_gpll0_gpll0_div[] = {
+	{ .fw_name = "xo" },
+	{ .fw_name = "gpll0" },
+	{ .fw_name = "gpll0_div" },
+};
+
+static const struct parent_map mmcc_xo_dplink_dpvco_map[] = {
+	{ P_XO, 0 },
+	{ P_DP_PHY_PLL_LINK_CLK, 1 },
+	{ P_DP_PHY_PLL_VCO_DIV, 2 },
+};
+
+static const struct clk_parent_data mmcc_xo_dplink_dpvco[] = {
+	{ .fw_name = "xo" },
+	{ .fw_name = "dp_link_2x_clk_divsel_five" },
+	{ .fw_name = "dp_vco_divided_clk_src_mux" },
+};
+
+static const struct parent_map mmcc_xo_mmpll0_mmpll5_mmpll7_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0, 1 },
+	{ P_MMPLL5, 2 },
+	{ P_MMPLL7, 3 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+};
+
+static const struct clk_parent_data mmcc_xo_mmpll0_mmpll5_mmpll7_gpll0_gpll0_div[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &mmpll0.clkr.hw },
+	{ .hw = &mmpll5.clkr.hw },
+	{ .hw = &mmpll7.clkr.hw },
+	{ .fw_name = "gpll0" },
+	{ .fw_name = "gpll0_div" },
+};
+
+static const struct parent_map mmcc_xo_dsi0pll_dsi1pll_map[] = {
+	{ P_XO, 0 },
+	{ P_DSI0PLL, 1 },
+	{ P_DSI1PLL, 2 },
+};
+
+static const struct clk_parent_data mmcc_xo_dsi0pll_dsi1pll[] = {
+	{ .fw_name = "xo" },
+	{ .fw_name = "dsi0pll" },
+	{ .fw_name = "dsi1pll" },
+};
+
+static const struct parent_map mmcc_mmpll0_mmpll4_mmpll7_mmpll10_mmpll6_gpll0_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0, 1 },
+	{ P_MMPLL4, 2 },
+	{ P_MMPLL7, 3 },
+	{ P_MMPLL10, 4 },
+	{ P_MMPLL6, 5 },
+	{ P_GPLL0, 6 },
+};
+
+static const struct clk_parent_data mmcc_mmpll0_mmpll4_mmpll7_mmpll10_mmpll6_gpll0[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &mmpll0.clkr.hw },
+	{ .hw = &mmpll4.clkr.hw },
+	{ .hw = &mmpll7.clkr.hw },
+	{ .hw = &mmpll10.clkr.hw },
+	{ .hw = &mmpll6.clkr.hw },
+	{ .fw_name = "gpll0" },
+};
+
+static const struct parent_map mmcc_xo_mmpll0_gpll0_gpll0_div_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0, 1 },
+	{ P_GPLL0, 5 },
+	{ P_GPLL0_DIV, 6 },
+};
+
+static const struct clk_parent_data mmcc_xo_mmpll0_gpll0_gpll0_div[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &mmpll0.clkr.hw },
+	{ .fw_name = "gpll0" },
+	{ .fw_name = "gpll0_div" },
+};
+
+static const struct parent_map mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_mmpll6_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0, 1 },
+	{ P_MMPLL4, 2 },
+	{ P_MMPLL7, 3 },
+	{ P_MMPLL10, 4 },
+	{ P_GPLL0, 5 },
+	{ P_MMPLL6, 6 },
+};
+
+static const struct clk_parent_data mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_mmpll6[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &mmpll0.clkr.hw },
+	{ .hw = &mmpll4.clkr.hw },
+	{ .hw = &mmpll7.clkr.hw },
+	{ .hw = &mmpll10.clkr.hw },
+	{ .fw_name = "gpll0" },
+	{ .hw = &mmpll6.clkr.hw },
+};
+
+static const struct parent_map mmcc_xo_mmpll0_mmpll8_mmpll3_mmpll6_gpll0_mmpll7_map[] = {
+	{ P_XO, 0 },
+	{ P_MMPLL0, 1 },
+	{ P_MMPLL8, 2 },
+	{ P_MMPLL3, 3 },
+	{ P_MMPLL6, 4 },
+	{ P_GPLL0, 5 },
+	{ P_MMPLL7, 6 },
+};
+
+static const struct clk_parent_data mmcc_xo_mmpll0_mmpll8_mmpll3_mmpll6_gpll0_mmpll7[] = {
+	{ .fw_name = "xo" },
+	{ .hw = &mmpll0.clkr.hw },
+	{ .hw = &mmpll8.clkr.hw },
+	{ .hw = &mmpll3.clkr.hw },
+	{ .hw = &mmpll6.clkr.hw },
+	{ .fw_name = "gpll0" },
+	{ .hw = &mmpll7.clkr.hw },
+};
+
+static const struct freq_tbl ftbl_ahb_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(40000000, P_GPLL0_DIV, 7.5, 0, 0),
+	F(80800000, P_MMPLL0, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 ahb_clk_src = {
+	.cmd_rcgr = 0x5000,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_ahb_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "ahb_clk_src",
+		.parent_data = mmcc_xo_mmpll0_gpll0_gpll0_div,
+		.num_parents = 4,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 byte0_clk_src = {
+	.cmd_rcgr = 0x2120,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dsibyte_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "byte0_clk_src",
+		.parent_data = mmcc_xo_dsibyte,
+		.num_parents = 3,
+		.ops = &clk_byte2_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_rcg2 byte1_clk_src = {
+	.cmd_rcgr = 0x2140,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dsibyte_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "byte1_clk_src",
+		.parent_data = mmcc_xo_dsibyte,
+		.num_parents = 3,
+		.ops = &clk_byte2_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static const struct freq_tbl ftbl_camss_gp0_clk_src[] = {
+	F(10000, P_XO, 16, 1, 120),
+	F(24000, P_XO, 16, 1, 50),
+	F(6000000, P_GPLL0_DIV, 10, 1, 5),
+	F(12000000, P_GPLL0_DIV, 10, 2, 5),
+	F(13043478, P_GPLL0_DIV, 1, 1, 23),
+	F(24000000, P_GPLL0_DIV, 1, 2, 25),
+	F(50000000, P_GPLL0_DIV, 6, 0, 0),
+	F(100000000, P_GPLL0_DIV, 3, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 camss_gp0_clk_src = {
+	.cmd_rcgr = 0x3420,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll7_mmpll10_sleep_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_camss_gp0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camss_gp0_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll7_mmpll10_sleep_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 camss_gp1_clk_src = {
+	.cmd_rcgr = 0x3450,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll7_mmpll10_sleep_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_camss_gp0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "camss_gp1_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll7_mmpll10_sleep_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cci_clk_src[] = {
+	F(37500000, P_GPLL0_DIV, 8, 0, 0),
+	F(50000000, P_GPLL0_DIV, 6, 0, 0),
+	F(100000000, P_GPLL0, 6, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cci_clk_src = {
+	.cmd_rcgr = 0x3300,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll7_mmpll10_sleep_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_cci_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cci_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll7_mmpll10_sleep_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_cpp_clk_src[] = {
+	F(120000000, P_GPLL0, 5, 0, 0),
+	F(256000000, P_MMPLL4, 3, 0, 0),
+	F(384000000, P_MMPLL4, 2, 0, 0),
+	F(480000000, P_MMPLL7, 2, 0, 0),
+	F(540000000, P_MMPLL6, 2, 0, 0),
+	F(576000000, P_MMPLL10, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 cpp_clk_src = {
+	.cmd_rcgr = 0x3640,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dsibyte_map,
+	.freq_tbl = ftbl_cpp_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "cpp_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_mmpll6,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csi0_clk_src[] = {
+	F(100000000, P_GPLL0_DIV, 3, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(310000000, P_MMPLL8, 3, 0, 0),
+	F(404000000, P_MMPLL0, 2, 0, 0),
+	F(465000000, P_MMPLL8, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csi0_clk_src = {
+	.cmd_rcgr = 0x3090,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi0_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csi0phytimer_clk_src[] = {
+	F(100000000, P_GPLL0_DIV, 3, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(269333333, P_MMPLL0, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csi0phytimer_clk_src = {
+	.cmd_rcgr = 0x3000,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi0phytimer_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi1_clk_src = {
+	.cmd_rcgr = 0x3100,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi1_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi1phytimer_clk_src = {
+	.cmd_rcgr = 0x3030,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi1phytimer_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi2_clk_src = {
+	.cmd_rcgr = 0x3160,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi2_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi2phytimer_clk_src = {
+	.cmd_rcgr = 0x3060,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi0phytimer_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi2phytimer_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 csi3_clk_src = {
+	.cmd_rcgr = 0x31c0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csi0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csi3_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_csiphy_clk_src[] = {
+	F(100000000, P_GPLL0_DIV, 3, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(269333333, P_MMPLL0, 3, 0, 0),
+	F(320000000, P_MMPLL7, 3, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 csiphy_clk_src = {
+	.cmd_rcgr = 0x3800,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_csiphy_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "csiphy_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll8_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dp_aux_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dp_aux_clk_src = {
+	.cmd_rcgr = 0x2260,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_dp_aux_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "dp_aux_clk_src",
+		.parent_data = mmcc_xo_gpll0_gpll0_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dp_crypto_clk_src[] = {
+	F(101250, P_DP_PHY_PLL_VCO_DIV, 4, 0, 0),
+	F(168750, P_DP_PHY_PLL_VCO_DIV, 4, 0, 0),
+	F(337500, P_DP_PHY_PLL_VCO_DIV, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dp_crypto_clk_src = {
+	.cmd_rcgr = 0x2220,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dplink_dpvco_map,
+	.freq_tbl = ftbl_dp_crypto_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "dp_crypto_clk_src",
+		.parent_data = mmcc_xo_dplink_dpvco,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dp_gtc_clk_src[] = {
+	F(40000000, P_GPLL0_DIV, 7.5, 0, 0),
+	F(60000000, P_GPLL0, 10, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dp_gtc_clk_src = {
+	.cmd_rcgr = 0x2280,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_dp_gtc_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "dp_gtc_clk_src",
+		.parent_data = mmcc_xo_gpll0_gpll0_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_dp_link_clk_src[] = {
+	F(162000, P_DP_PHY_PLL_LINK_CLK, 2, 0, 0),
+	F(270000, P_DP_PHY_PLL_LINK_CLK, 2, 0, 0),
+	F(540000, P_DP_PHY_PLL_LINK_CLK, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 dp_link_clk_src = {
+	.cmd_rcgr = 0x2200,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dplink_dpvco_map,
+	.freq_tbl = ftbl_dp_link_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "dp_link_clk_src",
+		.parent_data = mmcc_xo_dplink_dpvco,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+		.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_rcg2 dp_pixel_clk_src = {
+	.cmd_rcgr = 0x2240,
+	.mnd_width = 16,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dplink_dpvco_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "dp_pixel_clk_src",
+		.parent_data = mmcc_xo_dplink_dpvco,
+		.num_parents = 3,
+		.ops = &clk_dp_ops,
+		.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_rcg2 esc0_clk_src = {
+	.cmd_rcgr = 0x2160,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dsibyte_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "esc0_clk_src",
+		.parent_data = mmcc_xo_dsibyte,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 esc1_clk_src = {
+	.cmd_rcgr = 0x2180,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dsibyte_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "esc1_clk_src",
+		.parent_data = mmcc_xo_dsibyte,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_jpeg0_clk_src[] = {
+	F(66666667, P_GPLL0_DIV, 4.5, 0, 0),
+	F(133333333, P_GPLL0, 4.5, 0, 0),
+	F(219428571, P_MMPLL4, 3.5, 0, 0),
+	F(320000000, P_MMPLL7, 3, 0, 0),
+	F(480000000, P_MMPLL7, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 jpeg0_clk_src = {
+	.cmd_rcgr = 0x3500,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_jpeg0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "jpeg0_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_mclk0_clk_src[] = {
+	F(4800000, P_XO, 4, 0, 0),
+	F(6000000, P_GPLL0_DIV, 10, 1, 5),
+	F(8000000, P_GPLL0_DIV, 1, 2, 75),
+	F(9600000, P_XO, 2, 0, 0),
+	F(16666667, P_GPLL0_DIV, 2, 1, 9),
+	F(19200000, P_XO, 1, 0, 0),
+	F(24000000, P_MMPLL10, 1, 1, 24),
+	F(33333333, P_GPLL0_DIV, 1, 1, 9),
+	F(48000000, P_GPLL0, 1, 2, 25),
+	F(66666667, P_GPLL0, 1, 1, 9),
+	{ }
+};
+
+static struct clk_rcg2 mclk0_clk_src = {
+	.cmd_rcgr = 0x3360,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk0_clk_src",
+		.parent_data = mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 mclk1_clk_src = {
+	.cmd_rcgr = 0x3390,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk1_clk_src",
+		.parent_data = mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 mclk2_clk_src = {
+	.cmd_rcgr = 0x33c0,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk2_clk_src",
+		.parent_data = mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 mclk3_clk_src = {
+	.cmd_rcgr = 0x33f0,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mclk0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mclk3_clk_src",
+		.parent_data = mmcc_xo_mmpll4_mmpll7_mmpll10_sleep_gpll0_gpll0_div,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_mdp_clk_src[] = {
+	F(100000000, P_GPLL0_DIV, 3, 0, 0),
+	F(150000000, P_GPLL0_DIV, 2, 0, 0),
+	F(171428571, P_GPLL0, 3.5, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(275000000, P_MMPLL5, 3, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	F(330000000, P_MMPLL5, 2.5, 0, 0),
+	F(412500000, P_MMPLL5, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 mdp_clk_src = {
+	.cmd_rcgr = 0x2040,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll5_mmpll7_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_mdp_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "mdp_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll5_mmpll7_gpll0_gpll0_div,
+		.num_parents = 6,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 pclk0_clk_src = {
+	.cmd_rcgr = 0x2000,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dsi0pll_dsi1pll_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pclk0_clk_src",
+		.parent_data = mmcc_xo_dsi0pll_dsi1pll,
+		.num_parents = 3,
+		.ops = &clk_pixel_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static struct clk_rcg2 pclk1_clk_src = {
+	.cmd_rcgr = 0x2020,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_dsi0pll_dsi1pll_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "pclk1_clk_src",
+		.parent_data = mmcc_xo_dsi0pll_dsi1pll,
+		.num_parents = 3,
+		.ops = &clk_pixel_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+	},
+};
+
+static const struct freq_tbl ftbl_rot_clk_src[] = {
+	F(171428571, P_GPLL0, 3.5, 0, 0),
+	F(275000000, P_MMPLL5, 3, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	F(330000000, P_MMPLL5, 2.5, 0, 0),
+	F(412500000, P_MMPLL5, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 rot_clk_src = {
+	.cmd_rcgr = 0x21a0,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll5_mmpll7_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_rot_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "rot_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll5_mmpll7_gpll0_gpll0_div,
+		.num_parents = 6,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_vfe0_clk_src[] = {
+	F(120000000, P_GPLL0, 5, 0, 0),
+	F(200000000, P_GPLL0, 3, 0, 0),
+	F(256000000, P_MMPLL4, 3, 0, 0),
+	F(300000000, P_GPLL0, 2, 0, 0),
+	F(404000000, P_MMPLL0, 2, 0, 0),
+	F(480000000, P_MMPLL7, 2, 0, 0),
+	F(540000000, P_MMPLL6, 2, 0, 0),
+	F(576000000, P_MMPLL10, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 vfe0_clk_src = {
+	.cmd_rcgr = 0x3600,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_mmpll0_mmpll4_mmpll7_mmpll10_mmpll6_gpll0_map,
+	.freq_tbl = ftbl_vfe0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vfe0_clk_src",
+		.parent_data = mmcc_mmpll0_mmpll4_mmpll7_mmpll10_mmpll6_gpll0,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_rcg2 vfe1_clk_src = {
+	.cmd_rcgr = 0x3620,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_mmpll0_mmpll4_mmpll7_mmpll10_mmpll6_gpll0_map,
+	.freq_tbl = ftbl_vfe0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vfe1_clk_src",
+		.parent_data = mmcc_mmpll0_mmpll4_mmpll7_mmpll10_mmpll6_gpll0,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_video_core_clk_src[] = {
+	F(133333333, P_GPLL0, 4.5, 0, 0),
+	F(269333333, P_MMPLL0, 3, 0, 0),
+	F(320000000, P_MMPLL7, 3, 0, 0),
+	F(404000000, P_MMPLL0, 2, 0, 0),
+	F(441600000, P_MMPLL3, 2, 0, 0),
+	F(518400000, P_MMPLL3, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 video_core_clk_src = {
+	.cmd_rcgr = 0x1000,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_mmpll0_mmpll8_mmpll3_mmpll6_gpll0_mmpll7_map,
+	.freq_tbl = ftbl_video_core_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "video_core_clk_src",
+		.parent_data = mmcc_xo_mmpll0_mmpll8_mmpll3_mmpll6_gpll0_mmpll7,
+		.num_parents = 7,
+		.ops = &clk_rcg2_ops,
+		.flags = CLK_IS_CRITICAL,
+	},
+};
+
+static struct clk_rcg2 vsync_clk_src = {
+	.cmd_rcgr = 0x2080,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = mmcc_xo_gpll0_gpll0_div_map,
+	.freq_tbl = ftbl_dp_aux_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "vsync_clk_src",
+		.parent_data = mmcc_xo_gpll0_gpll0_div,
+		.num_parents = 3,
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch bimc_smmu_ahb_clk = {
+	.halt_reg = 0xe004,
+	.halt_check = BRANCH_VOTED,
+	.hwcg_reg = 0xe004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0xe004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "bimc_smmu_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch bimc_smmu_axi_clk = {
+	.halt_reg = 0xe008,
+	.halt_check = BRANCH_VOTED,
+	.hwcg_reg = 0xe008,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0xe008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "bimc_smmu_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_ahb_clk = {
+	.halt_reg = 0x348c,
+	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x348c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x348c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cci_ahb_clk = {
+	.halt_reg = 0x3348,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3348,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cci_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cci_clk = {
+	.halt_reg = 0x3344,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3344,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cci_clk",
+			.parent_hws = (const struct clk_hw *[]){ &cci_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cphy_csid0_clk = {
+	.halt_reg = 0x3730,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3730,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cphy_csid0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csiphy_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cphy_csid1_clk = {
+	.halt_reg = 0x3734,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3734,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cphy_csid1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csiphy_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cphy_csid2_clk = {
+	.halt_reg = 0x3738,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3738,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cphy_csid2_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csiphy_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cphy_csid3_clk = {
+	.halt_reg = 0x373c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x373c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cphy_csid3_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csiphy_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cpp_ahb_clk = {
+	.halt_reg = 0x36b4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x36b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cpp_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cpp_axi_clk = {
+	.halt_reg = 0x36c4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x36c4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cpp_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cpp_clk = {
+	.halt_reg = 0x36b0,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x36b0,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cpp_clk",
+			.parent_hws = (const struct clk_hw *[]){ &cpp_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_cpp_vbif_ahb_clk = {
+	.halt_reg = 0x36c8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x36c8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_cpp_vbif_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0_ahb_clk = {
+	.halt_reg = 0x30bc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x30bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0_clk = {
+	.halt_reg = 0x30b4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x30b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0phytimer_clk = {
+	.halt_reg = 0x3024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0phytimer_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi0phytimer_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0pix_clk = {
+	.halt_reg = 0x30e4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x30e4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0pix_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi0rdi_clk = {
+	.halt_reg = 0x30d4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x30d4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi0rdi_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1_ahb_clk = {
+	.halt_reg = 0x3128,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3128,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1_clk = {
+	.halt_reg = 0x3124,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3124,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1phytimer_clk = {
+	.halt_reg = 0x3054,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3054,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1phytimer_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi1phytimer_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1pix_clk = {
+	.halt_reg = 0x3154,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3154,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1pix_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi1rdi_clk = {
+	.halt_reg = 0x3144,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3144,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi1rdi_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2_ahb_clk = {
+	.halt_reg = 0x3188,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3188,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2_clk = {
+	.halt_reg = 0x3184,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3184,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi2_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2phytimer_clk = {
+	.halt_reg = 0x3084,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3084,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2phytimer_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi2phytimer_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2pix_clk = {
+	.halt_reg = 0x31b4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x31b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2pix_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi2_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi2rdi_clk = {
+	.halt_reg = 0x31a4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x31a4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi2rdi_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi2_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi3_ahb_clk = {
+	.halt_reg = 0x31e8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x31e8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi3_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi3_clk = {
+	.halt_reg = 0x31e4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x31e4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi3_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi3_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi3pix_clk = {
+	.halt_reg = 0x3214,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3214,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi3pix_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi3_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi3rdi_clk = {
+	.halt_reg = 0x3204,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3204,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi3rdi_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csi3_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi_vfe0_clk = {
+	.halt_reg = 0x3704,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3704,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi_vfe0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &vfe0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csi_vfe1_clk = {
+	.halt_reg = 0x3714,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3714,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csi_vfe1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &vfe1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csiphy0_clk = {
+	.halt_reg = 0x3740,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3740,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csiphy0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csiphy_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csiphy1_clk = {
+	.halt_reg = 0x3744,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3744,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csiphy1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csiphy_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_csiphy2_clk = {
+	.halt_reg = 0x3748,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3748,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_csiphy2_clk",
+			.parent_hws = (const struct clk_hw *[]){ &csiphy_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_gp0_clk = {
+	.halt_reg = 0x3444,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3444,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_gp0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &camss_gp0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_gp1_clk = {
+	.halt_reg = 0x3474,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3474,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_gp1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &camss_gp1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_ispif_ahb_clk = {
+	.halt_reg = 0x3224,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3224,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_ispif_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_jpeg0_clk = {
+	.halt_reg = 0x35a8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x35a8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_jpeg0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &jpeg0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_jpeg_ahb_clk = {
+	.halt_reg = 0x35b4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x35b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_jpeg_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_jpeg_axi_clk = {
+	.halt_reg = 0x35b8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x35b8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_jpeg_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch throttle_camss_axi_clk = {
+	.halt_reg = 0x3c3c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3c3c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "throttle_camss_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_mclk0_clk = {
+	.halt_reg = 0x3384,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3384,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_mclk0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &mclk0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_mclk1_clk = {
+	.halt_reg = 0x33b4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x33b4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_mclk1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &mclk1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_mclk2_clk = {
+	.halt_reg = 0x33e4,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x33e4,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_mclk2_clk",
+			.parent_hws = (const struct clk_hw *[]){ &mclk2_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_mclk3_clk = {
+	.halt_reg = 0x3414,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3414,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_mclk3_clk",
+			.parent_hws = (const struct clk_hw *[]){ &mclk3_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_micro_ahb_clk = {
+	.halt_reg = 0x3494,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3494,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_micro_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_top_ahb_clk = {
+	.halt_reg = 0x3484,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3484,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_top_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe0_ahb_clk = {
+	.halt_reg = 0x3668,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3668,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe0_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe0_clk = {
+	.halt_reg = 0x36a8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x36a8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &vfe0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe0_stream_clk = {
+	.halt_reg = 0x3720,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3720,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe0_stream_clk",
+			.parent_hws = (const struct clk_hw *[]){ &vfe0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe1_ahb_clk = {
+	.halt_reg = 0x3678,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3678,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe1_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe1_clk = {
+	.halt_reg = 0x36ac,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x36ac,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &vfe1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe1_stream_clk = {
+	.halt_reg = 0x3724,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x3724,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe1_stream_clk",
+			.parent_hws = (const struct clk_hw *[]){ &vfe1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe_vbif_ahb_clk = {
+	.halt_reg = 0x36b8,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x36b8,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe_vbif_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch camss_vfe_vbif_axi_clk = {
+	.halt_reg = 0x36bc,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x36bc,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "camss_vfe_vbif_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch csiphy_ahb2crif_clk = {
+	.halt_reg = 0x374c,
+	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x374c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x374c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "csiphy_ahb2crif_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_ahb_clk = {
+	.halt_reg = 0x2308,
+	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x8a004,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x2308,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.flags = CLK_SET_RATE_PARENT,
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static const struct freq_tbl ftbl_axi_clk_src[] = {
+		F(75000000, P_GPLL0, 8, 0, 0),
+		F(171428571, P_GPLL0, 3.5, 0, 0),
+		F(240000000, P_GPLL0, 2.5, 0, 0),
+		F(323200000, P_MMPLL0, 2.5, 0, 0),
+		F(406000000, P_MMPLL0, 2, 0, 0),
+		{ }
+};
+
+/* RO to linux */
+static struct clk_rcg2 axi_clk_src = {
+		.cmd_rcgr = 0xd000,
+		.hid_width = 5,
+		.parent_map = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div_map,
+		.freq_tbl = ftbl_axi_clk_src,
+		.clkr.hw.init = &(struct clk_init_data){
+				.name = "axi_clk_src",
+				.parent_data = mmcc_xo_mmpll0_mmpll4_mmpll7_mmpll10_gpll0_gpll0_div,
+				.num_parents = 7,
+				.ops = &clk_rcg2_ops,
+		},
+};
+
+static struct clk_branch mdss_axi_clk = {
+	.halt_reg = 0x2310,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2310,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_axi_clk",
+			.parent_hws = (const struct clk_hw *[]){ &axi_clk_src.clkr.hw },
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch throttle_mdss_axi_clk = {
+	.halt_reg = 0x246c,
+	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x246c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x246c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "throttle_mdss_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_byte0_clk = {
+	.halt_reg = 0x233c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x233c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &byte0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div mdss_byte0_intf_div_clk = {
+	.reg = 0x237c,
+	.shift = 0,
+	.width = 2,
+	/*
+	 * NOTE: Op does not work for div-3. Current assumption is that div-3
+	 * is not a recommended setting for this divider.
+	 */
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte0_intf_div_clk",
+			.parent_hws = (const struct clk_hw *[]){ &byte0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_regmap_div_ops,
+			.flags = CLK_GET_RATE_NOCACHE,
+		},
+	},
+};
+
+static struct clk_branch mdss_byte0_intf_clk = {
+	.halt_reg = 0x2374,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2374,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte0_intf_clk",
+			.parent_hws = (const struct clk_hw *[]){ &mdss_byte0_intf_div_clk.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_byte1_clk = {
+	.halt_reg = 0x2340,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2340,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &byte1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap_div mdss_byte1_intf_div_clk = {
+	.reg = 0x2380,
+	.shift = 0,
+	.width = 2,
+	/*
+	 * NOTE: Op does not work for div-3. Current assumption is that div-3
+	 * is not a recommended setting for this divider.
+	 */
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte1_intf_div_clk",
+			.parent_hws = (const struct clk_hw *[]){ &byte1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_regmap_div_ops,
+			.flags = CLK_GET_RATE_NOCACHE,
+		},
+	},
+};
+
+static struct clk_branch mdss_byte1_intf_clk = {
+	.halt_reg = 0x2378,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2378,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_byte1_intf_clk",
+			.parent_hws = (const struct clk_hw *[]){ &mdss_byte1_intf_div_clk.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_aux_clk = {
+	.halt_reg = 0x2364,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2364,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_aux_clk",
+			.parent_hws = (const struct clk_hw *[]){ &dp_aux_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_crypto_clk = {
+	.halt_reg = 0x235c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x235c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_crypto_clk",
+			.parent_hws = (const struct clk_hw *[]){ &dp_crypto_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_gtc_clk = {
+	.halt_reg = 0x2368,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2368,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_gtc_clk",
+			.parent_hws = (const struct clk_hw *[]){ &dp_gtc_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_link_clk = {
+	.halt_reg = 0x2354,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2354,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_link_clk",
+			.parent_hws = (const struct clk_hw *[]){ &dp_link_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+/* Reset state of MDSS_DP_LINK_INTF_DIV is 0x3 (div-4) */
+static struct clk_branch mdss_dp_link_intf_clk = {
+	.halt_reg = 0x2358,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2358,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_link_intf_clk",
+			.parent_hws = (const struct clk_hw *[]){ &dp_link_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_dp_pixel_clk = {
+	.halt_reg = 0x2360,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2360,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_dp_pixel_clk",
+			.parent_hws = (const struct clk_hw *[]){ &dp_pixel_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_GET_RATE_NOCACHE | CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_esc0_clk = {
+	.halt_reg = 0x2344,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2344,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_esc0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &esc0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_esc1_clk = {
+	.halt_reg = 0x2348,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2348,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_esc1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &esc1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_hdmi_dp_ahb_clk = {
+	.halt_reg = 0x230c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x230c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_hdmi_dp_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_mdp_clk = {
+	.halt_reg = 0x231c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x231c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_mdp_clk",
+			.parent_hws = (const struct clk_hw *[]){ &mdp_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_pclk0_clk = {
+	.halt_reg = 0x2314,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2314,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_pclk0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &pclk0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_pclk1_clk = {
+	.halt_reg = 0x2318,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2318,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_pclk1_clk",
+			.parent_hws = (const struct clk_hw *[]){ &pclk1_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_rot_clk = {
+	.halt_reg = 0x2350,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2350,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_rot_clk",
+			.parent_hws = (const struct clk_hw *[]){ &rot_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mdss_vsync_clk = {
+	.halt_reg = 0x2328,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2328,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mdss_vsync_clk",
+			.parent_hws = (const struct clk_hw *[]){ &vsync_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch mnoc_ahb_clk = {
+	.halt_reg = 0x5024,
+	.halt_check = BRANCH_VOTED,
+	.clkr = {
+		.enable_reg = 0x5024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "mnoc_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch misc_ahb_clk = {
+	.halt_reg = 0x328,
+	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x328,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x328,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "misc_ahb_clk",
+			/*
+			 * Dependency to be enabled before the branch is
+			 * enabled.
+			 */
+			.parent_hws = (const struct clk_hw *[]){ &mnoc_ahb_clk.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch misc_cxo_clk = {
+	.halt_reg = 0x324,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x324,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "misc_cxo_clk",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "xo",
+			},
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch snoc_dvm_axi_clk = {
+	.halt_reg = 0xe040,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0xe040,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "snoc_dvm_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_ahb_clk = {
+	.halt_reg = 0x1030,
+	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x1030,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x1030,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_ahb_clk",
+			.parent_hws = (const struct clk_hw *[]){ &ahb_clk_src.clkr.hw },
+			.num_parents = 1,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_axi_clk = {
+	.halt_reg = 0x1034,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1034,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch throttle_video_axi_clk = {
+	.halt_reg = 0x118c,
+	.halt_check = BRANCH_HALT,
+	.hwcg_reg = 0x118c,
+	.hwcg_bit = 1,
+	.clkr = {
+		.enable_reg = 0x118c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "throttle_video_axi_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_core_clk = {
+	.halt_reg = 0x1028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_core_clk",
+			.parent_hws = (const struct clk_hw *[]){ &video_core_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch video_subcore0_clk = {
+	.halt_reg = 0x1048,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1048,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "video_subcore0_clk",
+			.parent_hws = (const struct clk_hw *[]){ &video_core_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc venus_gdsc = {
+	.gdscr = 0x1024,
+	.pd = {
+		.name = "venus",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc venus_core0_gdsc = {
+	.gdscr = 0x1040,
+	.pd = {
+		.name = "venus_core0",
+	},
+	.parent = &venus_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc mdss_gdsc = {
+	.gdscr = 0x2304,
+	.pd = {
+		.name = "mdss",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camss_top_gdsc = {
+	.gdscr = 0x34a0,
+	.pd = {
+		.name = "camss_top",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camss_vfe0_gdsc = {
+	.gdscr = 0x3664,
+	.pd = {
+		.name = "camss_vfe0",
+	},
+	.parent = &camss_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camss_vfe1_gdsc = {
+	.gdscr = 0x3674,
+	.pd = {
+		.name = "camss_vfe1_gdsc",
+	},
+	.parent = &camss_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc camss_cpp_gdsc = {
+	.gdscr = 0x36d4,
+	.pd = {
+		.name = "camss_cpp",
+	},
+	.parent = &camss_top_gdsc.pd,
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+/* This GDSC seems to hang the whole multimedia subsystem.
+static struct gdsc bimc_smmu_gdsc = {
+	.gdscr = 0xe020,
+	.gds_hw_ctrl = 0xe024,
+	.pd = {
+		.name = "bimc_smmu",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.parent = &bimc_smmu_gdsc.pd,
+	.flags = HW_CTRL,
+};
+*/
+
+static struct clk_regmap *mmcc_660_clocks[] = {
+	[AHB_CLK_SRC] = &ahb_clk_src.clkr,
+	[BYTE0_CLK_SRC] = &byte0_clk_src.clkr,
+	[BYTE1_CLK_SRC] = &byte1_clk_src.clkr,
+	[CAMSS_GP0_CLK_SRC] = &camss_gp0_clk_src.clkr,
+	[CAMSS_GP1_CLK_SRC] = &camss_gp1_clk_src.clkr,
+	[CCI_CLK_SRC] = &cci_clk_src.clkr,
+	[CPP_CLK_SRC] = &cpp_clk_src.clkr,
+	[CSI0_CLK_SRC] = &csi0_clk_src.clkr,
+	[CSI0PHYTIMER_CLK_SRC] = &csi0phytimer_clk_src.clkr,
+	[CSI1_CLK_SRC] = &csi1_clk_src.clkr,
+	[CSI1PHYTIMER_CLK_SRC] = &csi1phytimer_clk_src.clkr,
+	[CSI2_CLK_SRC] = &csi2_clk_src.clkr,
+	[CSI2PHYTIMER_CLK_SRC] = &csi2phytimer_clk_src.clkr,
+	[CSI3_CLK_SRC] = &csi3_clk_src.clkr,
+	[CSIPHY_CLK_SRC] = &csiphy_clk_src.clkr,
+	[DP_AUX_CLK_SRC] = &dp_aux_clk_src.clkr,
+	[DP_CRYPTO_CLK_SRC] = &dp_crypto_clk_src.clkr,
+	[DP_GTC_CLK_SRC] = &dp_gtc_clk_src.clkr,
+	[DP_LINK_CLK_SRC] = &dp_link_clk_src.clkr,
+	[DP_PIXEL_CLK_SRC] = &dp_pixel_clk_src.clkr,
+	[ESC0_CLK_SRC] = &esc0_clk_src.clkr,
+	[ESC1_CLK_SRC] = &esc1_clk_src.clkr,
+	[JPEG0_CLK_SRC] = &jpeg0_clk_src.clkr,
+	[MCLK0_CLK_SRC] = &mclk0_clk_src.clkr,
+	[MCLK1_CLK_SRC] = &mclk1_clk_src.clkr,
+	[MCLK2_CLK_SRC] = &mclk2_clk_src.clkr,
+	[MCLK3_CLK_SRC] = &mclk3_clk_src.clkr,
+	[MDP_CLK_SRC] = &mdp_clk_src.clkr,
+	[MMPLL0_PLL] = &mmpll0.clkr,
+	[MMPLL10_PLL] = &mmpll10.clkr,
+	[MMPLL3_PLL] = &mmpll3.clkr,
+	[MMPLL4_PLL] = &mmpll4.clkr,
+	[MMPLL5_PLL] = &mmpll5.clkr,
+	[MMPLL6_PLL] = &mmpll6.clkr,
+	[MMPLL7_PLL] = &mmpll7.clkr,
+	[MMPLL8_PLL] = &mmpll8.clkr,
+	[BIMC_SMMU_AHB_CLK] = &bimc_smmu_ahb_clk.clkr,
+	[BIMC_SMMU_AXI_CLK] = &bimc_smmu_axi_clk.clkr,
+	[CAMSS_AHB_CLK] = &camss_ahb_clk.clkr,
+	[CAMSS_CCI_AHB_CLK] = &camss_cci_ahb_clk.clkr,
+	[CAMSS_CCI_CLK] = &camss_cci_clk.clkr,
+	[CAMSS_CPHY_CSID0_CLK] = &camss_cphy_csid0_clk.clkr,
+	[CAMSS_CPHY_CSID1_CLK] = &camss_cphy_csid1_clk.clkr,
+	[CAMSS_CPHY_CSID2_CLK] = &camss_cphy_csid2_clk.clkr,
+	[CAMSS_CPHY_CSID3_CLK] = &camss_cphy_csid3_clk.clkr,
+	[CAMSS_CPP_AHB_CLK] = &camss_cpp_ahb_clk.clkr,
+	[CAMSS_CPP_AXI_CLK] = &camss_cpp_axi_clk.clkr,
+	[CAMSS_CPP_CLK] = &camss_cpp_clk.clkr,
+	[CAMSS_CPP_VBIF_AHB_CLK] = &camss_cpp_vbif_ahb_clk.clkr,
+	[CAMSS_CSI0_AHB_CLK] = &camss_csi0_ahb_clk.clkr,
+	[CAMSS_CSI0_CLK] = &camss_csi0_clk.clkr,
+	[CAMSS_CSI0PHYTIMER_CLK] = &camss_csi0phytimer_clk.clkr,
+	[CAMSS_CSI0PIX_CLK] = &camss_csi0pix_clk.clkr,
+	[CAMSS_CSI0RDI_CLK] = &camss_csi0rdi_clk.clkr,
+	[CAMSS_CSI1_AHB_CLK] = &camss_csi1_ahb_clk.clkr,
+	[CAMSS_CSI1_CLK] = &camss_csi1_clk.clkr,
+	[CAMSS_CSI1PHYTIMER_CLK] = &camss_csi1phytimer_clk.clkr,
+	[CAMSS_CSI1PIX_CLK] = &camss_csi1pix_clk.clkr,
+	[CAMSS_CSI1RDI_CLK] = &camss_csi1rdi_clk.clkr,
+	[CAMSS_CSI2_AHB_CLK] = &camss_csi2_ahb_clk.clkr,
+	[CAMSS_CSI2_CLK] = &camss_csi2_clk.clkr,
+	[CAMSS_CSI2PHYTIMER_CLK] = &camss_csi2phytimer_clk.clkr,
+	[CAMSS_CSI2PIX_CLK] = &camss_csi2pix_clk.clkr,
+	[CAMSS_CSI2RDI_CLK] = &camss_csi2rdi_clk.clkr,
+	[CAMSS_CSI3_AHB_CLK] = &camss_csi3_ahb_clk.clkr,
+	[CAMSS_CSI3_CLK] = &camss_csi3_clk.clkr,
+	[CAMSS_CSI3PIX_CLK] = &camss_csi3pix_clk.clkr,
+	[CAMSS_CSI3RDI_CLK] = &camss_csi3rdi_clk.clkr,
+	[CAMSS_CSI_VFE0_CLK] = &camss_csi_vfe0_clk.clkr,
+	[CAMSS_CSI_VFE1_CLK] = &camss_csi_vfe1_clk.clkr,
+	[CAMSS_CSIPHY0_CLK] = &camss_csiphy0_clk.clkr,
+	[CAMSS_CSIPHY1_CLK] = &camss_csiphy1_clk.clkr,
+	[CAMSS_CSIPHY2_CLK] = &camss_csiphy2_clk.clkr,
+	[CAMSS_GP0_CLK] = &camss_gp0_clk.clkr,
+	[CAMSS_GP1_CLK] = &camss_gp1_clk.clkr,
+	[CAMSS_ISPIF_AHB_CLK] = &camss_ispif_ahb_clk.clkr,
+	[CAMSS_JPEG0_CLK] = &camss_jpeg0_clk.clkr,
+	[CAMSS_JPEG_AHB_CLK] = &camss_jpeg_ahb_clk.clkr,
+	[CAMSS_JPEG_AXI_CLK] = &camss_jpeg_axi_clk.clkr,
+	[CAMSS_MCLK0_CLK] = &camss_mclk0_clk.clkr,
+	[CAMSS_MCLK1_CLK] = &camss_mclk1_clk.clkr,
+	[CAMSS_MCLK2_CLK] = &camss_mclk2_clk.clkr,
+	[CAMSS_MCLK3_CLK] = &camss_mclk3_clk.clkr,
+	[CAMSS_MICRO_AHB_CLK] = &camss_micro_ahb_clk.clkr,
+	[CAMSS_TOP_AHB_CLK] = &camss_top_ahb_clk.clkr,
+	[CAMSS_VFE0_AHB_CLK] = &camss_vfe0_ahb_clk.clkr,
+	[CAMSS_VFE0_CLK] = &camss_vfe0_clk.clkr,
+	[CAMSS_VFE0_STREAM_CLK] = &camss_vfe0_stream_clk.clkr,
+	[CAMSS_VFE1_AHB_CLK] = &camss_vfe1_ahb_clk.clkr,
+	[CAMSS_VFE1_CLK] = &camss_vfe1_clk.clkr,
+	[CAMSS_VFE1_STREAM_CLK] = &camss_vfe1_stream_clk.clkr,
+	[CAMSS_VFE_VBIF_AHB_CLK] = &camss_vfe_vbif_ahb_clk.clkr,
+	[CAMSS_VFE_VBIF_AXI_CLK] = &camss_vfe_vbif_axi_clk.clkr,
+	[CSIPHY_AHB2CRIF_CLK] = &csiphy_ahb2crif_clk.clkr,
+	[MDSS_AHB_CLK] = &mdss_ahb_clk.clkr,
+	[MDSS_AXI_CLK] = &mdss_axi_clk.clkr,
+	[MDSS_BYTE0_CLK] = &mdss_byte0_clk.clkr,
+	[MDSS_BYTE0_INTF_CLK] = &mdss_byte0_intf_clk.clkr,
+	[MDSS_BYTE0_INTF_DIV_CLK] = &mdss_byte0_intf_div_clk.clkr,
+	[MDSS_BYTE1_CLK] = &mdss_byte1_clk.clkr,
+	[MDSS_BYTE1_INTF_CLK] = &mdss_byte1_intf_clk.clkr,
+	[MDSS_DP_AUX_CLK] = &mdss_dp_aux_clk.clkr,
+	[MDSS_DP_CRYPTO_CLK] = &mdss_dp_crypto_clk.clkr,
+	[MDSS_DP_GTC_CLK] = &mdss_dp_gtc_clk.clkr,
+	[MDSS_DP_LINK_CLK] = &mdss_dp_link_clk.clkr,
+	[MDSS_DP_LINK_INTF_CLK] = &mdss_dp_link_intf_clk.clkr,
+	[MDSS_DP_PIXEL_CLK] = &mdss_dp_pixel_clk.clkr,
+	[MDSS_ESC0_CLK] = &mdss_esc0_clk.clkr,
+	[MDSS_ESC1_CLK] = &mdss_esc1_clk.clkr,
+	[MDSS_HDMI_DP_AHB_CLK] = &mdss_hdmi_dp_ahb_clk.clkr,
+	[MDSS_MDP_CLK] = &mdss_mdp_clk.clkr,
+	[MDSS_PCLK0_CLK] = &mdss_pclk0_clk.clkr,
+	[MDSS_PCLK1_CLK] = &mdss_pclk1_clk.clkr,
+	[MDSS_ROT_CLK] = &mdss_rot_clk.clkr,
+	[MDSS_VSYNC_CLK] = &mdss_vsync_clk.clkr,
+	[MISC_AHB_CLK] = &misc_ahb_clk.clkr,
+	[MISC_CXO_CLK] = &misc_cxo_clk.clkr,
+	[MNOC_AHB_CLK] = &mnoc_ahb_clk.clkr,
+	[SNOC_DVM_AXI_CLK] = &snoc_dvm_axi_clk.clkr,
+	[THROTTLE_CAMSS_AXI_CLK] = &throttle_camss_axi_clk.clkr,
+	[THROTTLE_MDSS_AXI_CLK] = &throttle_mdss_axi_clk.clkr,
+	[THROTTLE_VIDEO_AXI_CLK] = &throttle_video_axi_clk.clkr,
+	[VIDEO_AHB_CLK] = &video_ahb_clk.clkr,
+	[VIDEO_AXI_CLK] = &video_axi_clk.clkr,
+	[VIDEO_CORE_CLK] = &video_core_clk.clkr,
+	[VIDEO_SUBCORE0_CLK] = &video_subcore0_clk.clkr,
+	[PCLK0_CLK_SRC] = &pclk0_clk_src.clkr,
+	[PCLK1_CLK_SRC] = &pclk1_clk_src.clkr,
+	[ROT_CLK_SRC] = &rot_clk_src.clkr,
+	[VFE0_CLK_SRC] = &vfe0_clk_src.clkr,
+	[VFE1_CLK_SRC] = &vfe1_clk_src.clkr,
+	[VIDEO_CORE_CLK_SRC] = &video_core_clk_src.clkr,
+	[VSYNC_CLK_SRC] = &vsync_clk_src.clkr,
+	[MDSS_BYTE1_INTF_DIV_CLK] = &mdss_byte1_intf_div_clk.clkr,
+	[AXI_CLK_SRC] = &axi_clk_src.clkr,
+};
+
+static struct gdsc *mmcc_sdm660_gdscs[] = {
+	[VENUS_GDSC] = &venus_gdsc,
+	[VENUS_CORE0_GDSC] = &venus_core0_gdsc,
+	[MDSS_GDSC] = &mdss_gdsc,
+	[CAMSS_TOP_GDSC] = &camss_top_gdsc,
+	[CAMSS_VFE0_GDSC] = &camss_vfe0_gdsc,
+	[CAMSS_VFE1_GDSC] = &camss_vfe1_gdsc,
+	[CAMSS_CPP_GDSC] = &camss_cpp_gdsc,
+};
+
+static const struct qcom_reset_map mmcc_660_resets[] = {
+	[CAMSS_MICRO_BCR] = { 0x3490 },
+};
+
+static const struct regmap_config mmcc_660_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= 0x40000,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc mmcc_660_desc = {
+	.config = &mmcc_660_regmap_config,
+	.clks = mmcc_660_clocks,
+	.num_clks = ARRAY_SIZE(mmcc_660_clocks),
+	.resets = mmcc_660_resets,
+	.num_resets = ARRAY_SIZE(mmcc_660_resets),
+	.gdscs = mmcc_sdm660_gdscs,
+	.num_gdscs = ARRAY_SIZE(mmcc_sdm660_gdscs),
+};
+
+static const struct of_device_id mmcc_660_match_table[] = {
+	{ .compatible = "qcom,mmcc-sdm660" },
+	{ .compatible = "qcom,mmcc-sdm630" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmcc_660_match_table);
+
+static int mmcc_660_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	bool is_sdm630 = 0;
+
+	regmap = qcom_cc_map(pdev, &mmcc_660_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	is_sdm630 = of_device_is_compatible(pdev->dev.of_node,
+					    "qcom,mmcc-sdm630");
+
+	clk_alpha_pll_configure(&mmpll3, regmap, &mmpll3_config);
+	clk_alpha_pll_configure(&mmpll4, regmap, &mmpll4_config);
+	clk_alpha_pll_configure(&mmpll5, regmap, &mmpll5_config);
+	clk_alpha_pll_configure(&mmpll7, regmap, &mmpll7_config);
+	clk_alpha_pll_configure(&mmpll8, regmap, &mmpll8_config);
+	clk_alpha_pll_configure(&mmpll10, regmap, &mmpll10_config);
+
+	if (is_sdm630) {
+		mmcc_660_desc.clks[BYTE1_CLK_SRC] = 0;
+		mmcc_660_desc.clks[MDSS_BYTE1_CLK] = 0;
+		mmcc_660_desc.clks[MDSS_BYTE1_INTF_DIV_CLK] = 0;
+		mmcc_660_desc.clks[MDSS_BYTE1_INTF_CLK] = 0;
+		mmcc_660_desc.clks[ESC1_CLK_SRC] = 0;
+		mmcc_660_desc.clks[MDSS_ESC1_CLK] = 0;
+		mmcc_660_desc.clks[PCLK1_CLK_SRC] = 0;
+		mmcc_660_desc.clks[MDSS_PCLK1_CLK] = 0;
+	}
+
+	return qcom_cc_really_probe(pdev, &mmcc_660_desc, regmap);
+}
+
+static struct platform_driver mmcc_660_driver = {
+	.probe		= mmcc_660_probe,
+	.driver		= {
+		.name	= "mmcc-sdm660",
+		.of_match_table = mmcc_660_match_table,
+	},
+};
+
+static int __init mmcc_660_init(void)
+{
+	return platform_driver_register(&mmcc_660_driver);
+}
+core_initcall_sync(mmcc_660_init);
+
+static void __exit mmcc_660_exit(void)
+{
+	platform_driver_unregister(&mmcc_660_driver);
+}
+module_exit(mmcc_660_exit);
+
diff --git a/include/dt-bindings/clock/qcom,mmcc-sdm660.h b/include/dt-bindings/clock/qcom,mmcc-sdm660.h
new file mode 100644
index 000000000000..f9dbc21cb5c7
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,mmcc-sdm660.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_MMCC_660_H
+#define _DT_BINDINGS_CLK_MSM_MMCC_660_H
+
+#define AHB_CLK_SRC							0
+#define BYTE0_CLK_SRC						1
+#define BYTE1_CLK_SRC						2
+#define CAMSS_GP0_CLK_SRC					3
+#define CAMSS_GP1_CLK_SRC					4
+#define CCI_CLK_SRC							5
+#define CPP_CLK_SRC							6
+#define CSI0_CLK_SRC						7
+#define CSI0PHYTIMER_CLK_SRC				8
+#define CSI1_CLK_SRC						9
+#define CSI1PHYTIMER_CLK_SRC				10
+#define CSI2_CLK_SRC						11
+#define CSI2PHYTIMER_CLK_SRC				12
+#define CSI3_CLK_SRC						13
+#define CSIPHY_CLK_SRC						14
+#define DP_AUX_CLK_SRC						15
+#define DP_CRYPTO_CLK_SRC					16
+#define DP_GTC_CLK_SRC						17
+#define DP_LINK_CLK_SRC						18
+#define DP_PIXEL_CLK_SRC					19
+#define ESC0_CLK_SRC						20
+#define ESC1_CLK_SRC						21
+#define JPEG0_CLK_SRC						22
+#define MCLK0_CLK_SRC						23
+#define MCLK1_CLK_SRC						24
+#define MCLK2_CLK_SRC						25
+#define MCLK3_CLK_SRC						26
+#define MDP_CLK_SRC							27
+#define MMPLL0_PLL							28
+#define MMPLL10_PLL							29
+#define MMPLL1_PLL							30
+#define MMPLL3_PLL							31
+#define MMPLL4_PLL							32
+#define MMPLL5_PLL							33
+#define MMPLL6_PLL							34
+#define MMPLL7_PLL							35
+#define MMPLL8_PLL							36
+#define BIMC_SMMU_AHB_CLK					37
+#define BIMC_SMMU_AXI_CLK					38
+#define CAMSS_AHB_CLK						39
+#define CAMSS_CCI_AHB_CLK					40
+#define CAMSS_CCI_CLK						41
+#define CAMSS_CPHY_CSID0_CLK				42
+#define CAMSS_CPHY_CSID1_CLK				43
+#define CAMSS_CPHY_CSID2_CLK				44
+#define CAMSS_CPHY_CSID3_CLK				45
+#define CAMSS_CPP_AHB_CLK					46
+#define CAMSS_CPP_AXI_CLK					47
+#define CAMSS_CPP_CLK						48
+#define CAMSS_CPP_VBIF_AHB_CLK				49
+#define CAMSS_CSI0_AHB_CLK					50
+#define CAMSS_CSI0_CLK						51
+#define CAMSS_CSI0PHYTIMER_CLK				52
+#define CAMSS_CSI0PIX_CLK					53
+#define CAMSS_CSI0RDI_CLK					54
+#define CAMSS_CSI1_AHB_CLK					55
+#define CAMSS_CSI1_CLK						56
+#define CAMSS_CSI1PHYTIMER_CLK				57
+#define CAMSS_CSI1PIX_CLK					58
+#define CAMSS_CSI1RDI_CLK					59
+#define CAMSS_CSI2_AHB_CLK					60
+#define CAMSS_CSI2_CLK						61
+#define CAMSS_CSI2PHYTIMER_CLK				62
+#define CAMSS_CSI2PIX_CLK					63
+#define CAMSS_CSI2RDI_CLK					64
+#define CAMSS_CSI3_AHB_CLK					65
+#define CAMSS_CSI3_CLK						66
+#define CAMSS_CSI3PIX_CLK					67
+#define CAMSS_CSI3RDI_CLK					68
+#define CAMSS_CSI_VFE0_CLK					69
+#define CAMSS_CSI_VFE1_CLK					70
+#define CAMSS_CSIPHY0_CLK					71
+#define CAMSS_CSIPHY1_CLK					72
+#define CAMSS_CSIPHY2_CLK					73
+#define CAMSS_GP0_CLK						74
+#define CAMSS_GP1_CLK						75
+#define CAMSS_ISPIF_AHB_CLK					76
+#define CAMSS_JPEG0_CLK						77
+#define CAMSS_JPEG_AHB_CLK					78
+#define CAMSS_JPEG_AXI_CLK					79
+#define CAMSS_MCLK0_CLK						80
+#define CAMSS_MCLK1_CLK						81
+#define CAMSS_MCLK2_CLK						82
+#define CAMSS_MCLK3_CLK						83
+#define CAMSS_MICRO_AHB_CLK					84
+#define CAMSS_TOP_AHB_CLK					85
+#define CAMSS_VFE0_AHB_CLK					86
+#define CAMSS_VFE0_CLK						87
+#define CAMSS_VFE0_STREAM_CLK				88
+#define CAMSS_VFE1_AHB_CLK					89
+#define CAMSS_VFE1_CLK						90
+#define CAMSS_VFE1_STREAM_CLK				91
+#define CAMSS_VFE_VBIF_AHB_CLK				92
+#define CAMSS_VFE_VBIF_AXI_CLK				93
+#define CSIPHY_AHB2CRIF_CLK					94
+#define CXO_CLK								95
+#define MDSS_AHB_CLK						96
+#define MDSS_AXI_CLK						97
+#define MDSS_BYTE0_CLK						98
+#define MDSS_BYTE0_INTF_CLK					99
+#define MDSS_BYTE0_INTF_DIV_CLK				100
+#define MDSS_BYTE1_CLK						101
+#define MDSS_BYTE1_INTF_CLK					102
+#define MDSS_DP_AUX_CLK						103
+#define MDSS_DP_CRYPTO_CLK					104
+#define MDSS_DP_GTC_CLK						105
+#define MDSS_DP_LINK_CLK					106
+#define MDSS_DP_LINK_INTF_CLK				107
+#define MDSS_DP_PIXEL_CLK					108
+#define MDSS_ESC0_CLK						109
+#define MDSS_ESC1_CLK						110
+#define MDSS_HDMI_DP_AHB_CLK				111
+#define MDSS_MDP_CLK						112
+#define MDSS_PCLK0_CLK						113
+#define MDSS_PCLK1_CLK						114
+#define MDSS_ROT_CLK						115
+#define MDSS_VSYNC_CLK						116
+#define MISC_AHB_CLK						117
+#define MISC_CXO_CLK						118
+#define MNOC_AHB_CLK						119
+#define SNOC_DVM_AXI_CLK					120
+#define THROTTLE_CAMSS_AHB_CLK				121
+#define THROTTLE_CAMSS_AXI_CLK				122
+#define THROTTLE_MDSS_AHB_CLK				123
+#define THROTTLE_MDSS_AXI_CLK				124
+#define THROTTLE_VIDEO_AHB_CLK				125
+#define THROTTLE_VIDEO_AXI_CLK				126
+#define VIDEO_AHB_CLK						127
+#define VIDEO_AXI_CLK						128
+#define VIDEO_CORE_CLK						129
+#define VIDEO_SUBCORE0_CLK					130
+#define PCLK0_CLK_SRC						131
+#define PCLK1_CLK_SRC						132
+#define ROT_CLK_SRC							133
+#define VFE0_CLK_SRC						134
+#define VFE1_CLK_SRC						135
+#define VIDEO_CORE_CLK_SRC					136
+#define VSYNC_CLK_SRC						137
+#define MDSS_BYTE1_INTF_DIV_CLK				138
+#define AXI_CLK_SRC							139
+
+#define VENUS_GDSC								0
+#define VENUS_CORE0_GDSC						1
+#define MDSS_GDSC								2
+#define CAMSS_TOP_GDSC							3
+#define CAMSS_VFE0_GDSC							4
+#define CAMSS_VFE1_GDSC							5
+#define CAMSS_CPP_GDSC							6
+#define BIMC_SMMU_GDSC							7
+
+#define CAMSS_MICRO_BCR				 0
+
+#endif
+
-- 
2.28.0

