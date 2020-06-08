Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6659A1F19D9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 15:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgFHNXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 09:23:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41518 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgFHNXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:23:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EBF8F1A1036;
        Mon,  8 Jun 2020 15:23:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D22171A1031;
        Mon,  8 Jun 2020 15:23:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7CFB5402F0;
        Mon,  8 Jun 2020 21:22:51 +0800 (SGT)
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
Subject: [PATCH 1/9] clk: composite: Export clk_hw_register_composite()
Date:   Mon,  8 Jun 2020 21:12:08 +0800
Message-Id: <1591621936-11886-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591621936-11886-1-git-send-email-Anson.Huang@nxp.com>
References: <1591621936-11886-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export clk_hw_register_composite() to support user built as module.

ERROR: modpost: "clk_hw_register_composite" [drivers/clk/imx/mxc-clk.ko] undefined!
scripts/Makefile.modpost:111: recipe for target 'Module.symvers' failed
make[1]: *** [Module.symvers] Error 1
make[1]: *** Deleting file 'Module.symvers'
Makefile:1384: recipe for target 'modules' failed
make: *** [modules] Error 2

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/clk-composite.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 7376f57..2ddb54f 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -328,6 +328,7 @@ struct clk_hw *clk_hw_register_composite(struct device *dev, const char *name,
 					   rate_hw, rate_ops, gate_hw,
 					   gate_ops, flags);
 }
+EXPORT_SYMBOL_GPL(clk_hw_register_composite);
 
 struct clk_hw *clk_hw_register_composite_pdata(struct device *dev,
 			const char *name,
-- 
2.7.4

