Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD32531EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 16:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgHZOud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 10:50:33 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:55446 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgHZOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:50:06 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65f46765af00-5abea; Wed, 26 Aug 2020 22:48:59 +0800 (CST)
X-RM-TRANSID: 2ee65f46765af00-5abea
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.0.144.112])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee65f467658e6c-12e8e;
        Wed, 26 Aug 2020 22:48:59 +0800 (CST)
X-RM-TRANSID: 2ee65f467658e6c-12e8e
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        kgene@kernel.org, krzk@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] usb: host: ohci-exynos: Fix error handling in exynos_ohci_probe()
Date:   Wed, 26 Aug 2020 22:49:31 +0800
Message-Id: <20200826144931.1828-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the function platform_get_irq() failed, the negative value
returned will not be detected here. So fix error handling in
exynos_ohci_probe(). And when get irq failed, the function
platform_get_irq() logs an error message, so remove redundant
message here.

Fixes: 62194244cf87 ("USB: Add Samsung Exynos OHCI diver")
Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/usb/host/ohci-exynos.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
index bd40e597f..5f5e8a64c 100644
--- a/drivers/usb/host/ohci-exynos.c
+++ b/drivers/usb/host/ohci-exynos.c
@@ -171,9 +171,8 @@ static int exynos_ohci_probe(struct platform_device *pdev)
 	hcd->rsrc_len = resource_size(res);
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
-		dev_err(&pdev->dev, "Failed to get IRQ\n");
-		err = -ENODEV;
+	if (irq < 0) {
+		err = irq;
 		goto fail_io;
 	}
 
-- 
2.20.1.windows.1



