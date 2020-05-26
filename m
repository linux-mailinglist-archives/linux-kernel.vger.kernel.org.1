Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703181AAEAE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410418AbgDOQrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416245AbgDOQq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:46:58 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0824121569;
        Wed, 15 Apr 2020 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969216;
        bh=fKvchPFltiWny9z669M9tY5uwWLTQtVHQZBCB0Y/158=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/KSE5ZlddO7r+i2ko/g/kBYD2p4rNZYiPv4REP8+S018VPvQ40bdjQsI3PrQJTyE
         6JShv+n7+RUo/7qSOsdnAiicat3AKLfjRcWpJwSdZiKTtdEQVG09nENnfucTGRJRS2
         jS7hhh7mpsmwVMaj7Q3Id/MUgWAlrY5w8YSJEaRY=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv7 5/5] clk: socfpga: agilex: add clock driver for the Agilex platform
Date:   Wed, 15 Apr 2020 11:46:42 -0500
Message-Id: <20200415164642.29382-6-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415164642.29382-1-dinguyen@kernel.org>
References: <20200415164642.29382-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the most part the Agilex clock structure is very similar to
Stratix10, so we re-use most of the Stratix10 clock driver.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v7: no changes
v6: no changes
v5: no changes
v4: no changes
v3: Address Stephen Boyd's comments
v2: update to use clk_parent_data
---
 drivers/clk/Makefile                |   3 +-
 drivers/clk/socfpga/Makefile        |   2 +
 drivers/clk/socfpga/clk-agilex.c    | 454 ++++++++++++++++++++++++++++
 drivers/clk/socfpga/clk-pll-s10.c   |  68 +++++
 drivers/clk/socfpga/stratix10-clk.h |   2 +
 5 files changed, 528 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/socfpga/clk-agilex.c

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index f4169cc2fd31..a178e4b6001f 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -104,10 +104,11 @@ obj-$(CONFIG_COMMON_CLK_SAMSUNG)	+= samsung/
 obj-$(CONFIG_CLK_SIFIVE)		+= sifive/
 obj-$(CONFIG_ARCH_SIRF)			+= sirf/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
+obj-$(CONFIG_ARCH_AGILEX)		+= socfpga/
+obj-$(CONFIG_ARCH_STRATIX10)		+= socfpga/
 obj-$(CONFIG_PLAT_SPEAR)		+= spear/
 obj-$(CONFIG_ARCH_SPRD)			+= sprd/
 obj-$(CONFIG_ARCH_STI)			+= st/
-obj-$(CONFIG_ARCH_STRATIX10)		+= socfpga/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-$(CONFIG_SUNXI_CCU)			+= sunxi-ng/
 obj-$(CONFIG_ARCH_TEGRA)		+= tegra/
diff --git a/drivers/clk/socfpga/Makefile b/drivers/clk/socfpga/Makefile
index ce5aa7802eb8..bf736f8d201a 100644
--- a/drivers/clk/socfpga/Makefile
+++ b/drivers/clk/socfpga/Makefile
@@ -3,3 +3,5 @@ obj-$(CONFIG_ARCH_SOCFPGA) += clk.o clk-gate.o clk-pll.o clk-periph.o
 obj-$(CONFIG_ARCH_SOCFPGA) += clk-pll-a10.o clk-periph-a10.o clk-gate-a10.o
 obj-$(CONFIG_ARCH_STRATIX10) += clk-s10.o
 obj-$(CONFIG_ARCH_STRATIX10) += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
