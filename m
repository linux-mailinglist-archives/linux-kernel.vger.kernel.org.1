Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB6D2D2425
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgLHHQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgLHHQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:16:05 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2670AC06138C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 23:14:48 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d2so9159955pfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 23:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcT3FEpjfnNNOfXVHR4OgFShiExAK/kmCKbCpgFxpkY=;
        b=HRqtIhvKXQ6DMw07yiQZlgxtn8SuYERG99TR+hRAnUId4Xn/dEy17dtS+eLZBYEvqk
         MrOtAPYRoKFVzdYT11Zvn2d6vbRkBY/DWEdZ0pS5VogFXXRjFGYpATJGHUgWsrbmQ5kR
         l9W9KaVxIq9sWsRxaZG7Gh0CFAdVXFUV7B55+wp2TNkHpILFTTJTjV1uGpYFQc/N6FBM
         qRUYxbpq2albfZmXFc1oYHg1Rp7wVYY0lJL7G7V5Vy6kpPLmzMj25jgnl0Rgu3GIAQII
         MUXiUKq3vJVyZRqnbUUAAqgTBQ32ni4WVE/llilMEouRFgJ+oEuGOTxfCOqX/ZvVm0CJ
         U/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcT3FEpjfnNNOfXVHR4OgFShiExAK/kmCKbCpgFxpkY=;
        b=tpy+8vDgRxQ2C2vIJAOwmsFIBzbuM4wKCA0cDzEPyT5wi4ml0JsHae3Yt7mnstmthz
         b0OH8NzR3X3d9dErRJbhUq1MCwJuI46gBoif7sFKo742G3t5V1Y1Ji9/SotFoKtgBuUC
         fC7LeRs+5wvSa3qY4JH+mkzg4SDUnhmSetlmYD68aRuJZAC1+txj3n121w6iWt2U3jx7
         K1Frf64KwtrdeA8sc5AELwdbRs+nbavlQZwhxyFgiMHoyGPaR5ZHcdRyxTIstv0T8pHf
         T4y7mB69Vv1iDHZEZb8/RQVot77J1V9L2o+/HyPCa4FHer1f75UiXU5AT8fVaK5Yt7jG
         uPfA==
X-Gm-Message-State: AOAM532EnjFbM2E15Jp/DgIALOzWz/Qqftnym5cRYElLsrBzLPNJKWnP
        OYeuGjhMG5LYLR4DLZadB+Vjcg==
X-Google-Smtp-Source: ABdhPJxTIBjuEokvl4x99Oc4TAdOGKUaSS6HU0tr8s+XXcXqvvSVArak+Iyq34roqegogXz9Sz9BqQ==
X-Received: by 2002:a63:484d:: with SMTP id x13mr22066180pgk.301.1607411687635;
        Mon, 07 Dec 2020 23:14:47 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id gp17sm1801318pjb.0.2020.12.07.23.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 23:14:47 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>,
        Pragnesh Patel <Pragnesh.patel@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Henry Styles <hes@sifive.com>,
        Erik Danie <erik.danie@sifive.com>,
        Pragnesh Patel <pragnesh.patel@sifive.com>
Subject: [PATCH v6 3/5] clk: sifive: Add a driver for the SiFive FU740 PRCI IP block
Date:   Tue,  8 Dec 2020 15:14:30 +0800
Message-Id: <20201208071432.55583-4-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208071432.55583-1-zong.li@sifive.com>
References: <20201208071432.55583-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver code for the SiFive FU740 PRCI IP block. This IP block
handles reset and clock control for the SiFive FU740 device and
implements SoC-level clock tree controls and dividers.

The link of unmatched as follow, and the U740-C000 manual would
be present in the same page as soon.
https://www.sifive.com/boards/hifive-unmatched

