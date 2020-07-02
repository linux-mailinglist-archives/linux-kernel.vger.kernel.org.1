Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA7E211A0F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 04:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgGBCSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 22:18:03 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39422 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbgGBCSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:18:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C0DB200801;
        Thu,  2 Jul 2020 04:17:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4EA0B2005AD;
        Thu,  2 Jul 2020 04:17:52 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0CB0B402B1;
        Thu,  2 Jul 2020 10:17:40 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        peng.fan@nxp.com, arnd@arndb.de, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, sfr@canb.auug.org.au,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 5/5] clk: imx8qxp: Support building i.MX8QXP clock driver as module
Date:   Thu,  2 Jul 2020 10:14:34 +0800
Message-Id: <1593656074-10092-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change configuration to "tristate", use device_initcall() instead
of builtin_platform_driver(), add module author, description and
license to support building i.MX8QXP clock drivers as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V3:
	- use device_initcall() instead of builtin_platform_driver();
	- add module author/description;
	- link common scu/lpcg clock driver to i.MX8QXP clock driver, then
	  no need to have exports.
---
 drivers/clk/imx/Kconfig            |  6 +++---
 drivers/clk/imx/Makefile           |  9 ++++-----
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 10 +++++++++-
 drivers/clk/imx/clk-imx8qxp.c      | 11 ++++++++++-
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 1867111..8340dfe 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -5,8 +5,8 @@ config MXC_CLK
 	depends on ARCH_MXC
 
 config MXC_CLK_SCU
-	bool
-	depends on IMX_SCU
+	tristate "IMX SCU clock"
+	depends on ARCH_MXC && IMX_SCU
 
 config CLK_IMX1
          bool "IMX1 CCM Clock Driver"
@@ -127,7 +127,7 @@ config CLK_IMX8MQ
 	    Build the driver for i.MX8MQ CCM Clock Driver
 
 config CLK_IMX8QXP
-	bool "IMX8QXP SCU Clock"
+	tristate "IMX8QXP SCU Clock"
 	depends on ARCH_MXC && IMX_SCU && ARM64
 	select MXC_CLK_SCU
 	help
diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 17f5d12..79e53f2 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -21,15 +21,14 @@ mxc-clk-objs += clk-pll14xx.o
 mxc-clk-objs += clk-sscg-pll.o
 obj-$(CONFIG_MXC_CLK) += mxc-clk.o
 
-obj-$(CONFIG_MXC_CLK_SCU) += \
-	clk-scu.o \
-	clk-lpcg-scu.o
-
 obj-$(CONFIG_CLK_IMX8MM) += clk-imx8mm.o
 obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
 obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
-obj-$(CONFIG_CLK_IMX8QXP) += clk-imx8qxp.o clk-imx8qxp-lpcg.o
+
+obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
+clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o
+clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
 
 obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
 obj-$(CONFIG_CLK_IMX21)  += clk-imx21.o
diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
index 04c8ee3..5b6648e 100644
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
@@ -231,4 +231,12 @@ static struct platform_driver imx8qxp_lpcg_clk_driver = {
 	.probe = imx8qxp_lpcg_clk_probe,
 };
 
-builtin_platform_driver(imx8qxp_lpcg_clk_driver);
+static int __init imx8qxp_lpcg_clk_init(void)
+{
+	return platform_driver_register(&imx8qxp_lpcg_clk_driver);
+}
+device_initcall(imx8qxp_lpcg_clk_init);
+
+MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8QXP LPCG clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 5e2903e..9bcf0d1 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -151,4 +151,13 @@ static struct platform_driver imx8qxp_clk_driver = {
 	},
 	.probe = imx8qxp_clk_probe,
 };
-builtin_platform_driver(imx8qxp_clk_driver);
+
+static int __init imx8qxp_clk_init(void)
+{
+	return platform_driver_register(&imx8qxp_clk_driver);
+}
+device_initcall(imx8qxp_clk_init);
+
+MODULE_AUTHOR("Aisheng Dong <aisheng.dong@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8QXP clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

