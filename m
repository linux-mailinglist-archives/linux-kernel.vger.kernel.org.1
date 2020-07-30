Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129A423297C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 03:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgG3B13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 21:27:29 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49252 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbgG3B11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 21:27:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E3E16201130;
        Thu, 30 Jul 2020 03:27:23 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3307B201123;
        Thu, 30 Jul 2020 03:27:17 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DED114031E;
        Thu, 30 Jul 2020 03:27:08 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V9 3/6] clk: imx: Support building i.MX common clock driver as module
Date:   Thu, 30 Jul 2020 09:22:51 +0800
Message-Id: <1596072174-16358-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596072174-16358-1-git-send-email-Anson.Huang@nxp.com>
References: <1596072174-16358-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more and more requirements of building SoC specific drivers
as modules, add support for building i.MX common clock driver as module
to meet the requirement.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
no change.
---
 drivers/clk/imx/Kconfig            |  8 ++++++--
 drivers/clk/imx/Makefile           | 40 +++++++++++++++++++-------------------
 drivers/clk/imx/clk-composite-8m.c |  2 ++
 drivers/clk/imx/clk-cpu.c          |  2 ++
 drivers/clk/imx/clk-frac-pll.c     |  2 ++
 drivers/clk/imx/clk-gate2.c        |  2 ++
 drivers/clk/imx/clk-pll14xx.c      |  5 +++++
 drivers/clk/imx/clk-sscg-pll.c     |  2 ++
 drivers/clk/imx/clk.c              | 17 ++++++++++++----
 drivers/clk/imx/clk.h              |  6 ++++++
 10 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db0253f..ee854ac 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # common clock support for NXP i.MX SoC family.
 config MXC_CLK
-	bool
-	def_bool ARCH_MXC
+	tristate "IMX clock"
+	depends on ARCH_MXC
 
 config MXC_CLK_SCU
 	bool
@@ -11,24 +11,28 @@ config MXC_CLK_SCU
 config CLK_IMX8MM
 	bool "IMX8MM CCM Clock Driver"
 	depends on ARCH_MXC
+	select MXC_CLK
 	help
 	    Build the driver for i.MX8MM CCM Clock Driver
 
 config CLK_IMX8MN
 	bool "IMX8MN CCM Clock Driver"
 	depends on ARCH_MXC
+	select MXC_CLK
 	help
 	    Build the driver for i.MX8MN CCM Clock Driver
 
 config CLK_IMX8MP
 	bool "IMX8MP CCM Clock Driver"
 	depends on ARCH_MXC
+	select MXC_CLK
 	help
 	    Build the driver for i.MX8MP CCM Clock Driver
 
 config CLK_IMX8MQ
 	bool "IMX8MQ CCM Clock Driver"
 	depends on ARCH_MXC
+	select MXC_CLK
 	help
 	    Build the driver for i.MX8MQ CCM Clock Driver
 
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 928f874..687207d 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -1,25 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_MXC_CLK) += \
-	clk.o \
-	clk-busy.o \
-	clk-composite-8m.o \
-	clk-cpu.o \
-	clk-composite-7ulp.o \
-	clk-divider-gate.o \
-	clk-fixup-div.o \
-	clk-fixup-mux.o \
-	clk-frac-pll.o \
-	clk-gate-exclusive.o \
-	clk-gate2.o \
-	clk-pfd.o \
-	clk-pfdv2.o \
-	clk-pllv1.o \
-	clk-pllv2.o \
-	clk-pllv3.o \
-	clk-pllv4.o \
-	clk-sscg-pll.o \
-	clk-pll14xx.o
+mxc-clk-objs += clk.o
+mxc-clk-objs += clk-busy.o
+mxc-clk-objs += clk-composite-7ulp.o
+mxc-clk-objs += clk-composite-8m.o
+mxc-clk-objs += clk-cpu.o
+mxc-clk-objs += clk-divider-gate.o
+mxc-clk-objs += clk-fixup-div.o
+mxc-clk-objs += clk-fixup-mux.o
+mxc-clk-objs += clk-frac-pll.o
+mxc-clk-objs += clk-gate2.o
+mxc-clk-objs += clk-gate-exclusive.o
+mxc-clk-objs += clk-pfd.o
+mxc-clk-objs += clk-pfdv2.o
+mxc-clk-objs += clk-pllv1.o
+mxc-clk-objs += clk-pllv2.o
+mxc-clk-objs += clk-pllv3.o
+mxc-clk-objs += clk-pllv4.o
+mxc-clk-objs += clk-pll14xx.o
+mxc-clk-objs += clk-sscg-pll.o
+obj-$(CONFIG_MXC_CLK) += mxc-clk.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += \
 	clk-scu.o \
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index d2b5af8..78fb7e5 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
@@ -243,3 +244,4 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 	kfree(mux);
 	return ERR_CAST(hw);
 }
+EXPORT_SYMBOL_GPL(imx8m_clk_hw_composite_flags);
diff --git a/drivers/clk/imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
index cb182be..cb6ca4c 100644
--- a/drivers/clk/imx/clk-cpu.c
+++ b/drivers/clk/imx/clk-cpu.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/export.h>
 #include <linux/slab.h>
 #include "clk.h"
 