This driver contains bug fixes and contributions from
Henry Styles <hes@sifive.com>
Erik Danie <erik.danie@sifive.com>
Pragnesh Patel <pragnesh.patel@sifive.com>

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Pragnesh Patel <Pragnesh.patel@sifive.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Henry Styles <hes@sifive.com>
Cc: Erik Danie <erik.danie@sifive.com>
Cc: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 drivers/clk/sifive/Kconfig                    |   4 +-
 drivers/clk/sifive/Makefile                   |   1 +
 drivers/clk/sifive/fu740-prci.c               | 111 ++++++++++++++++
 drivers/clk/sifive/fu740-prci.h               |  21 +++
 drivers/clk/sifive/sifive-prci.c              | 120 ++++++++++++++++++
 drivers/clk/sifive/sifive-prci.h              |  88 +++++++++++++
 include/dt-bindings/clock/sifive-fu740-prci.h |  23 ++++
 7 files changed, 366 insertions(+), 2 deletions(-)
 create mode 100644 drivers/clk/sifive/fu740-prci.c
 create mode 100644 drivers/clk/sifive/fu740-prci.h
 create mode 100644 include/dt-bindings/clock/sifive-fu740-prci.h

diff --git a/drivers/clk/sifive/Kconfig b/drivers/clk/sifive/Kconfig
index ab48cf7e0105..1c14eb20c066 100644
--- a/drivers/clk/sifive/Kconfig
+++ b/drivers/clk/sifive/Kconfig
@@ -13,7 +13,7 @@ config CLK_SIFIVE_PRCI
 	select CLK_ANALOGBITS_WRPLL_CLN28HPC
 	help
 	  Supports the Power Reset Clock interface (PRCI) IP block found in
-	  FU540 SoCs. If this kernel is meant to run on a SiFive FU540 SoC,
-	  enable this driver.
+	  FU540/FU740 SoCs. If this kernel is meant to run on a SiFive FU540/
+	  FU740 SoCs, enable this driver.
 
 endif
diff --git a/drivers/clk/sifive/Makefile b/drivers/clk/sifive/Makefile
index fe3e2cb4c4d8..2c05798e4ba4 100644
--- a/drivers/clk/sifive/Makefile
+++ b/drivers/clk/sifive/Makefile
@@ -2,3 +2,4 @@
 obj-y += sifive-prci.o
 
 obj-$(CONFIG_CLK_SIFIVE_PRCI)	+= fu540-prci.o
