Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F83211A0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 04:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgGBCRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 22:17:55 -0400
Received: from inva020.nxp.com ([92.121.34.13]:45958 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728132AbgGBCRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:17:52 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A78791A0925;
        Thu,  2 Jul 2020 04:17:50 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8AF911A1890;
        Thu,  2 Jul 2020 04:17:43 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A16F8402E7;
        Thu,  2 Jul 2020 10:17:34 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        peng.fan@nxp.com, arnd@arndb.de, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, fugang.duan@nxp.com, daniel.baluta@nxp.com,
        yuehaibing@huawei.com, sfr@canb.auug.org.au,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 1/5] clk: composite: Export clk_hw_register_composite()
Date:   Thu,  2 Jul 2020 10:14:30 +0800
Message-Id: <1593656074-10092-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
References: <1593656074-10092-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export clk_hw_register_composite() to support user built as module.

ERROR: modpost: "clk_hw_register_composite" [drivers/clk/imx/mxc-clk.ko] undefined!

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
No change.
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

