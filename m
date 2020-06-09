Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95271F3531
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgFIHnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 03:43:31 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48732 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727844AbgFIHnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:43:24 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A283D200189;
        Tue,  9 Jun 2020 09:43:22 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AD1B1200FC0;
        Tue,  9 Jun 2020 09:43:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5AD874030C;
        Tue,  9 Jun 2020 15:43:00 +0800 (SGT)
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
Subject: [PATCH V2 5/9] clk: imx8mm: Support module build
Date:   Tue,  9 Jun 2020 15:32:09 +0800
Message-Id: <1591687933-19495-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
References: <1591687933-19495-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support building i.MX8MM clock driver as module.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No change.
---
 drivers/clk/imx/Kconfig      | 2 +-
 drivers/clk/imx/clk-imx8mm.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index 678113b..97d86a3 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -9,7 +9,7 @@ config MXC_CLK_SCU
 	depends on ARCH_MXC && IMX_SCU
 
 config CLK_IMX8MM
-	bool "IMX8MM CCM Clock Driver"
+	tristate "IMX8MM CCM Clock Driver"
 	depends on ARCH_MXC
 	select MXC_CLK
 	help
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b793264..1e8242d 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -657,3 +657,4 @@ static struct platform_driver imx8mm_clk_driver = {
 	},
 };
 module_platform_driver(imx8mm_clk_driver);
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

