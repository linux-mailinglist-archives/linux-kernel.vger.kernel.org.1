Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F71A3DDE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 03:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDJB5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 21:57:15 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:35836 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDJB5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:57:15 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35e8fd268f7d-f51a4; Fri, 10 Apr 2020 09:56:56 +0800 (CST)
X-RM-TRANSID: 2ee35e8fd268f7d-f51a4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35e8fd2650fe-770f4;
        Fri, 10 Apr 2020 09:56:56 +0800 (CST)
X-RM-TRANSID: 2ee35e8fd2650fe-770f4
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     leoyang.li@nxp.com, balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] usb: gadget: fsl: Fix a wrong judgment in fsl_udc_probe()
Date:   Fri, 10 Apr 2020 09:58:32 +0800
Message-Id: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the function "platform_get_irq()" failed, the negative value
returned will not be detected here, including "-EPROBE_DEFER", which
causes the application to fail to get the correct error message.
Thus it must be fixed.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index ec6eda426..60853ad10 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2441,8 +2441,8 @@ static int fsl_udc_probe(struct platform_device *pdev)
 	udc_controller->max_ep = (dccparams & DCCPARAMS_DEN_MASK) * 2;
 
 	udc_controller->irq = platform_get_irq(pdev, 0);
-	if (!udc_controller->irq) {
-		ret = -ENODEV;
+	if (udc_controller->irq <= 0) {
+		ret = udc_controller->irq ? : -ENODEV;
 		goto err_iounmap;
 	}
 
-- 
2.20.1.windows.1



