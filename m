Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E841AF8E9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 11:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgDSJRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 05:17:53 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5123 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 05:17:53 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5e9c1732645-b9893; Sun, 19 Apr 2020 17:17:38 +0800 (CST)
X-RM-TRANSID: 2eec5e9c1732645-b9893
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.1.172.61])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e9c172fdbc-c19ef;
        Sun, 19 Apr 2020 17:17:37 +0800 (CST)
X-RM-TRANSID: 2ee45e9c172fdbc-c19ef
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] mfd: asic3: Add error checking return in asic3_mfd_probe()
Date:   Sun, 19 Apr 2020 17:19:23 +0800
Message-Id: <20200419091923.5728-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function asic3_mfd_probe(), when get resource or irq
failed, the value returned just detected and debug error message,
but there were no error checking return. So add the right error
checking return. And remove the redundant 'ret = 0'.

Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/mfd/asic3.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 7694de3f1..827449b7a 100644
--- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -881,12 +881,18 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 	int irq, ret;
 
 	mem_sdio = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!mem_sdio)
+	if (!mem_sdio) {
 		dev_dbg(asic->dev, "no SDIO MEM resource\n");
+		ret = -EINVAL;
+		goto out;
+	}
 
 	irq = platform_get_irq(pdev, 1);
-	if (irq < 0)
+	if (irq < 0) {
 		dev_dbg(asic->dev, "no SDIO IRQ resource\n");
+		ret = irq;
+		goto out;
+	}
 
 	/* DS1WM */
 	asic3_set_register(asic, ASIC3_OFFSET(EXTCF, SELECT),
@@ -924,7 +930,6 @@ static int __init asic3_mfd_probe(struct platform_device *pdev,
 			goto out;
 	}
 
-	ret = 0;
 	if (pdata->leds) {
 		int i;
 
-- 
2.20.1.windows.1



