Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E700C27A142
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 15:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgI0Nmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 09:42:42 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:24098 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgI0Nml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 09:42:41 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75f7096be93d-df9df; Sun, 27 Sep 2020 21:42:23 +0800 (CST)
X-RM-TRANSID: 2ee75f7096be93d-df9df
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.153])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45f7096bbeea-169d4;
        Sun, 27 Sep 2020 21:42:23 +0800 (CST)
X-RM-TRANSID: 2ee45f7096bbeea-169d4
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] usb: bdc: Remove duplicate error message in bdc_probe()
Date:   Sun, 27 Sep 2020 21:42:18 +0800
Message-Id: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this function, we don't need dev_err() message because
when something goes wrong, devm_platform_ioremap_resource()
can print an error message itself, so remove the redundant
one.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 02a3a7746..9454f179e 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -508,10 +508,8 @@ static int bdc_probe(struct platform_device *pdev)
 	bdc->clk = clk;
 
 	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(bdc->regs)) {
-		dev_err(dev, "ioremap error\n");
+	if (IS_ERR(bdc->regs))
 		return -ENOMEM;
-	}
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-- 
2.20.1.windows.1