+obj-$(CONFIG_CLK_SIFIVE_PRCI)	+= fu740-prci.o
diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
new file mode 100644
index 000000000000..41ddd4431497
--- /dev/null
+++ b/drivers/clk/sifive/fu740-prci.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 SiFive, Inc.
+ * Copyright (C) 2020 Zong Li
+ */
+
+#include <dt-bindings/clock/sifive-fu740-prci.h>
+#include <linux/module.h>
+#include "sifive-prci.h"
+
+/* PRCI integration data for each WRPLL instance */
+
+static struct __prci_wrpll_data __prci_corepll_data = {
+	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
+	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
+	.disable_bypass = sifive_prci_coreclksel_use_final_corepll,
+};
+
+static struct __prci_wrpll_data __prci_ddrpll_data = {
+	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
+};
+
+static struct __prci_wrpll_data __prci_gemgxlpll_data = {
+	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
+};
+
+static struct __prci_wrpll_data __prci_dvfscorepll_data = {
+	.cfg0_offs = PRCI_DVFSCOREPLLCFG0_OFFSET,
+	.enable_bypass = sifive_prci_corepllsel_use_corepll,
+	.disable_bypass = sifive_prci_corepllsel_use_dvfscorepll,
+};
+
+static struct __prci_wrpll_data __prci_hfpclkpll_data = {
+	.cfg0_offs = PRCI_HFPCLKPLLCFG0_OFFSET,
+	.enable_bypass = sifive_prci_hfpclkpllsel_use_hfclk,
+	.disable_bypass = sifive_prci_hfpclkpllsel_use_hfpclkpll,
+};
+
+static struct __prci_wrpll_data __prci_cltxpll_data = {
+	.cfg0_offs = PRCI_CLTXPLLCFG0_OFFSET,
+};
+
+/* Linux clock framework integration */
+
+static const struct clk_ops sifive_fu740_prci_wrpll_clk_ops = {
+	.set_rate = sifive_prci_wrpll_set_rate,
+	.round_rate = sifive_prci_wrpll_round_rate,
+	.recalc_rate = sifive_prci_wrpll_recalc_rate,
+};
+
+static const struct clk_ops sifive_fu740_prci_wrpll_ro_clk_ops = {
+	.recalc_rate = sifive_prci_wrpll_recalc_rate,
+};
+
+static const struct clk_ops sifive_fu740_prci_tlclksel_clk_ops = {
+	.recalc_rate = sifive_prci_tlclksel_recalc_rate,
+};
+
+static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops = {
+	.recalc_rate = sifive_prci_hfpclkplldiv_recalc_rate,
+};
+
+/* List of clock controls provided by the PRCI */
+struct __prci_clock __prci_init_clocks_fu740[] = {
+	[PRCI_CLK_COREPLL] = {
+		.name = "corepll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &__prci_corepll_data,
+	},
+	[PRCI_CLK_DDRPLL] = {
+		.name = "ddrpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_ro_clk_ops,
+		.pwd = &__prci_ddrpll_data,
+	},
+	[PRCI_CLK_GEMGXLPLL] = {
+		.name = "gemgxlpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &__prci_gemgxlpll_data,
+	},
+	[PRCI_CLK_DVFSCOREPLL] = {
+		.name = "dvfscorepll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &__prci_dvfscorepll_data,
+	},
+	[PRCI_CLK_HFPCLKPLL] = {
+		.name = "hfpclkpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &__prci_hfpclkpll_data,
+	},
+	[PRCI_CLK_CLTXPLL] = {
+		.name = "cltxpll",
+		.parent_name = "hfclk",
+		.ops = &sifive_fu740_prci_wrpll_clk_ops,
+		.pwd = &__prci_cltxpll_data,
+	},
+	[PRCI_CLK_TLCLK] = {
+		.name = "tlclk",
+		.parent_name = "corepll",
+		.ops = &sifive_fu740_prci_tlclksel_clk_ops,
+	},
+	[PRCI_CLK_PCLK] = {
+		.name = "pclk",
+		.parent_name = "hfpclkpll",
+		.ops = &sifive_fu740_prci_hfpclkplldiv_clk_ops,
+	},
+};
diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
new file mode 100644
index 000000000000..13ef971f7764
--- /dev/null
+++ b/drivers/clk/sifive/fu740-prci.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 SiFive, Inc.
+ * Zong Li
+ */
+
+#ifndef __SIFIVE_CLK_FU740_PRCI_H
+#define __SIFIVE_CLK_FU740_PRCI_H
+
+#include "sifive-prci.h"
+
+#define NUM_CLOCK_FU740	8
+
+extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
+
+static const struct prci_clk_desc prci_clk_fu740 = {
+	.clks = __prci_init_clocks_fu740,
+	.num_clks = ARRAY_SIZE(__prci_init_clocks_fu740),
+};
+
+#endif /* __SIFIVE_CLK_FU740_PRCI_H */
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 603c0cad5e8d..f4bab45509b3 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -10,6 +10,7 @@
 #include <linux/of_device.h>
 #include "sifive-prci.h"
 #include "fu540-prci.h"
+#include "fu740-prci.h"
 
 /*
  * Private functions
@@ -225,6 +226,18 @@ unsigned long sifive_prci_tlclksel_recalc_rate(struct clk_hw *hw,
 	return div_u64(parent_rate, div);
 }
 
+/* HFPCLK clock integration */
+
+unsigned long sifive_prci_hfpclkplldiv_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_data *pd = pc->pd;
+	u32 div = __prci_readl(pd, PRCI_HFPCLKPLLDIV_OFFSET);
+
+	return div_u64(parent_rate, div + 2);
+}
+
 /*
  * Core clock mux control
  */
@@ -270,6 +283,112 @@ void sifive_prci_coreclksel_use_corepll(struct __prci_data *pd)
 	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);	/* barrier */
 }
 
