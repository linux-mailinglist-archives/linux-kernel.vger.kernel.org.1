Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF40241643
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 08:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHKGVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 02:21:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:54168 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgHKGVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:21:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BE4A21A08A7;
        Tue, 11 Aug 2020 08:21:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A5E7B1A1E44;
        Tue, 11 Aug 2020 08:21:09 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 416B6402DD;
        Tue, 11 Aug 2020 08:21:04 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/2] irqchip/imx-irqsteer: Use dev_err_probe() to simplify error handling
Date:   Tue, 11 Aug 2020 14:16:16 +0800
Message-Id: <1597126576-18383-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597126576-18383-1-git-send-email-Anson.Huang@nxp.com>
References: <1597126576-18383-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	- remove redundant return value print.
---
 drivers/irqchip/irq-imx-irqsteer.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 290531e..1edf769 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -158,12 +158,9 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
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
+				     "failed to get ipg clk\n");
 
 	raw_spin_lock_init(&data->lock);
 
-- 
2.7.4

