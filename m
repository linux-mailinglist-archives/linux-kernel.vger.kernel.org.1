Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582651F3530
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgFIHn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 03:43:28 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47050 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgFIHnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:43:20 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D4A91A12A0;
        Tue,  9 Jun 2020 09:43:18 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 507691A12A9;
        Tue,  9 Jun 2020 09:43:08 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 02D73402FB;
        Tue,  9 Jun 2020 15:42:55 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, mturquette@baylibre.com,
        sboyd@kernel.org, oleksandr.suvorov@toradex.com,
        stefan.agner@toradex.com, arnd@arndb.de, abel.vesa@nxp.com,
        peng.fan@nxp.com, aisheng.dong@nxp.com, tglx@linutronix.de,
        allison@lohutok.net, gregkh@linuxfoundation.org, info@metux.net,
        leonard.crestez@nxp.com, fugang.duan@nxp.com,
        daniel.baluta@nxp.com, yuehaibing@huawei.com, sfr@canb.auug.org.au,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 3/9] clk: imx: Support building SCU clock driver as module
Date:   Tue,  9 Jun 2020 15:32:07 +0800
Message-Id: <1591687933-19495-4-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more and more requirements of building SoC specific drivers
as modules, add support for building SCU clock driver as module to meet
the requirement.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- add ARCH_MXC to build dependency to avoid build fail on x86 arch;
	- move clk-lpcg-scu.c change in to this patch.
---
 drivers/clk/imx/Kconfig        | 4 ++--
 drivers/clk/imx/Makefile       | 5 ++---
 drivers/clk/imx/clk-lpcg-scu.c | 1 +
 drivers/clk/imx/clk-scu.c      | 5 +++++
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index db0253f..ded0643 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -5,8 +5,8 @@ config MXC_CLK
 	def_bool ARCH_MXC
 
 config MXC_CLK_SCU
-	bool
-	depends on IMX_SCU
+	tristate "IMX SCU clock"
+	depends on ARCH_MXC && IMX_SCU
 
 config CLK_IMX8MM
 	bool "IMX8MM CCM Clock Driver"
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 928f874..1af8cff 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -21,9 +21,8 @@ obj-$(CONFIG_MXC_CLK) += \
 	clk-sscg-pll.o \
 	clk-pll14xx.o
 
-obj-$(CONFIG_MXC_CLK_SCU) += \
-	clk-scu.o \
-	clk-lpcg-scu.o
+mxc-clk-scu-objs += clk-scu.o clk-lpcg-scu.o
+obj-$(CONFIG_MXC_CLK_SCU) += mxc-clk-scu.o
 
 obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
 obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index a73a799..8177f0e 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -114,3 +114,4 @@ struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_lpcg_scu);
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index b8b2072..9688981 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -8,6 +8,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 
 #include "clk-scu.h"
@@ -132,6 +133,7 @@ int imx_clk_scu_init(void)
 {
 	return imx_scu_get_handle(&ccm_ipc_handle);
 }
+EXPORT_SYMBOL_GPL(imx_clk_scu_init);
 
 /*
  * clk_scu_recalc_rate - Get clock rate for a SCU clock
@@ -387,3 +389,6 @@ struct clk_hw *__imx_clk_scu(const char *name, const char * const *parents,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(__imx_clk_scu);
+
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

