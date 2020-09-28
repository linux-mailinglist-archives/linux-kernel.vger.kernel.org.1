Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632FF27AD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgI1MBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:01:21 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:24101 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgI1MBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:01:20 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75f71d077242-f63b6; Mon, 28 Sep 2020 20:00:58 +0800 (CST)
X-RM-TRANSID: 2ee75f71d077242-f63b6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35f71d078268-40e0d;
        Mon, 28 Sep 2020 20:00:58 +0800 (CST)
X-RM-TRANSID: 2ee35f71d078268-40e0d
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     f.fainelli@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        chunfeng.yun@mediatek.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH v2] usb: bdc: Fix the return value and remove duplicate error message
Date:   Mon, 28 Sep 2020 20:00:51 +0800
Message-Id: <20200928120051.21748-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When call function devm_platform_ioremap_resource(), we should use
IS_ERR() to check the return value and return PTR_ERR() if failed,
and it can print an error message itself if failed. So remove the
redundant dev_err() in this place.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
Changes from v1
 - fix the subject and commit message
 - fix the code of right return if failed
---
 drivers/usb/gadget/udc/bdc/bdc_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 02a3a7746..70ff31bc8 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -508,10 +508,9 @@ static int bdc_probe(struct platform_device *pdev)
 	bdc->clk = clk;
 
 	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(bdc->regs)) {
-		dev_err(dev, "ioremap error\n");
-		return -ENOMEM;
-	}
+	if (IS_ERR(bdc->regs))
+		return PTR_ERR(bdc->regs);
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
-- 
2.20.1.windows.1



