Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D002415BA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 06:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgHKEaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 00:30:04 -0400
Received: from inva021.nxp.com ([92.121.34.21]:58008 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgHKEaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 00:30:03 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C962201DA2;
        Tue, 11 Aug 2020 06:30:02 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 44236201D9C;
        Tue, 11 Aug 2020 06:29:58 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DA64440243;
        Tue, 11 Aug 2020 06:29:52 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] irqchip/imx-intmux: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 12:25:04 +0800
Message-Id: <1597119905-7341-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/irqchip/irq-imx-intmux.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index e35b7b0..2f51ec9 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -226,12 +226,10 @@ static int imx_intmux_probe(struct platform_device *pdev)
 	}
 
 	data->ipg_clk = devm_clk_get(&pdev->dev, "ipg");
-	if (IS_ERR(data->ipg_clk)) {
-		ret = PTR_ERR(data->ipg_clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(data->ipg_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(data->ipg_clk),
+				     "failed to get ipg clk: %ld\n",
+				     PTR_ERR(data->ipg_clk));
 
 	data->channum = channum;
 	raw_spin_lock_init(&data->lock);
-- 
2.7.4