+/**
+ * sifive_prci_coreclksel_use_final_corepll() - switch the CORECLK mux to output
+ * FINAL_COREPLL
+ * @pd: struct __prci_data * for the PRCI containing the CORECLK mux reg
+ *
+ * Switch the CORECLK mux to the final COREPLL output clock; return once
+ * complete.
+ *
+ * Context: Any context.  Caller must prevent concurrent changes to the
+ *          PRCI_CORECLKSEL_OFFSET register.
+ */
+void sifive_prci_coreclksel_use_final_corepll(struct __prci_data *pd)
+{
+	u32 r;
+
+	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);
+	r &= ~PRCI_CORECLKSEL_CORECLKSEL_MASK;
+	__prci_writel(r, PRCI_CORECLKSEL_OFFSET, pd);
+
+	r = __prci_readl(pd, PRCI_CORECLKSEL_OFFSET);	/* barrier */
+}
+
+/**
+ * sifive_prci_corepllsel_use_dvfscorepll() - switch the COREPLL mux to
+ * output DVFS_COREPLL
+ * @pd: struct __prci_data * for the PRCI containing the COREPLL mux reg
+ *
+ * Switch the COREPLL mux to the DVFSCOREPLL output clock; return once complete.
+ *
+ * Context: Any context.  Caller must prevent concurrent changes to the
+ *          PRCI_COREPLLSEL_OFFSET register.
+ */
+void sifive_prci_corepllsel_use_dvfscorepll(struct __prci_data *pd)
+{
+	u32 r;
+
+	r = __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);
+	r |= PRCI_COREPLLSEL_COREPLLSEL_MASK;
+	__prci_writel(r, PRCI_COREPLLSEL_OFFSET, pd);
+
+	r = __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);	/* barrier */
+}
+
+/**
+ * sifive_prci_corepllsel_use_corepll() - switch the COREPLL mux to
+ * output COREPLL
+ * @pd: struct __prci_data * for the PRCI containing the COREPLL mux reg
+ *
+ * Switch the COREPLL mux to the COREPLL output clock; return once complete.
+ *
+ * Context: Any context.  Caller must prevent concurrent changes to the
+ *          PRCI_COREPLLSEL_OFFSET register.
+ */
+void sifive_prci_corepllsel_use_corepll(struct __prci_data *pd)
+{
+	u32 r;
+
+	r = __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);
+	r &= ~PRCI_COREPLLSEL_COREPLLSEL_MASK;
+	__prci_writel(r, PRCI_COREPLLSEL_OFFSET, pd);
+
+	r = __prci_readl(pd, PRCI_COREPLLSEL_OFFSET);	/* barrier */
+}
+
+/**
+ * sifive_prci_hfpclkpllsel_use_hfclk() - switch the HFPCLKPLL mux to
+ * output HFCLK
+ * @pd: struct __prci_data * for the PRCI containing the HFPCLKPLL mux reg
+ *
+ * Switch the HFPCLKPLL mux to the HFCLK input source; return once complete.
+ *
+ * Context: Any context.  Caller must prevent concurrent changes to the
+ *          PRCI_HFPCLKPLLSEL_OFFSET register.
+ */
+void sifive_prci_hfpclkpllsel_use_hfclk(struct __prci_data *pd)
+{
+	u32 r;
+
+	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);
+	r |= PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_MASK;
+	__prci_writel(r, PRCI_HFPCLKPLLSEL_OFFSET, pd);
+
+	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
+}
+
+/**
+ * sifive_prci_hfpclkpllsel_use_hfpclkpll() - switch the HFPCLKPLL mux to
+ * output HFPCLKPLL
+ * @pd: struct __prci_data * for the PRCI containing the HFPCLKPLL mux reg
+ *
+ * Switch the HFPCLKPLL mux to the HFPCLKPLL output clock; return once complete.
+ *
+ * Context: Any context.  Caller must prevent concurrent changes to the
+ *          PRCI_HFPCLKPLLSEL_OFFSET register.
+ */
+void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd)
+{
+	u32 r;
+
+	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);
+	r &= ~PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_MASK;
+	__prci_writel(r, PRCI_HFPCLKPLLSEL_OFFSET, pd);
+
+	r = __prci_readl(pd, PRCI_HFPCLKPLLSEL_OFFSET);	/* barrier */
+}
+
 /**
  * __prci_register_clocks() - register clock controls in the PRCI
  * @dev: Linux struct device *
@@ -374,6 +493,7 @@ static int sifive_prci_probe(struct platform_device *pdev)
 
 static const struct of_device_id sifive_prci_of_match[] = {
 	{.compatible = "sifive,fu540-c000-prci", .data = &prci_clk_fu540},
+	{.compatible = "sifive,fu740-c000-prci", .data = &prci_clk_fu740},
 	{}
 };
 
diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index 025f717bc053..802fc8fb9c09 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -117,6 +117,87 @@
 #define PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_MASK			\
 		(0x1 << PRCI_CLKMUXSTATUSREG_TLCLKSEL_STATUS_SHIFT)
 
+/* CLTXPLLCFG0 */
+#define PRCI_CLTXPLLCFG0_OFFSET		0x30
+#define PRCI_CLTXPLLCFG0_DIVR_SHIFT	0
+#define PRCI_CLTXPLLCFG0_DIVR_MASK	(0x3f << PRCI_CLTXPLLCFG0_DIVR_SHIFT)
+#define PRCI_CLTXPLLCFG0_DIVF_SHIFT	6
+#define PRCI_CLTXPLLCFG0_DIVF_MASK	(0x1ff << PRCI_CLTXPLLCFG0_DIVF_SHIFT)
+#define PRCI_CLTXPLLCFG0_DIVQ_SHIFT	15
+#define PRCI_CLTXPLLCFG0_DIVQ_MASK	(0x7 << PRCI_CLTXPLLCFG0_DIVQ_SHIFT)
+#define PRCI_CLTXPLLCFG0_RANGE_SHIFT	18
+#define PRCI_CLTXPLLCFG0_RANGE_MASK	(0x7 << PRCI_CLTXPLLCFG0_RANGE_SHIFT)
+#define PRCI_CLTXPLLCFG0_BYPASS_SHIFT	24
+#define PRCI_CLTXPLLCFG0_BYPASS_MASK	(0x1 << PRCI_CLTXPLLCFG0_BYPASS_SHIFT)
+#define PRCI_CLTXPLLCFG0_FSE_SHIFT	25
+#define PRCI_CLTXPLLCFG0_FSE_MASK	(0x1 << PRCI_CLTXPLLCFG0_FSE_SHIFT)
+#define PRCI_CLTXPLLCFG0_LOCK_SHIFT	31
+#define PRCI_CLTXPLLCFG0_LOCK_MASK	(0x1 << PRCI_CLTXPLLCFG0_LOCK_SHIFT)
+
+/* CLTXPLLCFG1 */
+#define PRCI_CLTXPLLCFG1_OFFSET		0x34
+#define PRCI_CLTXPLLCFG1_CKE_SHIFT	31
+#define PRCI_CLTXPLLCFG1_CKE_MASK	(0x1 << PRCI_CLTXPLLCFG1_CKE_SHIFT)
+
+/* DVFSCOREPLLCFG0 */
+#define PRCI_DVFSCOREPLLCFG0_OFFSET	0x38
+
+/* DVFSCOREPLLCFG1 */
+#define PRCI_DVFSCOREPLLCFG1_OFFSET	0x3c
+#define PRCI_DVFSCOREPLLCFG1_CKE_SHIFT	31
+#define PRCI_DVFSCOREPLLCFG1_CKE_MASK	(0x1 << PRCI_DVFSCOREPLLCFG1_CKE_SHIFT)
+
+/* COREPLLSEL */
+#define PRCI_COREPLLSEL_OFFSET			0x40
+#define PRCI_COREPLLSEL_COREPLLSEL_SHIFT	0
+#define PRCI_COREPLLSEL_COREPLLSEL_MASK					\
+		(0x1 << PRCI_COREPLLSEL_COREPLLSEL_SHIFT)
+
+/* HFPCLKPLLCFG0 */
+#define PRCI_HFPCLKPLLCFG0_OFFSET		0x50
+#define PRCI_HFPCLKPLL_CFG0_DIVR_SHIFT		0
+#define PRCI_HFPCLKPLL_CFG0_DIVR_MASK					\
+		(0x3f << PRCI_HFPCLKPLLCFG0_DIVR_SHIFT)
+#define PRCI_HFPCLKPLL_CFG0_DIVF_SHIFT		6
+#define PRCI_HFPCLKPLL_CFG0_DIVF_MASK					\
+		(0x1ff << PRCI_HFPCLKPLLCFG0_DIVF_SHIFT)
+#define PRCI_HFPCLKPLL_CFG0_DIVQ_SHIFT		15
+#define PRCI_HFPCLKPLL_CFG0_DIVQ_MASK					\
+		(0x7 << PRCI_HFPCLKPLLCFG0_DIVQ_SHIFT)
+#define PRCI_HFPCLKPLL_CFG0_RANGE_SHIFT		18
+#define PRCI_HFPCLKPLL_CFG0_RANGE_MASK					\
+		(0x7 << PRCI_HFPCLKPLLCFG0_RANGE_SHIFT)
+#define PRCI_HFPCLKPLL_CFG0_BYPASS_SHIFT	24
+#define PRCI_HFPCLKPLL_CFG0_BYPASS_MASK					\
+		(0x1 << PRCI_HFPCLKPLLCFG0_BYPASS_SHIFT)
+#define PRCI_HFPCLKPLL_CFG0_FSE_SHIFT		25
+#define PRCI_HFPCLKPLL_CFG0_FSE_MASK					\
+		(0x1 << PRCI_HFPCLKPLLCFG0_FSE_SHIFT)
+#define PRCI_HFPCLKPLL_CFG0_LOCK_SHIFT		31
+#define PRCI_HFPCLKPLL_CFG0_LOCK_MASK					\
+		(0x1 << PRCI_HFPCLKPLLCFG0_LOCK_SHIFT)
+
+/* HFPCLKPLLCFG1 */
+#define PRCI_HFPCLKPLLCFG1_OFFSET		0x54
+#define PRCI_HFPCLKPLLCFG1_CKE_SHIFT		31
+#define PRCI_HFPCLKPLLCFG1_CKE_MASK					\
+		(0x1 << PRCI_HFPCLKPLLCFG1_CKE_SHIFT)
+
+/* HFPCLKPLLSEL */
+#define PRCI_HFPCLKPLLSEL_OFFSET		0x58
+#define PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_SHIFT	0
+#define PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_MASK				\
+		(0x1 << PRCI_HFPCLKPLLSEL_HFPCLKPLLSEL_SHIFT)
+
+/* HFPCLKPLLDIV */
+#define PRCI_HFPCLKPLLDIV_OFFSET		0x5c
+
+/* PRCIPLL */
+#define PRCI_PRCIPLL_OFFSET			0xe0
+
+/* PROCMONCFG */
+#define PRCI_PROCMONCFG_OFFSET			0xf0
+
 /*
  * Private structures
  */