+obj-$(CONFIG_ARCH_AGILEX) += clk-agilex.o
+obj-$(CONFIG_ARCH_AGILEX) += clk-pll-s10.o clk-periph-s10.o clk-gate-s10.o
diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
new file mode 100644
index 000000000000..699527f7e764
--- /dev/null
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019, Intel Corporation
+ */
+#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/agilex-clock.h>
+
+#include "stratix10-clk.h"
+
+static const struct clk_parent_data pll_mux[] = {
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data cntr_mux[] = {
+	{ .fw_name = "main_pll",
+	  .name = "main_pll", },
+	{ .fw_name = "periph_pll",
+	  .name = "periph_pll", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data boot_mux[] = {
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+};
+
+static const struct clk_parent_data mpu_free_mux[] = {
+	{ .fw_name = "main_pll_c0",
+	  .name = "main_pll_c0", },
+	{ .fw_name = "peri_pll_c0",
+	  .name = "peri_pll_c0", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data noc_free_mux[] = {
+	{ .fw_name = "main_pll_c1",
+	  .name = "main_pll_c1", },
+	{ .fw_name = "peri_pll_c1",
+	  .name = "peri_pll_c1", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data emaca_free_mux[] = {
+	{ .fw_name = "main_pll_c2",
+	  .name = "main_pll_c2", },
+	{ .fw_name = "peri_pll_c2",
+	  .name = "peri_pll_c2", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data emacb_free_mux[] = {
+	{ .fw_name = "main_pll_c3",
+	  .name = "main_pll_c3", },
+	{ .fw_name = "peri_pll_c3",
+	  .name = "peri_pll_c3", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data emac_ptp_free_mux[] = {
+	{ .fw_name = "main_pll_c3",
+	  .name = "main_pll_c3", },
+	{ .fw_name = "peri_pll_c3",
+	  .name = "peri_pll_c3", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data gpio_db_free_mux[] = {
+	{ .fw_name = "main_pll_c3",
+	  .name = "main_pll_c3", },
+	{ .fw_name = "peri_pll_c3",
+	  .name = "peri_pll_c3", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data psi_ref_free_mux[] = {
+	{ .fw_name = "main_pll_c3",
+	  .name = "main_pll_c3", },
+	{ .fw_name = "peri_pll_c3",
+	  .name = "peri_pll_c3", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data sdmmc_free_mux[] = {
+	{ .fw_name = "main_pll_c3",
+	  .name = "main_pll_c3", },
+	{ .fw_name = "peri_pll_c3",
+	  .name = "peri_pll_c3", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data s2f_usr0_free_mux[] = {
+	{ .fw_name = "main_pll_c2",
+	  .name = "main_pll_c2", },
+	{ .fw_name = "peri_pll_c2",
+	  .name = "peri_pll_c2", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data s2f_usr1_free_mux[] = {
+	{ .fw_name = "main_pll_c2",
+	  .name = "main_pll_c2", },
+	{ .fw_name = "peri_pll_c2",
+	  .name = "peri_pll_c2", },
+	{ .fw_name = "osc1",
+	  .name = "osc1", },
+	{ .fw_name = "cb-intosc-hs-div2-clk",
+	  .name = "cb-intosc-hs-div2-clk", },
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data mpu_mux[] = {
+	{ .fw_name = "mpu_free_clk",
+	  .name = "mpu_free_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data s2f_usr0_mux[] = {
+	{ .fw_name = "f2s-free-clk",
+	  .name = "f2s-free-clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+static const struct clk_parent_data emac_mux[] = {
+	{ .fw_name = "emaca_free_clk",
+	  .name = "emaca_free_clk", },
+	{ .fw_name = "emacb_free_clk",
+	  .name = "emacb_free_clk", },
+};
+
+static const struct clk_parent_data noc_mux[] = {
+	{ .fw_name = "noc_free_clk",
+	  .name = "noc_free_clk", },
+	{ .fw_name = "boot_clk",
+	  .name = "boot_clk", },
+};
+
+/* clocks in AO (always on) controller */
+static const struct stratix10_pll_clock agilex_pll_clks[] = {
+	{ AGILEX_BOOT_CLK, "boot_clk", boot_mux, ARRAY_SIZE(boot_mux), 0,
+	  0x0},
+	{ AGILEX_MAIN_PLL_CLK, "main_pll", pll_mux, ARRAY_SIZE(pll_mux),
+	  0, 0x48},
+	{ AGILEX_PERIPH_PLL_CLK, "periph_pll", pll_mux, ARRAY_SIZE(pll_mux),
+	  0, 0x9c},
+};
+
+static const struct stratix10_perip_c_clock agilex_main_perip_c_clks[] = {
+	{ AGILEX_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0, 0x58},
+	{ AGILEX_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0, 0x5C},
+	{ AGILEX_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0, 0x64},
+	{ AGILEX_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0, 0x68},
+	{ AGILEX_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0, 0xAC},
+	{ AGILEX_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0, 0xB0},
+	{ AGILEX_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0, 0xB8},
+	{ AGILEX_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0, 0xBC},
+};
+
+static const struct stratix10_perip_cnt_clock agilex_main_perip_cnt_clks[] = {
+	{ AGILEX_MPU_FREE_CLK, "mpu_free_clk", NULL, mpu_free_mux, ARRAY_SIZE(mpu_free_mux),
+	   0, 0x3C, 0, 0, 0},
+	{ AGILEX_NOC_FREE_CLK, "noc_free_clk", NULL, noc_free_mux, ARRAY_SIZE(noc_free_mux),
+	  0, 0x40, 0, 0, 1},
+	{ AGILEX_L4_SYS_FREE_CLK, "l4_sys_free_clk", "noc_free_clk", NULL, 1, 0,
+	  0, 4, 0, 0},
+	{ AGILEX_NOC_CLK, "noc_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux),
+	  0, 0, 0, 0x30, 1},
+	{ AGILEX_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, emaca_free_mux, ARRAY_SIZE(emaca_free_mux),
+	  0, 0xD4, 0, 0x88, 0},
+	{ AGILEX_EMAC_B_FREE_CLK, "emacb_free_clk", NULL, emacb_free_mux, ARRAY_SIZE(emacb_free_mux),
+	  0, 0xD8, 0, 0x88, 1},
+	{ AGILEX_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL, emac_ptp_free_mux,
+	  ARRAY_SIZE(emac_ptp_free_mux), 0, 0xDC, 0, 0x88, 2},
+	{ AGILEX_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL, gpio_db_free_mux,
+	  ARRAY_SIZE(gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3},
+	{ AGILEX_SDMMC_FREE_CLK, "sdmmc_free_clk", NULL, sdmmc_free_mux,
+	  ARRAY_SIZE(sdmmc_free_mux), 0, 0xE4, 0, 0x88, 4},
+	{ AGILEX_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", NULL, s2f_usr0_free_mux,
+	  ARRAY_SIZE(s2f_usr0_free_mux), 0, 0xE8, 0, 0, 0},
+	{ AGILEX_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", NULL, s2f_usr1_free_mux,
+	  ARRAY_SIZE(s2f_usr1_free_mux), 0, 0xEC, 0, 0x88, 5},
+	{ AGILEX_PSI_REF_FREE_CLK, "psi_ref_free_clk", NULL, psi_ref_free_mux,
+	  ARRAY_SIZE(psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6},
+};
+
+static const struct stratix10_gate_clock agilex_gate_clks[] = {
+	{ AGILEX_MPU_CLK, "mpu_clk", NULL, mpu_mux, ARRAY_SIZE(mpu_mux), 0, 0x24,
+	  0, 0, 0, 0, 0x30, 0, 0},
+	{ AGILEX_MPU_PERIPH_CLK, "mpu_periph_clk", "mpu_clk", NULL, 1, 0, 0x24,
+	  0, 0, 0, 0, 0, 0, 4},
+	{ AGILEX_MPU_L2RAM_CLK, "mpu_l2ram_clk", "mpu_clk", NULL, 1, 0, 0x24,
+	  0, 0, 0, 0, 0, 0, 2},
+	{ AGILEX_L4_MAIN_CLK, "l4_main_clk", "noc_clk", NULL, 1, 0, 0x24,
+	  1, 0x44, 0, 2, 0, 0, 0},
+	{ AGILEX_L4_MP_CLK, "l4_mp_clk", "noc_clk", NULL, 1, 0, 0x24,
+	  2, 0x44, 8, 2, 0, 0, 0},
+	/*
+	 * The l4_sp_clk feeds a 100 MHz clock to various peripherals, one of them
+	 * being the SP timers, thus cannot get gated.
+	 */
+	{ AGILEX_L4_SP_CLK, "l4_sp_clk", "noc_clk", NULL, 1, CLK_IS_CRITICAL, 0x24,
+	  3, 0x44, 16, 2, 0, 0, 0},
+	{ AGILEX_CS_AT_CLK, "cs_at_clk", "noc_clk", NULL, 1, 0, 0x24,
+	  4, 0x44, 24, 2, 0, 0, 0},
+	{ AGILEX_CS_TRACE_CLK, "cs_trace_clk", "noc_clk", NULL, 1, 0, 0x24,
+	  4, 0x44, 26, 2, 0, 0, 0},
+	{ AGILEX_CS_PDBG_CLK, "cs_pdbg_clk", "cs_at_clk", NULL, 1, 0, 0x24,
+	  4, 0x44, 28, 1, 0, 0, 0},
+	{ AGILEX_CS_TIMER_CLK, "cs_timer_clk", "noc_clk", NULL, 1, 0, 0x24,
+	  5, 0, 0, 0, 0, 0, 0},
+	{ AGILEX_S2F_USER0_CLK, "s2f_user0_clk", NULL, s2f_usr0_mux, ARRAY_SIZE(s2f_usr0_mux), 0, 0x24,
+	  6, 0, 0, 0, 0, 0, 0},
+	{ AGILEX_EMAC0_CLK, "emac0_clk", NULL, emac_mux, ARRAY_SIZE(emac_mux), 0, 0x7C,
+	  0, 0, 0, 0, 0x94, 26, 0},
+	{ AGILEX_EMAC1_CLK, "emac1_clk", NULL, emac_mux, ARRAY_SIZE(emac_mux), 0, 0x7C,
+	  1, 0, 0, 0, 0x94, 27, 0},
+	{ AGILEX_EMAC2_CLK, "emac2_clk", NULL, emac_mux, ARRAY_SIZE(emac_mux), 0, 0x7C,
+	  2, 0, 0, 0, 0x94, 28, 0},
+	{ AGILEX_EMAC_PTP_CLK, "emac_ptp_clk", "emac_ptp_free_clk", NULL, 1, 0, 0x7C,
+	  3, 0, 0, 0, 0, 0, 0},
+	{ AGILEX_GPIO_DB_CLK, "gpio_db_clk", "gpio_db_free_clk", NULL, 1, 0, 0x7C,
+	  4, 0x98, 0, 16, 0, 0, 0},
+	{ AGILEX_SDMMC_CLK, "sdmmc_clk", "sdmmc_free_clk", NULL, 1, 0, 0x7C,
+	  5, 0, 0, 0, 0, 0, 4},
+	{ AGILEX_S2F_USER1_CLK, "s2f_user1_clk", "s2f_user1_free_clk", NULL, 1, 0, 0x7C,
+	  6, 0, 0, 0, 0, 0, 0},
+	{ AGILEX_PSI_REF_CLK, "psi_ref_clk", "psi_ref_free_clk", NULL, 1, 0, 0x7C,
+	  7, 0, 0, 0, 0, 0, 0},
+	{ AGILEX_USB_CLK, "usb_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  8, 0, 0, 0, 0, 0, 0},
+	{ AGILEX_SPI_M_CLK, "spi_m_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  9, 0, 0, 0, 0, 0, 0},
+	{ AGILEX_NAND_CLK, "nand_clk", "l4_main_clk", NULL, 1, 0, 0x7C,
+	  10, 0, 0, 0, 0, 0, 0},
+};
+
+static int agilex_clk_register_c_perip(const struct stratix10_perip_c_clock *clks,
+				       int nums, struct stratix10_clock_data *data)
+{
+	struct clk *clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = s10_register_periph(&clks[i], base);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		data->clk_data.clks[clks[i].id] = clk;
+	}
+	return 0;
+}
+
+static int agilex_clk_register_cnt_perip(const struct stratix10_perip_cnt_clock *clks,
+					 int nums, struct stratix10_clock_data *data)
+{
+	struct clk *clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = s10_register_cnt_periph(&clks[i], base);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		data->clk_data.clks[clks[i].id] = clk;
+	}
+
+	return 0;
+}
+
+static int agilex_clk_register_gate(const struct stratix10_gate_clock *clks,					    int nums, struct stratix10_clock_data *data)
+{
+	struct clk *clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = s10_register_gate(&clks[i], base);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		data->clk_data.clks[clks[i].id] = clk;
+	}
+
+	return 0;
+}
+
+static int agilex_clk_register_pll(const struct stratix10_pll_clock *clks,
+				 int nums, struct stratix10_clock_data *data)
+{
+	struct clk *clk;
+	void __iomem *base = data->base;
+	int i;
+
+	for (i = 0; i < nums; i++) {
+		clk = agilex_register_pll(&clks[i], base);
+		if (IS_ERR(clk)) {
+			pr_err("%s: failed to register clock %s\n",
+			       __func__, clks[i].name);
+			continue;
+		}
+		data->clk_data.clks[clks[i].id] = clk;
+	}
+
+	return 0;
+}
+
+static struct stratix10_clock_data *__socfpga_agilex_clk_init(struct platform_device *pdev,
+						    int nr_clks)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct stratix10_clock_data *clk_data;
+	struct clk **clk_table;
+	struct resource *res;
+	void __iomem *base;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return ERR_CAST(base);
+
+	clk_data = devm_kzalloc(dev, sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return ERR_PTR(-ENOMEM);
+
+	clk_data->base = base;
+	clk_table = devm_kcalloc(dev, nr_clks, sizeof(*clk_table), GFP_KERNEL);
+	if (!clk_table)
+		return ERR_PTR(-ENOMEM);
+
+	clk_data->clk_data.clks = clk_table;
+	clk_data->clk_data.clk_num = nr_clks;
+	ret = of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data->clk_data);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return clk_data;
+}
+
+static int agilex_clkmgr_probe(struct platform_device *pdev)
+{
+	struct stratix10_clock_data *clk_data;
+
+	clk_data = __socfpga_agilex_clk_init(pdev, AGILEX_NUM_CLKS);
+	if (IS_ERR(clk_data))
+		return PTR_ERR(clk_data);
+
+	agilex_clk_register_pll(agilex_pll_clks, ARRAY_SIZE(agilex_pll_clks), clk_data);
+
+	agilex_clk_register_c_perip(agilex_main_perip_c_clks,
+				 ARRAY_SIZE(agilex_main_perip_c_clks), clk_data);
+
+	agilex_clk_register_cnt_perip(agilex_main_perip_cnt_clks,
+				   ARRAY_SIZE(agilex_main_perip_cnt_clks),
+				   clk_data);
+
+	agilex_clk_register_gate(agilex_gate_clks, ARRAY_SIZE(agilex_gate_clks),
+			      clk_data);
+	return 0;
+}
+
+static const struct of_device_id agilex_clkmgr_match_table[] = {
+	{ .compatible = "intel,agilex-clkmgr",
+	  .data = agilex_clkmgr_probe },
+	{ }
+};
+
+static struct platform_driver agilex_clkmgr_driver = {
+	.probe		= agilex_clkmgr_probe,
+	.driver		= {
+		.name	= "agilex-clkmgr",
+		.suppress_bind_attrs = true,
+		.of_match_table = agilex_clkmgr_match_table,
+	},
+};
+
+static int __init agilex_clk_init(void)
+{
+	return platform_driver_register(&agilex_clkmgr_driver);
+}
+core_initcall(agilex_clk_init);
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index 5c3e1ee44f6b..4e268953b7da 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -18,8 +18,12 @@
 #define SOCFPGA_PLL_RESET_MASK		0x2
 #define SOCFPGA_PLL_REFDIV_MASK		0x00003F00
 #define SOCFPGA_PLL_REFDIV_SHIFT	8
+#define SOCFPGA_PLL_AREFDIV_MASK	0x00000F00
+#define SOCFPGA_PLL_DREFDIV_MASK	0x00003000
+#define SOCFPGA_PLL_DREFDIV_SHIFT	12
 #define SOCFPGA_PLL_MDIV_MASK		0xFF000000
 #define SOCFPGA_PLL_MDIV_SHIFT		24
+#define SOCFPGA_AGILEX_PLL_MDIV_MASK	0x000003FF
 #define SWCTRLBTCLKSEL_MASK		0x200
 #define SWCTRLBTCLKSEL_SHIFT		9
 
@@ -27,6 +31,27 @@
 
 #define to_socfpga_clk(p) container_of(p, struct socfpga_pll, hw.hw)
 
+static unsigned long agilex_clk_pll_recalc_rate(struct clk_hw *hwclk,
+						unsigned long parent_rate)
+{
+	struct socfpga_pll *socfpgaclk = to_socfpga_clk(hwclk);
+	unsigned long arefdiv, reg, mdiv;
+	unsigned long long vco_freq;
+
+	/* read VCO1 reg for numerator and denominator */
+	reg = readl(socfpgaclk->hw.reg);
+	arefdiv = (reg & SOCFPGA_PLL_AREFDIV_MASK) >> SOCFPGA_PLL_REFDIV_SHIFT;
+
+	vco_freq = (unsigned long long)parent_rate / arefdiv;
+
+	/* Read mdiv and fdiv from the fdbck register */
+	reg = readl(socfpgaclk->hw.reg + 0x24);
+	mdiv = reg & SOCFPGA_AGILEX_PLL_MDIV_MASK;
+
+	vco_freq = (unsigned long long)vco_freq * mdiv;
+	return (unsigned long)vco_freq;
+}
+
 static unsigned long clk_pll_recalc_rate(struct clk_hw *hwclk,
 					 unsigned long parent_rate)
 {
@@ -98,6 +123,12 @@ static int clk_pll_prepare(struct clk_hw *hwclk)
 	return 0;
 }
 
+static const struct clk_ops agilex_clk_pll_ops = {
+	.recalc_rate = agilex_clk_pll_recalc_rate,
+	.get_parent = clk_pll_get_parent,
+	.prepare = clk_pll_prepare,
+};
+
 static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.get_parent = clk_pll_get_parent,
@@ -146,3 +177,40 @@ struct clk *s10_register_pll(const struct stratix10_pll_clock *clks,
 	}
 	return clk;
 }
+
+struct clk *agilex_register_pll(const struct stratix10_pll_clock *clks,
+				void __iomem *reg)
+{
+	struct clk *clk;
+	struct socfpga_pll *pll_clk;
+	struct clk_init_data init;
+	const char *name = clks->name;
+
+	pll_clk = kzalloc(sizeof(*pll_clk), GFP_KERNEL);
+	if (WARN_ON(!pll_clk))
+		return NULL;
+
+	pll_clk->hw.reg = reg + clks->offset;
+
+	if (streq(name, SOCFPGA_BOOT_CLK))
+		init.ops = &clk_boot_ops;
+	else
+		init.ops = &agilex_clk_pll_ops;
+
+	init.name = name;
+	init.flags = clks->flags;
+
+	init.num_parents = clks->num_parents;
+	init.parent_names = NULL;
+	init.parent_data = clks->parent_data;
+	pll_clk->hw.hw.init = &init;
+
+	pll_clk->hw.bit_idx = SOCFPGA_PLL_POWER;
+
+	clk = clk_register(NULL, &pll_clk->hw.hw);
+	if (WARN_ON(IS_ERR(clk))) {
+		kfree(pll_clk);
+		return NULL;
+	}
+	return clk;
+}
diff --git a/drivers/clk/socfpga/stratix10-clk.h b/drivers/clk/socfpga/stratix10-clk.h
index ffbd1fb2c8ef..f9d5d724c694 100644
--- a/drivers/clk/socfpga/stratix10-clk.h
+++ b/drivers/clk/socfpga/stratix10-clk.h
@@ -62,6 +62,8 @@ struct stratix10_gate_clock {
 
 struct clk *s10_register_pll(const struct stratix10_pll_clock *,
 			     void __iomem *);
+struct clk *agilex_register_pll(const struct stratix10_pll_clock *,
+				void __iomem *);
 struct clk *s10_register_periph(const struct stratix10_perip_c_clock *,
 				void __iomem *);
 struct clk *s10_register_cnt_periph(const struct stratix10_perip_cnt_clock *,
-- 
2.25.1