@@ -104,3 +105,4 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_hw_cpu);
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
index 101e0a3..c703056 100644
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
@@ -233,3 +234,4 @@ struct clk_hw *imx_clk_hw_frac_pll(const char *name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_hw_frac_pll);
diff --git a/drivers/clk/imx/clk-gate2.c b/drivers/clk/imx/clk-gate2.c
index b87ab3c..512f675 100644
--- a/drivers/clk/imx/clk-gate2.c
+++ b/drivers/clk/imx/clk-gate2.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/export.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/io.h>
@@ -177,3 +178,4 @@ struct clk_hw *clk_hw_register_gate2(struct device *dev, const char *name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(clk_hw_register_gate2);
diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index f9eb189..f5c3e7e 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -6,6 +6,7 @@
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
@@ -68,6 +69,7 @@ struct imx_pll14xx_clk imx_1443x_pll = {
 	.rate_table = imx_pll1443x_tbl,
 	.rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
 };
+EXPORT_SYMBOL_GPL(imx_1443x_pll);
 
 struct imx_pll14xx_clk imx_1443x_dram_pll = {
 	.type = PLL_1443X,
@@ -75,12 +77,14 @@ struct imx_pll14xx_clk imx_1443x_dram_pll = {
 	.rate_count = ARRAY_SIZE(imx_pll1443x_tbl),
 	.flags = CLK_GET_RATE_NOCACHE,
 };
+EXPORT_SYMBOL_GPL(imx_1443x_dram_pll);
 
 struct imx_pll14xx_clk imx_1416x_pll = {
 	.type = PLL_1416X,
 	.rate_table = imx_pll1416x_tbl,
 	.rate_count = ARRAY_SIZE(imx_pll1416x_tbl),
 };
+EXPORT_SYMBOL_GPL(imx_1416x_pll);
 
 static const struct imx_pll14xx_rate_table *imx_get_pll_settings(
 		struct clk_pll14xx *pll, unsigned long rate)
@@ -436,3 +440,4 @@ struct clk_hw *imx_dev_clk_hw_pll14xx(struct device *dev, const char *name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_dev_clk_hw_pll14xx);
diff --git a/drivers/clk/imx/clk-sscg-pll.c b/drivers/clk/imx/clk-sscg-pll.c
index 773d8a5..9d6cdff 100644
--- a/drivers/clk/imx/clk-sscg-pll.c
+++ b/drivers/clk/imx/clk-sscg-pll.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
@@ -537,3 +538,4 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_hw_sscg_pll);
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 87ab8db..547cade 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -3,6 +3,7 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -13,6 +14,7 @@
 #define CCDR_MMDC_CH1_MASK		BIT(16)
 
 DEFINE_SPINLOCK(imx_ccm_lock);
+EXPORT_SYMBOL_GPL(imx_ccm_lock);
 
 void imx_unregister_clocks(struct clk *clks[], unsigned int count)
 {
@@ -29,8 +31,9 @@ void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count)
 	for (i = 0; i < count; i++)
 		clk_hw_unregister(hws[i]);
 }
+EXPORT_SYMBOL_GPL(imx_unregister_hw_clocks);
 
-void __init imx_mmdc_mask_handshake(void __iomem *ccm_base,
+void imx_mmdc_mask_handshake(void __iomem *ccm_base,
 				    unsigned int chn)
 {
 	unsigned int reg;
@@ -59,8 +62,9 @@ void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count)
 			pr_err("i.MX clk %u: register failed with %ld\n",
 			       i, PTR_ERR(clks[i]));
 }
+EXPORT_SYMBOL_GPL(imx_check_clk_hws);
 
-static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
+static struct clk *imx_obtain_fixed_clock_from_dt(const char *name)
 {
 	struct of_phandle_args phandle;
 	struct clk *clk = ERR_PTR(-ENODEV);
@@ -80,7 +84,7 @@ static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
 	return clk;
 }
 
-struct clk * __init imx_obtain_fixed_clock(
+struct clk *imx_obtain_fixed_clock(
 			const char *name, unsigned long rate)
 {
 	struct clk *clk;
@@ -91,7 +95,7 @@ struct clk * __init imx_obtain_fixed_clock(
 	return clk;
 }
 
-struct clk_hw * __init imx_obtain_fixed_clock_hw(
+struct clk_hw *imx_obtain_fixed_clock_hw(
 			const char *name, unsigned long rate)
 {
 	struct clk *clk;
@@ -113,6 +117,7 @@ struct clk_hw * imx_obtain_fixed_clk_hw(struct device_node *np,
 
 	return __clk_get_hw(clk);
 }
+EXPORT_SYMBOL_GPL(imx_obtain_fixed_clk_hw);
 
 /*
  * This fixups the register CCM_CSCMR1 write value.
@@ -140,6 +145,7 @@ void imx_cscmr1_fixup(u32 *val)
 	return;
 }
 
+#ifndef MODULE
 static int imx_keep_uart_clocks;
 static struct clk ** const *imx_uart_clocks;
 
@@ -177,3 +183,6 @@ static int __init imx_clk_disable_uart(void)
 	return 0;
 }
 late_initcall_sync(imx_clk_disable_uart);
+#endif
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 16adbc3..dd47c19 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -11,7 +11,13 @@ extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
+#ifndef MODULE
 void imx_register_uart_clocks(struct clk ** const clks[]);
+#else
+static inline void imx_register_uart_clocks(struct clk ** const clks[])
+{
+}
+#endif
 void imx_mmdc_mask_handshake(void __iomem *ccm_base, unsigned int chn);
 void imx_unregister_clocks(struct clk *clks[], unsigned int count);
 void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count);
-- 
2.7.4

