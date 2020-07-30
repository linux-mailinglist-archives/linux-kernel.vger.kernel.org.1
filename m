Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6A232887
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 02:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgG3ADY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 20:03:24 -0400
Received: from inva020.nxp.com ([92.121.34.13]:51320 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728203AbgG3ADW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 20:03:22 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 65D2A1A12AB;
        Thu, 30 Jul 2020 02:03:20 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DC361A12A9;
        Thu, 30 Jul 2020 02:03:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 64BCB40320;
        Thu, 30 Jul 2020 02:02:59 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, arnd@arndb.de, peng.fan@nxp.com,
        abel.vesa@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V8 5/6] clk: imx8m: Support module build
Date:   Thu, 30 Jul 2020 07:58:39 +0800
Message-Id: <1596067120-1193-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596067120-1193-1-git-send-email-Anson.Huang@nxp.com>
References: <1596067120-1193-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change configuration to "tristate", add module author, description
and license to support building i.MX8M SoCs clock driver as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
no change.
---
 drivers/clk/imx/Kconfig      | 16 ++++++++--------
 drivers/clk/imx/clk-imx8mm.c |  4 ++++
 drivers/clk/imx/clk-imx8mn.c |  4 ++++
 drivers/clk/imx/clk-imx8mp.c |  4 ++++
 drivers/clk/imx/clk-imx8mq.c |  4 ++++
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index e96bd38..3897712 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -69,29 +69,29 @@ config CLK_VF610
 	select MXC_CLK
 
 config CLK_IMX8MM
-	bool "IMX8MM CCM Clock Driver"
-	depends on ARCH_MXC
+	tristate "IMX8MM CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
 	help
 	    Build the driver for i.MX8MM CCM Clock Driver
 
 config CLK_IMX8MN
-	bool "IMX8MN CCM Clock Driver"
-	depends on ARCH_MXC
+	tristate "IMX8MN CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
 	help
 	    Build the driver for i.MX8MN CCM Clock Driver
 
 config CLK_IMX8MP
-	bool "IMX8MP CCM Clock Driver"
-	depends on ARCH_MXC
+	tristate "IMX8MP CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
 	help
 	    Build the driver for i.MX8MP CCM Clock Driver
 
 config CLK_IMX8MQ
-	bool "IMX8MQ CCM Clock Driver"
-	depends on ARCH_MXC
+	tristate "IMX8MQ CCM Clock Driver"
+	depends on ARCH_MXC || COMPILE_TEST
 	select MXC_CLK
 	help
 	    Build the driver for i.MX8MQ CCM Clock Driver
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b793264..0de0be0 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -657,3 +657,7 @@ static struct platform_driver imx8mm_clk_driver = {
 	},
 };
 module_platform_driver(imx8mm_clk_driver);
+
+MODULE_AUTHOR("Bai Ping <ping.bai@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8MM clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 213cc37..e984de5 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -608,3 +608,7 @@ static struct platform_driver imx8mn_clk_driver = {
 	},
 };
 module_platform_driver(imx8mn_clk_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8MN clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index ca74771..f3cedf2 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -773,3 +773,7 @@ static struct platform_driver imx8mp_clk_driver = {
 	},
 };
 module_platform_driver(imx8mp_clk_driver);
+
+MODULE_AUTHOR("Anson Huang <Anson.Huang@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8MP clock driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index a64aace..a06cc21 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -643,3 +643,7 @@ static struct platform_driver imx8mq_clk_driver = {
 	},
 };
 module_platform_driver(imx8mq_clk_driver);
+
+MODULE_AUTHOR("Abel Vesa <abel.vesa@nxp.com>");
+MODULE_DESCRIPTION("NXP i.MX8MQ clock driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