@@ -187,6 +268,11 @@ struct prci_clk_desc {
 /* Core clock mux control */
 void sifive_prci_coreclksel_use_hfclk(struct __prci_data *pd);
 void sifive_prci_coreclksel_use_corepll(struct __prci_data *pd);
+void sifive_prci_coreclksel_use_final_corepll(struct __prci_data *pd);
+void sifive_prci_corepllsel_use_dvfscorepll(struct __prci_data *pd);
+void sifive_prci_corepllsel_use_corepll(struct __prci_data *pd);
+void sifive_prci_hfpclkpllsel_use_hfclk(struct __prci_data *pd);
+void sifive_prci_hfpclkpllsel_use_hfpclkpll(struct __prci_data *pd);
 
 /* Linux clock framework integration */
 long sifive_prci_wrpll_round_rate(struct clk_hw *hw, unsigned long rate,
@@ -197,5 +283,7 @@ unsigned long sifive_prci_wrpll_recalc_rate(struct clk_hw *hw,
 					    unsigned long parent_rate);
 unsigned long sifive_prci_tlclksel_recalc_rate(struct clk_hw *hw,
 					       unsigned long parent_rate);
+unsigned long sifive_prci_hfpclkplldiv_recalc_rate(struct clk_hw *hw,
+						   unsigned long parent_rate);
 
 #endif /* __SIFIVE_CLK_SIFIVE_PRCI_H */
diff --git a/include/dt-bindings/clock/sifive-fu740-prci.h b/include/dt-bindings/clock/sifive-fu740-prci.h
new file mode 100644
index 000000000000..cd7706ea5677
--- /dev/null
+++ b/include/dt-bindings/clock/sifive-fu740-prci.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
+/*
+ * Copyright (C) 2019 SiFive, Inc.
+ * Wesley Terpstra
+ * Paul Walmsley
+ * Zong Li
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H
+#define __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H
+
+/* Clock indexes for use by Device Tree data and the PRCI driver */
+
+#define PRCI_CLK_COREPLL	       0
+#define PRCI_CLK_DDRPLL		       1
+#define PRCI_CLK_GEMGXLPLL	       2
+#define PRCI_CLK_DVFSCOREPLL	       3
+#define PRCI_CLK_HFPCLKPLL	       4
+#define PRCI_CLK_CLTXPLL	       5
+#define PRCI_CLK_TLCLK		       6
+#define PRCI_CLK_PCLK		       7
+
+#endif	/* __DT_BINDINGS_CLOCK_SIFIVE_FU740_PRCI_H */
-- 
2.29.2

